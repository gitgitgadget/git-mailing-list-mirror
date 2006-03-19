From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/3] git.el: Get the default user name and email from the repository config.
Date: Sun, 19 Mar 2006 10:05:48 +0100
Message-ID: <87wteqby8j.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 19 10:05:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKtrK-0006oL-37
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 10:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWCSJFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 04:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWCSJFy
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 04:05:54 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:47045 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751471AbWCSJFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 04:05:53 -0500
Received: from adsl-84-226-35-143.adslplus.ch ([84.226.35.143] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FKtrC-0005DT-HA
	for git@vger.kernel.org; Sun, 19 Mar 2006 03:05:53 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 4FEAA4F657; Sun, 19 Mar 2006 10:05:48 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.226.35.143
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17710>

If user name or email are not set explicitly, get them from the
user.name and user.email configuration values before falling back to
the Emacs defaults.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

ac4b54cc4019abdb92cd0fbbf7c644976227fea0
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index cf650da..5496a1b 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -59,14 +59,14 @@
 
 (defcustom git-committer-name nil
   "User name to use for commits.
-The default is to fall back to `add-log-full-name' and then `user-full-name'."
+The default is to fall back to the repository config, then to `add-log-full-name' and then to `user-full-name'."
   :group 'git
   :type '(choice (const :tag "Default" nil)
                  (string :tag "Name")))
 
 (defcustom git-committer-email nil
   "Email address to use for commits.
-The default is to fall back to `add-log-mailing-address' and then `user-mail-address'."
+The default is to fall back to the git repository config, then to `add-log-mailing-address' and then to `user-mail-address'."
   :group 'git
   :type '(choice (const :tag "Default" nil)
                  (string :tag "Email")))
@@ -203,6 +203,7 @@ The default is to fall back to `add-log-
   "Return the name to use as GIT_COMMITTER_NAME."
   ; copied from log-edit
   (or git-committer-name
+      (git-repo-config "user.name")
       (and (boundp 'add-log-full-name) add-log-full-name)
       (and (fboundp 'user-full-name) (user-full-name))
       (and (boundp 'user-full-name) user-full-name)))
@@ -211,6 +212,7 @@ The default is to fall back to `add-log-
   "Return the email address to use as GIT_COMMITTER_EMAIL."
   ; copied from log-edit
   (or git-committer-email
+      (git-repo-config "user.email")
       (and (boundp 'add-log-mailing-address) add-log-mailing-address)
       (and (fboundp 'user-mail-address) (user-mail-address))
       (and (boundp 'user-mail-address) user-mail-address)))
@@ -268,6 +270,11 @@ The default is to fall back to `add-log-
   (git-get-string-sha1
    (git-call-process-env-string nil "rev-parse" rev)))
 
+(defun git-repo-config (key)
+  "Retrieve the value associated to KEY in the git repository config file."
+  (let ((str (git-call-process-env-string nil "repo-config" key)))
+    (and str (car (split-string str "\n")))))
+
 (defun git-symbolic-ref (ref)
   "Wrapper for the git-symbolic-ref command."
   (let ((str (git-call-process-env-string nil "symbolic-ref" ref)))
-- 
1.2.4.g9c5a7

-- 
Alexandre Julliard
julliard@winehq.org
