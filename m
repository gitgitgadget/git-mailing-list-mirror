From: larsxschneider@gmail.com
Subject: [PATCH v5 4/7] git-p4: add file streaming progress in verbose mode
Date: Mon, 14 Sep 2015 15:26:31 +0200
Message-ID: <1442237194-49624-5-git-send-email-larsxschneider@gmail.com>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 15:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbTn7-0003A2-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 15:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbbINN1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 09:27:23 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34225 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbbINN1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 09:27:21 -0400
Received: by wicfx3 with SMTP id fx3so140248484wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w6wMZNervhUATD7QIJDR44+cHqjXJQgHbuEydG5QrW4=;
        b=b/DEcv0edUjvM6KZQLSfzea/1m9psLNqi2KZpAes8nooPXGguS8ywQ97EwHww46myI
         Vwq5gqlbhzxPis+E/r49UUgTFPVdl/ujZ+JnzkWvDQKQcGJKxiIeV69ZafDZv+He4nNl
         ieI8hdkIbHyEo3ipZwJWyVJAn+3AXbeROka1JWNVIL6aht7eqEuK8GrFcsWAiZUJlssq
         pNzgbxXuziclfo1yW3f24E7IILGOSsAuGbErIbKXZBSenKn0pKGy/PkMRnl11rMb1y7X
         5lD0mFl3pDwaHT5HYtPlL+1QE2Robe8r7uPObHFonCKc3a/N0rPr+oqPZlM5p1jX+5/f
         +cZA==
X-Received: by 10.194.60.71 with SMTP id f7mr29972899wjr.15.1442237240549;
        Mon, 14 Sep 2015 06:27:20 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xt1sm12578013wjb.32.2015.09.14.06.26.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 06:26:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277823>

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
