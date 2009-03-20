From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.defaultOptions"
Date: Fri, 20 Mar 2009 03:01:48 -0400
Message-ID: <20090320070148.GD27008@coredump.intra.peff.net>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0903170825340.16242@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Fri Mar 20 08:03:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkYlP-0005Qb-7A
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 08:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbZCTHCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 03:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbZCTHB7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 03:01:59 -0400
Received: from peff.net ([208.65.91.99]:52020 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbZCTHB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 03:01:58 -0400
Received: (qmail 7010 invoked by uid 107); 20 Mar 2009 07:02:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 03:02:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 03:01:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0903170825340.16242@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113904>

On Tue, Mar 17, 2009 at 09:05:18AM -0700, Keith Cascio wrote:

> In order to answer your questions as convincingly as possible, I wrote up a 
> one-page PDF document, downloadable here:
>                 http://preview.tinyurl.com/c769dd

Thanks for following up on this. And I appreciate that it is probably
nicer to compose in whatever you used to make this PDF due to enhanced
typography and linked footnotes, but posting a link to a PDF has a few
downsides:

  - the text in the PDF does not become part of the list archive; if
    your tinyurl or your hosted file ever goes away, the content of
    your message is permanently lost

  - it makes it very difficult for readers to reply inline to your
    comments

So please just send text emails in the future.

This time, however, I converted your PDF to text so I could reply.

Your PDF said:

> No matter which implementation, we all agree the semantics are "pretend
> as if the options in [diff.defaultOptions] were prepended to the command
> line" [1]. That requirement is subject neither to confusion nor doubt.
> An implementation is acceptable only if it delivers exactly that
> behavior to the user.

OK, good, I think we are in agreement there.

> Git's diff options processing scheme is a mature[2], versatile
> instrument relied upon by at least 47 client codepaths. The API it
> provides for recording user intent to an instance of struct diff_options
> entails the following steps[3]:
> 
> 1) to prepare the structure for recording, call diff_setup() once
> 
> 2) to record user intention, write to the structure[4], calling
> diff_opt_parse() as needed

I think there is a step 1.5, where callers can record their own
"default" intentions -- things that this particular caller will default
to, but which users can override via command-line options. E.g., "git
log" tweaks several options in cmd_log_init, such as turning on
ALLOW_TEXTCONV and RECURSIVE.

> 3) to prepare the structure for "playback", call diff_setup_done() once
>
> 4) to test user intention, read from the structure

OK, makes sense.

> Git's code is already equipped to react to every kind of user intention
> during step 2.

More or less. I think in our past discussion, it came about that there
are some things the user cannot say, like undoing certain options. This
could be a problem if a caller defaults options to something un-doable.
For example, I don't think there is a way to turn off OPT_RECURSIVE in
git-log.  In practice, this hasn't been a problem.

> An attractive (but hopelessly flawed) strategy is to pre-load the
> structure with defaultOptions before step 2. Step 1, diff_setup(), is
> the only place to do that, since the client starts overwriting as soon
> as diff_setup() returns.

I don't agree that it is hopelessly flawed. It requires a new call at
each callsite to say "I have set up my defaults, now take the user
defaults from the config, before I proceed to step 2 and parse the
user intentions". Which sounds awful to add a new call at each site,
but I am not sure that is not necessary anyway.

I don't know that all callsites will _want_ to respect such a config
option, especially not plumbing. So any callsite is going to have to opt
into this functionality anyway.

> Some aspects of user intention dictate whether or not to perform the
> pre-load at all, most notably: which Git command the user invoked (also
> switches). But at step 1, inside diff_setup(), we don't know the user's
> full intention yet, so we can't decide whether or not to perform the
> pre-load.

I think I suggested last time that the idea of whether or not to perform
the pre-load doesn't _have_ to come from the same set of user intention.
That is, in the call

  git [git-options] diff [diff-options]

we actually parse [git-options] and [diff-options] at different times.
Pre-load intention can go into [git-options], which avoids this
dependency cycle.

> This could tempt an undisciplined programmer to try to peek ahead at
> part of the user's intention before the code sees it in its normal
> course. That would be a disaster because it would undermine the
> integrity, not to mention beauty, of Git's entire initialization scheme.
> It would be a cheap hack; an inelegant, fragile, ugly, and utterly
> half-baked attempt to bypass and circumvent the existing architecture.

Your poetry aside, I agree that way madness lies.

> My proposal:
> 
> a) patiently accumulates user intention via Git's well-established
> initialization scheme, never needing to peek ahead or misbehave in any
> way, thus attaining harmony.
> 
> b) postpones the decision whether or not to load defaultOptions until
> step 3, diff_setup_done(), after we've had every opportunity to examine
> user intention, but loads them effectively underneath any explicit
> command line options, thereby fulfilling the agreed upon semantic
> obligation.
> 
> c) is inspired by a simple, powerful, easy-to-understand, and popular
> metaphor: layer flattening.
> 
> Why, oh why do some people think there's an "easier" way[1]?!

Because I outlined it above?

Look, I am not opposed to layer flattening if that's what is required to
get it right. But consider the downside of layer flattening: we must
always record intent-to-change when making a change to the struct (i.e.,
the "mask" variable in your original patches). This is fine for members
hidden behind macros, but there are a lot of members that are assigned
to directly. We would need to:

  1. Introduce new infrastructure for assigning to these members.

  2. Fix existing locations by converting them to this infrastructure.

  3. Introduce some mechanism to help future callers get it right (since
     otherwise assigning directly is a subtle bug).

This is elementary encapsulation; in a language with better OO support,
you would hide all of your struct members behind accessors. But this is
C, and a dialect of C where that doesn't usually happen. So I think it
is going to introduce a lot of code changes, and the resulting code will
not look as much like the rest of git as it once did.

So what I am suggesting is that _if_ there is an easier way to do it,
then it is worth exploring.

-Peff
