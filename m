From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: don't resolve refs when
 core.warnambiguousrefs is false
Date: Tue, 7 Jan 2014 14:58:44 -0500
Message-ID: <20140107195844.GA21812@sigill.intra.peff.net>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
 <CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
 <20140107171307.GA19482@sigill.intra.peff.net>
 <xmqqzjn7el4k.fsf@gitster.dls.corp.google.com>
 <20140107175241.GA20415@sigill.intra.peff.net>
 <xmqqppo3d1lk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cnb-0003Ur-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbaAGT6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:58:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:56642 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752610AbaAGT6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:58:46 -0500
Received: (qmail 20292 invoked by uid 102); 7 Jan 2014 19:58:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 13:58:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 14:58:44 -0500
Content-Disposition: inline
In-Reply-To: <xmqqppo3d1lk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240142>

On Tue, Jan 07, 2014 at 11:38:15AM -0800, Junio C Hamano wrote:

> >> > Alternatively, I guess "cat-file
> >> > --batch" could just turn off warn_ambiguous_refs itself.
> >> 
> >> Sounds like a sensible way to go, perhaps on top of this change?
> >
> > The downside is that we would not warn about ambiguous refs anymore,
> > even if the user was expecting it to. I don't know if that matters much.
> 
> That is true already with or without Brodie's change, isn't it?
> With warn_on_object_refname_ambiguity, "cat-file --batch" makes us
> ignore core.warnambigousrefs setting.  If we redo 25fba78d
> (cat-file: disable object/refname ambiguity check for batch mode,
> 2013-07-12) to unconditionally disable warn_ambiguous_refs in
> "cat-file --batch" and get rid of warn_on_object_refname_ambiguity,
> the end result would be the same, no?

No, I don't think the end effect is the same (or maybe we are not
talking about the same thing. :) ).

There are two ambiguity situations:

  1. Ambiguous non-fully-qualified refs (e.g., same tag and head name).

  2. 40-hex sha1 object names which might also be unqualified ref names.

Prior to 25ffba78d, cat-file checked both (like all the rest of git).
But checking (2) is very expensive, since otherwise a 40-hex sha1 does
not need to do a ref lookup at all, and something like "rev-list
--objects | cat-file --batch-check" processes a large number of these.

Detecting (1) is not nearly as expensive. You must already be doing a
ref lookup to trigger it (so the relative cost is much closer), and your
query size is bounded by the number of refs, not the number of objects.

Commit 25ffba78d traded off some safety for a lot of performance by
disabling (2), but left (1) in place because the tradeoff is different.

The two options I was musing over earlier today were (all on top of
Brodie's patch):

  a. Revert 25ffba78d. With Brodie's patch, core.warnAmbiguousRefs
     disables _both_ warnings. So we default to safe-but-slow, but
     people who care about performance can turn off ambiguity warnings.
     The downside is that you have to know to turn it off manually (and
     it's a global config flag, so you end up turning it off
     _everywhere_, not just in big queries where it matters).

  b. Revert 25ffba78d, but then on top of it just turn off
     warn_ambiguous_refs unconditionally in "cat-file --batch-check".
     The downside is that we drop the safety from (1). The upside is
     that the code is a little simpler, as we drop the extra flag.

And obviously:

  c. Just leave it at Brodie's patch with nothing else on top.

My thinking in favor of (b) was basically "does anybody actually care
about ambiguous refs in this situation anyway?". If they do, then I
think (c) is my preferred choice.

> > I kind of feel in the --batch situation that it is somewhat useless (I
> > wonder if "rev-list --stdin" should turn it off, too).
> 
> I think doing the same as "cat-file --batch" in "rev-list --stdin"
> makes sense.  Both interfaces are designed to grok extended SHA-1s,
> and full 40-hex object names could be ambiguous and we are missing
> the warning for them.

I'm not sure I understand what you are saying. We _do_ have the warning
for "rev-list --stdin" currently. We do _not_ have the warning for
"cat-file --batch", since my 25ffba78d. I was wondering if rev-list
should go the same way as 25ffba78d, for efficiency reasons (e.g., think
piping to "rev-list --no-walk --stdin").

> Or are you wondering if we should revert 25fba78d, apply Brodie's
> change to skip the ref resolution whose result is never used, and
> tell people who want to use "cat-file --batch" (or "rev-list
> --stdin") to disable the ambiguity warning themselves?

See above. :)

-Peff
