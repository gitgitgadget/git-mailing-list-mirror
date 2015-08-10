From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/17] removing questionable uses of git_path
Date: Mon, 10 Aug 2015 13:47:43 -0400
Message-ID: <20150810174743.GB20546@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
 <xmqqr3nbuk23.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:47:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOrAx-0007RL-IK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbbHJRrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:47:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:43161 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932486AbbHJRrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:47:48 -0400
Received: (qmail 32155 invoked by uid 102); 10 Aug 2015 17:47:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 12:47:48 -0500
Received: (qmail 7681 invoked by uid 107); 10 Aug 2015 17:47:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 13:47:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 13:47:43 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3nbuk23.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275641>

On Mon, Aug 10, 2015 at 10:31:32AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The problem is that git_path uses a static buffer that gets overwritten
> > by subsequent calls.
> 
> As the rotating static buffer pattern used in get_pathname() was
> modeled after sha1_to_hex(), we have the same issue there.  They are
> troubles waiting to happen unless the callers are careful.

Yeah, I think Michael mentioned that to me off-list. I don't _think_
sha1_to_hex is nearly such a problem, because we tend to store sha1s in
their binary form. So sha1_to_hex is almost always an argument to
fprintf() or similar.

Of course there are some exceptions. :) I notice we pass one return
value to add_pending_object, which was almost certainly horribly broken
before 31faeb2 started strdup'ing object_array names.

So certainly it would be nice to audit them all, but there are over 600
calls. Given the likelihood of finding a useful bug, I'm not sure it's
the greatest use of developer time.

> > producing a fairly tame-looking set of function calls. It's OK to pass
> > the result of git_path() to a system call, or something that is a thin
> > wrapper around one (e.g., strbuf_read_file).
> 
> That is a short and good rule to follow, but the problem is that not
> everybody has good taste to interpret the above rule and apply it with
> an eye toward maintainability X-<.

Yeah. Part of me wants to eradicate git_path entirely. My series takes
out over half of the calls, but there are still close to 100, I think.
I think it would make the code worse to convert all of them naively. We
could provide format-aware wrappers for some filesystem functions, like:

  git_stat(&st, "%s", refname);

or something. That feels horribly coupled compared to:

  stat(git_path("%s", refname), &st);

but it makes it very clear what the memory ownership/lifetime rules are.

Anyway, part of my goal with the series was not just to clean up the
existing suspicious spots, but to raise awareness of the issue. At least
for me, I know it's something I will look for more carefully when
reviewing patches. Once bitten, twice shy. :)

-Peff
