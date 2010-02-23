From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 1/2] shell setup: clear_local_git_env() function
Date: Tue, 23 Feb 2010 09:30:28 +0100
Message-ID: <1266913829-14533-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a1002222355s38fda032g99623f44d6200fbc@mail.gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 09:37:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjqGn-0002N5-UA
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 09:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab0BWIhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 03:37:24 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51927 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab0BWIhX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 03:37:23 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2010 03:37:23 EST
Received: by wya21 with SMTP id 21so492258wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mO/nqzjPLawK4Z2nUCmID+iqhvm2K08npRQZLkQQYVQ=;
        b=jiBm8Rlhg6xzxBSvlgXk4p95jGd97gWDmR8L0SKAB1+z1AHKYDpDmjf+AVrDRoWsic
         6DBmHW8cl+dnYt+eY7ZIBjCIMwLdSYpBdacF2c+IObkcacTWXMcBOP9xX8ejcmBkkbWf
         SVxO+T/+snz7xe56alUypipULE2UdYguMXz4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F4Klysqqv2vIsJZpMQBpank/3eFOc6JOAQYksEEKEhuhrbauca/FhN6AmIOVFrxKAF
         nLzlRm9rAU34GOSsmsCC7YmSFCPMlz7WTcPiq0nUYJn4lnpGVIYkU0GVNyhnRUUq8xdy
         ognv+V19kszGm8hx9bXKAWERT471+ZNLFFT5M=
Received: by 10.216.163.207 with SMTP id a57mr3333891wel.220.1266913837679;
        Tue, 23 Feb 2010 00:30:37 -0800 (PST)
Received: from localhost ([151.60.177.169])
        by mx.google.com with ESMTPS id u14sm16779122gvf.2.2010.02.23.00.30.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 00:30:37 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
In-Reply-To: <cb7bb73a1002222355s38fda032g99623f44d6200fbc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140777>

Introduce an auxiliary function to clear all repo-local environment
variables. This should be invoked by any shell script that switches
repository during execution, to ensure that the environment is clean
and that things such as the git dir and worktree are set up correctly.

The list matches the one in git_connect(), so bring them in sync by adding
the missing CONFIG_ENVIRONMENT. Also add a note about the fact that they
should be kept that way.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 connect.c       |    2 ++
 git-sh-setup.sh |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 9f39038..12dd0b5 100644
--- a/connect.c
+++ b/connect.c
@@ -583,8 +583,10 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	}
 	else {
 		/* remove these from the environment */
+		/* see also clear_local_git_env() in git-sh-setup.sh */
 		const char *env[] = {
 			ALTERNATE_DB_ENVIRONMENT,
+			CONFIG_ENVIRONMENT,
 			DB_ENVIRONMENT,
 			GIT_DIR_ENVIRONMENT,
 			GIT_WORK_TREE_ENVIRONMENT,
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7a09566..f1be832 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -172,6 +172,21 @@ get_author_ident_from_commit () {
 	LANG=C LC_ALL=C sed -ne "$pick_author_script"
 }
 
+# Clear repo-local GIT_* environment variables. Useful when switching to
+# another repository (e.g. when entering a submodule). See also the env
+# list in git_connect()
+clear_local_git_env() {
+	unset	GIT_ALTERNATE_OBJECT_DIRECTORIES \
+		GIT_CONFIG \
+		GIT_DIR \
+		GIT_GRAFT_FILE \
+		GIT_INDEX_FILE \
+		GIT_NO_REPLACE_OBJECTS \
+		GIT_OBJECT_DIRECTORY \
+		GIT_WORKTREE
+
+}
+
 # Make sure we are in a valid repository of a vintage we understand,
 # if we require to be in a git repository.
 if test -z "$NONGIT_OK"
-- 
1.7.0.200.g5ba36.dirty
