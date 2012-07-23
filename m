From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Mon, 23 Jul 2012 22:08:26 +0200
Message-ID: <1343074107-23262-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <7v4noyo6tc.fsf@alter.siamese.dyndns.org>
Cc: florian.achleitner.2.6.31@gmail.com,
	Jonathan Nieder <jrnieder@gmail.com>, davidbarr@google.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:09:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StOwx-0003tb-9g
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab2GWUIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:08:50 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63143 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab2GWUIq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:08:46 -0400
Received: by bkwj10 with SMTP id j10so5685608bkw.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XDujr5J8MgskeOj/jZsXWYIGCsfilcD+GlkLW6uEUqE=;
        b=Isy7SzKZ8zy1N0p+Y0YNUwS0cUCUOqLhqazQufcYFcP5i2ov6rxx/z05MaugF+4wOT
         6d8ezVIORnNfJw0c9Qy9HNKm6SS65IgS99S4EeMHcOwbDfvyAJed7zdQL3C1YO8pC+Ps
         NDoWBGmYHfkl9/xl2X9MLT+ArbauK24wFRUvtvIT0nbMm9/qXNPtIw6ZPN63nR9ltKb1
         Yo5fHM4VQZNvO7mqPkRaoghFdRvcmaUGrohAz9IiwGP1ho4FvHoFCALU0jHmGXbEF6or
         L5IyeDY5Tkmr1UE+jVSAmZKO0zVlfv94+hayKfTbU+1rIf8AUkfqBA7AzguA0jppP07U
         7xLw==
Received: by 10.204.157.146 with SMTP id b18mr8704340bkx.108.1343074124794;
        Mon, 23 Jul 2012 13:08:44 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id hg13sm8944908bkc.7.2012.07.23.13.08.42
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 13:08:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7v4noyo6tc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201972>

To ease testing without depending on a reachable svn server, this
compact python script mimics parts of svnrdumps behaviour.
It requires the remote url to start with sim://.
Eventual slashes at the end of the url are stripped.
The url specifies the path of the svn dump file (as created by
svnrdump). Selectable parts of it, or the whole file, are written
to stdout. The part is selectable by giving start and end revision
on the command line.

Start and end revisions can be specified on the command line
(-rSTART:END, like for svnrdump).
Only revisions between START and excluding END are replayed from
the dumpfile specified by the url. END can also be HEAD.

If the start revision specified on the command line doesn't exist
in the dump file, it returns 1.
This emulates the behaviour of svnrdump when START>HEAD, i.e. the
requested start revision doesn't exist on the server.

To allow using the same dump file for simulating multiple
incremental imports the highest visible revision can be limited by
setting the environment variable SVNRMAX to that value. This
effectively limits HEAD to simulate the situation where higher
revs don't exist yet.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/svnrdump_sim.py |   53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 contrib/svn-fe/svnrdump_sim.py

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
new file mode 100755
index 0000000..4701d76
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
\ No newline at end of file
-- 
1.7.9.5
