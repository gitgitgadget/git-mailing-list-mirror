From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add another fast-import example, this time for .zip files
Date: Mon, 30 Jun 2008 19:50:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806301948130.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 20:53:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDOVM-0002qN-IW
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 20:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYF3Swk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 14:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbYF3Swj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 14:52:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:55139 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752099AbYF3Swj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 14:52:39 -0400
Received: (qmail invoked by alias); 30 Jun 2008 18:52:36 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp055) with SMTP; 30 Jun 2008 20:52:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tKNp74xDtTF25h19sM3Opoh0g5hkUMaRTQDMr68
	d7talhrKDPLKey
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86929>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I needed that today.

 contrib/fast-import/import-zip.py |   66 +++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100755 contrib/fast-import/import-zip.py

diff --git a/contrib/fast-import/import-zip.py b/contrib/fast-import/import-zip.py
new file mode 100755
index 0000000..de677e4
--- /dev/null
+++ b/contrib/fast-import/import-zip.py
@@ -0,0 +1,66 @@
+#!/usr/bin/python
+
+## zip archive frontend for git-fast-import
+##
+## For example:
+##
+##  mkdir project; cd project; git init
+##  python import-zips.py *.zip
+##  git log --stat import-zips
+
+from os import popen, path
+from sys import argv, exit
+from time import mktime
+from zipfile import ZipFile
+
+if len(argv) < 2:
+	print 'Usage:', argv[0], '<zipfile>...'
+	exit(1)
+
+branch_ref = 'refs/heads/import-zips'
+committer_name = 'Z Ip Creator'
+committer_email = 'zip@example.com'
+
+fast_import = popen('git fast-import --quiet', 'w')
+def printlines(list):
+	for str in list:
+		fast_import.write(str + "\n")
+
+for zipfile in argv[1:]:
+	commit_time = 0
+	next_mark = 1
+	common_prefix = None
+	mark = dict()
+	
+	zip = ZipFile(zipfile, 'r')
+	for name in zip.namelist():
+		if name.endswith('/'):
+			continue
+		info = zip.getinfo(name)
+
+		if commit_time < info.date_time:
+			commit_time = info.date_time
+
+		mark[name] = ':' + str(next_mark)
+		next_mark += 1
+
+		printlines(('blob', 'mark ' + mark[name], \
+					'data ' + str(info.file_size)))
+		fast_import.write(zip.read(name) + "\n")
+
+	committer = committer_name + ' <' + committer_email + '> %d +0000' % \
+		mktime(commit_time + (0, 0, 0))
+
+	printlines(('commit ' + branch_ref, 'committer ' + committer, \
+		'data <<EOM', 'Imported from ' + zipfile + '.', 'EOM', \
+		'', 'deleteall'))
+
+	for name in mark.keys():
+		fast_import.write('M 100644 ' + mark[name] + ' ' + name + "\n")
+
+	printlines(('',  'tag ' + path.basename(zipfile), \
+		'from ' + branch_ref, 'tagger ' + committer, \
+		'data <<EOM', 'Package ' + zipfile, 'EOM', ''))
+
+if fast_import.close():
+	exit(1)
-- 
1.5.6.1.297.g148d9
