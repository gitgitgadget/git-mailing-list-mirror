From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Mon, 21 Jan 2008 14:48:28 -0800
Message-ID: <20080121224818.GA8872@untitled>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk> <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma> <20080120093436.GA10924@diana.vm.bytemark.co.uk> <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:49:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5Rr-0005LZ-VE
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbYAUWsa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 17:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbYAUWsa
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:48:30 -0500
Received: from hand.yhbt.net ([66.150.188.102]:51018 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936AbYAUWs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 17:48:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E016F2DC08B;
	Mon, 21 Jan 2008 14:48:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71364>

Junio C Hamano <gitster@pobox.com> wrote:
> Karl Hasselstr=F6m <kha@treskal.com> writes:
>=20
> > On 2008-01-19 19:37:37 -0800, Eric Wong wrote:
> >
> >> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> >>
> >> > I found 100 was a bit too low when doing some large repos, I've
> >> > been using 1000. I'd argue that --repack=3D1000 should be done b=
y
> >> > default.
> >>
> >> I've found 100 for repack too low in the past, too, which is why
> >> repack defaults to 1000 if no number is specified. I think it shou=
ld
> >> hold for gc --auto, too.
> >
> > OK, I'll change it. But remember, gc --auto doesn't do _anything_
> > unless it's deemed necessary, so it should behave much better than
> > just plain repack. In theory at least.
>=20
> Careful. I made the same mistake and it had to be corrected with
> e0cd252eb0ba6453acd64762625b004aa4cc162b.
>=20
> I think defaulting to --repack=3D1000 is a sane first step and you
> guys already have most code for it so that is a very safe thing.
>=20
> Switching to "gc --auto" can be done early post 1.5.4, right?

Sorry for the latency[1], ack on both of Karl's patches for post-1.5.4.

Here's a conservative change for 1.5.4 (not at all tested):

=46rom dbccd8081c6422569a9ca1211e27f56a24fdf3f3 Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Mon, 21 Jan 2008 14:37:41 -0800
Subject: [PATCH] git-svn: default to repacking every 1000 commits

This should reduce disk space usage when doing large imports.
We'll be switching to "gc --auto" post-1.5.4 to handle
repacking for us.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9f2b587..12745d5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1408,11 +1408,9 @@ sub read_all_remotes {
 }
=20
 sub init_vars {
-	if (defined $_repack) {
-		$_repack =3D 1000 if ($_repack <=3D 0);
-		$_repack_nr =3D $_repack;
-		$_repack_flags ||=3D '-d';
-	}
+	$_repack =3D 1000 unless (defined $_repack && $_repack > 0);
+	$_repack_nr =3D $_repack;
+	$_repack_flags ||=3D '-d';
 }
=20
 sub verify_remotes_sanity {
--=20
Eric Wong

[1] - I've been busy with other things and will also be traveling
      this week, too.
