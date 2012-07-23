From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Mon, 23 Jul 2012 15:16:57 +0200
Message-ID: <5998541.c9PWeIAsEV@flomedio>
References: <4514544.Xip1OCQ7Uj@flomedio> <1448476.VR1Gla8Cvg@flomedio> <20120723125921.GA16768@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	davidbarr@google.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 15:17:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StIVb-0007CK-2O
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 15:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab2GWNRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 09:17:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36820 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab2GWNRC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 09:17:02 -0400
Received: by lbbgm6 with SMTP id gm6so8013108lbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=IYM+zUEoiSee954oCHwWD2V+u92X8w9pMIA2HHolmVo=;
        b=IN6uceirB122ypSzlNinLrCyODkNj5r2prsAtXqyaMJh33Y3vAaTXLP0K9YLDU0yPp
         1IstoHknOvWaAuowxJDYpv31SohbhJzvyWnrmNn/7hEDTukQLgX9jxBA33jOoVm3SQz/
         qpNCawuiktP18wvyNpBXQYG0yBjd0k4UJKaDoVCn1dwiZlehcZlXcDNV4HXcvOey7bDt
         I5ezLAId7ELGILyTv/wBaM3U6AFP3uzpjh9MELSsHog0Bauqd7pXbwhRQLjpctdXF3yk
         bqINo1k/7Fy+RWJbdnZ9o26CMRv2T4tEQiYsFKyC26QNd/N9V4TYnikDB/pC2rClRFjQ
         EnXg==
Received: by 10.112.103.135 with SMTP id fw7mr7670506lbb.25.1343049420670;
        Mon, 23 Jul 2012 06:17:00 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id j5sm3031103lbg.1.2012.07.23.06.16.58
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 06:16:59 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120723125921.GA16768@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201934>

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

I had to fix the missing sign-off anyways..

 contrib/svn-fe/svnrdump_sim.py |   53 
++++++++++++++++++++++++++++++++++++++++
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
+		if not upper == 'HEAD' and state == 'selection' and l == 'Revision-
number: %s\n' % upper:
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
+	if not sys.argv[1] == 'dump': raise NotImplementedError('only "dump" is 
suppported.')
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
