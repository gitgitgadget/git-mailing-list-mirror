From: larsxschneider@gmail.com
Subject: [PATCH v6 4/7] git-p4: add file streaming progress in verbose mode
Date: Sun, 20 Sep 2015 22:26:24 +0200
Message-ID: <1442780787-65166-5-git-send-email-larsxschneider@gmail.com>
References: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 22:27:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdlCQ-0003Z3-R9
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 22:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbbITU07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 16:26:59 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38402 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbbITU0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 16:26:35 -0400
Received: by wiclk2 with SMTP id lk2so87353615wic.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w6wMZNervhUATD7QIJDR44+cHqjXJQgHbuEydG5QrW4=;
        b=QxvxQf7hZwgvC7xLJHNz/rT2MImZQ91h8AVhB18PMiq8RrmBlgeDmpH29OrJqxDl/l
         or2usp+75x5ZcfOwb3mesjzWXmooGDHHKy54QtEPTSVSe7T5IoSddh0qEESNUe/XsP1q
         YEUqhcfdGWQI/mEAIPm/pAMS057HNzSrms48KClqAtyEicYh1Cx7taVz7944LNFXkRbW
         gaDYssZgfcdru48k4lqelxvC8MP6AxPk3hlx56aOOYppzt8yxf05e1+lVgZ2WFfO6giK
         hgRMA3QfN/6nwDscCEg0e0Nth+M+MtYWN9kNJK+iqdpb7TqBT/gvqfiGbzmjb+r65FsJ
         i+ZA==
X-Received: by 10.180.74.47 with SMTP id q15mr10292783wiv.73.1442780794623;
        Sun, 20 Sep 2015 13:26:34 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id go2sm9869879wib.20.2015.09.20.13.26.33
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 13:26:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278263>

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
