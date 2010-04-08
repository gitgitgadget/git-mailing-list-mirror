From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 2/2] Change the description of '-M' and '-C' option.
Date: Wed,  7 Apr 2010 23:51:30 -0700
Message-ID: <1270709490-19163-3-git-send-email-struggleyb.nku@gmail.com>
References: <1270709490-19163-1-git-send-email-struggleyb.nku@gmail.com>
 <1270709490-19163-2-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 08 08:51:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlaZ-000159-V2
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758378Ab0DHGvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:51:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43264 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758371Ab0DHGva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:51:30 -0400
Received: by mail-pv0-f174.google.com with SMTP id 18so1199735pva.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=n46w58VMNiUiVZbQHsNjVnhN8UkcI+kREyD2DhhYZFs=;
        b=U/ANCauHFRfH2a0+wcOgMbJXfwtzHiIm99sEso+xq7Oi/PK8PiD11c7bBrqYgEhbm+
         PEA29rEKQqXWAPcPsSAfdwDVb1zDViUHaxQtqmVGnIZ4GMLfpekpsJDFU/vbhrJr+edL
         UAxyfSCbvxIRmmOtde/PXuPUE+BIcpdbePYqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i0inUeeZ/mNaCOKnpXnoXvJqzicb4153uqHr7jMJR28EfDhLePhgep/A32MRKh9eEq
         pqW4SKzYxOle1nCCE+ZvG078z+kHNCDrpTSa/uiXW0w77nxfa4hnVL5a+tN1H+ebxdoG
         zzZiJ+xpnCQCmBPe0ll5tOn7g9GRR2It9Jjsg=
Received: by 10.115.117.31 with SMTP id u31mr9640989wam.70.1270709490531;
        Wed, 07 Apr 2010 23:51:30 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id 22sm3689059iwn.12.2010.04.07.23.51.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 23:51:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1270709490-19163-2-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144332>

Both '-M' and '-C' option detect code moving and copying.
The difference between the two options is whether they
search across file boundary.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/blame-options.txt |   41 +++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 4833cac..aca2a1c 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -79,14 +79,15 @@ of lines before or after the line given by <start>.
 	of the --date option at linkgit:git-log[1].
 
 -M|<num>|::
-	Detect moving lines in the file as well.  When a commit
-	moves a block of lines in a file (e.g. the original file
-	has A and then B, and the commit changes it to B and
-	then A), the traditional 'blame' algorithm typically blames
-	the lines that were moved up (i.e. B) to the parent and
-	assigns blame to the lines that were moved down (i.e. A)
-	to the child commit.  With this option, both groups of lines
-	are blamed on the parent.
+	Detect moving/copying lines in the file as well.  Instead of
+	taking blame for all added lines, attempt to find the same
+	lines 'in the same file' in the parent commit.  If such a
+	match was found, shift the blame to these lines in the
+	parent. (This expends extra effort on the order of the size
+	of the file for every change.)
++
+The net effect is that if code is moved or copied within the file, the
+lines are attributed to the original instead of the move/copy.
 +
 <num> is optional but it is the lower bound on the number of
 alphanumeric characters that git must detect as moving
@@ -94,14 +95,22 @@ within a file for it to associate those lines with the parent
 commit.
 
 -C|<num>|::
-	In addition to `-M`, detect lines copied from other
-	files that were modified in the same commit.  This is
-	useful when you reorganize your program and move code
-	around across files.  When this option is given twice,
-	the command additionally looks for copies from other
-	files in the commit that creates the file. When this
-	option is given three times, the command additionally
-	looks for copies from other files in any commit.
+	Like `-M`, detect moving/copying lines between files as well.
+	Instead of taking blame for all added lines, attempt to find the same
+	lines across file boundary according to the number of given `-C`.
+	This is useful when you reorganize your program and move/copy
+	code around across files. When this option is given once, detect
+	lines moved/copied from other files that were modified in the
+	same commit. (This expends extra effort on the order of
+	<number of modified files>*<file size> for every change.) When this
+	option is given twice, the command additionally looks for moves/copies
+	from other files in the commit that creates this file. (This expends
+	extra effort on the order of <number of files in the commit>*<file size>
+	for every change.) When this option is given three times, the
+	command additionally looks for moves/copies from other files
+	in any commit. (This expends extra effort on the order of
+	<commit number>*<number of files in one commit>*<file size>
+	for every change.)
 +
 <num> is optional but it is the lower bound on the number of
 alphanumeric characters that git must detect as moving
-- 
1.6.0.4
