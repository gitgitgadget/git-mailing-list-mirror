From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] contrib/workdir: add a simple script to create a working
	directory
Date: Tue, 27 Mar 2007 00:15:32 +0100
Message-ID: <20070326232751.2647.19279.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 01:30:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVydt-0007Tv-2s
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933736AbXCZX3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933757AbXCZX3s
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:29:48 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:48361 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933736AbXCZX3r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 19:29:47 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 99413C61A7
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 00:29:45 +0100 (BST)
Received: (qmail 23374 invoked by uid 103); 27 Mar 2007 00:29:45 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2930. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.02464 secs); 26 Mar 2007 23:29:45 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 27 Mar 2007 00:29:45 +0100
X-git-sha1: ec8d055fd50673cb75da35ef13487c2d158b17c5 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43206>

Add a simple script to create a working directory that uses symlinks
to point at an exisiting repository.  This allows having different
branches in different working directories but all from the same
repository.  A poor-man's .gitlink if you will.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

I wrote this for my own use based on a post from Junio earlier this month
(http://article.gmane.org/gmane.comp.version-control.git/41513/).

Sent just in case it might be useful?

 contrib/workdir/git-new-workdir |   53 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100755 contrib/workdir/git-new-workdir

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
new file mode 100755
index 0000000..4f4f926
--- /dev/null
+++ b/contrib/workdir/git-new-workdir
@@ -0,0 +1,53 @@
+#!/bin/bash
+
+function usage () {
+	echo "usage:" $1;
+	exit 127;
+}
+
+function die () {
+	echo $1;
+	exit 128;
+}
+
+test $# -eq 3 || usage "$0 <original> <new_workdir> <branch>";
+
+orig_git=$1;
+new_workdir=$2;
+branch=$3;
+
+# want to make sure that what is pointed to has a .git directory ...
+test -d ${orig_git}/.git || die "${original_git} is not a git repository!";
+
+# don't link to a workdir, link to the original repo the workdir is linked to
+if test -L ${orig_git}/.git/config
+then
+	orig_git=$(dirname $(dirname $(readlink -f gm/.git/config)));
+fi
+
+# make sure the the links use full paths
+orig_git=$(cd ${orig_git}; pwd);
+
+# create the workdir
+mkdir -p ${new_workdir}/.git || die "unable to create new dir ${new_workdir}!";
+
+# create the links to the original repo
+for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache
+do
+	case ${x} in
+	*/*)
+		mkdir -p $(dirname ${new_workdir}/.git/${x});
+		;;
+	esac
+	ln -s ${orig_git}/.git/${x} ${new_workdir}/.git/${x};
+done
+
+# now setup the workdir
+cd ${new_workdir};
+# create a fake HEAD, to stop checkout complaining
+echo "ref: refs/heads/master" > .git/HEAD;
+# now checkout the branch that was asked for
+git checkout ${branch};
+
+# vim: tabstop=8
+# vim: noexpandtab
-- 
1.5.0.5
