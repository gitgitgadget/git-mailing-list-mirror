From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin/tag: Changes argument format for verify
Date: Thu, 3 Mar 2016 17:26:36 -0500
Message-ID: <20160303222636.GA26712@sigill.intra.peff.net>
References: <1456532864-30327-1-git-send-email-santiago@nyu.edu>
 <20160227043625.GC11604@sigill.intra.peff.net>
 <20160227174523.GB11593@LykOS>
 <20160227183133.GB12822@sigill.intra.peff.net>
 <20160303220502.GA2234@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Thu Mar 03 23:26:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abbhk-0001fP-HS
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 23:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758368AbcCCW0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 17:26:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:54456 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758051AbcCCW0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 17:26:40 -0500
Received: (qmail 20618 invoked by uid 102); 3 Mar 2016 22:26:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 17:26:39 -0500
Received: (qmail 10479 invoked by uid 107); 3 Mar 2016 22:26:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 17:26:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2016 17:26:36 -0500
Content-Disposition: inline
In-Reply-To: <20160303220502.GA2234@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288219>

On Thu, Mar 03, 2016 at 05:05:03PM -0500, Santiago Torres wrote:

> I've been trying to shape these changes into sensible patch, but it is
> not as trivial as I originally thought. I think the issue lies in the
> tag desambiguation aspect of the git-tag command.
> 
> It seems that verify-tag can take either the refname or the hash of the
> object. However, git tag --verify takes only the refname, so it doesn't
> resolve the tag-sha1 if that's specified as an argument.

Right. Git-tag's arguments are tag-names, _not_ general sha1
expressions. So we look at "refs/tags/<whatever>", and nothing else. I
think this should remain the case. Even though it may seem like a
convenience to fall back to resolving the sha1, I think it introduces
unexpected corner cases.

> Also, would it make sense to remove the verify-tag command altogether?

No, I don't think so, for two reasons.

One is simply that it would break backwards compatibility. Verify-tag is
the advertised "plumbing" command for scripts to use, and we do not want
to break them. So even if its features were totally subsumed by "git tag
--verify", we would keep it anyway.

The second is that I don't think it is quite the same thing as "tag
--verify". Verify-tag is plumbing for operating on a tag object; that's
why it takes an arbitrary sha1 expression. But git-tag is a general
command for operating on tag-names defined in refs/tags. We've already
seen one difference there (how we resolve the arguments), but as time
goes on, there may be others. E.g., "tag --verify" may learn to validate
additional elements of the tag, like whether the refname matches what is
in the signed object (that's just an example; I don't know if it's a
good idea or not, but I just meant to illustrate the conceptual
difference between the two).

> On the same line, it seems that there used to be a --raw flag on the
> verify-tag command, should I propagate this to git tag --verify?

I'm not sure if it is necessary. It's primarily for machine consumption,
and in that case, I'd expect people to use the verify-tag plumbing.

-Peff
