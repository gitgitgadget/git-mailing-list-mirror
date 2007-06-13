From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH 1/2] gitview: Fix the blame interface.
Date: Wed, 13 Jun 2007 14:16:15 +0530
Message-ID: <1181724376650-git-send-email-aneesh.kumar@gmail.com>
Cc: gitster@pobox.com, "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 10:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyOWA-00089F-2P
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 10:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbXFMIrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 04:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755092AbXFMIrg
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 04:47:36 -0400
Received: from qb-out-0506.google.com ([72.14.204.225]:6622 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXFMIrf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 04:47:35 -0400
Received: by qb-out-0506.google.com with SMTP id z8so2771537qbc
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 01:47:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:message-id;
        b=KRwR8CPP9yIABBduZ4lqA/kAMj6Yt1ZmEB/xCW06zWXBv4DKVM8oR9ROl5xaeu8aJ+gnGnxBODm2f6VueImz1iKBHD1DGT/OxpIcBktyd7pxomIyBayYqlRPjEwD9abac3oeT0on0riwKSxYPdomhl7bpSkVIDDm/kRHdMAwhro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=CNeC+pXKDiD2Ofc5kL5ZPXwxpwp4pPfS2FYPilcXtb2qdgFuoHAFQWSw2AnKQBch4gsVnqHVjl7n86efUM0aWZwWXT/kX0oZy+1rnEpXV9n7lrDgzTI1sev1T85GVa5vdgQ5l2eqnojVll9uBGe1ICpZw+L5Y7WVPZ3ySKT8EiE=
Received: by 10.115.95.1 with SMTP id x1mr404999wal.1181724453744;
        Wed, 13 Jun 2007 01:47:33 -0700 (PDT)
Received: from localhost ( [59.145.136.1])
        by mx.google.com with ESMTP id v35sm1165460wah.2007.06.13.01.46.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2007 01:47:33 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.1.255.gca6c0-dirty
Message-Id: <142a3f15cd43680e0d7a02f09ffdd93864d13871.1181724308.git.aneesh.kumar@linux.vnet.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The async reading from the pipe was skipping some of the
input lines. Fix the same by making sure that we add the
partial content of the previous read to the newly read
data.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 098cb01..93ecfc1 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -352,6 +352,7 @@ class AnnotateWindow(object):
 		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
 		self.window.set_border_width(0)
 		self.window.set_title("Git repository browser annotation window")
+		self.prev_read = ""
 
 		# Use two thirds of the screen by default
 		screen = self.window.get_screen()
@@ -401,7 +402,10 @@ class AnnotateWindow(object):
 	def data_ready(self, source, condition):
 		while (1):
 			try :
-				buffer = source.read(8192)
+				# A simple readline doesn't work
+				# a readline bug ??
+				buffer = source.read(100)
+
 			except:
 				# resource temporary not available
 				return True
@@ -411,6 +415,19 @@ class AnnotateWindow(object):
 				source.close()
 				return False
 
+			if (self.prev_read != ""):
+				buffer = self.prev_read + buffer
+				self.prev_read = ""
+
+			if (buffer[len(buffer) -1] != '\n'):
+				try:
+					newline_index = buffer.rindex("\n")
+				except ValueError:
+					newline_index = 0
+
+				self.prev_read = buffer[newline_index:(len(buffer))]
+				buffer = buffer[0:newline_index]
+
 			for buff in buffer.split("\n"):
 				annotate_line = re.compile('^([0-9a-f]{40}) (.+) (.+) (.+)$')
 				m = annotate_line.match(buff)
-- 
1.5.2.1.255.gca6c0-dirty
