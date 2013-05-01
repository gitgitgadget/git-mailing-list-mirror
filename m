From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/18] remote-bzr: delay blob fetching until the very end
Date: Tue, 30 Apr 2013 20:09:54 -0500
Message-ID: <1367370610-14250-3-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLaS-00073I-2O
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933958Ab3EABLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:11:48 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:48325 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933572Ab3EABLk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:11:40 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so210325yho.30
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fSul3m68z5nzTbnVRs/BLux2HLoDdrMt30z6fRFoL6I=;
        b=GKm6N4anFP94KT0tARK6bUu9zQv9tvnu1CgkkdXkWMp4oHeAEemg+Z7fZ600CfYAwB
         3yShBXWstHq9IO+No8wnGnR4TzPd/HfQbmO5i7Ud0xnjRjOVfrM0vl16e27EcCwGELco
         sUePksa6dMQ4uKuRUzQTNdHUgXygUr1yl6+cbvTPYZ5JYoX9VyxEMHm5oq0/B4C+2Lwe
         gwa9RvpLgdtfOP4AwrxcEKoxHeXcyc0IPeHE09ehBM5OV0abwZWY3hs7mNj5fqwhkzwN
         xPt7RGjCYEdyWzMJSsVO4QhiJA+JzcWRYhR/ffnDJ6ORXWj3MO3OgznEkVOhKj2/NnN4
         XnIg==
X-Received: by 10.236.31.66 with SMTP id l42mr602658yha.143.1367370700014;
        Tue, 30 Apr 2013 18:11:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id f71sm1622270yha.8.2013.04.30.18.11.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:11:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223048>

Might be more efficient, but the real reason to use the marks will be
revealed in upcoming patches.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7452a57..91b5cda 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -506,10 +506,12 @@ class CustomTree():
         return changes
 
     def get_file_with_stat(self, file_id, path=None):
-        return (StringIO.StringIO(self.updates[file_id]['data']), None)
+        mark = self.updates[file_id]['mark']
+        return (StringIO.StringIO(blob_marks[mark]), None)
 
     def get_symlink_target(self, file_id):
-        return self.updates[file_id]['data']
+        mark = self.updates[file_id]['mark']
+        return blob_marks[mark]
 
 def c_style_unescape(string):
     if string[0] == string[-1] == '"':
@@ -553,7 +555,7 @@ def parse_commit(parser):
         if parser.check('M'):
             t, m, mark_ref, path = line.split(' ', 3)
             mark = int(mark_ref[1:])
-            f = { 'mode' : m, 'data' : blob_marks[mark] }
+            f = { 'mode' : m, 'mark' : mark }
         elif parser.check('D'):
             t, path = line.split(' ')
             f = { 'deleted' : True }
-- 
1.8.3.rc0.399.gc96a135
