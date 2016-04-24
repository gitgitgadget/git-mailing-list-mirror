From: larsxschneider@gmail.com
Subject: [PATCH v3 3/3] git-p4: fix Git LFS pointer parsing
Date: Sun, 24 Apr 2016 20:58:12 +0200
Message-ID: <1461524292-20490-4-git-send-email-larsxschneider@gmail.com>
References: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, gitster@pobox.com, ben.woosley@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 20:58:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPEj-0006I5-Jf
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 20:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbcDXS6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 14:58:23 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38060 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbcDXS6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 14:58:20 -0400
Received: by mail-wm0-f45.google.com with SMTP id u206so96931095wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SONxqjXX5Z3ux8UuqWQ9vmWPhYzyFotDHXrf9gVJm2Q=;
        b=M9fdNYcY1JGpeoFDYcJX36SWLKSfvzrf1onhku7maKLixWmh2heOBMFw7lnJ94cD8Q
         5fj+3fZQvZUJwhW80vMI+TQpbT9K2mZp8stS+VGW/gN7MXPLA4uVkqjW9asCqXIn8JOj
         9ln3s7at5MagAHcsvvy4hoGSjZH7QZwm6/86IRl79/ddyntTAFZtozTuuCbAE2CNVg0R
         4zQVLkwxV3vkTEwPcEVsn4srjSMOc3GJvoRIMKpzxiH24ll+ni8QEwzY8qhlWEY2PFr0
         5t3LGCBb7UgMbZnq8rUPfa4Aeej7oA59flKAO5S6QAgWUBBKGoFRGkTU9gCR/iTrsNnI
         0aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SONxqjXX5Z3ux8UuqWQ9vmWPhYzyFotDHXrf9gVJm2Q=;
        b=b0LwAYpbWCAD18xrAIt1luot4SBGHyXhGmUb6mupO6YGK1dAUy6Yx3d94e/NGFDLT+
         zahoC/k09f4xPviVEHMYY67pWuTaJUgkAVTkLTNsgQha605TJ13ej4cXl4aCdBV3ogpw
         3N8Nm/8Jk7dqP5ZTnpsNsRG5GywKxcOSiJrcjH2HijAiP+DOyIorD9YzXMvbHnH5QQm+
         c9B5/txfcY8qDBZI+sEb1pfWVNO9oOfQkYhXOIoY5+pXjhErwXE/u6aw+7UXPyV/JPoT
         oifT1VtLHsCKzP2OS+2VTRslSwDTleiuaSw9fFs26eT1XTH2gFqFQfiM5WDHUA0Snj7e
         VDaw==
X-Gm-Message-State: AOPr4FUTp2aBwFzaBn9t29pzpLvDA6pjpmSdVka6X6UnYVyRvad0BH0u68/1vKU3BrbWDQ==
X-Received: by 10.28.130.6 with SMTP id e6mr8641867wmd.94.1461524299272;
        Sun, 24 Apr 2016 11:58:19 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BA7B8.dip0.t-ipconnect.de. [80.139.167.184])
        by smtp.gmail.com with ESMTPSA id d79sm14948541wmi.23.2016.04.24.11.58.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 11:58:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292428>

From: Lars Schneider <larsxschneider@gmail.com>

Git LFS 1.2.0 removed a preamble from the output of the 'git lfs pointer'
command [1] which broke the parsing of this output. Adjust the parser
to support the old and the new format.

Please note that this patch slightly changes the second return parameter
from a list of LF terminated strings to a single string that contains
a number of LF characters.

[1] https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Helped-by: Sebastian Schuberth <sschuberth@gmail.com>
Helped-by: Ben Woosley <ben.woosley@gmail.com>
---
 git-p4.py                 | 13 ++++++++++---
 t/t9824-git-p4-git-lfs.sh |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 527d44b..f92a4bc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1064,8 +1064,15 @@ class GitLFS(LargeFileSystem):
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
-        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
-        oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
+
+        # Git LFS removed the preamble in the output of the 'pointer' command
+        # starting from version 1.2.0. Check for the preamble here to support
+        # earlier versions.
+        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
+        if pointerFile.startswith('Git LFS pointer for'):
+            re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
+
+        oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
         localLargeFile = os.path.join(
             os.getcwd(),
             '.git', 'lfs', 'objects', oid[:2], oid[2:4],
@@ -1073,7 +1080,7 @@ class GitLFS(LargeFileSystem):
         )
         # LFS Spec states that pointer files should not have the executable bit set.
         gitMode = '100644'
-        return (gitMode, pointerContents, localLargeFile)
+        return (gitMode, pointerFile, localLargeFile)
 
     def pushFile(self, localLargeFile):
         uploadProcess = subprocess.Popen(
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index 0b664a3..ca93ac8 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -13,6 +13,10 @@ test_file_in_lfs () {
 	FILE="$1" &&
 	SIZE="$2" &&
 	EXPECTED_CONTENT="$3" &&
+	sed -n '1,1 p' "$FILE" | grep "^version " &&
+	sed -n '2,2 p' "$FILE" | grep "^oid " &&
+	sed -n '3,3 p' "$FILE" | grep "^size " &&
+	test_line_count = 3 "$FILE" &&
 	cat "$FILE" | grep "size $SIZE" &&
 	HASH=$(cat "$FILE" | grep "oid sha256:" | sed -e "s/oid sha256://g") &&
 	LFS_FILE=".git/lfs/objects/$(echo "$HASH" | cut -c1-2)/$(echo "$HASH" | cut -c3-4)/$HASH" &&
-- 
2.5.1
