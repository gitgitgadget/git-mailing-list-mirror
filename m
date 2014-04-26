From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Sat, 26 Apr 2014 13:35:49 -0400
Message-ID: <20140426173549.GB21493@sigill.intra.peff.net>
References: <20140421204622.GA9532@logfs.org>
 <20140425182928.GA29904@logfs.org>
 <vpqoazpdz1r.fsf@anie.imag.fr>
 <20140425201048.GB29904@logfs.org>
 <20140426071358.GA7558@sigill.intra.peff.net>
 <7vtx9ghuhg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	=?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6Wf-0008LI-8l
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbaDZRfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 13:35:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:39149 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751732AbaDZRfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:35:51 -0400
Received: (qmail 25917 invoked by uid 102); 26 Apr 2014 17:35:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Apr 2014 12:35:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2014 13:35:49 -0400
Content-Disposition: inline
In-Reply-To: <7vtx9ghuhg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247167>

[+cc Duy for real this time]

On Sat, Apr 26, 2014 at 10:27:07AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > [+cc Duy, whose patch this is]
> >
> > On Fri, Apr 25, 2014 at 04:10:49PM -0400, J=C3=B6rn Engel wrote:
> >
> >> A second option is to add a --pager (or rather --no-pager) option =
to
> >> the command line and allow the user to specify
> >>     GIT_PAGER=3D"git --no-pager -p column --mode=3D'dense color'" =
git -p branch
> >
> > I think we have "--no-pager" already. But the "-p" is turning _on_ =
the
> > pager, so you could also just omit it. IOW, I really don't understa=
nd
> > why the original command was not simply:
> >
> >   GIT_PAGER=3D"git column --mode=3D'dense color'" git -p branch
> >
> > The whole infinite loop that the original commit solved is caused b=
y
> > specifying the "-p". So it sounds like the right solution is "don't=
 do
> > that". Am I missing something useful that the "-p" does?
>=20
> My reading of this is that Duy wanted to let "-p" kick in to pass
> the columnized output, which could be more than a page long, thru
> the usual "less" or whatever pager.

I thought that at first, too. But it doesn't work, because his patch
actually _suppresses_ the pager. For example, something like:

  git config pager.column less
  git config pager.branch "git column --mode=3Ddense"
  git branch

actively works without the original patch (and after J=C3=B6rn's revert=
), but
not with current git. However, you would not use "-p" there in any case=
,
because it kicks in early and only respects $GIT_PAGER.

And I would also say that you are much better off there actually
specifying your whole pipeline as a unit:

  git config pager.branch "git column --mode=3Ddense | less"

I do a similar thing where I have PAGER=3Dless, but set pager.log to
"diff-highlight | less". I tried at one point to have it chain
automatically, but the setup is just too complicated (as we're seeing
here), and it's not _that_ big a deal to explicitly pipe to the next
pager in the sequence.

-Peff
