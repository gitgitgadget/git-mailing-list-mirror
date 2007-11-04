From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add missing inside_work_tree setting in
	setup_git_directory_gently
Date: Sun, 4 Nov 2007 14:03:07 +0700
Message-ID: <20071104070307.GA26071@laptop>
References: <20071103100323.GA25305@laptop> <20071103131806.GA25109@laptop> <7vir4ivdcr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoZWG-0000Mx-RU
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 08:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbXKDHDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 02:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbXKDHDU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 02:03:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:3565 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbXKDHDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 02:03:19 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1210030rvb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=lES7+pujBh0AqFJOEVePdxXw1SomCW0CBTA4EZ480Vg=;
        b=kiIpVoJ0yeFRRUHAJL/zvaDpT7xGkzQjH4vqpK6qpd0Mcipm2zqe2LYkPrJmtyg7iyQULKm+Rl6JDcXOD4MYv4rv3dICqIp9SxvQcnLYrFWHw2WxsQP2u/Yd0CNAIdPmSIsoK62LmylmJJkjb+i6CCHkmXnBKZ1fJM2BUhHXin0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=i4k5FSLzbZp9bcO9FlqYp3jFyNKXgVkdWGkTFrXcMsCgpphuasU4Xj7yzqX2IS9Ycq7RkDf1jeWE68TdKJU7BQuR3heBhrk692gY5SuH0TRcZq4HTgc7Dcf93s9i/jFpcw4kUCGbS/QsXGLO3NWi81sJAuZjncvfx65wfdnzyZ0=
Received: by 10.140.251.1 with SMTP id y1mr1743362rvh.1194159798963;
        Sun, 04 Nov 2007 00:03:18 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.0.14])
        by mx.google.com with ESMTPS id b24sm10842430rvf.2007.11.04.00.03.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Nov 2007 00:03:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  4 Nov 2007 14:03:07 +0700
Content-Disposition: inline
In-Reply-To: <7vir4ivdcr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63356>

On Sat, Nov 03, 2007 at 09:33:40PM -0700, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>=20
> > When both GIT_DIR and GIT_WORK_TREE are set, and
> > setup_git_directory_gently() changes the current working
> > directory accordingly, it should also set inside_work_tree =3D 1.
> >
> > Without this, work_tree handling code in setup_git_directory()
> > will be activated. If you stay in root work tree (no prefix),
> > it does not harm. It does if you work from a subdirectory though.
>=20
> Please add automated test script for this, thanks.
>=20

Thank you for reminding.  I tried to put a test in
t1501-worktree.sh and found out core.worktree can override
inside_work_tree previously set by setup_git_directory_gently(),
activating the worktree code in setup_git_directory() again.

This made me think setup_git_directory_gently() should use
get_git_work_tree() instead. But then git_work_tree_cfg may not be
initialized when get_git_work_tree() is called (starting from
setup_git_directory(), git_work_tree_cfg is initialized in
check_repository_format_version(), which is called _after_
setup_git_directory_gently()).

The interaction between these variables and functions is really beyond
my knowledge. Johannes, can you have a look at this? In theory the
following test should pass:

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 7ee3820..bdb7720 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -103,6 +103,11 @@ test_expect_success 'repo finds its work tree from=
 work tree, too' '
 	 test sub/dir/tracked =3D "$(git ls-files)")
 '
=20
+test_expect_success 'Try a command from subdir in worktree' '
+	(cd repo.git/work/sub &&
+	GIT_DIR=3D../.. GIT_WORK_TREE=3D.. git blame dir/tracked)
+'
+
 test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE'=
 '
 	cd repo.git/work/sub/dir &&
 	GIT_DIR=3D../../.. GIT_WORK_TREE=3D../.. GIT_PAGER=3D \
--=20
Duy
