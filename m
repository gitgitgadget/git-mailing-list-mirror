From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 13/16] Add a svnrdump-simulator replaying a dump file for testing.
Date: Thu, 26 Jul 2012 09:32:34 +0200
Message-ID: <1343287957-22040-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:35:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIbE-0005DO-P8
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab2GZHew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:52 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab2GZHev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:51 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NUd8IBoaIuSmQHhGZco9DH1FVW1Ch0wrzg5rkLf2Dj8=;
        b=wyd1rYYYCBT9syVkkKmfxHrfXwksD8bbkDqYNSPbFXagEKmpEkjuma/TaCsj7lGs+t
         6dbM2wziD9kqMaOADQXkpeYmS9nOtFBjoPd6xCLkKxwsh/X1HGm546oQDWaJHbPi0vXv
         1W25MNl8nhOfx8sqz1ciLoRDgn5gKqgblTKnzwQ7/Klcs8u4CEzhngaFk7fSvjxWgVHK
         gVcpEiriURhyhT4xSkSiuk/9iGX5R45E6KBI4vpE1SC3+a8uTUr3VDpVY6RqS1GO0rd7
         NZ0W8SGcC7Klw7MCpwdpt6hq3l/87rRZhGVwnfNL7C+srlWaEdTGnHdkqOMh3iXDCOtD
         TLGQ==
Received: by 10.204.154.214 with SMTP id p22mr13580165bkw.111.1343288090352;
        Thu, 26 Jul 2012 00:34:50 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.46
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202243>

To ease testing without depending on a reachable svn server, this
compact python script mimics parts of svnrdumps behaviour.
It requires the remote url to start with sim://.
Start and end revisions are evaluated.
If the requested revision doesn't exist, as it is the case with
incremental imports, if no new commit was added, it returns 1
(like svnrdump).
To allow using the same dump file for simulating multiple
incremental imports the highest revision can be limited by setting
the environment variable SVNRMAX to that value. This simulates the
situation where higher revs don't exist yet.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/svnrdump_sim.py |   53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 contrib/svn-fe/svnrdump_sim.py

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
new file mode 100755
index 0000000..ab4ccf1
--- /dev/null
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -0,0 +1,53 @@
+#!/usr/bin/python
+"""
+Simulates svnrdump by replaying an existing dump from a file, taking care
+of the specified revision range.
+To simulate incremental imports the environment variable SVNRMAX can be set
+to the highest revision that should be available.
+"""
+import sys, os
+
+
+def getrevlimit():
+	var = 'SVNRMAX'
+	if os.environ.has_key(var):
+		return os.environ[var]
+	return None
+	
+def writedump(url, lower, upper):
+	if url.startswith('sim://'):
+		filename = url[6:]
+		if filename[-1] == '/': filename = filename[:-1] #remove terminating slash
+	else:
+		raise ValueError('sim:// url required')
+	f = open(filename, 'r');
+	state = 'header'
+	wroterev = False
+	while(True):
+		l = f.readline()
+		if l == '': break
+		if state == 'header' and l.startswith('Revision-number: '):
+			state = 'prefix'
+		if state == 'prefix' and l == 'Revision-number: %s\n' % lower:
+			state = 'selection'
+		if not upper == 'HEAD' and state == 'selection' and l == 'Revision-number: %s\n' % upper:
+			break;
+
+		if state == 'header' or state == 'selection':
+			if state == 'selection': wroterev = True
+			sys.stdout.write(l)
+	return wroterev
+
+if __name__ == "__main__":
+	if not (len(sys.argv) in (3, 4, 5)):
+		print "usage: %s dump URL -rLOWER:UPPER"
+		sys.exit(1)
+	if not sys.argv[1] == 'dump': raise NotImplementedError('only "dump" is suppported.')
+	url = sys.argv[2]
+	r = ('0', 'HEAD')
+	if len(sys.argv) == 4 and sys.argv[3][0:2] == '-r':
+		r = sys.argv[3][2:].lstrip().split(':')
+	if not getrevlimit() is None: r[1] = getrevlimit()
+	if writedump(url, r[0], r[1]): ret = 0
+	else: ret = 1
+	sys.exit(ret)
-- 
1.7.9.5
