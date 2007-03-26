From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] contrib/workdir: add a simple script to create a working
	directory
Date: Tue, 27 Mar 2007 00:15:32 +0100
Message-ID: <20070327003033.4226.8413.julian@quantumfyre.co.uk>
References: <7vtzw7tvvv.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzjW-0000td-Cf
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933860AbXC0AkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933861AbXC0AkO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:40:14 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:32993 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933860AbXC0AkL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 20:40:11 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 41742C60E0
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 01:40:10 +0100 (BST)
Received: (qmail 25073 invoked by uid 103); 27 Mar 2007 01:40:10 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2930. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024883 secs); 27 Mar 2007 00:40:10 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 27 Mar 2007 01:40:09 +0100
X-git-sha1: 229ea4bc9fa30161e0f971c1a16c908797ccc314 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <7vtzw7tvvv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43218>

Add a simple script to create a working directory that uses symlinks
to point at an exisiting repository.  This allows having different
branches in different working directories but all from the same
repository.

Based on a description from Junio of how he creates multiple working
directories[1].  With the following caveat:

"This risks confusion for an uninitiated if you update a ref that
is checked out in another working tree, but modulo that caveat
it works reasonably well."

[1] http://article.gmane.org/gmane.comp.version-control.git/41513/

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Mon, 26 Mar 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> Add a simple script to create a working directory that uses symlinks
>> to point at an exisiting repository.  This allows having different
>> branches in different working directories but all from the same
>> repository.  A poor-man's .gitlink if you will.
>
> I would not call it poor-man's.  It is 'without complexity' and
> that is a good thing, especially when you are not doing any
> submodule stuff.

True, it may not be as wizzy as .gitlink no doubt will be, but I
think it will suit me nicely.

I also thought it was worth a reference to your caveat, but perhaps
that would be better as a comment in the code?

>
>> +# create the links to the original repo
>> +for x in config refs logs/refs objects info hooks packed-refs remotes
rr-cache
>> +do
>> +	case ${x} in
>> +	*/*)
>> +		mkdir -p $(dirname ${new_workdir}/.git/${x});
>> +		;;
>> +	esac
>> +	ln -s ${orig_git}/.git/${x} ${new_workdir}/.git/${x};
>> +done
>
> I think the above list "for x" is correct, but probably the code
> wants to comment on why it specifically excludes logs/HEAD from
> the symlinked set ;-).

Good point.

>
>> +# now setup the workdir
>> +cd ${new_workdir};
>> +# create a fake HEAD, to stop checkout complaining
>> +echo "ref: refs/heads/master" > .git/HEAD;
>> +# now checkout the branch that was asked for
>> +git checkout ${branch};
>
> If ${branch} was 'master', does this do a checkout?  I think -f
> might be needed.
>

It worked when I tried it ... but -f might be worth it anyway.


 contrib/workdir/git-new-workdir |   55 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 contrib/workdir/git-new-workdir

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
new file mode 100755
index 0000000..5bfd87e
--- /dev/null
+++ b/contrib/workdir/git-new-workdir
@@ -0,0 +1,55 @@
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
+# create the links to the original repo.  explictly exclude index, HEAD and
+# logs/HEAD from the list since they are purely related to the current working
+# directory, and should not be shared.
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
+git checkout -f ${branch};
+
+# vim: tabstop=8
+# vim: noexpandtab
-- 
1.5.0.5
