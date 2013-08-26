From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Mon, 26 Aug 2013 10:31:35 -0400
Message-ID: <20130826143135.GB14858@sigill.intra.peff.net>
References: <20130824013310.GA9343@sigill.intra.peff.net>
 <20130825061500.GR2882@elie.Belkin>
 <20130825095818.GA12556@sigill.intra.peff.net>
 <20130825195412.GA2752@elie.Belkin>
 <xmqqob8lj8dx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 16:31:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDxpX-00037Q-B6
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 16:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab3HZObj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 10:31:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:37367 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755408Ab3HZObj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 10:31:39 -0400
Received: (qmail 11790 invoked by uid 102); 26 Aug 2013 14:31:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 09:31:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 10:31:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqob8lj8dx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232995>

On Sun, Aug 25, 2013 at 11:03:54PM -0700, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > In other words, why not use something like this?
> >
> > 	write_index: optionally allow broken null sha1s
> >
> > 	Commit 4337b58 (do not write null sha1s to on-disk index, 2012-07-28)
> > 	added a safety check preventing git from writing null sha1s into the
> > 	index. The intent was to catch errors in other parts of the code that
> > 	might let such an entry slip into the index (or worse, a tree).
> >
> > 	Some existing repositories have some invalid trees that contain null
> > 	sha1s already, though.  Until 4337b58, a common way to clean this up
> > 	would be to use git-filter-branch's index-filter to repair such broken
> > 	entries.  That now fails when filter-branch tries to write out the
> > 	index.
> >
> > 	Introduce a GIT_ALLOW_NULL_SHA1 environment variable to relax this check
> > 	and make it easier to recover from such a history.
> 
> I found this version more readable than Peff's (albeit slightly).

OK. Do you want to apply with Jonathan's wording, then?

There's one subtle thing I didn't mention in the "it is already on stack
overflow". If you have a version of git which complains about the null
sha1, then the SO advice is already broken. But if the SO works, then
you do not have a version of git which complains. So why do you care?

And the answer is: you may be pushing to a remote with a version of git
that complains, and which has receive.fsckObjects set (and in many
cases, that remote is GitHub, since we have had that check on for a
while).

I don't know if it is worth spelling that out or not.

> > After this patch, do you think (in a separate change) it would make
> > sense for cache-tree.c::update_one() to check for null sha1 and error
> > out unless GIT_ALLOW_NULL_SHA1 is true?  That would let us get rid of
> > the caveat from the last paragraph.
> 
> Hmm, interesting thought.

I think it is worth doing. The main reason I put the original check on
writing to the index is that it more clearly pinpoints the source of the
error. If we just died during git-write-tree, then you know somebody
broke your index, but you don't know which command.

But checking in both places would add extra protection, and would make
possible the "relax on read, strict on write" policy that filter-branch
wants to do.

-Peff
