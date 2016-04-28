From: larsxschneider@gmail.com
Subject: [PATCH v4 3/3] git-p4: fix Git LFS pointer parsing
Date: Thu, 28 Apr 2016 08:26:33 +0200
Message-ID: <1461824793-43235-4-git-send-email-larsxschneider@gmail.com>
References: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, gitster@pobox.com, ben.woosley@gmail.com,
	sunshine@sunshineco.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 08:26:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avfPR-0006RM-LH
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbcD1G0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 02:26:42 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38641 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbcD1G0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 02:26:40 -0400
Received: by mail-wm0-f50.google.com with SMTP id g17so23530912wme.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 23:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ySXMoeg/kOs08T6qigmRUuroYSMZVpHNE03gsL3izAM=;
        b=AvNLV2f98cTrNDITZ5Cd3YUkky2GoSPingEX7s30ZIXmv7zGF9oSTSzdtH3VFGHWfj
         mpRD14RB2kkU4qSKae/xB9BdL4nKtUdg5nIZ9JKhWhU2GdXyOm0f0lA24b6nYx5rfCrD
         IgDQeKDDBDoCNlRgUj59ixhXsWKNNf4qdxxIj/lNnyTrotRfVqEMKUyqii+AbRzatQ5b
         mjc19kSS9cSuEAASa9lfg5m5C/oUmGSI2Kxgo9Q5ECSmIwupYq2DhSUA3BZs2HKRutCw
         EJ0XqH4Ey6Ka3WS4cxxbc3V3uzu+hCzdVdFexo7DYEBHGaopNUU2Ubfh1XvrKQB+7R12
         H3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ySXMoeg/kOs08T6qigmRUuroYSMZVpHNE03gsL3izAM=;
        b=SzbsNl9dVmKr5URpiMyJ/m57zSZQO9KvrqXbYnX5tI97Sz0YTHyIqmDyUyyja0aZa5
         nuYDK6S9M+GuDSAQIJStEsPMeay/yQK1dIrgHGTm3yCy1y79htICjEtKG02Vtk6rGB1B
         piSHZxd1icGPRbtb+HgQFJhfBnrPl20pYqKrez/yDjrMeBYClY7JBaepg4vkt6vWQiz7
         H3GP5zv7fc4o0Xr5kBdQt1pTnXkpsHzKp0pY7jmDorSXjug6m3cRRHygTd1Tz7XBuMi2
         u8mWkB4CGwGOxgjwQ/m3ZFHOSIwSpjFKgt3/GvgQ+HaC2EtpSQwK2rqGTRfqiciFF1oI
         e3Xw==
X-Gm-Message-State: AOPr4FWX615Tw4jE9p7YKWgz5IU3k2RddpxyCf61MlMiTPS1skHy4NwIyG202lQit+HTOQ==
X-Received: by 10.194.88.201 with SMTP id bi9mr13026103wjb.147.1461824799178;
        Wed, 27 Apr 2016 23:26:39 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BAD07.dip0.t-ipconnect.de. [80.139.173.7])
        by smtp.gmail.com with ESMTPSA id y91sm12225405wmh.10.2016.04.27.23.26.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 23:26:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1461824793-43235-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292848>

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
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py                 | 13 ++++++++++---
 t/t9824-git-p4-git-lfs.sh |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 527d44b..8ab48f2 100755
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
+            pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
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
