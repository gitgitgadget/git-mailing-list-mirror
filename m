From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] reflog: add for_each_reflog_ent_reverse() API
Date: Fri,  8 Mar 2013 13:53:44 -0800
Message-ID: <1362779624-15513-4-git-send-email-gitster@pobox.com>
References: <1362779624-15513-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 22:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE5F8-0000MP-Si
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154Ab3CHVx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:53:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756564Ab3CHVxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:53:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9A1CB4D1
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Zi23
	PYeANtHBoET7HaijRQunMGI=; b=U2sKjb7NVKfQXNJxxqh801c+hyrYaOSVJYoO
	scjdvOloUtX78rFfft96C7nLB2HR/1NyGwnp05ajvTm21kgbYEDxVoe0BTnxWOEI
	H+Tbd/Qs5Gj6krE6uLxRGL+Q0fEujxHLVOW7D44KLn4C3a7m/HG5nNgHE6iCxHR9
	7zmMaF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BQkVyR
	zTtEcF36RFCp9xziKx/Cc/5wzoDoIsr5Pj7AuO0ko4XrdR+Vn4cdJQf6UYJHnhva
	EMJhyToC8c179DMMOmo3K1JOvCAgyaA8JXBzNJartfSjEVhwmCTvY4F6iaChmRyU
	l6IkHxkScR1oQXbWdwjFO3fdxLjejQpdBoNxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEB98B4CE
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCD25B4CB for
 <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:51 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-189-g94c4d42
In-Reply-To: <1362779624-15513-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AA2D5A36-883A-11E2-B7D6-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217686>

"git checkout -" is a short-hand for "git checkout @{-1}" and the
"@{nth}" notation for a negative number is to find nth previous
checkout in the reflog of the HEAD to determine the name of the
branch the user was on.  We would want to find the nth most recent
reflog entry that matches "checkout: moving from X to Y" for this.

Unfortunately, reflog is implemented as an append-only file, and the
API to iterate over its entries, for_each_reflog_ent(), reads the
file in order, giving the entries from oldest to newer.  For the
purpose of finding nth most recent one, this API makes us to record
the last n entries in a rotating buffer and give the result out only
after we read everything.  To optimize for a common case of finding
the nth most recent one for a small value of n, we also have a side
API for_each_recent_reflog_ent() that starts reading near the end of
the file, but it still reads the entries in the "wrong" order.  The
implementation of understanding @{-1} uses this interface.

This all becomes unnecessary if we had an API to let us iterate over
reflog entries in the reverse order, from the newest to older.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c      | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 refs.h      |   2 +-
 sha1_name.c |  48 +++++++++++-----------------
 3 files changed, 105 insertions(+), 47 deletions(-)

diff --git a/refs.c b/refs.c
index e302521..8e24060 100644
--- a/refs.c
+++ b/refs.c
@@ -2318,30 +2318,89 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	return fn(osha1, nsha1, sb->buf + 82, timestamp, tz, message, cb_data);
 }
 
-int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long ofs, void *cb_data)
+static char *find_beginning_of_line(char *bob, char *scan)
+{
+	while (bob < scan && *(--scan) != '\n')
+		; /* keep scanning backwards */
+	/*
+	 * Return either beginning of the buffer, or LF at the end of
+	 * the previous line.
+	 */
+	return scan;
+}
+
+int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
 {
-	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
-	int ret = 0;
+	FILE *logfp;
+	long pos;
+	int ret = 0, at_tail = 1;
 
 	logfp = fopen(git_path("logs/%s", refname), "r");
 	if (!logfp)
 		return -1;
 
-	if (ofs) {
-		struct stat statbuf;
-		if (fstat(fileno(logfp), &statbuf) ||
-		    statbuf.st_size < ofs ||
-		    fseek(logfp, -ofs, SEEK_END) ||
-		    strbuf_getwholeline(&sb, logfp, '\n')) {
-			fclose(logfp);
-			strbuf_release(&sb);
-			return -1;
+	/* Jump to the end */
+	if (fseek(logfp, 0, SEEK_END) < 0)
+		return error("cannot seek back reflog for %s: %s",
+			     refname, strerror(errno));
+	pos = ftell(logfp);
+	while (!ret && 0 < pos) {
+		int cnt;
+		size_t nread;
+		char buf[BUFSIZ];
+		char *endp, *scanp;
+
+		/* Fill next block from the end */
+		cnt = (sizeof(buf) < pos) ? sizeof(buf) : pos;
+		if (fseek(logfp, pos - cnt, SEEK_SET))
+			return error("cannot seek back reflog for %s: %s",
+				     refname, strerror(errno));
+		nread = fread(buf, cnt, 1, logfp);
+		if (nread < 0)
+			return error("cannot read %d bytes from reflog for %s: %s",
+				     cnt, refname, strerror(errno));
+		pos -= cnt;
+
+		scanp = endp = buf + cnt;
+		if (at_tail && scanp[-1] == '\n')
+			/* Looking at the final LF at the end of the file */
+			scanp--;
+		at_tail = 0;
+
+		while (buf < scanp) {
+			/*
+			 * terminating LF of the previous line, or the beginning
+			 * of the buffer.
+			 */
+			char *bp;
+
+			bp = find_beginning_of_line(buf, scanp);
+
+			if (*bp != '\n') {
+				strbuf_splice(&sb, 0, 0, buf, endp - buf);
+				if (pos)
+					break; /* need to fill another block */
+				scanp = buf - 1; /* leave loop */
+			} else {
+				/*
+				 * (bp + 1) thru endp is the beginning of the
+				 * current line we have in sb
+				 */
+				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
+				scanp = bp;
+				endp = bp + 1;
+			}
+			ret = show_one_reflog_ent(&sb, fn, cb_data);
+			strbuf_reset(&sb);
+			if (ret)
+				break;
 		}
-	}
 
-	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
+	}
+	if (!ret && sb.len)
 		ret = show_one_reflog_ent(&sb, fn, cb_data);
+
 	fclose(logfp);
 	strbuf_release(&sb);
 	return ret;
@@ -2349,9 +2408,20 @@ int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long
 
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
 {
-	return for_each_recent_reflog_ent(refname, fn, 0, cb_data);
-}
+	FILE *logfp;
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	logfp = fopen(git_path("logs/%s", refname), "r");
+	if (!logfp)
+		return -1;
 
+	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
+		ret = show_one_reflog_ent(&sb, fn, cb_data);
+	fclose(logfp);
+	strbuf_release(&sb);
+	return ret;
+}
 /*
  * Call fn for each reflog in the namespace indicated by name.  name
  * must be empty or end with '/'.  Name will be used as a scratch
diff --git a/refs.h b/refs.h
index d6c2fe2..a62b9db 100644
--- a/refs.h
+++ b/refs.h
@@ -103,7 +103,7 @@ extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
-int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long, void *cb_data);
+int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
 /*
  * Calls the specified function for each reflog file until it returns nonzero,
diff --git a/sha1_name.c b/sha1_name.c
index 95003c7..635cd13 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -856,8 +856,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 }
 
 struct grab_nth_branch_switch_cbdata {
-	long cnt, alloc;
-	struct strbuf *buf;
+	int remaining;
+	struct strbuf buf;
 };
 
 static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
@@ -867,7 +867,6 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
 	const char *match = NULL, *target = NULL;
 	size_t len;
-	int nth;
 
 	if (!prefixcmp(message, "checkout: moving from ")) {
 		match = message + strlen("checkout: moving from ");
@@ -876,11 +875,12 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 
 	if (!match || !target)
 		return 0;
-
-	len = target - match;
-	nth = cb->cnt++ % cb->alloc;
-	strbuf_reset(&cb->buf[nth]);
-	strbuf_add(&cb->buf[nth], match, len);
+	if (--(cb->remaining) == 0) {
+		len = target - match;
+		strbuf_reset(&cb->buf);
+		strbuf_add(&cb->buf, match, len);
+		return 1; /* we are done */
+	}
 	return 0;
 }
 
@@ -891,7 +891,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
 {
 	long nth;
-	int i, retval;
+	int retval;
 	struct grab_nth_branch_switch_cbdata cb;
 	const char *brace;
 	char *num_end;
@@ -901,34 +901,22 @@ static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
 	brace = strchr(name, '}');
 	if (!brace)
 		return -1;
-	nth = strtol(name+3, &num_end, 10);
+	nth = strtol(name + 3, &num_end, 10);
 	if (num_end != brace)
 		return -1;
 	if (nth <= 0)
 		return -1;
-	cb.alloc = nth;
-	cb.buf = xmalloc(nth * sizeof(struct strbuf));
-	for (i = 0; i < nth; i++)
-		strbuf_init(&cb.buf[i], 20);
-	cb.cnt = 0;
+	cb.remaining = nth;
+	strbuf_init(&cb.buf, 20);
+
 	retval = 0;
-	for_each_recent_reflog_ent("HEAD", grab_nth_branch_switch, 40960, &cb);
-	if (cb.cnt < nth) {
-		cb.cnt = 0;
-		for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
+		strbuf_reset(buf);
+		strbuf_add(buf, cb.buf.buf, cb.buf.len);
+		retval = brace - name + 1;
 	}
-	if (cb.cnt < nth)
-		goto release_return;
-	i = cb.cnt % nth;
-	strbuf_reset(buf);
-	strbuf_add(buf, cb.buf[i].buf, cb.buf[i].len);
-	retval = brace-name+1;
-
-release_return:
-	for (i = 0; i < nth; i++)
-		strbuf_release(&cb.buf[i]);
-	free(cb.buf);
 
+	strbuf_release(&cb.buf);
 	return retval;
 }
 
-- 
1.8.2-rc3-189-g94c4d42
