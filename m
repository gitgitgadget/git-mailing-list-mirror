From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix date display
Date: Thu, 2 Feb 2006 13:21:24 +0100
Message-ID: <20060202122124.GB9756@diku.dk>
References: <cc723f590602012033w41b49b2ao4423707702086739@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Feb 02 13:23:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4dV4-00020R-CP
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 13:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWBBMXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 07:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWBBMXn
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 07:23:43 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:6615 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750950AbWBBMXn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 07:23:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1459B52D4B5;
	Thu,  2 Feb 2006 13:23:42 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06102-01; Thu,  2 Feb 2006 13:23:40 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2523152D4C4;
	Thu,  2 Feb 2006 13:21:25 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 040226DFBC6; Thu,  2 Feb 2006 13:20:47 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 091FF61A54; Thu,  2 Feb 2006 13:21:24 +0100 (CET)
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Content-Disposition: inline
In-Reply-To: <cc723f590602012033w41b49b2ao4423707702086739@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15505>

Hello,

Here is a patch that uses the tz info for setting commit dates.

--- a/gitview	2006-02-02 12:29:05.000000000 +0100
+++ b/gitview	2006-02-02 12:28:24.000000000 +0100
@@ -31,6 +31,7 @@
     have_gtksourceview = False
     print "Running without gtksourceview module"
 
+re_ident = re.compile('(author|committer) (?P<ident>.*) (?P<epoch>\d+) (?P<tz>[+-]\d{4})')
 
 def list_to_string(args, skip):
 	count = len(args)
@@ -43,6 +44,16 @@
 
 	return str_arg
 
+def show_date(epoch, tz):
+	secs = float(epoch)
+	tzsecs = float(tz[1:3]) * 3600
+	tzsecs += float(tz[3:5]) * 60
+	if (tz[0] == "+"):
+		secs += tzsecs
+	else:
+		secs -= tzsecs
+	return time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(secs))
+
 
 class CellRendererGraph(gtk.GenericCellRenderer):
 	"""Cell renderer for directed graph.
@@ -277,22 +288,15 @@
 			if (m != None):
 				continue
 
-
-			m = re.match("author", line)
-			if (m  != None ):
-				patch_author = re.split(" ", line)	
-				self.author = list_to_string(patch_author[1:-2], 0)
-				self.date = time.strftime("%Y-%m-%d %H:%M:%S",
-						time.gmtime(float(patch_author[-2])))
-				continue
-
-			m = re.match("committer", line)
-			if (m  != None ):
-				patch_committer = re.split(" ", line)	
-				self.committer = list_to_string(patch_committer[1:-2], 0)
-				self.commit_date = time.strftime("%Y-%m-%d %H:%M:%S",
-						time.gmtime(float(patch_committer[-2])))
-				continue
+			m = re_ident.match(line)
+			if (m != None):
+				date = show_date(m.group('epoch'), m.group('tz'))
+				if m.group(1)[0] == 'a':
+					self.author = m.group('ident')
+					self.date = date
+				else:
+					self.committer = m.group('ident')
+					self.commit_date = date
 
 	def get_message(self, with_diff=0):
 		if (with_diff == 1):
-- 
Jonas Fonseca
