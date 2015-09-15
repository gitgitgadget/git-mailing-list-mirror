From: Jeff King <peff@peff.net>
Subject: [PATCH 34/67] resolve_ref: use strbufs for internal buffers
Date: Tue, 15 Sep 2015 11:50:43 -0400
Message-ID: <20150915155042.GH29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:51:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsVU-0004nq-0P
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbbIOPus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:50:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:59370 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753505AbbIOPup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:50:45 -0400
Received: (qmail 12643 invoked by uid 102); 15 Sep 2015 15:50:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:50:45 -0500
Received: (qmail 7394 invoked by uid 107); 15 Sep 2015 15:50:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:50:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:50:43 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277935>

resolve_ref already uses a strbuf internally when generating
pathnames, but it uses fixed-size buffers for storing the
refname and symbolic refs. This means that you cannot
actually point HEAD to a ref that is larger than 256 bytes.

We can lift this limit by using strbufs here, too. Like
sb_path, we pass the the buffers into our helper function,
so that we can easily clean up all output paths. We can also
drop the "unsafe" name from our helper function, as it no
longer uses a single static buffer (but of course
resolve_ref_unsafe is still unsafe, because the static
buffers moved there).

As a bonus, we also get to drop some strcpy calls between
the two fixed buffers (that cannot currently overflow
because the two buffers are sized identically).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                  | 57 ++++++++++++++++++++++++++-----------------------
 t/t1401-symbolic-ref.sh | 29 +++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index d5c8b2f..c2709de 100644
--- a/refs.c
+++ b/refs.c
@@ -1579,16 +1579,15 @@ static int resolve_missing_loose_ref(const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_unsafe_1(const char *refname,
-					int resolve_flags,
-					unsigned char *sha1,
-					int *flags,
-					struct strbuf *sb_path)
+static const char *resolve_ref_1(const char *refname,
+				 int resolve_flags,
+				 unsigned char *sha1,
+				 int *flags,
+				 struct strbuf *sb_refname,
+				 struct strbuf *sb_path,
+				 struct strbuf *sb_contents)
 {
 	int depth = MAXDEPTH;
-	ssize_t len;
-	char buffer[256];
-	static char refname_buffer[256];
 	int bad_name = 0;
 
 	if (flags)
@@ -1654,19 +1653,18 @@ static const char *resolve_ref_unsafe_1(const char *refname,
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
-			len = readlink(path, buffer, sizeof(buffer)-1);
-			if (len < 0) {
+			strbuf_reset(sb_contents);
+			if (strbuf_readlink(sb_contents, path, 0) < 0) {
 				if (errno == ENOENT || errno == EINVAL)
 					/* inconsistent with lstat; retry */
 					goto stat_ref;
 				else
 					return NULL;
 			}
-			buffer[len] = 0;
-			if (starts_with(buffer, "refs/") &&
-					!check_refname_format(buffer, 0)) {
-				strcpy(refname_buffer, buffer);
-				refname = refname_buffer;
+			if (starts_with(sb_contents->buf, "refs/") &&
+			    !check_refname_format(sb_contents->buf, 0)) {
+				strbuf_swap(sb_refname, sb_contents);
+				refname = sb_refname->buf;
 				if (flags)
 					*flags |= REF_ISSYMREF;
 				if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
@@ -1695,28 +1693,26 @@ static const char *resolve_ref_unsafe_1(const char *refname,
 			else
 				return NULL;
 		}
-		len = read_in_full(fd, buffer, sizeof(buffer)-1);
-		if (len < 0) {
+		strbuf_reset(sb_contents);
+		if (strbuf_read(sb_contents, fd, 256) < 0) {
 			int save_errno = errno;
 			close(fd);
 			errno = save_errno;
 			return NULL;
 		}
 		close(fd);
-		while (len && isspace(buffer[len-1]))
-			len--;
-		buffer[len] = '\0';
+		strbuf_rtrim(sb_contents);
 
 		/*
 		 * Is it a symbolic ref?
 		 */
-		if (!starts_with(buffer, "ref:")) {
+		if (!starts_with(sb_contents->buf, "ref:")) {
 			/*
 			 * Please note that FETCH_HEAD has a second
 			 * line containing other data.
 			 */
-			if (get_sha1_hex(buffer, sha1) ||
-			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
+			if (get_sha1_hex(sb_contents->buf, sha1) ||
+			    (sb_contents->buf[40] != '\0' && !isspace(sb_contents->buf[40]))) {
 				if (flags)
 					*flags |= REF_ISBROKEN;
 				errno = EINVAL;
@@ -1731,10 +1727,12 @@ static const char *resolve_ref_unsafe_1(const char *refname,
 		}
 		if (flags)
 			*flags |= REF_ISSYMREF;
-		buf = buffer + 4;
+		buf = sb_contents->buf + 4;
 		while (isspace(*buf))
 			buf++;
-		refname = strcpy(refname_buffer, buf);
+		strbuf_reset(sb_refname);
+		strbuf_addstr(sb_refname, buf);
+		refname = sb_refname->buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
 			return refname;
@@ -1756,10 +1754,15 @@ static const char *resolve_ref_unsafe_1(const char *refname,
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
+	static struct strbuf sb_refname = STRBUF_INIT;
+	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
-	const char *ret = resolve_ref_unsafe_1(refname, resolve_flags,
-					       sha1, flags, &sb_path);
+	const char *ret;
+
+	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
+			    &sb_refname, &sb_path, &sb_contents);
 	strbuf_release(&sb_path);
+	strbuf_release(&sb_contents);
 	return ret;
 }
 
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 36378b0..20b022a 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -63,4 +63,33 @@ test_expect_success 'symbolic-ref fails to delete real ref' '
 '
 reset_to_sane
 
+test_expect_success 'create large ref name' '
+	# make 256+ character ref; some systems may not handle that,
+	# so be gentle
+	long=0123456789abcdef &&
+	long=$long/$long/$long/$long &&
+	long=$long/$long/$long/$long &&
+	long_ref=refs/heads/$long &&
+	tree=$(git write-tree) &&
+	commit=$(echo foo | git commit-tree $tree) &&
+	if git update-ref $long_ref $commit; then
+		test_set_prereq LONG_REF
+	else
+		echo >&2 "long refs not supported"
+	fi
+'
+
+test_expect_success LONG_REF 'symbolic-ref can point to large ref name' '
+	git symbolic-ref HEAD $long_ref &&
+	echo $long_ref >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success LONG_REF 'we can parse long symbolic ref' '
+	echo $commit >expect &&
+	git rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.6.0.rc2.408.ga2926b9
