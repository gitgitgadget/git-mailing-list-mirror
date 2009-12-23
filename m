From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG REPORT] git-svn fails to create branches if ssh+svn gets
	used as protocol.
Date: Tue, 22 Dec 2009 23:25:00 -0800
Message-ID: <20091223072500.GB4323@dcvr.yhbt.net>
References: <4B309730.5070509@fkoeberle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian =?iso-8859-1?Q?K=F6berle?= <florian@fkoeberle.de>
X-From: git-owner@vger.kernel.org Wed Dec 23 08:25:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNLas-0004zb-Da
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 08:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbZLWHZB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Dec 2009 02:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbZLWHZB
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 02:25:01 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60963 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbZLWHZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 02:25:00 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A8F1F4EF;
	Wed, 23 Dec 2009 07:25:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B309730.5070509@fkoeberle.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135616>

=46lorian K=F6berle <florian@fkoeberle.de> wrote:
> Hello
>=20
> I haven't seen a link to a bug tracker so I am sending this bug repor=
t
> to the mailing list, I hope it's okay.

Hi Florian,

The mailing list is the bug tracker here :)

> If you try to run
> $ git svn branch foo
> in a project using a svn+ssh url, you get the following error log:
>=20
> Copying svn+ssh://example.org/svn/project/trunk at r1000 to
> svn+ssh://me@example.org/svn/project/branches/foo...
> Trying to use an unsupported feature: Source and dest appear not to b=
e
> in the same repository (src: 'svn+ssh://example.org/svn/project/trunk=
';
> dst: 'svn+ssh://me@example.org/svn/project/branches/foo') at
> /home/florian/libexec/git-core/git-svn line 722
>=20
> It fails as the username is missing in the source url. If you modify =
the
> git-svn script and add the username it works. The bug can be reproduc=
ed
> with git-svn version 1.6.5.7 (svn 1.5.1).

Thanks for the info, the following patch should help.

I rarely get around to testing against svn+ssh servers myself
(and they don't appear too common compared to http/https).

Let us know how it goes, thanks!

=46rom b2bc7e330209659c20d02ee0ba3785f9f59fd0b2 Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Tue, 22 Dec 2009 22:40:18 -0800
Subject: [PATCH] git svn: branch/tag commands detect username in URLs

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index dba0d12..650c9e5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -663,7 +663,8 @@ sub cmd_branch {
 	}
 	$head ||=3D 'HEAD';
=20
-	my ($src, $rev, undef, $gs) =3D working_head_info($head);
+	my (undef, $rev, undef, $gs) =3D working_head_info($head);
+	my $src =3D $gs->full_url;
=20
 	my $remote =3D Git::SVN::read_all_remotes()->{$gs->{repo_id}};
 	my $allglobs =3D $remote->{ $_tag ? 'tags' : 'branches' };
--=20
Eric Wong
