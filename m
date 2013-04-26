From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/20] remote-bzr: delay blob fetching until the very end
Date: Thu, 25 Apr 2013 20:07:50 -0500
Message-ID: <1366938488-25425-3-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAN-0003R9-Qi
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624Ab3DZBJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:30 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:44137 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab3DZBJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:29 -0400
Received: by mail-ob0-f173.google.com with SMTP id xn12so3045431obc.4
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=02++IoajwJos7Z/LR4APl7iAbxoLzMqfdg0cfbJLOm0=;
        b=OPxfRWQ7bBVbKWTzQmbccf7JjxtI1kcVddWiiDKgNrytbqPAuY1HsHjcrUQYj7orM5
         Gje49RnznodWU+ekRRQNyh/i/sJBv7IMmlw/WjqAcZLB7oKjWH2ubAVr8CRP1y9lY05q
         vHCA5jare3yLKO6RwWFRbTKSayoCE7TXWH9UX6c5adyE0qsgHmyjyvE5DIpi8WMINvCU
         qQ+kKKRXiLe7oXV1KRkJgwQtUml1+hy3ObFo0chK+1icFIFOa3IzEdPUU5Bv3NjHjtOt
         agRHAx3GviVgGpbZa1/iYG87j3Q/KM1ANaAFVUXwpTcdeoi2dOY4LtgshuiZDW6d1TmT
         XArg==
X-Received: by 10.182.166.10 with SMTP id zc10mr16727033obb.80.1366938569037;
        Thu, 25 Apr 2013 18:09:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qt5sm6102663oeb.4.2013.04.25.18.09.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222485>

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
1.8.2.1.884.g3532a8d
