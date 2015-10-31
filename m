From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: add --progress option
Date: Sat, 31 Oct 2015 16:07:02 -0400
Message-ID: <20151031200702.GA4115@sigill.intra.peff.net>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
 <CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
 <xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
 <20151030193151.GB5336@sigill.intra.peff.net>
 <xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
 <CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
 <CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
 <xmqqk2q3hrbl.fsf@gitster.mtv.corp.google.com>
 <CAOc6eta7_0RfBUngtMg5ZAEUvjuPVgZ20ESgnbJK=--h53k+Tw@mail.gmail.com>
 <CAOc6etapqKNAXxNycAx9g9VTJXnnCxuXj5eU7giKvZUy5s8X3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 21:07:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZscRJ-00041u-Vz
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 21:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbbJaUHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 16:07:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:50984 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751620AbbJaUHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 16:07:05 -0400
Received: (qmail 23738 invoked by uid 102); 31 Oct 2015 20:07:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Oct 2015 15:07:05 -0500
Received: (qmail 575 invoked by uid 107); 31 Oct 2015 20:07:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Oct 2015 16:07:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Oct 2015 16:07:02 -0400
Content-Disposition: inline
In-Reply-To: <CAOc6etapqKNAXxNycAx9g9VTJXnnCxuXj5eU7giKvZUy5s8X3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280600>

On Sat, Oct 31, 2015 at 12:14:39PM -0600, Edmundo Carmona Antoranz wrote:

> On Sat, Oct 31, 2015 at 11:42 AM, Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
> > On Sat, Oct 31, 2015 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> I do find what Peff showed us a lot easier to follow.
> >>
> >>         if (opts.show_progress < 0) {
> >>                 if (opts.quiet)
> >>                         opts.show_progress = 0;
> >>                 else
> >>                         opts.show_progress = isatty(2);
> >>         }
> >>
> >
> > Ok.... let me rewrite it that way. Other than that, the other things are ok?
> 
> In Peff's implementation I think he uses -1 as --no-progress, 1 as
> --progress and 0 as undefined, right?

I didn't mean to, though I don't promise I didn't send something buggy.
It looks right to me, though:

  if (opts.show_progress < 0) { /* if the user didn't say... */
          if (opts.quiet)
		opts.show_progress = 0; /* quiet means "no progress" */
	  else
		opts.show_progress = isatty(2); /* returns 0/1 bool */
  }

> In my implementation I'm using -1 as undefined and 0 as --no-progress.
> What would be the standard approach?

That's standard. And "1" is "--progress".

> From what I can see on
> parse_options's behavior, if you select --no-progress, the variable
> ends up with a 0, which makes me think I'm using the right approach.
> 
> End result with my assumptions would be:
> 
>         if (opts.show_progress) {
>                 /* user selected --progress or didn't specify */
>                 if (opts.quiet) {
>                         opts.show_progress = 0;
>                 } else if (opts.show_progress < 0) {
>                         opts.show_progress = isatty(2);
>                 }
>         }

The difference between mine and yours is that in mine, "--progress"
trumps "--quiet", whereas it is the other way around in yours. I don't
know if it is a huge deal, but mine makes more sense to me (because
"--progress" is more specific than "--quiet", which might silence other
messages, too).

-Peff
