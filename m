From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC PATCH] git-svn does not support intermediate directories?
Date: Sat, 7 Mar 2009 20:43:18 -0800
Message-ID: <20090308044318.GA31205@untitled>
References: <21fc26450903031743x4beda8a3i835ecbd428817070@mail.gmail.com> <20090304043019.GC20790@mail.rocksoft.com> <21fc26450903051612u1400b2b4gd71c3eafa4418e37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Stoakes <tim@stoakes.net>, git@vger.kernel.org
To: Michael Lai <myllai@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 05:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgAtD-0008QE-9M
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 05:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbZCHEnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 23:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbZCHEnV
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 23:43:21 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51878 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320AbZCHEnV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 23:43:21 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8381F79E;
	Sun,  8 Mar 2009 04:43:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <21fc26450903051612u1400b2b4gd71c3eafa4418e37@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112612>

Michael Lai <myllai@gmail.com> wrote:
> I did some additional hacking and may have found a slightly cleaner
> way of at least fixing the problems with "git svn fetch".  The proble=
m
> with the wrong paths being initialized for branches and tags is fairl=
y
> minor (since you can just edit the config by hand), so I'll probably
> address that later, if I have time.  Here's the patch (I hope I'm
> doing this right):

Hi Michael,

Your patch was whitespace damaged and lacked a proposed commit message.
Please read Documentation/SubmittingPatches next time.

Anyhow, I fixed your patch up a bit.  Can you sign-off on it
if its right to you or let me know if it's broken?  Thanks.

=46rom cddc7e5bde060eb963534156ae0daaf41c87c21a Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Sat, 7 Mar 2009 20:22:29 -0800
Subject: [PATCH] git-svn: support intermediate paths when matching tags=
/branches
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

=46or repositories laid out like the following:

> [svn-remote "svn"]
> =A0 =A0 =A0 url =3D http://foo.com/svn/repos/bar
> =A0 =A0 =A0 fetch =3D myproject/trunk:refs/remotes/trunk
> =A0 =A0 =A0 branches =3D bar/myproject/branches/*:refs/remotes/*
> =A0 =A0 =A0 tags =3D bar/myproject/tags/*:refs/remotes/tags/*

The "bar" component above is considered the intermediate path
and was not handled correctly.

This patch was originally by Michael Lai (without a commit
message) with some minor fixes:

  * extraneous slash removed from $intermediate_path,
    this was causing tests to fail.

  * fixed a case where $intermediate_path could be "0" and
    considered false by Perl, preventing the necessary
    slash from being appended.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 959eb52..745dd03 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2351,7 +2351,11 @@ sub match_paths {
 	if (my $path =3D $paths->{"/$self->{path}"}) {
 		return ($path->{action} eq 'D') ? 0 : 1;
 	}
-	$self->{path_regex} ||=3D qr/^\/\Q$self->{path}\E\//;
+	my $repos_root =3D $self->ra->{repos_root};
+	my $intermediate_path =3D $self->{url};
+	$intermediate_path =3D~ s#^\Q$repos_root\E(/|$)##;
+	$intermediate_path .=3D '/' if length($intermediate_path) > 0;
+	$self->{path_regex} ||=3D qr/^\/\Q$intermediate_path$self->{path}\E\/=
/;
 	if (grep /$self->{path_regex}/, keys %$paths) {
 		return 1;
 	}
--=20
Eric Wong
