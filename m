From: larsxschneider@gmail.com
Subject: [PATCH v7 4/7] git-p4: add file streaming progress in verbose mode
Date: Tue, 22 Sep 2015 00:41:10 +0200
Message-ID: <1442875273-48610-5-git-send-email-larsxschneider@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:41:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9mN-0000tR-0W
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933102AbbIUWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:41:38 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36211 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbbIUWlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:41:24 -0400
Received: by wicgb1 with SMTP id gb1so135410448wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ytJAU6XgC1j9U8/PAD/M4ClnUYnUx6fscnjD109qv8=;
        b=VFp8dh28N2MZGSCWV5o6dW+YaSMgJM4R2MY7OSPVD2ixLUGa6MaWpd1cIIwUPNJ6gF
         DR1Q6/QMiCsmeN6SEZbZoI4uCiRit3igjHr+5QUJ8C+gNi1NfNS7T7m4kzBBxQfornOT
         SWrl8DgttQcUZyWIdIeN9hAi+9ucco/WZwGQ7oOwBf57bA7eSjIoXtdFWXKKgfq/55Xi
         Dk5rXqiJjQlRp1/TRQTG1mjyCzbu7Nj1Q8IdR+fK6xGzBaudCIcZsMfhmuSLPT9fy437
         l6mke6F6W0na3jNNSv9lyMoGC3CdIFAUlW0lUTNRJXLnwrgLCEIEuRvLlDFBNdZ8FYrx
         QH4g==
X-Received: by 10.180.90.166 with SMTP id bx6mr12708580wib.93.1442875283022;
        Mon, 21 Sep 2015 15:41:23 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s16sm121516wik.13.2015.09.21.15.41.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 15:41:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278356>

From: Lars Schneider <larsxschneider@gmail.com>

If a file is streamed from P4 to Git then the verbose mode prints
continuously the progress as percentage like this:
//depot/file.bin 20% (10 MB)

Upon completion the progress is overwritten with depot source, local
file and size like this:
//depot/file.bin --> local/file.bin (10 MB)

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e7d1b3f..fabc900 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2171,7 +2171,9 @@ class P4Sync(Command, P4UserMap):
     def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         if verbose:
-            sys.stderr.write("%s\n" % relPath)
+            size = int(self.stream_file['fileSize'])
+            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
 
@@ -2258,7 +2260,8 @@ class P4Sync(Command, P4UserMap):
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
         if verbose:
-            sys.stderr.write("delete %s\n" % relPath)
+            sys.stdout.write("delete %s\n" % relPath)
+            sys.stdout.flush()
         self.gitStream.write("D %s\n" % relPath)
 
     # handle another chunk of streaming data
@@ -2298,10 +2301,23 @@ class P4Sync(Command, P4UserMap):
         # 'data' field we need to append to our array
         for k in marshalled.keys():
             if k == 'data':
+                if 'streamContentSize' not in self.stream_file:
+                    self.stream_file['streamContentSize'] = 0
+                self.stream_file['streamContentSize'] += len(marshalled['data'])
                 self.stream_contents.append(marshalled['data'])
             else:
                 self.stream_file[k] = marshalled[k]
 
+        if (verbose and
+            'streamContentSize' in self.stream_file and
+            'fileSize' in self.stream_file and
+            'depotFile' in self.stream_file):
+            size = int(self.stream_file["fileSize"])
+            if size > 0:
+                progress = 100*self.stream_file['streamContentSize']/size
+                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                sys.stdout.flush()
+
         self.stream_have_file_info = True
 
     # Stream directly from "p4 files" into "git fast-import"
-- 
2.5.1
