From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] clean: improve performance when removing lots of
 directories
Date: Fri, 17 Apr 2015 15:00:02 -0400
Message-ID: <20150417190002.GB32578@peff.net>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
 <1428770587-9674-5-git-send-email-erik.elfstrom@gmail.com>
 <xmqqpp75l1gd.fsf@gitster.dls.corp.google.com>
 <CAMpP7NbQ7pmcjT4pDn5dA5yvfgMgirbkoMD6ijjiFp7zmARPbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjBUp-0002m6-EE
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 21:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbbDQTAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 15:00:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:46875 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932162AbbDQTAF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 15:00:05 -0400
Received: (qmail 14962 invoked by uid 102); 17 Apr 2015 19:00:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 14:00:04 -0500
Received: (qmail 4947 invoked by uid 107); 17 Apr 2015 19:00:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 15:00:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 15:00:02 -0400
Content-Disposition: inline
In-Reply-To: <CAMpP7NbQ7pmcjT4pDn5dA5yvfgMgirbkoMD6ijjiFp7zmARPbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267379>

On Fri, Apr 17, 2015 at 08:15:40PM +0200, erik elfstr=C3=B6m wrote:

> > Doesn't this implementation get confused by modern submodule
> > checkouts and descend into and clean their working tree, though?
> > Module M with path P would have a directory P in the working tree o=
f
> > the top-level project, and P/.git is a regular file that will fail
> > "is_git_directory()" test but records the location of the real
> > submodule repository i.e. ".git/modules/M" via the "gitdir:"
> > mechanism.
> >
>=20
> Yes, there is a problem here. I've added the test below and it fails =
after
> my change by cleaning sub2 (sub1 is not cleaned). Are there more case=
s
> here that I should test for?

I wonder about the opposite case, too (finding more repos than we used
to).

It looks like your patches will find bare repositories in the tree,
whereas the current code does not (it only cares about ".git"). AFAIK,
submodules will never exist as bare in the working tree. And I have see=
n
repositories which embed bare repos as test cases. Admittedly this is
because I work on projects that are related to git itself, but I don't
see a reason to regress this case if the submodule code doesn't get any
benefit.

> Base on the previous discussion of the patch topic I can see 3 option=
s
> for how to fix this:
>=20
> Option 1:
>  Plug the hole in my new is_git_repository function. A quick and dirt=
y
>  fix that passes the above test would be:

I think that makes sense. It would be nice if you could just call
read_gitfile, but that function is very anxious to die on error. So the
prerequisite step would probably be to refactor that into a
read_gitfile_gently that returns an error code.

-Peff

PS Thank you for working on this. I have been quiet because I haven't
   had a chance to look over your patches carefully yet, but overall
   they look very promising.
