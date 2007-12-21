From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Fri, 21 Dec 2007 23:32:45 +0100
Message-ID: <873atvwueq.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew Farrellee <mfarrellee@redhat.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:33:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5qQb-0004Dk-9J
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 23:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbXLUWct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 17:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbXLUWct
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 17:32:49 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:37790 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851AbXLUWcs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 17:32:48 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 23F4717B564
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 23:32:46 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id EDF1B17B561
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 23:32:45 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id CDA7F371A6; Fri, 21 Dec 2007 23:32:45 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69101>

While Matthew Farrellee was working on converting the Condor repository
from cvs to git, he managed to make git segfault (with help from parsecvs)
while producing a 100MB .git repository.  He found the single offending
,v file that led parsecvs to generate a bogus repository, and deduced
that adding a single well-placed branch tag[*] was enough to avoid
the problem.  I fixed the bug in git along with a few in parsecvs that
were exposed while paring the ,v file down from a 150KB monstrosity to
something manageable.

[*] Adding this tag avoids the problem: FOO:1.30.2.5.0.8

First, here's how to reproduce the git segfault, using the file, "min,v"
included below.  Run this in an empty directory:

  rm -rf k .git .git-cvs
  parsecvs min,v >& log
  git clone -q . k

I noticed that while I get a segfault both on x86 and x86_64, I see
clear evidence of it only on x86:

  0 blocks
  error: Object 0d57588da39d10795486bd5451bc2660832228e6 is a commit, not a tree
  Segmentation fault
  fatal: The remote end hung up unexpectedly
  [Exit 1]

When running on an x86_64 system (either debian unstable or rawhide)
I see only this:

  0 blocks
  error: Object 0d57588da39d10795486bd5451bc2660832228e6 is a commit, not a tree
  fatal: The remote end hung up unexpectedly

Of course, valgrind shows you the segfault in both cases.

The above was using git version 1.5.4.rc1.3.gec692
and the latest parsecvs from here:
git://people.freedesktop.org/~keithp/parsecvs

    commit 2b0113ffb0055620193397c025d6f6bca3b110cd
    Author: Finn Arne Gangstad <finnag@pvv.org>
    Date:   Sun Nov 18 15:26:35 2007 -0800

This patch avoids the NULL dereference by treating a failed lookup_tree the
same way an invalid "type" is handled in the "else" block just below.
The only difference is that for a failed lookup_tree, the failing
function has already produced a diagnostic.

-----------------------------------------------------
From 4cd649160d8174b23727b3d7276f1bd7246d0aff Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Fri, 21 Dec 2007 11:56:32 +0100
Subject: [PATCH] Don't dereference NULL upon lookup_tree failure.


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 object.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 16793d9..eb59550 100644
--- a/object.c
+++ b/object.c
@@ -142,10 +142,14 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 		obj = &blob->object;
 	} else if (type == OBJ_TREE) {
 		struct tree *tree = lookup_tree(sha1);
-		obj = &tree->object;
-		if (!tree->object.parsed) {
-			parse_tree_buffer(tree, buffer, size);
-			eaten = 1;
+		if (!tree)
+		    obj = NULL;
+		else {
+		    obj = &tree->object;
+		    if (!tree->object.parsed) {
+			    parse_tree_buffer(tree, buffer, size);
+			    eaten = 1;
+		    }
 		}
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(sha1);
--
1.5.4.rc0.76.g55ee


Here's the contents of min,v
------------------------------------------------
head	1.31;
access;
symbols
	a:1.30.2.18.4.14.4.29.0.6
	b:1.30.2.18.4.14.4.29.0.4
	c:1.30.2.18.4.14.4.29.0.2
	d:1.30.2.18.4.14.4.27.0.6
	e:1.30.2.18.4.14.4.27.0.4
	f:1.30.2.18.4.14.4.27.0.2
	g:1.30.2.18.4.14.4.25.0.6
	h:1.30.2.18.4.14.4.25.0.4
	i:1.30.2.18.4.14.4.25.0.2
	j:1.30.2.18.4.14.4.24.0.24
	k:1.30.2.18.4.14.4.24.0.22
	l:1.30.2.18.4.14.4.24.0.20
	m:1.30.2.18.4.14.4.24.0.18
	n:1.30.2.18.4.14.4.24.0.16
	o:1.30.2.18.4.14.4.24.0.14
	p:1.30.2.18.4.14.4.24.0.12
	q:1.30.2.18.4.14.4.24.0.10
	r:1.30.2.18.4.14.4.24.0.8
	s:1.30.2.18.4.14.4.24.0.6
	t:1.30.2.18.4.14.4.24.0.4
	u:1.30.2.18.4.14.4.24.0.2
	a0:1.30.2.18.4.14.4.23.0.10
	a1:1.30.2.18.4.14.4.23.0.8
	a2:1.30.2.18.4.14.4.23.0.6
	a3:1.30.2.18.4.14.4.23.0.4
	a4:1.30.2.18.4.14.4.23.0.2
	a5:1.30.2.18.4.14.4.22.0.2
	a6:1.30.2.18.4.14.4.21.0.2
	a7:1.30.2.18.4.14.4.18.4.1.0.2
	a8:1.30.2.18.4.14.4.18.0.6
	a9:1.30.2.18.4.14.4.18.0.4
	a10:1.30.2.18.4.14.4.17.0.12
	a11:1.30.2.18.4.14.4.18.0.2
	a12:1.30.2.18.4.14.4.17.0.10
	a13:1.30.2.18.4.14.4.17.0.8
	a14:1.30.2.18.4.14.4.17.0.6
	a15:1.30.2.18.4.14.4.17.0.4
	a16:1.30.2.18.4.14.4.17.0.2
	a17:1.30.2.18.4.14.4.16.0.2
	a18:1.30.2.18.4.14.4.15.0.2
	a19:1.30.2.18.4.14.4.14.0.10
	a20:1.30.2.18.4.14.4.14.0.8
	a21:1.30.2.18.4.14.4.14.0.6
	a22:1.30.2.18.4.14.4.14.0.4
	a23:1.30.2.18.4.14.4.14.0.2
	a24:1.30.2.18.4.14.4.13.0.4
	a25:1.30.2.18.4.14.4.13.0.2
	a26:1.30.2.18.4.14.4.7.0.6
	a27:1.30.2.18.4.14.4.12.0.8
	a28:1.30.2.18.4.14.4.12.0.6
	a29:1.30.2.18.4.14.4.12.0.4
	a30:1.30.2.18.4.14.4.12.0.2
	a31:1.30.2.18.4.14.4.11.0.4
	a32:1.30.2.18.4.14.4.11.0.2
	a33:1.30.2.18.4.14.4.9.0.16
	a34:1.30.2.18.4.14.4.9.0.14
	a35:1.30.2.18.4.14.4.9.0.12
	a36:1.30.2.18.4.14.4.9.0.10
	a37:1.30.2.18.4.14.4.9.0.8
	a38:1.30.2.18.4.14.4.9.0.6
	a39:1.30.2.18.4.14.4.9.0.4
	a40:1.30.2.18.4.14.4.9.0.2
	a41:1.30.2.18.4.14.4.8.0.16
	a42:1.30.2.18.4.14.4.8.0.14
	a43:1.30.2.18.4.14.4.8.0.12
	a44:1.30.2.18.4.14.4.8.0.10
	a45:1.30.2.18.4.14.4.8.0.8
	a46:1.30.2.18.4.14.4.8.0.6
	a47:1.30.2.18.4.14.4.8.0.4
	a48:1.30.2.18.4.14.4.8.0.2
	a49:1.30.2.18.4.14.4.7.0.4
	a50:1.30.2.18.4.14.4.7.0.2
	a51:1.30.2.18.4.14.4.6.0.2
	a52:1.30.2.18.4.14.4.3.4.1.0.2
	a53:1.30.2.18.4.14.4.5.0.2
	a54:1.30.2.18.4.14.4.5.0.14
	a55:1.30.2.18.4.14.4.5.0.12
	a56:1.30.2.18.4.14.4.5.0.10
	a57:1.30.2.18.4.14.4.5.0.8
	a58:1.30.2.18.4.14.4.5.0.6
	a59:1.30.2.18.4.14.4.5.0.4
	a60:1.30.2.18.4.14.4.3.0.4
	a61:1.30.2.18.4.14.4.3.0.2
	a62:1.30.2.18.4.14.4.2.0.16
	a63:1.30.2.18.4.14.4.2.0.14
	a64:1.30.2.18.4.14.4.2.0.12
	a65:1.30.2.18.4.14.4.2.0.10
	a66:1.30.2.18.4.14.4.2.0.8
	a67:1.30.2.18.4.14.4.2.0.6
	a68:1.30.2.18.4.14.4.2.0.4
	a69:1.30.2.18.4.14.4.2.0.2
	a70:1.30.2.18.4.14.4.1.0.4
	a71:1.30.2.18.4.14.4.1.0.2
	a72:1.30.2.18.4.14.0.4
	a73:1.30.2.18.4.14.0.2
	a74:1.30.2.18.4.13.0.2
	a75:1.30.2.18.4.11.0.4
	a76:1.30.2.18.4.11.0.2
	a77:1.30.2.18.4.10.0.2
	a78:1.30.2.18.4.6.0.2
	a79:1.30.2.18.4.3.0.4
	a80:1.30.2.18.4.5.0.4
	a81:1.30.2.18.4.5.0.2
	a82:1.30.2.18.4.3.0.2
	a83:1.30.2.18.2.8.0.2
	a84:1.30.2.18.4.1.0.8
	a85:1.30.2.18.4.1.0.6
	a86:1.30.2.18.4.1.0.4
	a87:1.30.2.18.4.1.0.2
	a88:1.30.2.18.0.4
	a89:1.30.2.18.0.2
	a90:1.30.2.14.0.2
	a91:1.31.0.4
	a92:1.31.0.2
	a93:1.30.2.5.0.14
	a94:1.30.2.5.0.12
	a95:1.30.2.5.0.10
	a96:1.30.2.5.0.6
	a97:1.30.2.5.0.4
	a98:1.30.2.5.0.2
	a99:1.30.2.4.0.2
	a100:1.30.2.3.0.8
	a101:1.30.2.3.0.6
	a102:1.30.2.3.0.2
	a103:1.30.2.3.0.4
	a104:1.30.2.1.0.2
	a105:1.30.0.2
	new-syscall-branch:1.14.0.2
	V6_0-branch:1.6.0.2;
locks; strict;
comment	@ * @;


1.31
date	2000.07.06.19.46.55;	author x;	state Exp;
branches
	1.31.4.1;
next	1.30;

1.30
date	2000.07.06.17.21.26;	author x;	state Exp;
branches
	1.30.2.1;
next	1.14;

1.14
date	99.03.09.23.33.53;	author x;	state Exp;
branches
	1.14.6.1;
next	;

1.14.6.1
date	99.03.17.05.07.10;	author x;	state Exp;
branches;
next	;

1.30.2.1
date	2000.12.13.20.13.52;	author x;	state Exp;
branches;
next	1.30.2.3;

1.30.2.3
date	2001.03.28.18.40.01;	author x;	state Exp;
branches;
next	1.30.2.4;

1.30.2.4
date	2001.08.21.21.14.44;	author x;	state Exp;
branches;
next	1.30.2.5;

1.30.2.5
date	2001.10.17.20.05.09;	author x;	state Exp;
branches
	1.30.2.5.8.1;
next	1.30.2.14;

1.30.2.14
date	2002.06.13.17.02.53;	author x;	state Exp;
branches;
next	1.30.2.18;

1.30.2.18
date	2002.07.18.22.25.03;	author x;	state Exp;
branches;
next	;

1.30.2.5.8.1
date	2002.01.29.00.03.25;	author x;	state Exp;
branches;
next	;

1.31.4.1
date	2002.04.16.22.46.40;	author x;	state Exp;
branches;
next	;


desc
@@


1.31
log
@6.5.0 version string, on the trunk.
@
text
@



















































































@


1.31.4.1
log
@
@
text
@d35 1
a35 1

@


1.30
log
@
@
text
@d35 1
a35 1

@


1.30.2.1
log
@
@
text
@d35 1
a35 1

@


1.30.2.3
log
@
@
text
@d35 1
a35 1

@


1.30.2.4
log
@
@
text
@d35 1
a35 1

@


1.30.2.5
log
@
@
text
@d35 1
a35 1

@


1.30.2.14
log
@
@
text
@d35 1
a35 1

@


1.30.2.18
log
@
@
text
@d35 1
a35 1

@


1.30.2.5.8.1
log
@
@
text
@d35 1
a35 1

@


1.14
log
@
@
text
@d25 43
a67 1
s
d72 1
a72 1
C
d77 6
d84 1
@


1.14.6.1
log
@
@
text
@d25 1
a25 1

@
