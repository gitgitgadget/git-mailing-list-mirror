From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH 1/2] gitview: Fix the blame interface.
Date: Tue, 12 Jun 2007 23:05:20 +0530
Message-ID: <11816697213806-git-send-email-aneesh.kumar@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 19:35:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAHD-0000zG-NC
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 19:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbXFLRfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 13:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbXFLRfa
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 13:35:30 -0400
Received: from ag-out-0708.google.com ([72.14.246.248]:32837 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbXFLRf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 13:35:29 -0400
Received: by ag-out-0708.google.com with SMTP id 22so1902047agd
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 10:35:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:message-id;
        b=NLqp67uQQ5PoyBQ0tOmB6MFteBrTWf2sBUQkV5Oge/WIWt98E5gpJJtlKQukicuCX33jvj1S9tN0wbf6TIn0/9kkHNTpeaVbfht4sdDjhauueZ3vHWi2KjY8Qf4TaKWfGhWK0wuqzNVCiLMIQ6EWQ6Vnh1zNTXLtWsIwEfTDPrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=Vtq4H+djArZzpQnOGhXoZG2s0Z3if3mO2YBUTeMTJHzbNFSU8Wq/zrysN3Rycsu7oO03b3VHf1+jMmZFR+IllXxMaT0/MJOIwf/sQdOWGP87haf2ntK7j3qiGJvuCslO7VTn99nXl3yLk6noeyNXBco5vdbD1ViD4LEhnfDDiuY=
Received: by 10.90.29.18 with SMTP id c18mr6848746agc.1181669728642;
        Tue, 12 Jun 2007 10:35:28 -0700 (PDT)
Received: from localhost ( [122.167.206.108])
        by mx.google.com with ESMTP id 37sm5741374nzf.2007.06.12.10.35.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2007 10:35:27 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.1.239.g75d8-dirty
Message-Id: <392459374618773353ea560d021dd3211d143d86.1181669428.git.aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The async reading from the pipe was skipping some of the
input lines. Fix the same by making sure that we add the
partial content of the previous read to the newly read
data.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 098cb01..286e974 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -352,6 +352,7 @@ class AnnotateWindow(object):
 		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
 		self.window.set_border_width(0)
 		self.window.set_title("Git repository browser annotation window")
+		self.prev_read = ""
 
 		# Use two thirds of the screen by default
 		screen = self.window.get_screen()
@@ -401,7 +402,11 @@ class AnnotateWindow(object):
 	def data_ready(self, source, condition):
 		while (1):
 			try :
-				buffer = source.read(8192)
+				# A simple readline doesn't work
+				# a readline bug ??
+				buffer=""
+				buffer = source.read(100)
+
 			except:
 				# resource temporary not available
 				return True
@@ -411,6 +416,14 @@ class AnnotateWindow(object):
 				source.close()
 				return False
 
+			if (self.prev_read != ""):
+				buffer = self.prev_read + buffer
+				self.prev_read = ""
+
+			if (buffer[len(buffer) -1] != '\n'):
+				self.prev_read = buffer[buffer.rindex("\n"):(len(buffer))]
+				buffer = buffer[0:buffer.rindex("\n")]
+
 			for buff in buffer.split("\n"):
 				annotate_line = re.compile('^([0-9a-f]{40}) (.+) (.+) (.+)$')
 				m = annotate_line.match(buff)
@@ -419,7 +432,8 @@ class AnnotateWindow(object):
 					m = annotate_line.match(buff)
 					if not m:
 						continue
-					filename = m.group(2)
+					else:
+						filename = m.group(2)
 				else:
 					self.commit_sha1 = m.group(1)
 					self.source_line = int(m.group(2))
-- 
1.5.2.1.239.g75d8-dirty
