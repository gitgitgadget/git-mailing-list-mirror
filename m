From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2] completion: Handle '!f() { ... }; f' and "!sh -c '...'" aliases
Date: Thu, 12 Jun 2014 20:49:29 +0200
Message-ID: <1402598969-31401-1-git-send-email-prohaska@zib.de>
References: <62610ABB-4ED5-4CF1-B5B2-B89C9DD22FBD@zib.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:50:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvA4f-0005NR-QU
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaFLSuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:50:00 -0400
Received: from mailer.zib.de ([130.73.108.11]:57690 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbaFLSt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 14:49:59 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s5CInsNk011803;
	Thu, 12 Jun 2014 20:49:54 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s5CInsxr011788;
	Thu, 12 Jun 2014 20:49:54 +0200 (CEST)
X-Mailer: git-send-email 1.9.0.258.g00eda23
In-Reply-To: <62610ABB-4ED5-4CF1-B5B2-B89C9DD22FBD@zib.de>
X-Miltered: at mailer.zib.de with ID 5399F652.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5399F652.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 5399F652.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251477>

'!f() { ... }; f' and "!sh -c '....'" are recommended patterns for
declaring more complex aliases (see git wiki [1]).  This commit teaches
the completion to handle them.

When determining which completion to use for an alias, an opening brace
or single quote is now skipped, and the search for a git command is
continued.  For example, the aliases '!f() { git commit ... }' or "!sh
-c 'git commit ...'" now trigger commit completion.  Previously, the
search stopped on the opening brace or quote, and the completion tried
it to determine how to complete, which obviously was useless.

The null command ':' is now skipped, so that it can be used as
a workaround to declare the desired completion style.  For example, the
aliases '!f() { : git commit ; if ...  ' and "!sh -c ': git commit; if
...'" now trigger commit completion.

Shell function declarations now work with or without space before
the parens, i.e. '!f() ...' and '!f () ...' both work.

[1] https://git.wiki.kernel.org/index.php/Aliases

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 contrib/completion/git-completion.bash | 10 ++++++++++
 t/t9902-completion.sh                  | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c59a76..575f8f7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -21,6 +21,12 @@
 #        source ~/.git-completion.sh
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.
+#
+# If you use complex aliases of form '!f() { ... }; f', you can use the null
+# command ':' as the first command in the function body to declare the desired
+# completion style.  For example '!f() { : git commit ; ... }; f' will
+# tell the completion to use commit completion.  This also works with aliases
+# of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -781,6 +787,10 @@ __git_aliased_command ()
 		-*)	: option ;;
 		*=*)	: setting env ;;
 		git)	: git itself ;;
+		\(\))   : skip parens of shell function definition ;;
+		{)	: skip start of shell helper function ;;
+		:)	: skip null command ;;
+		\'*)	: skip opening quote after sh -c ;;
 		*)
 			echo "$word"
 			return
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2d4beb5..1d1c106 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -550,6 +550,33 @@ test_expect_success 'complete files' '
 	test_completion "git add mom" "momified"
 '
 
+test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
+	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
+	test_completion "git co m" <<-\EOF
+	master Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
+test_expect_success 'completion uses <cmd> completion for alias: !f () { VAR=val git <cmd> ... }' '
+	test_config alias.co "!f () { VAR=val git checkout ... ; } f" &&
+	test_completion "git co m" <<-\EOF
+	master Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
+test_expect_success 'completion used <cmd> completion for alias: !f() { : git <cmd> ; ... }' '
+	test_config alias.co "!f() { : git checkout ; if ... } f" &&
+	test_completion "git co m" <<-\EOF
+	master Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
 test_expect_failure 'complete with tilde expansion' '
 	git init tmp && cd tmp &&
 	test_when_finished "cd .. && rm -rf tmp" &&
-- 
2.0.0.244.g4e8e734
