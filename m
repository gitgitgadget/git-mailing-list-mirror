From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] setup_revisions(): take pathspec from command line and
 --stdin correctly
Date: Wed, 11 May 2011 14:44:55 -0700
Message-ID: <7vd3jogbe0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 23:45:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKHDT-0006E7-Ad
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 23:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831Ab1EKVpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 17:45:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747Ab1EKVpB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 17:45:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A259B4142;
	Wed, 11 May 2011 17:47:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	XY0GcbpvjGVKCrlL4FQUukzeBE=; b=nr2CGGcW/aSTl4XIPZtxJtZBilUF9780d
	ns3EL0MAftyWAnAtPUMyyaT1O454nsWndY/GgZ3ykTkOeSS+i0gksN32xxzVLvd4
	5Nu5TprM9WzzXLMqK4f0ImPOOEJ9X5iyH48/tomAtrYRGBTGGwQEy8x7yffTrGZh
	Ui5Ay0+xbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=vQG
	QE8ERngS66Yn47bFM2W90WSPxk5fPW3d/EWNqyulyR1Nd2hOjZib5BfOo82JAa9q
	h3OzK43OC1utRh8kWuZzIj5C6y0ce6unAmcqNswFpeevSp8FRd6qoQZ1NH1Bl9V6
	wrICMw10i4++li7iVaAaqDM59zBa90d2VPPXY58Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E31A4141;
	Wed, 11 May 2011 17:47:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 534714140; Wed, 11 May 2011
 17:47:02 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35C5DEBE-7C18-11E0-BADA-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173429>

When the command line has "--" disambiguator, we take the remainder of
argv[] as "prune_data", but when --stdin is given at the same time, we
need to append to the existing prune_data and end up attempting to
realloc(3) it, which would not work and can lead to a segfault or worse.

Fix it by consistently using append_prune_data() throughout the input
processing.  Also avoid counting the number of existing paths in the
function over and over again.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is relative to 1.6.6; the bug originates back to 60da8b1 (Make
   --stdin option to "log" family read also pathspecs, 2009-11-20).

 revision.c                |   80 ++++++++++++++++-----------------------------
 t/t6017-rev-list-stdin.sh |   17 +++++++++
 2 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/revision.c b/revision.c
index c92ffc2..58b5651 100644
--- a/revision.c
+++ b/revision.c
@@ -956,35 +956,34 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
-static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb, const char ***prune_data)
-{
-	const char **prune = *prune_data;
-	int prune_nr;
-	int prune_alloc;
+struct cmdline_pathspec {
+	int alloc;
+	int nr;
+	const char **path;
+};
 
-	/* count existing ones */
-	if (!prune)
-		prune_nr = 0;
-	else
-		for (prune_nr = 0; prune[prune_nr]; prune_nr++)
-			;
-	prune_alloc = prune_nr; /* not really, but we do not know */
+static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
+{
+	while (*av) {
+		ALLOC_GROW(prune->path, prune->nr+1, prune->alloc);
+		prune->path[prune->nr++] = *(av++);
+	}
+}
 
+static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
+				     struct cmdline_pathspec *prune)
+{
 	while (strbuf_getwholeline(sb, stdin, '\n') != EOF) {
 		int len = sb->len;
 		if (len && sb->buf[len - 1] == '\n')
 			sb->buf[--len] = '\0';
-		ALLOC_GROW(prune, prune_nr+1, prune_alloc);
-		prune[prune_nr++] = xstrdup(sb->buf);
+		ALLOC_GROW(prune->path, prune->nr+1, prune->alloc);
+		prune->path[prune->nr++] = xstrdup(sb->buf);
 	}
-	if (prune) {
-		ALLOC_GROW(prune, prune_nr+1, prune_alloc);
-		prune[prune_nr] = NULL;
-	}
-	*prune_data = prune;
 }
 
-static void read_revisions_from_stdin(struct rev_info *revs, const char ***prune)
+static void read_revisions_from_stdin(struct rev_info *revs,
+				      struct cmdline_pathspec *prune)
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
@@ -1279,34 +1278,6 @@ static int for_each_good_bisect_ref(each_ref_fn fn, void *cb_data)
 	return for_each_ref_in("refs/bisect/good", fn, cb_data);
 }
 
-static void append_prune_data(const char ***prune_data, const char **av)
-{
-	const char **prune = *prune_data;
-	int prune_nr;
-	int prune_alloc;
-
-	if (!prune) {
-		*prune_data = av;
-		return;
-	}
-
-	/* count existing ones */
-	for (prune_nr = 0; prune[prune_nr]; prune_nr++)
-		;
-	prune_alloc = prune_nr; /* not really, but we do not know */
-
-	while (*av) {
-		ALLOC_GROW(prune, prune_nr+1, prune_alloc);
-		prune[prune_nr++] = *av;
-		av++;
-	}
-	if (prune) {
-		ALLOC_GROW(prune, prune_nr+1, prune_alloc);
-		prune[prune_nr] = NULL;
-	}
-	*prune_data = prune;
-}
-
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -1317,7 +1288,9 @@ static void append_prune_data(const char ***prune_data, const char **av)
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
 	int i, flags, left, seen_dashdash, read_from_stdin;
-	const char **prune_data = NULL;
+	struct cmdline_pathspec prune_data;
+
+	memset(&prune_data, 0, sizeof(prune_data));
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1328,7 +1301,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		argv[i] = NULL;
 		argc = i;
 		if (argv[i + 1])
-			prune_data = argv + i + 1;
+			append_prune_data(&prune_data, argv + i + 1);
 		seen_dashdash = 1;
 		break;
 	}
@@ -1420,8 +1393,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		}
 	}
 
-	if (prune_data)
-		revs->prune_data = get_pathspec(revs->prefix, prune_data);
+	if (prune_data.nr) {
+		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
+		prune_data.path[prune_data.nr++] = NULL;
+		revs->prune_data = get_pathspec(revs->prefix, prune_data.path);
+	}
 
 	if (revs->def == NULL)
 		revs->def = def;
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index f1c32db..667b375 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -58,4 +58,21 @@ check side-3 ^side-4 -- file-3
 check side-3 ^side-2
 check side-3 ^side-2 -- file-1
 
+test_expect_success 'not only --stdin' '
+	cat >expect <<-EOF &&
+	7
+
+	file-1
+	file-2
+	EOF
+	cat >input <<-EOF &&
+	^master^
+	--
+	file-2
+	EOF
+	git log --pretty=tformat:%s --name-only --stdin master -- file-1 \
+		<input >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.5.1.315.ge7efa
