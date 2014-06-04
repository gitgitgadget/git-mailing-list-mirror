From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 11/11] t9904: new __git_ps1 tests for Zsh
Date: Wed,  4 Jun 2014 17:01:27 -0400
Message-ID: <1401915687-8602-12-git-send-email-rhansen@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:02:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIKA-0005VM-2F
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbaFDVCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 17:02:10 -0400
Received: from smtp.bbn.com ([128.33.0.80]:12374 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbaFDVCD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:02:03 -0400
Received: from socket.bbn.com ([192.1.120.102]:34543)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsIJu-000IYc-PL; Wed, 04 Jun 2014 17:02:02 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7FD7A3FFFC
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250789>

These are the same tests as in t9903, but run in zsh instead of bash.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-zsh.sh          | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t9904-zsh-prompt.sh | 10 ++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 t/lib-zsh.sh
 create mode 100755 t/t9904-zsh-prompt.sh

diff --git a/t/lib-zsh.sh b/t/lib-zsh.sh
new file mode 100644
index 0000000..1fd69fd
--- /dev/null
+++ b/t/lib-zsh.sh
@@ -0,0 +1,52 @@
+# Shell library sourced instead of ./test-lib.sh by tests that need to
+# run under Zsh; primarily intended for tests of the git-prompt.sh
+# script.
+
+if test -n "$ZSH_VERSION" && test -z "$POSIXLY_CORRECT" && [[ ! -o FUNCTION_ARGZERO ]]; then
+	true
+elif command -v zsh >/dev/null 2>&1; then
+	unset POSIXLY_CORRECT
+	# Run Zsh with the FUNCTION_ARGZERO option disabled so that
+	# test-lib.sh sees the test script pathname when it examines
+	# $0 instead of "./lib-zsh.sh".  (This works around a Zsh
+	# limitation: 'emulate sh -c' does not restore $0 to the value
+	# specified by POSIX.)
+	exec zsh +o FUNCTION_ARGZERO "$0" "$@"
+else
+	echo '1..0 #SKIP skipping Zsh-specific tests; zsh not available'
+	exit 0
+fi
+
+# ensure that we are in full-on Zsh mode.  note: this re-enables the
+# FUNCTION_ARGZERO option
+emulate -R zsh || exit 1
+
+shellname=Zsh
+
+ps1_expansion_enable () { setopt PROMPT_SUBST; }
+ps1_expansion_disable () { unsetopt PROMPT_SUBST; }
+set_ps1_format_vars () {
+	percent='%%%%'
+	c_red='%%F{red}'
+	c_green='%%F{green}'
+	c_lblue='%%F{blue}'
+	c_clear='%%f'
+}
+
+# Due to language incompatibilities between POSIX sh and Zsh,
+# test-lib.sh must be sourced in sh emulation mode.
+#
+# Note: Although the FUNCTION_ARGZERO option is currently enabled, sh
+# emulation mode temporarily turns it off ($0 is left alone when
+# sourcing test-lib.sh)
+emulate -R sh -c '. ./test-lib.sh'
+
+# Ensure that the test code is run in Zsh mode.  Because test_eval_()
+# was defined by test-lib.sh inside the above 'emulate sh -c', the Zsh
+# shell options that implement sh emulation will be temporarily
+# toggled when test_eval_() executes.  Normally this would cause the
+# test code to run in sh emulation mode, not Zsh mode.  By defining
+# test_eval_override() in zsh emulation mode, the options are
+# temporarily toggled back to the Zsh defaults when evaluating the
+# test code.
+emulate -R zsh -c 'test_eval_override () { eval "$*"; }'
diff --git a/t/t9904-zsh-prompt.sh b/t/t9904-zsh-prompt.sh
new file mode 100755
index 0000000..a38a3fd
--- /dev/null
+++ b/t/t9904-zsh-prompt.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='test git-specific Zsh prompt functions'
+
+. ./lib-zsh.sh
+. "$TEST_DIRECTORY"/lib-prompt-tests.sh
+
+run_prompt_tests
+
+test_done
-- 
2.0.0
