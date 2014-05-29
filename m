From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 11/10] fixup! t9904: new __git_ps1 tests for Zsh
Date: Thu, 29 May 2014 18:30:33 -0400
Message-ID: <1401402633-14742-1-git-send-email-rhansen@bbn.com>
References: <87fvjsmmr4.fsf@thomasrast.ch>
Cc: git@vger.kernel.org, rhansen@bbn.com
To: tr@thomasrast.ch
X-From: git-owner@vger.kernel.org Fri May 30 00:30:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq8qW-00068I-DW
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 00:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbaE2Wan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 18:30:43 -0400
Received: from smtp.bbn.com ([128.33.0.80]:62145 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbaE2Wan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 18:30:43 -0400
Received: from socket.bbn.com ([192.1.120.102]:34205)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Wq8qO-0003qD-5J; Thu, 29 May 2014 18:30:40 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id DACB740BE2
X-Mailer: git-send-email 2.0.0
In-Reply-To: <87fvjsmmr4.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250409>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---

On 2014-05-29 15:02, Thomas Rast wrote:
> Richard Hansen <rhansen@bbn.com> writes:
>
>> These are the same tests as in t9903, but run in zsh instead of bash.
>>
>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>> ---
>>  t/lib-zsh.sh          | 30 ++++++++++++++++++++++++++++++
>>  t/t9904-zsh-prompt.sh | 10 ++++++++++
>>  2 files changed, 40 insertions(+)
>>  create mode 100644 t/lib-zsh.sh
>>  create mode 100755 t/t9904-zsh-prompt.sh
>
> This doesn't appear to work in valgrind mode:
>
> $ ./t9904-zsh-prompt.sh --valgrind
> error: Test script did not set test_description.
>
> t9903 however works.  I'm not sure how much of a difference it makes,
> but: I use bash as my shell and as /bin/sh, but I do have zsh installed.
>
> Can you look into it?

*sigh* By default, Zsh munges $0 whenever a function is called or a
file is sourced, with no (immediately obvious) way to get the original
value of $0.  This fixup causes that feature to be temporarily turned
off so that test-lib.sh does the right thing when it execs $0.

Thank you for finding this bug!

-Richard


 t/lib-zsh.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/lib-zsh.sh b/t/lib-zsh.sh
index fa6fcd9..ab4bef2 100644
--- a/t/lib-zsh.sh
+++ b/t/lib-zsh.sh
@@ -2,17 +2,23 @@
 # run under Zsh; primarily intended for tests of the git-prompt.sh
 # script.
 
-if test -n "$ZSH_VERSION" && test -z "$POSIXLY_CORRECT"; then
+if test -n "$ZSH_VERSION" && test -z "$POSIXLY_CORRECT" && [[ ! -o FUNCTION_ARGZERO ]]; then
 	true
 elif command -v zsh >/dev/null 2>&1; then
 	unset POSIXLY_CORRECT
-	exec zsh "$0" "$@"
+	# Run Zsh with the FUNCTION_ARGZERO option disabled so that
+	# test-lib.sh sees the test script pathname when it examines
+	# $0 instead of "./lib-zsh.sh".  (This works around a Zsh bug;
+	# 'emulate sh -c' should temporarily restore $0 to the POSIX
+	# specification for $0, but it doesn't.)
+	exec zsh +o FUNCTION_ARGZERO "$0" "$@"
 else
 	echo '1..0 #SKIP skipping Zsh-specific tests; zsh not available'
 	exit 0
 fi
 
-# ensure that we are in full-on Zsh mode
+# ensure that we are in full-on Zsh mode.  note: this re-enables the
+# FUNCTION_ARGZERO option
 emulate -R zsh || exit 1
 
 shellname=Zsh
@@ -27,4 +33,7 @@ set_ps1_format_vars () {
 	c_clear='%%f'
 }
 
+# note: although the FUNCTION_ARGZERO option is currently enabled, sh
+# emulation mode temporarily turns it off ($0 is left alone when
+# sourcing test-lib.sh)
 emulate sh -c '. ./test-lib.sh'
-- 
2.0.0
