From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Sun, 16 Dec 2007 23:28:41 -0800
Message-ID: <7vd4t5eq52.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<20071213102636.GD12398@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4APg-0000Vy-NW
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 08:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934AbXLQH24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 02:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755539AbXLQH24
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 02:28:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646AbXLQH2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 02:28:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 18C45558B;
	Mon, 17 Dec 2007 02:28:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DB6845588;
	Mon, 17 Dec 2007 02:28:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68509>

The command freely used optional option-argments for its -l and -n options.
I think allowing "git tag -n xxx" without barfing was an error to begin with,
but not supporting "git tag -l pattern" form is a serious regression.

So this fixes the handling of -l to reinstate the original behaviour while
detecting a user error "git tag -l pattern garbage", and adjusts tests that
use "-n param" form to use "-nparam".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-tag.c  |   15 +++++++-
 t/t7004-tag.sh |  110 +++++++++++++++++++++++++------------------------------
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 274901a..5213c62 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -371,7 +371,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	int annotate = 0, sign = 0, force = 0, lines = 0,
 					delete = 0, verify = 0;
-	char *list = NULL, *msgfile = NULL, *keyid = NULL;
+	const char *list = NULL, *msgfile = NULL, *keyid = NULL;
 	const char *no_pattern = "NO_PATTERN";
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct option options[] = {
@@ -407,8 +407,19 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (sign)
 		annotate = 1;
 
-	if (list)
+	if (list) {
+		/*
+		 * This is unfortunate but requiring "git tag -lpattern" and not
+		 * allowing "git tag -l pattern" is a serious regression.
+		 */
+		if (argc && list == no_pattern) {
+			list = argv[0];
+			argc--;
+		}
+		if (argc)
+			die("extra argument after -l[pattern]: %s", argv[0]);
 		return list_tags(list == no_pattern ? NULL : list, lines);
+	}
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 09d56e0..7f58038 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -491,25 +491,19 @@ test_expect_success \
 	echo "tag-one-line" >expect &&
 	git-tag -l | grep "^tag-one-line" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l | grep "^tag-one-line" >actual &&
+	git-tag -n0 -l | grep "^tag-one-line" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l tag-one-line >actual &&
+	git-tag -n0 -l tag-one-line >actual &&
 	git diff expect actual &&
 
 	echo "tag-one-line    A msg" >expect &&
-	git-tag -n xxx -l | grep "^tag-one-line" >actual &&
-	git diff expect actual &&
-	git-tag -n "" -l | grep "^tag-one-line" >actual &&
-	git diff expect actual &&
-	git-tag -n 1 -l | grep "^tag-one-line" >actual &&
-	git diff expect actual &&
 	git-tag -n -l | grep "^tag-one-line" >actual &&
 	git diff expect actual &&
-	git-tag -n 1 -l tag-one-line >actual &&
+	git-tag -n1 -l | grep "^tag-one-line" >actual &&
 	git diff expect actual &&
-	git-tag -n 2 -l tag-one-line >actual &&
+	git-tag -n2 -l tag-one-line >actual &&
 	git diff expect actual &&
-	git-tag -n 999 -l tag-one-line >actual &&
+	git-tag -n999 -l tag-one-line >actual &&
 	git diff expect actual
 '
 
@@ -520,21 +514,21 @@ test_expect_success \
 	echo "tag-zero-lines" >expect &&
 	git-tag -l | grep "^tag-zero-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l | grep "^tag-zero-lines" >actual &&
+	git-tag -n0 -l | grep "^tag-zero-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l tag-zero-lines >actual &&
+	git-tag -n0 -l tag-zero-lines >actual &&
 	git diff expect actual &&
 
 	echo "tag-zero-lines  " >expect &&
-	git-tag -n 1 -l | grep "^tag-zero-lines" >actual &&
+	git-tag -n1 -l | grep "^tag-zero-lines" >actual &&
 	git diff expect actual &&
 	git-tag -n -l | grep "^tag-zero-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 1 -l tag-zero-lines >actual &&
+	git-tag -n1 -l tag-zero-lines >actual &&
 	git diff expect actual &&
-	git-tag -n 2 -l tag-zero-lines >actual &&
+	git-tag -n2 -l tag-zero-lines >actual &&
 	git diff expect actual &&
-	git-tag -n 999 -l tag-zero-lines >actual &&
+	git-tag -n999 -l tag-zero-lines >actual &&
 	git diff expect actual
 '
 
@@ -548,37 +542,37 @@ test_expect_success \
 	echo "tag-lines" >expect &&
 	git-tag -l | grep "^tag-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l | grep "^tag-lines" >actual &&
+	git-tag -n0 -l | grep "^tag-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l tag-lines >actual &&
+	git-tag -n0 -l tag-lines >actual &&
 	git diff expect actual &&
 
 	echo "tag-lines       tag line one" >expect &&
-	git-tag -n 1 -l | grep "^tag-lines" >actual &&
+	git-tag -n1 -l | grep "^tag-lines" >actual &&
 	git diff expect actual &&
 	git-tag -n -l | grep "^tag-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 1 -l tag-lines >actual &&
+	git-tag -n1 -l tag-lines >actual &&
 	git diff expect actual &&
 
 	echo "    tag line two" >>expect &&
-	git-tag -n 2 -l | grep "^ *tag.line" >actual &&
+	git-tag -n2 -l | grep "^ *tag.line" >actual &&
 	git diff expect actual &&
-	git-tag -n 2 -l tag-lines >actual &&
+	git-tag -n2 -l tag-lines >actual &&
 	git diff expect actual &&
 
 	echo "    tag line three" >>expect &&
-	git-tag -n 3 -l | grep "^ *tag.line" >actual &&
+	git-tag -n3 -l | grep "^ *tag.line" >actual &&
 	git diff expect actual &&
-	git-tag -n 3 -l tag-lines >actual &&
+	git-tag -n3 -l tag-lines >actual &&
 	git diff expect actual &&
-	git-tag -n 4 -l | grep "^ *tag.line" >actual &&
+	git-tag -n4 -l | grep "^ *tag.line" >actual &&
 	git diff expect actual &&
-	git-tag -n 4 -l tag-lines >actual &&
+	git-tag -n4 -l tag-lines >actual &&
 	git diff expect actual &&
-	git-tag -n 99 -l | grep "^ *tag.line" >actual &&
+	git-tag -n99 -l | grep "^ *tag.line" >actual &&
 	git diff expect actual &&
-	git-tag -n 99 -l tag-lines >actual &&
+	git-tag -n99 -l tag-lines >actual &&
 	git diff expect actual
 '
 
@@ -906,25 +900,21 @@ test_expect_success \
 	echo "stag-one-line" >expect &&
 	git-tag -l | grep "^stag-one-line" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l | grep "^stag-one-line" >actual &&
+	git-tag -n0 -l | grep "^stag-one-line" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l stag-one-line >actual &&
+	git-tag -n0 -l stag-one-line >actual &&
 	git diff expect actual &&
 
 	echo "stag-one-line   A message line signed" >expect &&
-	git-tag -n xxx -l | grep "^stag-one-line" >actual &&
-	git diff expect actual &&
-	git-tag -n "" -l | grep "^stag-one-line" >actual &&
-	git diff expect actual &&
-	git-tag -n 1 -l | grep "^stag-one-line" >actual &&
-	git diff expect actual &&
 	git-tag -n -l | grep "^stag-one-line" >actual &&
 	git diff expect actual &&
-	git-tag -n 1 -l stag-one-line >actual &&
+	git-tag -n1 -l | grep "^stag-one-line" >actual &&
 	git diff expect actual &&
-	git-tag -n 2 -l stag-one-line >actual &&
+	git-tag -n1 -l stag-one-line >actual &&
 	git diff expect actual &&
-	git-tag -n 999 -l stag-one-line >actual &&
+	git-tag -n2 -l stag-one-line >actual &&
+	git diff expect actual &&
+	git-tag -n999 -l stag-one-line >actual &&
 	git diff expect actual
 '
 
@@ -935,21 +925,21 @@ test_expect_success \
 	echo "stag-zero-lines" >expect &&
 	git-tag -l | grep "^stag-zero-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l | grep "^stag-zero-lines" >actual &&
+	git-tag -n0 -l | grep "^stag-zero-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l stag-zero-lines >actual &&
+	git-tag -n0 -l stag-zero-lines >actual &&
 	git diff expect actual &&
 
 	echo "stag-zero-lines " >expect &&
-	git-tag -n 1 -l | grep "^stag-zero-lines" >actual &&
-	git diff expect actual &&
 	git-tag -n -l | grep "^stag-zero-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 1 -l stag-zero-lines >actual &&
+	git-tag -n1 -l | grep "^stag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n1 -l stag-zero-lines >actual &&
 	git diff expect actual &&
-	git-tag -n 2 -l stag-zero-lines >actual &&
+	git-tag -n2 -l stag-zero-lines >actual &&
 	git diff expect actual &&
-	git-tag -n 999 -l stag-zero-lines >actual &&
+	git-tag -n999 -l stag-zero-lines >actual &&
 	git diff expect actual
 '
 
@@ -963,37 +953,37 @@ test_expect_success \
 	echo "stag-lines" >expect &&
 	git-tag -l | grep "^stag-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l | grep "^stag-lines" >actual &&
+	git-tag -n0 -l | grep "^stag-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 0 -l stag-lines >actual &&
+	git-tag -n0 -l stag-lines >actual &&
 	git diff expect actual &&
 
 	echo "stag-lines      stag line one" >expect &&
-	git-tag -n 1 -l | grep "^stag-lines" >actual &&
-	git diff expect actual &&
 	git-tag -n -l | grep "^stag-lines" >actual &&
 	git diff expect actual &&
-	git-tag -n 1 -l stag-lines >actual &&
+	git-tag -n1 -l | grep "^stag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n1 -l stag-lines >actual &&
 	git diff expect actual &&
 
 	echo "    stag line two" >>expect &&
-	git-tag -n 2 -l | grep "^ *stag.line" >actual &&
+	git-tag -n2 -l | grep "^ *stag.line" >actual &&
 	git diff expect actual &&
-	git-tag -n 2 -l stag-lines >actual &&
+	git-tag -n2 -l stag-lines >actual &&
 	git diff expect actual &&
 
 	echo "    stag line three" >>expect &&
-	git-tag -n 3 -l | grep "^ *stag.line" >actual &&
+	git-tag -n3 -l | grep "^ *stag.line" >actual &&
 	git diff expect actual &&
-	git-tag -n 3 -l stag-lines >actual &&
+	git-tag -n3 -l stag-lines >actual &&
 	git diff expect actual &&
-	git-tag -n 4 -l | grep "^ *stag.line" >actual &&
+	git-tag -n4 -l | grep "^ *stag.line" >actual &&
 	git diff expect actual &&
-	git-tag -n 4 -l stag-lines >actual &&
+	git-tag -n4 -l stag-lines >actual &&
 	git diff expect actual &&
-	git-tag -n 99 -l | grep "^ *stag.line" >actual &&
+	git-tag -n99 -l | grep "^ *stag.line" >actual &&
 	git diff expect actual &&
-	git-tag -n 99 -l stag-lines >actual &&
+	git-tag -n99 -l stag-lines >actual &&
 	git diff expect actual
 '
 
-- 
1.5.4.rc0.54.g3eb2
