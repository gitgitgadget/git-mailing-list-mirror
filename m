From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] completion: Handle '!f() { ... }; f' aliases
Date: Sat,  7 Jun 2014 16:10:21 +0200
Message-ID: <1402150221-25548-1-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 17:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtIHJ-0007NP-9W
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 17:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbaFGPLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 11:11:25 -0400
Received: from mailer.zib.de ([130.73.108.11]:39820 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbaFGPLY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 11:11:24 -0400
X-Greylist: delayed 3630 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jun 2014 11:11:24 EDT
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s57EArDt018330
	for <git@vger.kernel.org>; Sat, 7 Jun 2014 16:10:53 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s57EAqWZ018252;
	Sat, 7 Jun 2014 16:10:53 +0200 (CEST)
X-Mailer: git-send-email 1.9.0.258.g00eda23
X-Miltered: at mailer.zib.de with ID 53931D6D.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53931D6D.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53931D6D.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251044>

'!f() { ... }; f' is a recommended pattern to declare more complex
aliases (see git wiki [1]).  This commit teaches the completion to
handle them.

When determining which completion to use for an alias, the opening brace
is now ignored in order to continue the search for a git command inside
the function body.  For example, the alias '!f() { git commit ... }' now
triggers commit completion.  Previously, the search stopped on '{', and
the completion tried it to determine how to complete, which obviously
was useless.

Furthermore, the null command ':' is now skipped, so that it can be used
as a workaround to declare the desired completion style.  For example,
the alias '!f() { : git commit ; if ...  ' now triggers commit
completion.

[1] https://git.wiki.kernel.org/index.php/Aliases

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 contrib/completion/git-completion.bash |  7 +++++++
 t/t9902-completion.sh                  | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c59a76..aecb975 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -21,6 +21,11 @@
 #        source ~/.git-completion.sh
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
+#
+# If you use complex aliases of form '!f() { ... }; f', you can use the null
+# command ':' as the first command in the function body to declare the desired
+# completion style.  For example '!f() { : git commit ; ... }; f' will
+# tell the completion to use commit completion.
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -781,6 +786,8 @@ __git_aliased_command ()
 		-*)	: option ;;
 		*=*)	: setting env ;;
 		git)	: git itself ;;
+		{)	: skip start of shell helper function ;;
+		:)	: skip null command ;;
 		*)
 			echo "$word"
 			return
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2d4beb5..ea48681 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -550,6 +550,26 @@ test_expect_success 'complete files' '
 	test_completion "git add mom" "momified"
 '
 
+test_expect_success 'completion uses <cmd> completion for alias !f() { VAR=val git <cmd> ... }' '
+	git config alias.co "!f() { VAR=val git checkout ... ; } f" &&
+	test_completion "git co m" <<-\EOF &&
+	master Z
+	mybranch Z
+	mytag Z
+	EOF
+	git config --unset alias.co
+'
+
+test_expect_success 'completion used <cmd> completion for alias !f() { : git <cmd> ; ... }' '
+	git config alias.co "!f() { : git checkout ; if ... } f" &&
+	test_completion "git co m" <<-\EOF &&
+	master Z
+	mybranch Z
+	mytag Z
+	EOF
+	git config --unset alias.co
+'
+
 test_expect_failure 'complete with tilde expansion' '
 	git init tmp && cd tmp &&
 	test_when_finished "cd .. && rm -rf tmp" &&
-- 
2.0.0.244.g4e8e734
