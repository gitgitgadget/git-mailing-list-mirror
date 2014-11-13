From: Paul Smith <paul@mad-scientist.net>
Subject: [PATCH] git-new-workdir: Add -f to force new-workdir in existing
 directory.
Date: Thu, 13 Nov 2014 14:16:53 -0500
Message-ID: <1415906213.32352.43.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 20:17:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoztX-0000ID-9m
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 20:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933917AbaKMTRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 14:17:07 -0500
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:32983 "HELO
	gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933423AbaKMTRG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2014 14:17:06 -0500
Received: (qmail 2324 invoked by uid 0); 13 Nov 2014 19:17:04 -0000
Received: from unknown (HELO cmgw4) (10.0.90.85)
  by gproxy7.mail.unifiedlayer.com with SMTP; 13 Nov 2014 19:17:04 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw4 with 
	id FDGz1p0142qhmhE01DH2Jw; Thu, 13 Nov 2014 18:17:03 -0700
X-Authority-Analysis: v=2.1 cv=b7chvL2x c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=2NV5t7OSZ7cA:10 a=HLPSmqP3z1ZTmeDY7uYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:From:Subject:Message-ID; bh=O08rwx5o9SHhgpLJgL3NrECQdmG8nBixwKLE/dmN7xE=;
	b=TP+dSA9R196YGm9/+Kr4uRQ2Y8Ut7/ewZP2bx7YfaI5y+SKahOV2VD37Zjet/Q0/2FrX7N/gU2pFGK8jtAbowDYFyUB6hhpyvK5f9vgMUEfZoFt/ChqGNfd1rwlenMqp;
Received: from [173.9.45.73] (port=37604 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1Xozt6-0007Cc-Bu
	for git@vger.kernel.org; Thu, 13 Nov 2014 12:17:00 -0700
X-Mailer: Evolution 3.12.7-0ubuntu1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 173.9.45.73 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul Smith <paul@mad-scientist.net>
Date: Thu, 13 Nov 2014 14:01:34 -0500
Subject: [PATCH] git-new-workdir: Add -f to force new-workdir in existing directory.

Signed-off-by: Paul Smith <psmith@mad-scientist.net>
---

I have an environment I want to use new-workdir for, where the directory
I need to use is pre-created for me and I'm dropped into that directory
and I have no control over this (it's an automated build system).  The
directory is empty but git-new-workdir still is unhappy about it.  I
added a "-f" flag to allow the user to force git-new-workdir to continue
even if the directory exists.  It still bails if there's a .git
directory already, however.

 contrib/workdir/git-new-workdir | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 75e8b25..a4079c1 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -10,11 +10,17 @@ die () {
 	exit 128
 }
 
-if test $# -lt 2 || test $# -gt 3
+if test $# -lt 2 || test $# -gt 4
 then
-	usage "$0 <repository> <new_workdir> [<branch>]"
+	usage "$0 [-f] <repository> <new_workdir> [<branch>]"
 fi
 
+force=false
+if [ x"$1" = x-f ]
+then
+    force=true
+    shift
+fi
 orig_git=$1
 new_workdir=$2
 branch=$3
@@ -51,7 +57,11 @@ fi
 # don't recreate a workdir over an existing repository
 if test -e "$new_workdir"
 then
-	die "destination directory '$new_workdir' already exists."
+	$force || die "destination directory '$new_workdir' already exists."
+	if test -e "$new_workdir/.git"
+	then
+		die "destination directory '$new_workdir/.git' already exists."
+	fi
 fi
 
 # make sure the links use full paths
-- 
2.1.3
