From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Mon, 23 Jul 2012 14:44:14 +0200
Message-ID: <1448476.VR1Gla8Cvg@flomedio>
References: <4514544.Xip1OCQ7Uj@flomedio> <20120722214333.GB680@burratino> <2948040.5ceLh0WG3L@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	davidbarr@google.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 14:44:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StI03-0007UD-3o
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 14:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2GWMoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 08:44:22 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61634 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab2GWMoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 08:44:21 -0400
Received: by lbbgm6 with SMTP id gm6so7974503lbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=S9FPpRfc0Zx31qGjoBPWzMAFl2B+WHb0gAMY+IZxNOY=;
        b=TXZPQbtbePeSaso38rvi84Ss/X1kfUnXaE07E2tcLicI1qKtaS5XMkRM34KWMAmlia
         eOrqRdENRGvO+/4IClP+ERkFvoGx3FtGThF5n3OEPNLkZssShjMw1QC18CSL+yRoFyEk
         VmfskdOpJWdG7cr8UD6wqVU+dH0kpg2PjuR3rBFZal+GYQPq098a50l7TiFM/Oukt7Uy
         RaClwkdPlkfUO92XG5ZSfzRCvahDWOw3zjPYNFvYk3uPL/qQYZusx8TRxjDVow9t11Hw
         Ih3bJVsa1CFgZet1URg0JFYWjY3hlJ1T2IIlF6GrAsj085gieHNoTytQGNCLM3RQI6I9
         UL5g==
Received: by 10.112.30.41 with SMTP id p9mr7824216lbh.26.1343047459809;
        Mon, 23 Jul 2012 05:44:19 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id p2sm2997723lbj.4.2012.07.23.05.44.17
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 05:44:18 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <2948040.5ceLh0WG3L@flomedio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201931>

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
