From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 14/16] Add a svnrdump-simulator replaying a dump file for testing.
Date: Fri, 17 Aug 2012 22:25:55 +0200
Message-ID: <1345235157-702-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:27:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T94-0006cg-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417Ab2HQU1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:27:41 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47144 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902Ab2HQU1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:27:11 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3663355wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NUd8IBoaIuSmQHhGZco9DH1FVW1Ch0wrzg5rkLf2Dj8=;
        b=vvuS9tgP+Xoz1TrImuRs8M3xS8b/EXcWZWn8gyyEtbL4dIskND7NEeTSABo3sIQr/I
         S2/wSKf0CGJYBVjYYIyA/vx9wIh1tOsbUnEW92It4IsHR2GfmfxYrAJ7ERghKt7Kz8Hl
         A4w2TjzqU1lXFEfTgKj8MKwb5osN2KRFtT4PYvHvEuJVTI2RPABNf88nDZf1lSEifpvp
         z8PTZLJvPwctTyTuLGck+zxgsah9a6bQA4J1RhgSmep493wt8wLz7icqO8NvPqSF/iWA
         Xk4mhuTS3j27v/orHE8yB8BnfQicEIXdrtuCcUGvQkAdvqsrU5Ku87632oVZFXCA9oB6
         4Fkw==
Received: by 10.216.192.85 with SMTP id h63mr3057006wen.7.1345235230593;
        Fri, 17 Aug 2012 13:27:10 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.27.08
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:27:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203655>

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
