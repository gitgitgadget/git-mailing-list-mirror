From: Crestez Dan Leonard <cdleonard@gmail.com>
Subject: [PATCH] git p4 submit: Add --{skip-,}edit-submit option
Date: Wed, 26 Feb 2014 14:26:45 +0200
Message-ID: <a6da387cdf3214fd7216ff980d2916aae055d4d9.1393417604.git.cdleonard@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------true"
Cc: Pete Wyckoff <pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 13:27:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIda9-0003gR-2F
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 13:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbaBZM1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 07:27:03 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:42565 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaBZM0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 07:26:55 -0500
Received: by mail-ee0-f47.google.com with SMTP id e49so481106eek.34
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type;
        bh=Y2x/w0CnUGLoQt5h0JqUa2Qpo7iZWpjZbJbPNo5HkxM=;
        b=MuReXBzH8vJ/0MVedb70IqCUrz7RyOUd2Add3SdFPM9rgGiC4ekESjPT4VUQ52ZWhh
         1ojJbfV68exUgnuf5dVFS7bKsO6bk3vFnMvIj01s9jOJU80jFgkvHNC+8AvY9ntvzUK/
         rVjkVvaB6bx6FRvZAWSQaNeVMUU2gg/E6WNkgrpgGVtYFMQC6UnVPokmUn8nOUU0VyAO
         E+sIes4AiU4mpom+38a3aKRZR92qE/A3bCZXBCb9nkYinBNNJ3zSg8jCxYXgILWWX1gL
         1+A+wm0bJNbfHlhazaAK7Rk0q6csJZd8poSBSb/eGtROkCRSXCGe4WRjDfxWTZp8cv+g
         duiw==
X-Received: by 10.15.27.200 with SMTP id p48mr2432234eeu.105.1393417614730;
        Wed, 26 Feb 2014 04:26:54 -0800 (PST)
Received: from ixro-lcrestez-lin.ixiacom.com ([212.146.94.66])
        by mx.google.com with ESMTPSA id j41sm3145019eeg.10.2014.02.26.04.26.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2014 04:26:52 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242729>

This is a multi-part message in MIME format.
--------------true
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This allows skipping interactively editting the p4 changelist before
submit. This is useful for pushing series of patches to p4 quickly.

This was already possible through a config option.

Signed-off-by: Crestez Dan Leonard <cdleonard@gmail.com>
---
 Documentation/git-p4.txt |  4 ++++
 git-p4.py                | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)


--------------true
Content-Type: text/x-patch; name="0001-git-p4-submit-Add-skip-edit-submit-option.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-git-p4-submit-Add-skip-edit-submit-option.patch"

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 6ab5f94..619f45f 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -299,6 +299,10 @@ These options can be used to modify 'git p4 submit' behavior.
 	to bypass the prompt, causing conflicting commits to be automatically
 	skipped, or to quit trying to apply commits, without prompting.
 
+--skip-submit-edit --edit-submit::
+	Edit the changelist before template or not. This defaults to true,
+	unless overridden by the git-p4.skipSubmitEdit config option.
+
 --branch <branch>::
 	After submitting, sync this named branch instead of the default
 	p4/master.  See the "Sync options" section above for more
diff --git a/git-p4.py b/git-p4.py
index cdfa2df..cafd997 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -998,6 +998,10 @@ class P4Submit(Command, P4UserMap):
                 optparse.make_option("--prepare-p4-only", dest="prepare_p4_only", action="store_true"),
                 optparse.make_option("--conflict", dest="conflict_behavior",
                                      choices=self.conflict_behavior_choices),
+                optparse.make_option("--skip-edit-submit", dest="edit_submit", action="store_true",
+                        help="Skip editting the changelist before submit"),
+                optparse.make_option("--edit-submit", dest="edit_submit", action="store_false",
+                        help="Edit the changelist before submit (default)"),
                 optparse.make_option("--branch", dest="branch"),
         ]
         self.description = "Submit changes from git to the perforce depot."
@@ -1203,12 +1207,17 @@ class P4Submit(Command, P4UserMap):
 
         return template
 
+    def get_edit_submit_value(self):
+        if hasattr(self, 'edit_submit'):
+            return self.edit_submit
+        return gitConfigBool('git-p4.skipSubmitEdit')
+
     def edit_template(self, template_file):
         """Invoke the editor to let the user change the submission
            message.  Return true if okay to continue with the submit."""
 
         # if configured to skip the editing part, just submit
-        if gitConfigBool("git-p4.skipSubmitEdit"):
+        if self.get_edit_submit_value():
             return True
 
         # look at the modification time, to check later if the user saved

--------------true--
