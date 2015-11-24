From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] git-p4: clean up after p4 submit failure
Date: Tue, 24 Nov 2015 07:43:59 +0000
Message-ID: <1448351039-15625-2-git-send-email-luke@diamand.org>
References: <1448351039-15625-1-git-send-email-luke@diamand.org>
Cc: sunshine@sunshineco.com, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net, egirard@murex.com, larsxschneider@gmail.com,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 08:44:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a18H1-0005gY-6e
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 08:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbbKXHoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 02:44:17 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35179 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbbKXHoO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 02:44:14 -0500
Received: by pacej9 with SMTP id ej9so13856857pac.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZTmlr2xbRbSuN3lqCSEr/MuAL0ji/fwoAU9I9eqi7Vk=;
        b=LHlokoFwUHYC8Q3Xh6i9hT85gn955UN0QgdQ4b9CisG+uXfkBGHW/BJTFNBaEZWcFr
         Lqut4URXPUT6WdzqSFoLrYOy8F3Cw6vzEksO8AaQl4apTw6DCxsDCOQtv0TKNAW6MBro
         9WKaK7lytcSy/q3zagHgHpkDSOE7m8Y11Gs+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZTmlr2xbRbSuN3lqCSEr/MuAL0ji/fwoAU9I9eqi7Vk=;
        b=bpVEsrnR92GzWKVJfsAiVMQ1+kmMMAXqEoZ1YEtOPbnii/tmHdy7mIiNw04VUjyXQc
         yuv9/kNBRJ0IvXgQzAXT4Yur8WMpzeEmp7oCMR5RHpCYHNtTsjpIRnUPIDKpPXaZMkW/
         1ykTr9LzHfxlWxs/DEaC77NyxLQEogSAxS1CiW2PO4jwLXHGObF8DofRJQJ1uZqQRmI9
         36BE0jj68bwh3Yem/zJrhCKWeuQSXx4pLNuOqfVxL5iACpPZtWdO4FycV4dR8LeDz5NE
         FLa7bdab2qHWHZGGZbSe27WJQNmIIDYsUxYX2lwFVxzgCZZHZvFnTTCvOIipQfDPzr/9
         XLQQ==
X-Gm-Message-State: ALoCoQnxn4B85ho5odzevvqEQxY/Ln+fC9gRU71mOlwdxgWYO8rq5RH7PaDekTnSGTFgc7qrZPb0
X-Received: by 10.98.73.1 with SMTP id w1mr21147096pfa.103.1448351054104;
        Mon, 23 Nov 2015 23:44:14 -0800 (PST)
Received: from lgd-kipper.corp.roku ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id ij3sm13058078pbb.62.2015.11.23.23.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2015 23:44:13 -0800 (PST)
X-Mailer: git-send-email 2.6.3.492.g06488d6
In-Reply-To: <1448351039-15625-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281611>

From: GIRARD Etienne <egirard@murex.com>

When "p4 submit" command fails in P4Submit.applyCommit, the
workspace is left with the changes.  We already have code to revert
the changes to the workspace when the user decides to cancel
submission by aborting the editor that edits the change description,
and we should treat the "p4 submit" failure the same way.

Clean the workspace if p4_write_pipe raised SystemExit, so that the
user don't have to do it themselves.

Signed-off-by: GIRARD Etienne <egirard@murex.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                | 71 +++++++++++++++++++++++++-----------------------
 t/t9807-git-p4-submit.sh |  2 +-
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0093fa3..d535904 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1538,44 +1538,47 @@ class P4Submit(Command, P4UserMap):
         #
         # Let the user edit the change description, then submit it.
         #
-        if self.edit_template(fileName):
-            # read the edited message and submit
-            ret = True
-            tmpFile = open(fileName, "rb")
-            message = tmpFile.read()
-            tmpFile.close()
-            if self.isWindows:
-                message = message.replace("\r\n", "\n")
-            submitTemplate = message[:message.index(separatorLine)]
-            p4_write_pipe(['submit', '-i'], submitTemplate)
-
-            if self.preserveUser:
-                if p4User:
-                    # Get last changelist number. Cannot easily get it from
-                    # the submit command output as the output is
-                    # unmarshalled.
-                    changelist = self.lastP4Changelist()
-                    self.modifyChangelistUser(changelist, p4User)
-
-            # The rename/copy happened by applying a patch that created a
-            # new file.  This leaves it writable, which confuses p4.
-            for f in pureRenameCopy:
-                p4_sync(f, "-f")
+        submitted = False
 
-        else:
+        try:
+            if self.edit_template(fileName):
+                # read the edited message and submit
+                tmpFile = open(fileName, "rb")
+                message = tmpFile.read()
+                tmpFile.close()
+                if self.isWindows:
+                    message = message.replace("\r\n", "\n")
+                submitTemplate = message[:message.index(separatorLine)]
+                p4_write_pipe(['submit', '-i'], submitTemplate)
+
+                if self.preserveUser:
+                    if p4User:
+                        # Get last changelist number. Cannot easily get it from
+                        # the submit command output as the output is
+                        # unmarshalled.
+                        changelist = self.lastP4Changelist()
+                        self.modifyChangelistUser(changelist, p4User)
+
+                # The rename/copy happened by applying a patch that created a
+                # new file.  This leaves it writable, which confuses p4.
+                for f in pureRenameCopy:
+                    p4_sync(f, "-f")
+                submitted = True
+
+        finally:
             # skip this patch
-            ret = False
-            print "Submission cancelled, undoing p4 changes."
-            for f in editedFiles:
-                p4_revert(f)
-            for f in filesToAdd:
-                p4_revert(f)
-                os.remove(f)
-            for f in filesToDelete:
-                p4_revert(f)
+            if not submitted:
+                print "Submission cancelled, undoing p4 changes."
+                for f in editedFiles:
+                    p4_revert(f)
+                for f in filesToAdd:
+                    p4_revert(f)
+                    os.remove(f)
+                for f in filesToDelete:
+                    p4_revert(f)
 
         os.remove(fileName)
-        return ret
+        return submitted
 
     # Export git tags as p4 labels. Create a p4 label and then tag
     # with that.
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 1f74a88..5931528 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -389,7 +389,7 @@ test_expect_success 'description with Jobs section and bogus following text' '
 	(
 		cd "$cli" &&
 		p4 revert desc6 &&
-		rm desc6
+		rm -f desc6
 	)
 '
 
-- 
2.6.3.492.g06488d6
