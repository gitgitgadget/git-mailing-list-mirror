From: larsxschneider@gmail.com
Subject: [PATCH v8 4/7] git-p4: add file streaming progress in verbose mode
Date: Sat, 26 Sep 2015 09:55:01 +0200
Message-ID: <1443254104-14966-5-git-send-email-larsxschneider@gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 09:55:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfkKm-0007RZ-Fn
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 09:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbbIZHzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 03:55:47 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37201 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbIZHze (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 03:55:34 -0400
Received: by wicfx3 with SMTP id fx3so44295512wic.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w6wMZNervhUATD7QIJDR44+cHqjXJQgHbuEydG5QrW4=;
        b=ijhKSMhfC2BGrWrRp/uxFFXuC8maCIphpObRCRRXT24usJd+Qvj1PSIPqYflxfQKY6
         nGnPqHBUunK31pzqp7W5pDtdhrGMr+HWLagpk4iiPno/Ze2sFag6qY19y8Po+7ZBG38Z
         kx8YxVA6EvAyYvzeUX84pokSvcLGUf4+eNv37Ss1dx0XZ7E+wyWGe4y/mizlLUAf//Ap
         ZdZ3r2nMulkGmLMFo/2nqLWpi8PxPV9gRKlR/g8Fx2vJJ7Rkhh97iN9/3EfBsKqkPzMI
         SLE/StGbY1QGg2nKzAeASVGQFnyYbUawbmaZrWlXc6Huomvx2BWbNytmeuuZZb1qvhPR
         u3iA==
X-Received: by 10.180.107.164 with SMTP id hd4mr8041759wib.94.1443254133240;
        Sat, 26 Sep 2015 00:55:33 -0700 (PDT)
Received: from localhost.localdomain (tmo-102-235.customers.d1-online.com. [80.187.102.235])
        by smtp.gmail.com with ESMTPSA id it4sm7176613wjb.0.2015.09.26.00.55.30
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Sep 2015 00:55:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278687>

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
index 90d3b90..e7a7ea4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2164,7 +2164,9 @@ class P4Sync(Command, P4UserMap):
     def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         if verbose:
-            sys.stderr.write("%s\n" % relPath)
+            size = int(self.stream_file['fileSize'])
+            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
 
@@ -2241,7 +2243,8 @@ class P4Sync(Command, P4UserMap):
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
         if verbose:
-            sys.stderr.write("delete %s\n" % relPath)
+            sys.stdout.write("delete %s\n" % relPath)
+            sys.stdout.flush()
         self.gitStream.write("D %s\n" % relPath)
 
     # handle another chunk of streaming data
@@ -2281,10 +2284,23 @@ class P4Sync(Command, P4UserMap):
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
