From: Eric Wong <normalperson@yhbt.net>
Subject: RFH: git-svn and submodules
Date: Sun, 31 Aug 2008 23:20:50 -0700
Message-ID: <20080901062050.GA29870@untitled>
References: <20080829092927.GA7500@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eddy =?utf-8?B?UGV0cmnImW9y?= <eddy.petrisor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 08:22:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka2ne-0005fk-4U
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 08:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYIAGVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 02:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbYIAGU7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 02:20:59 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35166 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbYIAGU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 02:20:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EF65D2DC01B;
	Sun, 31 Aug 2008 23:20:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080829092927.GA7500@yp-box.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94532>

Eric Wong <normalperson@yhbt.net> wrote:
> Eddy Petri=C8=99or <eddy.petrisor@gmail.com> wrote:
> >      - use submodules for externals
>=20
> I'm not sure if mapping submodules to externals is a good idea
> because externals don't require exact revisions and submodules do.
> There's also an issue I was just made aware of two days ago with
> submodules and git-svn that I haven't had time to work on.

Definitely a complex problem.  A new submodule from git mapping to an
new svn:external probably doesn't work very well, either.  There's also
UI/policy issues with creating a new directory/branch in SVN to house
the external.  It will also will not work for (the few) projects that
are using the root of the SVN repository directly.

> Another user also privately reported a bug to me about git-svn having
> trouble dcommitting when using submodules.  I've attached the test ca=
se
> here in case you have any thoughts on how to handle this (I think the
> easiest would be to ignore submodules on dcommit entirely).

Well, I'm stuck on this problem.  Since that user that reported this
emailed me privately, I'm bcc-ing him on this issue, too.

I've tried the following, and it gets the commit into SVN without the
submodules using dcommit.

--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3364,7 +3364,7 @@ sub new {
=20
 sub generate_diff {
 	my ($tree_a, $tree_b) =3D @_;
-	my @diff_tree =3D qw(diff-tree -z -r);
+	my @diff_tree =3D qw(diff-tree --ignore-submodules -z -r);
 	if ($_cp_similarity) {
 		push @diff_tree, "-C$_cp_similarity";
 	} else {

However, all is not well.  The rebase/reset step in dcommit gets
triggered with a rebase because the submodule is dropped from the tree
when we refetch the commit from SVN.


The simplest would be to say we don't support mixing submodules with
git-svn.  I'm fine with this statement.


The clever way would be introducing a custom revprop for git-svn
to use to declare submodule dependencies.  Then git-svn can
recreate the information needed for a revprop on fetch.

That would mean regular SVN users would not get access to submodules.

Cutting SVN users off from being able to effectively use an SVN repo
doesn't make sense to me.  The project might as well be using git
entirely and ditch SVN.  Of course, some PHB somewhere will want to kee=
p
the project on SVN even when all the developers are using git-svn...



Since gmane seems to have broken the attachment I previously sent,
here again is the patch inlined:

=46rom bddc57078188d4798a9a74401aa0da8ca35a4db1 Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Fri, 29 Aug 2008 02:09:50 -0700
Subject: [PATCH] git-svn: Add submodule ignore test

---
 t/t9126-git-svn-submodule.sh |   44 ++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 t/t9126-git-svn-submodule.sh

diff --git a/t/t9126-git-svn-submodule.sh b/t/t9126-git-svn-submodule.s=
h
new file mode 100644
index 0000000..c4b3489
--- /dev/null
+++ b/t/t9126-git-svn-submodule.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# Copyright (c) 2008 Eric Wong
+
+test_description=3D'git-svn submodule'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'setup repo' 'svn co "$svnrepo" svnfoo'
+
+test_expect_success 'add files to svn repo' '
+	touch svnfoo/foo.txt
+	(cd svnfoo && svn add * && svn commit -m "test commit")
+	'
+
+test_expect_success 'git-svn clone the svn repo' '
+	git-svn clone "$svnrepo" gitfoo
+	'
+
+test_expect_success 'create a git repo to include as a submodule' '
+	mkdir git_to_include
+	(
+		cd git_to_include &&
+		git init &&
+		echo "This is another file" > another.txt &&
+		git add another.txt &&
+		git commit -a -m "Adding file to submodule" &&
+		git log
+	)
+	'
+
+test_expect_success 'add the submodule' '
+	(
+		cd gitfoo &&
+		git submodule add "$remove_trash"/git_to_include \
+		  git_as_submodule &&
+		git commit -a -m "Adding submodule"
+	)
+	'
+
+test_expect_success 'try to rebase and commit' '
+	( cd gitfoo && git svn rebase && git svn dcommit )
+	'
+
+test_done
--=20
Eric Wong
