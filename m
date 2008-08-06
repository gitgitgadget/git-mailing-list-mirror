From: Marcus Griep <marcus@griep.us>
Subject: [PATCH 2/2] git-svn: Allow deep branch names by supporting multi-globs
Date: Wed, 06 Aug 2008 15:58:20 -0400
Message-ID: <489A025C.50507@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:00:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQpAU-0000zc-HD
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 21:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbYHFT6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 15:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbYHFT6b
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 15:58:31 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:47384 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbYHFT63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 15:58:29 -0400
Received: by an-out-0708.google.com with SMTP id d40so13459and.103
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:x-enigmail-version
         :content-type:content-transfer-encoding:sender;
        bh=AVNihsH+DSRSagueznFmHVBzYB8ohBzpg7pxZ8evCAg=;
        b=XYkAxRjEWPcTLRCrSuBDhw4pqhzgjeO6kSfC55Ny+UBNHP4ppkzS122Zcfsrur99RA
         kdIKEUaWd3E8uPmOzB2QIb4CeHAmetkJXV/boAguktN8rkkv1Dq342l/sOAFzoDI//Dk
         Brc+uZrt0dV3yjZ2V1PwY38dG8vxU+Or2+t2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=Vg1nLddAmYmeytNV9PPQBgBEPmW3NwL+Z8HbxXxCu1AJOTQfeJ8o8xVhA1ymvKSMrs
         bHWED4ghpaw/HddVrUUEwC3p11rNq0q26MHGNUPGNQ2/cmntY7yaIcTHf4NOIdhAjawi
         +DrfNTbIj9feKdYxeycByD+QNHZJ6r60k60Ro=
Received: by 10.100.14.17 with SMTP id 17mr182369ann.47.1218052708673;
        Wed, 06 Aug 2008 12:58:28 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id g7sm17577477wra.16.2008.08.06.12.58.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 12:58:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91535>

=46rom 3b95061c8d19b2285cdbf94001f3b718c8264c32 Mon Sep 17 00:00:00 200=
1
=46rom: Marcus Griep <marcus@griep.us>
Date: Tue, 5 Aug 2008 15:13:20 -0400
Subject: [PATCH 2/2] git-svn: Allow deep branch names by supporting mul=
ti-globs

Some repositories use a deep branching strategy, such as:
branches/1.0/1.0.rc1
branches/1.0/1.0.rc2
branches/1.0/1.0.rtm
branches/1.0/1.0.gold

Only allowing a single glob stiffles this.

This change allows for a single glob 'set' to accept this deep branchin=
g
strategy.

The ref glob depth must match the branch glob depth.  When using the -b=
 or -t
options for init or clone, this is automatically done.

=46or example, using the above branches:
  svn-remote.svn.branches =3D branches/*/*:refs/remote/*/*
gives the following branch names:
  1.0/1.0.rc1
  1.0/1.0.rc2
  1.0/1.0.rtm
  1.0/1.0.gold

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 git-svn.perl                               |   53 +++++++---
 t/t9108-git-svn-glob.sh                    |    9 +-
 t/t9108-git-svn-multi-glob.sh              |  155 ++++++++++++++++++++=
++++++++
 t/t9125-git-svn-multi-glob-branch-names.sh |   40 +++++++
 4 files changed, 238 insertions(+), 19 deletions(-)
 create mode 100755 t/t9108-git-svn-multi-glob.sh
 create mode 100755 t/t9125-git-svn-multi-glob-branch-names.sh

diff --git a/git-svn.perl b/git-svn.perl
index 95d11c2..dc80c56 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -981,7 +981,7 @@ sub complete_url_ls_init {
                die "--prefix=3D'$pfx' must have a trailing slash '/'\n=
";
        }
        command_noisy('config', "svn-remote.$gs->{repo_id}.$n",
-                               "$remote_path:refs/remotes/$pfx*");
+                               "$remote_path:refs/remotes/$pfx*" . ('/=
*' x (($remote_path =3D~ tr/*/*/)-1)));
 }

 sub verify_ref {
@@ -4113,16 +4113,35 @@ sub gs_fetch_loop_common {
        Git::SVN::gc();
 }

+sub get_dir_globbed {
+       my ($self, $left, $depth, $r) =3D @_;
+
+       my @x =3D eval { $self->get_dir($left, $r) };
+       return unless scalar @x =3D=3D 3;
+       my $dirents =3D $x[0];
+       my @finalents;
+       foreach my $de (keys %$dirents) {
+               next if $dirents->{$de}->{kind} !=3D $SVN::Node::dir;
+               if ($depth > 1) {
+                       foreach my $dir ($self->get_dir_globbed($left.'=
/'.$de, $depth - 1, $r)) {
+                               push @finalents, "$de/$dir";
+                       }
+               } else {
+                       push @finalents, $de;
+               }
+       }
+       @finalents;
+}
+
 sub match_globs {
        my ($self, $exists, $paths, $globs, $r) =3D @_;

        sub get_dir_check {
                my ($self, $exists, $g, $r) =3D @_;
-               my @x =3D eval { $self->get_dir($g->{path}->{left}, $r)=
 };
-               return unless scalar @x =3D=3D 3;
-               my $dirents =3D $x[0];
-               foreach my $de (keys %$dirents) {
-                       next if $dirents->{$de}->{kind} !=3D $SVN::Node=
::dir;
+
+               my @dirs =3D $self->get_dir_globbed($g->{path}->{left},=
 $g->{path}->{depth}, $r);
+
+               foreach my $de (@dirs) {
                        my $p =3D $g->{path}->full_path($de);
                        next if $exists->{$p};
                        next if (length $g->{path}->{right} &&
@@ -4904,16 +4923,20 @@ sub new {
        my ($class, $glob) =3D @_;
        my $re =3D $glob;
        $re =3D~ s!/+$!!g; # no need for trailing slashes
-       my $nr =3D $re =3D~ tr/*/*/;
-       if ($nr > 1) {
-               die "Only one '*' wildcard expansion ",
-                   "is supported (got $nr): '$glob'\n";
-       } elsif ($nr =3D=3D 0) {
+       $re =3D~ m!^([^*]*)(\*(?:/\*)*)([^*]*)$!;
+       my $temp =3D $re;
+       my ($left, $right) =3D ($1, $3);
+       $re =3D $2;
+       my $depth =3D $re =3D~ tr/*/*/;
+       if ($depth !=3D $temp =3D~ tr/*/*/) {
+               die "Only one set of wildcard directories (e.g. '*' or =
'*/*/*') is supported: '$glob'\n";
+       }
+       if ($depth =3D=3D 0) {
                die "One '*' is needed for glob: '$glob'\n";
        }
-       $re =3D~ s!^(.*)\*(.*)$!\(\[^/\]+\)!g;
-       my ($left, $right) =3D ($1, $2);
-       $re =3D quotemeta($left) . $re . quotemeta($right);
+       $re =3D~ s!\*!\[^/\]*!g;
+#      $re =3D~ s!\?!\[^/\]!g;
+       $re =3D quotemeta($left) . "($re)" . quotemeta($right);
        if (length $left && !($left =3D~ s!/+$!!g)) {
                die "Missing trailing '/' on left side of: '$glob' ($le=
ft)\n";
        }
@@ -4922,7 +4945,7 @@ sub new {
        }
        my $left_re =3D qr/^\/\Q$left\E(\/|$)/;
        bless { left =3D> $left, right =3D> $right, left_regex =3D> $le=
ft_re,
-               regex =3D> qr/$re/, glob =3D> $glob }, $class;
+               regex =3D> qr/$re/, glob =3D> $glob, depth =3D> $depth =
}, $class;
 }

 sub full_path {
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index ef6d88e..46958e5 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -52,7 +52,8 @@ test_expect_success 'test refspec globbing' '
        test "`git rev-parse refs/remotes/tags/end~1`" =3D \
                "`git rev-parse refs/remotes/branches/start`" &&
        test "`git rev-parse refs/remotes/branches/start~2`" =3D \
-               "`git rev-parse refs/remotes/trunk`"
+               "`git rev-parse refs/remotes/trunk`" &&
+       test_must_fail git rev-parse refs/remotes/tags/end@3
        '

 echo try to try > expect.two
@@ -83,14 +84,14 @@ test_expect_success 'test left-hand-side only globb=
ing' '
        cmp expect.two output.two
        '

-echo "Only one '*' wildcard expansion is supported (got 2): 'branches/=
*/*'" > expect.three
+echo "Only one set of wildcard directories (e.g. '*' or '*/*/*') is su=
pported: 'branches/*/t/*'" > expect.three
 echo "" >> expect.three

-test_expect_success 'test disallow multi-globs' '
+test_expect_success 'test disallow multiple globs' '
        git config --add svn-remote.three.url "$svnrepo" &&
        git config --add svn-remote.three.fetch trunk:refs/remotes/thre=
e/trunk &&
        git config --add svn-remote.three.branches \
-                        "branches/*/*:refs/remotes/three/branches/*" &=
&
+                        "branches/*/t/*:refs/remotes/three/branches/*"=
 &&
        git config --add svn-remote.three.tags \
                         "tags/*/*:refs/remotes/three/tags/*" &&
        cd tmp &&
diff --git a/t/t9108-git-svn-multi-glob.sh b/t/t9108-git-svn-multi-glob=
=2Esh
new file mode 100755
index 0000000..1d80cb1
--- /dev/null
+++ b/t/t9108-git-svn-multi-glob.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+# Copyright (c) 2007 Eric Wong
+test_description=3D'git-svn globbing refspecs'
+. ./lib-git-svn.sh
+
+cat > expect.end <<EOF
+the end
+hi
+start a new branch
+initial
+EOF
+
+test_expect_success 'test refspec globbing' '
+       mkdir -p trunk/src/a trunk/src/b trunk/doc &&
+       echo "hello world" > trunk/src/a/readme &&
+       echo "goodbye world" > trunk/src/b/readme &&
+       svn import -m "initial" trunk "$svnrepo"/trunk &&
+       svn co "$svnrepo" tmp &&
+       cd tmp &&
+               mkdir branches branches/v1 tags &&
+               svn add branches tags &&
+               svn cp trunk branches/v1/start &&
+               svn commit -m "start a new branch" &&
+               svn up &&
+               echo "hi" >> branches/v1/start/src/b/readme &&
+               poke branches/v1/start/src/b/readme &&
+               echo "hey" >> branches/v1/start/src/a/readme &&
+               poke branches/v1/start/src/a/readme &&
+               svn commit -m "hi" &&
+               svn up &&
+               svn cp branches/v1/start tags/end &&
+               echo "bye" >> tags/end/src/b/readme &&
+               poke tags/end/src/b/readme &&
+               echo "aye" >> tags/end/src/a/readme &&
+               poke tags/end/src/a/readme &&
+               svn commit -m "the end" &&
+               echo "byebye" >> tags/end/src/b/readme &&
+               poke tags/end/src/b/readme &&
+               svn commit -m "nothing to see here"
+               cd .. &&
+       git config --add svn-remote.svn.url "$svnrepo" &&
+       git config --add svn-remote.svn.fetch \
+                        "trunk/src/a:refs/remotes/trunk" &&
+       git config --add svn-remote.svn.branches \
+                        "branches/*/*/src/a:refs/remotes/branches/*/*"=
 &&
+       git config --add svn-remote.svn.tags\
+                        "tags/*/src/a:refs/remotes/tags/*" &&
+       git-svn multi-fetch &&
+       git log --pretty=3Doneline refs/remotes/tags/end | \
+           sed -e "s/^.\{41\}//" > output.end &&
+       cmp expect.end output.end &&
+       test "`git rev-parse refs/remotes/tags/end~1`" =3D \
+               "`git rev-parse refs/remotes/branches/v1/start`" &&
+       test "`git rev-parse refs/remotes/branches/v1/start~2`" =3D \
+               "`git rev-parse refs/remotes/trunk`" &&
+       test_must_fail git rev-parse refs/remotes/tags/end@3
+       '
+
+echo try to try > expect.two
+echo nothing to see here >> expect.two
+cat expect.end >> expect.two
+
+test_expect_success 'test left-hand-side only globbing' '
+       git config --add svn-remote.two.url "$svnrepo" &&
+       git config --add svn-remote.two.fetch trunk:refs/remotes/two/tr=
unk &&
+       git config --add svn-remote.two.branches \
+                        "branches/*/*:refs/remotes/two/branches/*/*" &=
&
+       git config --add svn-remote.two.tags \
+                        "tags/*:refs/remotes/two/tags/*" &&
+       cd tmp &&
+               echo "try try" >> tags/end/src/b/readme &&
+               poke tags/end/src/b/readme &&
+               svn commit -m "try to try"
+               cd .. &&
+       git-svn fetch two &&
+       test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
+       test `git rev-list refs/remotes/two/branches/v1/start | wc -l` =
-eq 3 &&
+       test `git rev-parse refs/remotes/two/branches/v1/start~2` =3D \
+            `git rev-parse refs/remotes/two/trunk` &&
+       test `git rev-parse refs/remotes/two/tags/end~3` =3D \
+            `git rev-parse refs/remotes/two/branches/v1/start` &&
+       git log --pretty=3Doneline refs/remotes/two/tags/end | \
+           sed -e "s/^.\{41\}//" > output.two &&
+       cmp expect.two output.two
+       '
+cat > expect.four <<EOF
+adios
+adding more
+Changed 2 in v2/start
+Another versioned branch
+initial
+EOF
+
+test_expect_success 'test another branch' '
+       (
+               cd tmp &&
+               mkdir branches/v2 &&
+               svn add branches/v2 &&
+               svn cp trunk branches/v2/start &&
+               svn commit -m "Another versioned branch" &&
+               svn up &&
+               echo "hello" >> branches/v2/start/src/b/readme &&
+               poke branches/v2/start/src/b/readme &&
+               echo "howdy" >> branches/v2/start/src/a/readme &&
+               poke branches/v2/start/src/a/readme &&
+               svn commit -m "Changed 2 in v2/start" &&
+               svn up &&
+               svn cp branches/v2/start tags/next &&
+               echo "bye" >> tags/next/src/b/readme &&
+               poke tags/next/src/b/readme &&
+               echo "aye" >> tags/next/src/a/readme &&
+               poke tags/next/src/a/readme &&
+               svn commit -m "adding more" &&
+               echo "byebye" >> tags/next/src/b/readme &&
+               poke tags/next/src/b/readme &&
+               svn commit -m "adios"
+       ) &&
+       git config --add svn-remote.four.url "$svnrepo" &&
+       git config --add svn-remote.four.fetch trunk:refs/remotes/four/=
trunk &&
+       git config --add svn-remote.four.branches \
+                        "branches/*/*:refs/remotes/four/branches/*/*" =
&&
+       git config --add svn-remote.four.tags \
+                        "tags/*:refs/remotes/four/tags/*" &&
+       git-svn fetch four &&
+       test `git rev-list refs/remotes/four/tags/next | wc -l` -eq 5 &=
&
+       test `git rev-list refs/remotes/four/branches/v2/start | wc -l`=
 -eq 3 &&
+       test `git rev-parse refs/remotes/four/branches/v2/start~2` =3D =
\
+            `git rev-parse refs/remotes/four/trunk` &&
+       test `git rev-parse refs/remotes/four/tags/next~2` =3D \
+            `git rev-parse refs/remotes/four/branches/v2/start` &&
+       git log --pretty=3Doneline refs/remotes/four/tags/next | \
+           sed -e "s/^.\{41\}//" > output.four &&
+       cmp expect.four output.four
+       '
+
+echo "Only one set of wildcard directories (e.g. '*' or '*/*/*') is su=
pported: 'branches/*/t/*'" > expect.three
+echo "" >> expect.three
+
+test_expect_success 'test disallow multiple globs' '
+       git config --add svn-remote.three.url "$svnrepo" &&
+       git config --add svn-remote.three.fetch trunk:refs/remotes/thre=
e/trunk &&
+       git config --add svn-remote.three.branches \
+                        "branches/*/t/*:refs/remotes/three/branches/*/=
*" &&
+       git config --add svn-remote.three.tags \
+                        "tags/*:refs/remotes/three/tags/*" &&
+       cd tmp &&
+               echo "try try" >> tags/end/src/b/readme &&
+               poke tags/end/src/b/readme &&
+               svn commit -m "try to try"
+               cd .. &&
+       test_must_fail git-svn fetch three &> stderr.three &&
+       cmp expect.three stderr.three
+       '
+
+test_done
diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-s=
vn-multi-glob-branch-names.sh
new file mode 100755
index 0000000..f7c7836
--- /dev/null
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+test_description=3D'git-svn multi-glob branch names'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svnrepo' '
+       mkdir project project/trunk project/branches project/branches/v=
14.1 project/tags &&
+       echo foo > project/trunk/foo &&
+       svn import -m "$test_description" project "$svnrepo/project" &&
+       rm -rf project &&
+       svn cp -m "fun" "$svnrepo/project/trunk" \
+                       "$svnrepo/project/branches/v14.1/beta" &&
+       svn cp -m "more fun!" "$svnrepo/project/branches/v14.1/beta" \
+                             "$svnrepo/project/branches/v14.1/gold" &&
+       start_httpd
+       '
+
+test_expect_success 'test clone with multi-glob in branch names' '
+       git svn clone -T trunk -b branches/*/* -t tags "$svnrepo/projec=
t" project &&
+       cd project &&
+               git rev-parse "refs/remotes/v14.1/beta" &&
+               git rev-parse "refs/remotes/v14.1/gold" &&
+       cd ..
+       '
+
+test_expect_success 'test dcommit to multi-globbed branch' "
+       cd project &&
+       git reset --hard 'refs/remotes/v14.1/gold' &&
+       echo hello >> foo &&
+       git commit -m 'hello' -- foo &&
+       git svn dcommit &&
+       cd ..
+       "
+
+stop_httpd
+
+test_done
--
1.5.4.3

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
