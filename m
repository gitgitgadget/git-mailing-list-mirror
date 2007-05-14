From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Sun, 13 May 2007 17:39:43 -0700
Message-ID: <20070514003943.GA18924@muzzle>
References: <vpq7irfengj.fsf@bauges.imag.fr> <20070513171707.GA14024@muzzle> <200705131949.38051.list-receive@mneisen.org> <20070513182405.GA13618@diana.vm.bytemark.co.uk> <20070513210128.GA13428@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Eisenhardt <martin.eisenhardt@mneisen.org>,
	git <git@vger.kernel.org>, Matthieu.Moy@imag.fr
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon May 14 02:39:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnObP-0002Dt-Bl
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbXENAjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 20:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757330AbXENAjq
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:39:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53694 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756783AbXENAjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 20:39:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 16A447DC0A3;
	Sun, 13 May 2007 17:39:44 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 May 2007 17:39:43 -0700
Content-Disposition: inline
In-Reply-To: <20070513210128.GA13428@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47206>

Eric Wong <normalperson@yhbt.net> wrote:
> Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > On 2007-05-13 19:49:34 +0200, Martin Eisenhardt wrote:
> >=20
> > > Another case where I stumbled upon said error message was when I
> > > added an empty (sub)directory to a project in subversion and then
> > > used git to track that project. Since git cannot track an empty
> > > directory, it did not appear in my git working copy. When I mkdir=
'd
> > > the directory locally (in my git wc) and then tried to add files
> > > within that repository, I got exactly the same error as Matthieu.
>=20
> Interesting.  I don't think git-svn currently checks for that case.

Ok, it already *does* check for this case and works for me(TM).

=46rom 8222388080c05157e2926faffcd853bae500c521 Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Sun, 13 May 2007 17:38:21 -0700
Subject: [PATCH] git-svn: test for creating new files in empty previous=
ly directories

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9112-git-svn-dcommit-new-file.sh |   40 +++++++++++++++++++++++++++=
++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 t/t9112-git-svn-dcommit-new-file.sh

diff --git a/t/t9112-git-svn-dcommit-new-file.sh b/t/t9112-git-svn-dcom=
mit-new-file.sh
new file mode 100755
index 0000000..e643c13
--- /dev/null
+++ b/t/t9112-git-svn-dcommit-new-file.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+test_description=3D'git-svn dcommit new files over svn:// test'
+
+. ./lib-git-svn.sh
+
+# standard svnserve runs on 3690, so lets not conflict with that
+SVNSERVE_PORT=3D${SVNSERVE_PORT-'3691'}
+
+start_svnserve () {
+	svnserve --listen-port $SVNSERVE_PORT \
+	         --root $rawsvnrepo \
+	         --listen-once \
+	         --listen-host 127.0.0.1 &
+}
+
+test_expect_success 'start tracking an empty repo' "
+	svn mkdir -m 'empty dir' $svnrepo/empty-dir &&
+	echo anon-access =3D write >> $rawsvnrepo/conf/svnserve.conf &&
+	start_svnserve &&
+	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
+	git svn fetch
+	"
+
+test_expect_success 'create two files in empty-directory with dcommit'=
 "
+	mkdir empty-dir &&
+	echo hello > empty-dir/a &&
+	echo hello > empty-dir/b &&
+	echo hello > empty-dir/c &&
+	git update-index --add empty-dir/a empty-dir/b empty-dir/c &&
+	git commit -m hello &&
+	start_svnserve &&
+	git svn dcommit
+	"
+
+test_done
+
--=20
Eric Wong
