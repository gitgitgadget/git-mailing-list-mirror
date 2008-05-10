From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow tracking branches to set up rebase by default.
Date: Sat, 10 May 2008 11:41:16 -0700
Message-ID: <7vfxsq9f3n.fsf@gitster.siamese.dyndns.org>
References: <7vprrycce9.fsf@gitster.siamese.dyndns.org>
 <1210271287-36719-1-git-send-email-dustin@spy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dustin Sallings <dustin@spy.net>
X-From: git-owner@vger.kernel.org Sat May 10 20:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juu1S-0003JS-OA
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 20:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbYEJSl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 14:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbYEJSl1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 14:41:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbYEJSl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 14:41:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 295752BF9;
	Sat, 10 May 2008 14:41:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 80CE12BF4; Sat, 10 May 2008 14:41:20 -0400 (EDT)
In-Reply-To: <1210271287-36719-1-git-send-email-dustin@spy.net> (Dustin
 Sallings's message of "Thu, 8 May 2008 11:28:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B1809DCC-1EC0-11DD-AD21-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81691>

The patch is looking better.

I'd suggest further fixes like the attached patch to address the following
issues:

 - Do not ignore misconfiguration, but diagnose it.

 - die_bad_config() takes a variable name without surrounding explanatory
   text.  If you actually tested your patch and looked at the error
   message, it would have been blatantly obvious and you would have
   noticed it.  Not a good sign.

 - Test not just the success cases but failure cases; test not just
   explicitly configured cases but also default cases.

The last one is something everybody tends to forget, but is very
important.  It is human nature that anybody would eagerly want to
demonstrate what new things their shiny new toy does, but would forget to
make sure that it does not take effect when people do not want it (either
saying 'never' which you do have test, which is good, or not asking for it
by not setting the variable, which you didn't).  You'd notice that I
played lazy and added a check for only the "tracked remote" case when the
new variable is left unspecified, but you might want to add tests for
other variants.  Also I suspect that we would want to test cases where
autosetuprebase is given but autosetupmerge is not.

Another thing we might want to address is to move parsing of branch.*
configuration variables out of git_default_config().  They are unnecessary
for majority of commands that do not create new branches.  But that would
be a separate topic if we were to do so.


 config.c          |    8 +++++---
 t/t3200-branch.sh |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 7d76986..cf2bfd3 100644
--- a/config.c
+++ b/config.c
@@ -487,8 +487,10 @@ int git_default_config(const char *var, const char *value)
 		git_branch_track = git_config_bool(var, value);
 		return 0;
 	}
-	if (value && !strcmp(var, "branch.autosetuprebase")) {
-		if (!strcmp(value, "never"))
+	if (!strcmp(var, "branch.autosetuprebase")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "never"))
 			autorebase = AUTOREBASE_NEVER;
 		else if (!strcmp(value, "local"))
 			autorebase = AUTOREBASE_LOCAL;
@@ -497,7 +499,7 @@ int git_default_config(const char *var, const char *value)
 		else if (!strcmp(value, "always"))
 			autorebase = AUTOREBASE_ALWAYS;
 		else
-			die_bad_config("Invalid value for branch.autosetupmerge");
+			return error("Malformed value for %s", var);
 		return 0;
 	}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d11dd41..5cfeaa7 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -144,6 +144,18 @@ test_expect_success 'test tracking setup (non-wildcard, not matching)' \
      ! test "$(git config branch.my5.remote)" = local &&
      ! test "$(git config branch.my5.merge)" = refs/heads/master'
 
+test_expect_success 'detect misconfigured autosetuprebase' '
+	git config branch.autosetuprebase garbage &&
+	test_must_fail git branch
+'
+
+test_expect_success 'detect misconfigured autosetuprebase' '
+	git config --unset branch.autosetuprebase &&
+	echo "[branch] autosetuprebase" >>.git/config &&
+	test_must_fail git branch &&
+	git config --unset branch.autosetuprebase
+'
+
 test_expect_success 'test tracking setup via config' \
     'git config branch.autosetupmerge true &&
      git config remote.local.url . &&
@@ -316,4 +328,16 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	test "$(git config branch.myr8.rebase)" = true
 '
 
+test_expect_success 'without autosetuprebase' '
+	git config --unset branch.autosetuprebase
+
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	git branch --track myr9 local/master &&
+	test "$(git config branch.myr9.remote)" = local &&
+	test "$(git config branch.myr9.merge)" = refs/heads/master &&
+	test "z$(git config branch.myr9.rebase)" = "z"
+'
+
 test_done
