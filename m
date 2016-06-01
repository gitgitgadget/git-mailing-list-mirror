From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Fix prune/gc problem with multiple worktrees
Date: Wed, 1 Jun 2016 12:01:44 -0400
Message-ID: <20160601160143.GA9219@sigill.intra.peff.net>
References: <574D382A.8030809@kdbg.org>
 <20160601104519.16563-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	mhagger@alum.mit.edu, dturner@twopensource.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:01:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88af-0000y0-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbcFAQBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 12:01:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:47243 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754177AbcFAQBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:01:47 -0400
Received: (qmail 15726 invoked by uid 102); 1 Jun 2016 16:01:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 12:01:46 -0400
Received: (qmail 1787 invoked by uid 107); 1 Jun 2016 16:01:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 12:01:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 12:01:44 -0400
Content-Disposition: inline
In-Reply-To: <20160601104519.16563-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296093>

On Wed, Jun 01, 2016 at 05:45:15PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This series makes sure that objects referenced by all worktrees are
> marked reachable so that we don't accidentally delete objects that ar=
e
> being used. Previously per-worktree references in index, detached HEA=
D
> or per-worktree reflogs come from current worktree only, not all
> worktrees.
>=20
> The series deals with git-prune and git-gc specifically. I left out
> "git rev-list". It shares the same problem because it will only
> consider current worktree's HEAD, index and per-worktree reflogs. The
> problem is I am not sure if we simply just change, say
> --indexed-objects, to cover all indexes, or should we only do that
> with "--all-worktrees --indexed-objects". I guess this is up for
> discussion.

I don't think touching reachable.c is enough. You also need to make sur=
e
that calling "git pack-objects --indexed-objects" will get them, too
(otherwise they will be either ejected loose or dropped completely
when --unpack-unreachable=3D2.weeks.ago or similar is used).

That code path uses rev-list internally. So I think you need something
like "--all-worktrees --indexed-objects", and you need to pass the new
option in from git-repack to pack-objects (or you need to simply make
"--indexed-objects" cover all worktrees by default).

-Peff
