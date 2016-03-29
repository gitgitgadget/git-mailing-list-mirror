From: John Keeping <john@keeping.me.uk>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 21:52:08 +0100
Message-ID: <20160329205208.GF1578@serenity.lan>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <20160329203425.GA24027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elliott Cable <me@ell.io>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:52:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0cp-0006eT-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024AbcC2UwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 16:52:24 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:35657 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742AbcC2UwX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 16:52:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 09A8BCDA582;
	Tue, 29 Mar 2016 21:52:22 +0100 (BST)
X-Quarantine-ID: <qxJv2hVhunxm>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qxJv2hVhunxm; Tue, 29 Mar 2016 21:52:21 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 58B41CDA569;
	Tue, 29 Mar 2016 21:52:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20160329203425.GA24027@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290194>

On Tue, Mar 29, 2016 at 04:34:25PM -0400, Jeff King wrote:
> On Tue, Mar 29, 2016 at 06:42:44AM -0500, Elliott Cable wrote:
>=20
> > So, I find this behaviour a little strange; I can't determine if it=
's
> > a subtle bug, or intentionally undefined/=E2=80=98fuzzy=E2=80=99 be=
haviour:
> >=20
> >     $ cd a-repo/.git/
> >     $ pwd
> >     /path/to/a-repo/.git
> >     $ git rev-parse --is-inside-work-tree
> >     false
> >     $ export GIT_WORK_TREE=3D/path/to/a-repo
> >     $ git rev-parse --is-inside-work-tree
> >     true
> >=20
> > i.e. when within the repository (the `.git` directory), and when th=
at
> > directory is a sub-directory of the working-tree, `rev-parse
> > --is-inside-work-tree` reports *false* (reasonable enough, I suppos=
e);
> > but then if `$GIT_WORK_TREE` is set to precisely the directory that
> > git was *already* assuming was the working-directory, then the same
> > command, in the same location, reports *true*.
> >=20
> > This should probably be made consistent: either `rev-parse
> > --is-inside-work-tree` should report =E2=80=9Ctrue=E2=80=9D, even i=
nside the `.git`
> > dir, as long as that directory is a sub-directory of the working-tr=
ee
> > =E2=80=A6 or repository-directories / `$GIT_DIR` / `.git` directori=
es should
> > be excluded from truthy responses to `rev-parse
> > --is-inside-work-tree`.
>=20
> Yeah, I think this is a bug. Presumably what is happening is that we =
are
> too eager to "cd $GIT_WORK_TREE" inside git-rev-parse, and by the tim=
e
> we ask "are we in a work tree", the answer has become yes. But the
> caller really wants to know "am _I_ inside the work tree".

I don't think that's what's happening.  Try:

	$ cd .git/
	$ GIT_WORK_TREE=3D.. git rev-parse --is-inside-work-tree
	true

so I think it's that we refuse to assume that the directory above a Git
directory is a working tree (something similar happens when the
"core.worktree" config variable is set).  I'm not convinced that's
unreasonable.

However, the case above also gives:

	$ GIT_WORK_TREE=3D.. git rev-parse --is-inside-git-dir
	false
	$ test $(pwd) =3D $(GIT_WORK_TREE=3D.. git rev-parse --git-dir); echo =
$?
	0

so even though $PWD *is* the Git directory, we're not in the Git
directory!  Setting GIT_DIR=3D$(pwd) makes no different to that.
