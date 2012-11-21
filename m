From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] fix git-config with duplicate variable entries
Date: Wed, 21 Nov 2012 15:06:24 -0500
Message-ID: <20121121200624.GF16280@sigill.intra.peff.net>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
 <20121022211505.GA3301@sigill.intra.peff.net>
 <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
 <20121023223502.GA23194@sigill.intra.peff.net>
 <7vsj84rt1g.fsf@alter.siamese.dyndns.org>
 <20121121192738.GA16280@sigill.intra.peff.net>
 <7vehjm20yu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 21:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbGZF-0006Iw-Rx
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 21:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab2KUUG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 15:06:27 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54493 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756112Ab2KUUG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 15:06:27 -0500
Received: (qmail 9897 invoked by uid 107); 21 Nov 2012 20:07:19 -0000
Received: from ip68-100-44-35.dc.dc.cox.net (HELO sigill.intra.peff.net) (68.100.44.35)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Nov 2012 15:07:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2012 15:06:24 -0500
Content-Disposition: inline
In-Reply-To: <7vehjm20yu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210173>

On Wed, Nov 21, 2012 at 11:46:33AM -0800, Junio C Hamano wrote:

> > The problem is that scripts currently using "--get" are broken by
> > duplicate entries in include files, whereas internal git handles them
> > just fine.  Introducing a new switch means that everybody also has to
> > start using it.
> 
> Not exactly.  There are three classes of people:
> 
>  - wrote scripts using --get; found out that --get barfs if you feed
>    two or more of the same, and have long learned to accept it as a
>    limitation and adjusted their configuration files to avoid it.
>    They have been doing just fine and wouldn't benefit from this
>    series at all.
> 
>  - wrote scripts using --get, relying on it barfing if fed zero
>    (i.e. missing) or two or more (i.e. ambiguous), perhaps a way to
>    keep their configuration files (arguably unnecessarily) clean.
>    They are directly harmed by this series.
> 
>  - wrote scripts using --get-all and did the last-one-wins
>    themselves.  They wouldn't benefit directly from this series,
>    unless they are willing to spend a bit of time to remove their
>    own last-one-wins logic and replace --get-all with --get (but the
>    same effort is needed to migrate to --get-one).
> 
>  - wanted to write scripts using --get, but after finding out that
>    it barfs if you feed two, gave up emulating the internal, without
>    realizing that they could do so with --get-all.  They can now
>    write their scripts without using --get-all.

I have a feeling that your cases 2 and 4 do not really exist. Because we
did "last one wins" in the case that it mattered (between different
files), it was always "good enough" to just assume that using "--get"
behaved like git did internally, and nobody really noticed or cared that
we did duplicate detection at all. But that is just from my own
perspective; it is not like I did a complete survey of git-config users.

More compelling to me is that the only ones negatively affected are your
case 2, and that is qualified by the "arguably unnecessary" you wrote.

Everyone else is not negatively impacted, and can later move to using
"--get" if they want to give up any home-grown --get-all code.

> >   2. If you are a script that only wants to mimic how get retrieves
> >      a single value, then this is a bug fix, as it brings "--get" in
> >      line with git's internal use.
> 
> But by definition, no such script exists (if it used "--get", it
> didn't mimic the internal in the first place).

They do not exist if we assume that anyone using "--get" carefully
thought about the distinction. But I have the impression that is not the
case, and that they _meant_ to behave just like git, and did not realize
they were not doing so. Even our own scripts are guilty of this.

> Yeah, so the only ones that can be harmed is a config lint that uses
> the --get option with --file to make sure variables they know must
> be single value are indeed so, and they are not doing a thorough
> job, unless they are checking across files themselves, at which
> point they are better off using --get-all piped to "sort | uniq -c"
> or something.  So breakages do not matter much for correctly written
> scripts.

Right.

> > IOW, I do not see a legitimate use case for this, but see it as an extra
> > check on broken config.
> 
> Yes, I agree with the latter half of that sentence.

So what do we want to do?

-Peff
