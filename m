From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 14/16] Add a svnrdump-simulator replaying a dump file for testing
Date: Wed, 19 Sep 2012 17:21:28 +0200
Message-ID: <1348068090-31988-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM7i-0006Jl-GX
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab2ISPXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:23:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64575 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab2ISPXB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:23:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so596995bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Rskdr1sHyIY10u9KTOcPDNO2pSsk79MsmxZcAlKU/zo=;
        b=J1mZI5LgT6enEgktOK+KNtZWmnQ93UJxB9hlkaq2FjeL8BSk5hUfKTS0mo/RvuOTlw
         kJ/p65CejZZRkrTc0geJvCnfiu2BcF8AlXVQ+/Z9Pqz/KSGxoW0zg/DUK+3oPwbmkmyh
         hedBQTpZF1HCOIJQbNXbTEEDT7ZI2m6ZUPQTnzmhU4BfrdodCauiqEQ1Z9VJC8F/8W/a
         Fq1HS5ApywBZZwUzSuBYNERzT2E3TGkc4xTmBUXq6CP9cK9CLXe6qDm7jSZs6n5ocCNs
         TZibZxbyA3TW2lJgc4bo9re0TJhuBerpsIPyxN3bFbrdRU1qQzR1rB8TKR4xK2k4uELq
         pjkA==
Received: by 10.204.129.76 with SMTP id n12mr1464855bks.18.1348068180705;
        Wed, 19 Sep 2012 08:23:00 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.58
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205943>

To ease testing without depending on a reachable svn server, this
compact python script mimics parts of svnrdumps behaviour.  It
requires the remote url to start with sim://.

Start and end revisions are evaluated.  If the requested revision
doesn't exist, as it is the case with incremental imports, if no new
commit was added, it returns 1 (like svnrdump).

To allow using the same dump file for simulating multiple incremental
imports, the highest revision can be limited by setting the environment
variable SVNRMAX to that value. This simulates the situation where
higher revs don't exist yet.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
no diff

 contrib/svn-fe/svnrdump_sim.py |   53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 contrib/svn-fe/svnrdump_sim.py

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
new file mode 100755
index 0000000..1cfac4a
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
+        var = 'SVNRMAX'
+        if os.environ.has_key(var):
+                return os.environ[var]
+        return None
+
+def writedump(url, lower, upper):
+        if url.startswith('sim://'):
+                filename = url[6:]
+                if filename[-1] == '/': filename = filename[:-1] #remove terminating slash
+        else:
+                raise ValueError('sim:// url required')
+        f = open(filename, 'r');
+        state = 'header'
+        wroterev = False
+        while(True):
+                l = f.readline()
+                if l == '': break
+                if state == 'header' and l.startswith('Revision-number: '):
+                        state = 'prefix'
+                if state == 'prefix' and l == 'Revision-number: %s\n' % lower:
+                        state = 'selection'
+                if not upper == 'HEAD' and state == 'selection' and l == 'Revision-number: %s\n' % upper:
+                        break;
+
+                if state == 'header' or state == 'selection':
+                        if state == 'selection': wroterev = True
+                        sys.stdout.write(l)
+        return wroterev
+
+if __name__ == "__main__":
+        if not (len(sys.argv) in (3, 4, 5)):
+                print "usage: %s dump URL -rLOWER:UPPER"
+                sys.exit(1)
+        if not sys.argv[1] == 'dump': raise NotImplementedError('only "dump" is suppported.')
+        url = sys.argv[2]
+        r = ('0', 'HEAD')
+        if len(sys.argv) == 4 and sys.argv[3][0:2] == '-r':
+                r = sys.argv[3][2:].lstrip().split(':')
+        if not getrevlimit() is None: r[1] = getrevlimit()
+        if writedump(url, r[0], r[1]): ret = 0
+        else: ret = 1
+        sys.exit(ret)
-- 
1.7.9.5
