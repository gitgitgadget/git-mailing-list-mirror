From: Jeff King <peff@peff.net>
Subject: Re: [issue?]'git branch -D' case sensitive issue
Date: Fri, 15 Jan 2016 17:28:00 -0500
Message-ID: <20160115222800.GA32081@sigill.intra.peff.net>
References: <CAB4fgE81JHzU=KmN9e=pjsurboipQ3K-pMu-26j+o+FU5G7tQQ@mail.gmail.com>
 <56978BA9.2010005@web.de>
 <CAB4fgE-UbTD6AkTaxyknJ+3ggtzRdYN43wgsamTXOYmGqDQ3_A@mail.gmail.com>
 <5697CFEB.4090308@web.de>
 <xmqq4megkrf9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	=?utf-8?B?6YOt6IW+6aOe?= <tfguo369@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:28:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKCrJ-0002vp-MD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 23:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbcAOW2H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2016 17:28:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:54751 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750723AbcAOW2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 17:28:04 -0500
Received: (qmail 16131 invoked by uid 102); 15 Jan 2016 22:28:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 17:28:03 -0500
Received: (qmail 25079 invoked by uid 107); 15 Jan 2016 22:28:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 17:28:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 17:28:00 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4megkrf9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284225>

On Thu, Jan 14, 2016 at 09:21:46AM -0800, Junio C Hamano wrote:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
> > No, this is typically what we observe on a case insensitive FS.
>=20
> There is an interesting bit in delete_branches::builtin/branch.c
>=20
> 	if (kinds =3D=3D FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
> 		error(_("Cannot delete the branch '%s' "
> 		      "which you are currently on."), bname.buf);
> 		ret =3D 1;
> 		continue;
> 	}
>=20
> The strcmp() does not protect you from attempting to remove "FrOtZ"
> branch when you are on (and more importantly, Git thinks you are on)
> "frotz" branch.  A case-insensitive system then can tell Git that
> the request to remove "refs/heads/FrOtZ" succeeded, even though in
> reality it didn't have such file, and silently "refs/heads/frotz"
> gets removed instead.  You can end up removing your current branch
> that way.

This seemed eerily familiar. And indeed, there's some discussion in:

  http://article.gmane.org/gmane.comp.version-control.git/276506

Changing that strcmp to strcmp_icase() is still wrong, though I suspect
it's less wrong in practice (and errs on the side of caution). But I
think there are probably a lot of similar problems lurking.

-Peff
