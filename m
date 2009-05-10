From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] mktree --missing: allow missing objects
Date: Sun, 10 May 2009 11:49:51 -0700
Message-ID: <1241981391-19639-7-git-send-email-gitster@pobox.com>
References: <1241981391-19639-1-git-send-email-gitster@pobox.com>
 <1241981391-19639-2-git-send-email-gitster@pobox.com>
 <1241981391-19639-3-git-send-email-gitster@pobox.com>
 <1241981391-19639-4-git-send-email-gitster@pobox.com>
 <1241981391-19639-5-git-send-email-gitster@pobox.com>
 <1241981391-19639-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 20:50:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3E6S-0004rg-2N
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 20:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296AbZEJSuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 14:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756037AbZEJSuL
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 14:50:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbZEJSuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 14:50:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 31F3CB1B6A
	for <git@vger.kernel.org>; Sun, 10 May 2009 14:50:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5FBFBB1B69 for
 <git@vger.kernel.org>; Sun, 10 May 2009 14:50:05 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.9.g6345d
In-Reply-To: <1241981391-19639-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 60D5ACF8-3D93-11DE-B85E-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118739>

We need to allow input lines that point at objects that we do not
have when dealing with submodule entries anyway.  This adds an explicit
option to allow missing objects of other types, to be consistent with
the use of --info-only option to the update-index command and --missing-ok
option to the write-tree command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mktree.c  |   11 ++++++++---
 t/t1010-mktree.sh |   10 ++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin-mktree.c b/builtin-mktree.c
index 17cdb3d..c2fd0f2 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -67,7 +67,7 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, size_t len, int line_termination)
+static void mktree_line(char *buf, size_t len, int line_termination, int allow_missing)
 {
 	char *ptr, *ntr;
 	unsigned mode;
@@ -92,9 +92,12 @@ static void mktree_line(char *buf, size_t len, int line_termination)
 
 	/* It is perfectly normal if we do not have a commit from a submodule */
 	if (!S_ISGITLINK(mode))
+		allow_missing = 1;
+
+	if (!allow_missing)
 		type = sha1_object_info(sha1, NULL);
 	else
-		type = OBJ_COMMIT;
+		type = object_type(mode);
 
 	if (type < 0)
 		die("object %s unavailable", sha1_to_hex(sha1));
@@ -118,15 +121,17 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	struct strbuf sb = STRBUF_INIT;
 	unsigned char sha1[20];
 	int line_termination = '\n';
+	int allow_missing = 0;
 	const struct option option[] = {
 		OPT_SET_INT('z', NULL, &line_termination, "input is NUL terminated", '\0'),
+		OPT_SET_INT( 0 , "missing", &allow_missing, "allow missing objects", 1),
 		OPT_END()
 	};
 
 	ac = parse_options(ac, av, option, mktree_usage, 0);
 
 	while (strbuf_getline(&sb, stdin, line_termination) != EOF)
-		mktree_line(sb.buf, sb.len, line_termination);
+		mktree_line(sb.buf, sb.len, line_termination, allow_missing);
 
 	strbuf_release(&sb);
 
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 4d9b138..9956e3a 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -10,6 +10,11 @@ test_expect_success setup '
 		mkdir "$d" && echo "$d/one" >"$d/one" &&
 		git add "$d"
 	done &&
+	echo zero >one &&
+	git update-index --add --info-only one &&
+	git write-tree --missing-ok >tree.missing &&
+	git ls-tree $(cat tree.missing) >top.missing &&
+	git ls-tree -r $(cat tree.missing) >all.missing &&
 	echo one >one &&
 	git add one &&
 	git write-tree >tree &&
@@ -48,6 +53,11 @@ test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
 	test_cmp tree.withsub actual
 '
 
+test_expect_success 'allow missing object with --missing' '
+	git mktree --missing <top.missing >actual &&
+	test_cmp tree.missing actual
+'
+
 test_expect_failure 'mktree reads ls-tree -r output (1)' '
 	git mktree <all >actual &&
 	test_cmp tree actual
-- 
1.6.3.9.g6345d
