From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 14/16] Add a svnrdump-simulator replaying a dump file for testing
Date: Mon, 20 Aug 2012 23:52:20 +0200
Message-ID: <1345499542-15536-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:54:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZvF-0000MP-ND
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab2HTVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:51 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58719 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab2HTVxc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:32 -0400
Received: by wicr5 with SMTP id r5so4068347wic.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Hb8Cgb6Z77mXKHLZKzitn6/eB8VQNUegPAANACIB+gc=;
        b=eYEyzn1gzb3afcnqTXSGJSOALRyIBP0s/TmA/PmMzmXfmHsojqQyy7/6c9hgj1aLre
         /P+SWe4qPyGXuM6p2fAF4z6hHYZN6FExwhG/lk42YGdK0NXEJKnJWgj+YQMNKMZkXb3L
         QcQPC/uuqSoDudS/WrKQsIgAE6omRyOIWRTpYJ28vOIBsfepJHK9icmMYgNqgX3A4s1a
         n3fVfOdMu2rbXXdBgiHkogPoc7N7wiy93BALUF3hTUvX+Rr/CsGg5bmXLsO2zNQxufL1
         X0iQK3dGpEhbdV4wA0mH8qgGIb9hpPdfNbiVaF4i5O6pdNt/k/jf9pxkDUbEKmrZPRhb
         U83Q==
Received: by 10.180.92.9 with SMTP id ci9mr30802345wib.22.1345499610272;
        Mon, 20 Aug 2012 14:53:30 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.28
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203892>

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
