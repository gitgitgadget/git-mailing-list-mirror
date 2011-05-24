From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] handle_options(): do not miscount how many arguments were
 used
Date: Tue, 24 May 2011 14:15:02 -0700
Message-ID: <7vsjs37qcp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Kazuki Tsujimoto <kazuki@callcc.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 23:15:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOywk-0006Oq-Rl
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102Ab1EXVPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:15:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab1EXVPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:15:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D2B25DB7;
	Tue, 24 May 2011 17:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	LjGZsXmS+ansylVCFBQpWATeUU=; b=r2XA3eEMzyC/EJc6SXxMfbkd9txOEM6JD
	lZOAsjDqzfxdBV0t11RKZGHZXH0d/pzdXXWDsW2QZMs88zms6c9pUvlcIDCLZd2n
	fIQ7oiyYPSmvAczzrbnCPSp6l0S6x/JD0EsFrangexv9G7DlryxdzI4DD/CVORHh
	VeNcsW/FhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=MEuDhb0+0Oc4u4jujCetKtaPQcfIH0fqrNrNzpBsglNOmcFHFAmJXKYL
	8oFxhYTPhUjow23xFn6k7zzbbxbZl5yoE+b7Gdw7W9mL9HH5tShV90c/2G4GJRX0
	OaYcsxVtWYohDKGdHp6jtencWE4O6IVwjaxlKW8PtTyGevHkgqA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC5485DB5;
	Tue, 24 May 2011 17:17:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E7A635DB4; Tue, 24 May 2011
 17:17:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 343CF752-864B-11E0-B55A-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174343>

The handle_options() function advances the base of the argument array and
returns the number of arguments it used. The caller in handle_alias()
wants to reallocate the argv array it passes to this function, and
attempts to do so by subtracting the returned value to compensate for the
change handle_options() makes to the new_argv.

But handle_options() did not correctly count when "-c <config=value>" is
given, causing a wrong pointer to be passed to realloc().

Fix it by saving the original argv at the beginning of handle_options(),
and return the difference between the final value of argv, which will
relieve the places that move the array pointer from the additional burden
of keeping track of "handled" counter.

Noticed-by: Kazuki Tsujimoto
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This fixes 8b1fa77 (Allow passing of configuration parameters in the
   command line, 2010-03-26), and when applied there, the new test passes,
   but if applied to newer codebase, the test fails for a different
   reason, for which another fix will be sent out separately.

 git.c                  |    6 ++----
 t/t1300-repo-config.sh |   10 ++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 1753811..55c2eda 100644
--- a/git.c
+++ b/git.c
@@ -53,7 +53,7 @@ static void commit_pager_choice(void) {
 
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
-	int handled = 0;
+	const char **orig_argv = *argv;
 
 	if (!getenv("GIT_ASKPASS") && getenv("SSH_ASKPASS"))
 		setenv("GIT_ASKPASS", getenv("SSH_ASKPASS"), 1);
@@ -106,7 +106,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
@@ -146,9 +145,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 
 		(*argv)++;
 		(*argc)--;
-		handled++;
 	}
-	return handled;
+	return (*argv) - orig_argv;
 }
 
 static int handle_alias(int *argcp, const char ***argv)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 64f0508..5f6766d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -832,4 +832,14 @@ test_expect_success 'git -c "key=value" support' '
 	test_must_fail git -c core.name=value config name
 '
 
+test_expect_success 'alias to give a configuration value' '
+	echo "foo and space " >foo &&
+	git diff HEAD >foo.patch &&
+	git checkout foo &&
+	git config alias.aw "-c apply.whitespace=fix apply" &&
+	git aw foo.patch &&
+	echo "foo and space" >expect &&
+	test_cmp expect foo
+'
+
 test_done
-- 
1.7.5.2.459.g67e41
