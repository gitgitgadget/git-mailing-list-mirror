From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/4] git-p4: use absolute directory for PWD env var
Date: Fri,  9 Dec 2011 18:48:16 -0500
Message-ID: <1323474497-14339-4-git-send-email-pw@padd.com>
References: <1323474497-14339-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 00:49:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZAC7-00078u-NA
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084Ab1LIXtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:49:25 -0500
Received: from honk.padd.com ([74.3.171.149]:44000 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755067Ab1LIXtW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:49:22 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 81DA9EE;
	Fri,  9 Dec 2011 15:49:21 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2E0A3313BB; Fri,  9 Dec 2011 18:49:18 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.4.gc2b11.dirty
In-Reply-To: <1323474497-14339-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186708>

From: Gary Gibbons <ggibbons@perforce.com>

P4 only looks at the environment variable $PWD to figure out
where it is, so chdir() has code to set that every time.  But
when the clone --destination is not an absolute path, PWD will
not be absolute and P4 won't be able to find any files expected
to be in the current directory.  Fix this by expanding PWD to
an absolute path.

One place this crops up is when using a P4CONFIG environment
variable to specify P4 parameters, such as P4USER or P4PORT.
Setting P4CONFIG=.p4config works for p4 invocations from the
current directory.  But if the value of PWD is not absolute, it
fails.

[ update description --pw ]

Signed-off-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 99d3abe..0083f86 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -53,9 +53,10 @@ def p4_build_cmd(cmd):
 
 def chdir(dir):
     # P4 uses the PWD environment variable rather than getcwd(). Since we're
-    # not using the shell, we have to set it ourselves.
-    os.environ['PWD']=dir
+    # not using the shell, we have to set it ourselves.  This path could
+    # be relative, so go there first, then figure out where we ended up.
     os.chdir(dir)
+    os.environ['PWD'] = os.getcwd()
 
 def die(msg):
     if verbose:
-- 
1.7.8.rc4.42.g8317d
