From: Jeff King <peff@peff.net>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 16:34:25 -0400
Message-ID: <20160329203425.GA24027@sigill.intra.peff.net>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Elliott Cable <me@ell.io>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:34:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0LR-0007tn-35
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbcC2Ue2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 16:34:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:40174 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753898AbcC2Ue2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:34:28 -0400
Received: (qmail 8130 invoked by uid 102); 29 Mar 2016 20:34:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 16:34:27 -0400
Received: (qmail 26296 invoked by uid 107); 29 Mar 2016 20:34:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 16:34:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 16:34:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290192>

On Tue, Mar 29, 2016 at 06:42:44AM -0500, Elliott Cable wrote:

> So, I find this behaviour a little strange; I can't determine if it's
> a subtle bug, or intentionally undefined/=E2=80=98fuzzy=E2=80=99 beha=
viour:
>=20
>     $ cd a-repo/.git/
>     $ pwd
>     /path/to/a-repo/.git
>     $ git rev-parse --is-inside-work-tree
>     false
>     $ export GIT_WORK_TREE=3D/path/to/a-repo
>     $ git rev-parse --is-inside-work-tree
>     true
>=20
> i.e. when within the repository (the `.git` directory), and when that
> directory is a sub-directory of the working-tree, `rev-parse
> --is-inside-work-tree` reports *false* (reasonable enough, I suppose)=
;
> but then if `$GIT_WORK_TREE` is set to precisely the directory that
> git was *already* assuming was the working-directory, then the same
> command, in the same location, reports *true*.
>=20
> This should probably be made consistent: either `rev-parse
> --is-inside-work-tree` should report =E2=80=9Ctrue=E2=80=9D, even ins=
ide the `.git`
> dir, as long as that directory is a sub-directory of the working-tree
> =E2=80=A6 or repository-directories / `$GIT_DIR` / `.git` directories=
 should
> be excluded from truthy responses to `rev-parse
> --is-inside-work-tree`.

Yeah, I think this is a bug. Presumably what is happening is that we ar=
e
too eager to "cd $GIT_WORK_TREE" inside git-rev-parse, and by the time
we ask "are we in a work tree", the answer has become yes. But the
caller really wants to know "am _I_ inside the work tree".

Unfortunately, I think the fix is likely to be rather tricky, as the
work-tree stuff is happening deep inside setup_git_directory().

-Peff
