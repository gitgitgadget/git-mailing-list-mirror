From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Thu, 17 Apr 2014 18:16:20 -0400
Message-ID: <20140417221619.GA697@sigill.intra.peff.net>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
 <xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
 <CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
 <xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, git@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Andreas Schwab <schwab@suse.de>, Jan Kara <jack@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 00:16:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wauba-0003ZA-E7
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 00:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbaDQWQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 18:16:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:33499 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750893AbaDQWQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 18:16:22 -0400
Received: (qmail 22749 invoked by uid 102); 17 Apr 2014 22:16:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Apr 2014 17:16:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Apr 2014 18:16:20 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246458>

On Thu, Apr 17, 2014 at 10:04:52AM -0700, Junio C Hamano wrote:

> Commit A can be described in terms of both v3.4 and v9.0, and it may
> be closer to v9.0 than v3.4, and under that definition "we pick the
> closest tag", the current "describe --contains" behaviour may be
> correct, but from the human point of view, it is *WRONG*.
> 
> It is wrong because v9.0 can reach v3.4.  So perhaps the rule should
> be updated to do something like:
> 
>     - find candidate tags that can be used to "describe --contains"
>       the commit A, yielding v3.4, v3.5 (not shown), and v9.0;
> 
>     - among the candidate tags, cull the ones that contain another
>       candidate tag, rejecting v3.5 (not shown) and v9.0;
> 
>     - among the surviving tags, pick the closest.
> 
> Hmm?

Interesting.  I think that would cover some cases, but there are others
in which the tags are not direct descendants. For example, imagine you
have both a "master" and a "maint" branch. You fork a topic from an old
commit that both branches contain, and then independently merge the
topic to each branch. You then cut a release for each. So your graph
might look like:

 ---A---B---C-----D---E---F (maint, v3.4)
     \   \       /
      \   ---G-----H---I (master, v4.0)
       \       /  /
        ------J---

The fix is J, and it got merged up to maint at D, and to master at H.
v4.0 does not contain v3.4. What's the best description of J?

By the rules above, we hit the third rule "pick the closest". Which
means we choose v3.4 or v4.0 based solely on how many commits are
between the topic's merge and the tag release. Which has nothing at all
to do with the topic itself.

In this case we'd show v4.0 (because "J-H-I" is shorter than "J-D-E-F").
But I suspect most users would want to know v3.4, because they want to
know the "oldest" release they can move up to that contains the commit.
But that notion of oldness is not conveyed by the graph above; it's only
an artifact of the tag names.

So you can solve this by actually representing the relationship with a
merge. IOW, by merging v3.4 into v4.0 to say "yes, v4.0 is a superset".
And that's generally what we do in git.git, merging maint into master
periodically. But I imagine there are other possible workflows where
people do not do that "merge up", and the maint and master branches
diverge (and maybe they even cherry-pick from each other, but sometimes
merge if the fix can be based on a common ancestor, as in this case).

-Peff
