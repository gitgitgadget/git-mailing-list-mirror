From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diffcore-rename: fall back to -C when -C -C busts
 the rename limit
Date: Wed, 23 Mar 2011 12:50:40 -0400
Message-ID: <20110323165040.GA4068@sigill.intra.peff.net>
References: <7vk4fqkewo.fsf@alter.siamese.dyndns.org>
 <1300830649-22830-1-git-send-email-gitster@pobox.com>
 <1300830649-22830-3-git-send-email-gitster@pobox.com>
 <20110323155854.GB30337@sigill.intra.peff.net>
 <7vfwqdg574.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:50:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2RGi-0001b4-E8
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 17:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab1CWQun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 12:50:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51178
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108Ab1CWQum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 12:50:42 -0400
Received: (qmail 6436 invoked by uid 107); 23 Mar 2011 16:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 12:51:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 12:50:40 -0400
Content-Disposition: inline
In-Reply-To: <7vfwqdg574.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169853>

On Wed, Mar 23, 2011 at 09:41:19AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > "find the highest limit needed and report once" strategy you used above?
> 
> Wasn't "find the highest limit" your invention in merge-recursive?  The

Hmm, you're right. I was thinking the code you were modifying was called
per-diff, but it's not. Though looking at it again, I think we could
technically still warn several times, one for each recursive call to
merge_recursive. Your call to show() does fix that (because it checks
o->call_depth).

So I think the code after your patch does the right thing.

> As to the warnings in "log" output, I actually prefer leaving saved_* out
> and showing the warning per internal diff invocation. My initial iteration
> was indeed coded that way, and I did the "find the highest" only to mimic
> what was already in merge-recursive.

I think they are two different cases, because the user never gets to see
the intermediate results of merge-recursive. That is, at the end of the
merge we tell them "here's the result, and by the way, we limited
renames." But for something like "log" or "diff-tree --stdin", it is
about doing N independent diffs, and the user gets to see the result of
each. So if we can match the warnings to the actual diffs in the output,
that is much more useful.

But in the case of something like:

  git rev-list HEAD | git diff-tree --stdin >foo.out

I don't think there is a way to match the warnings to their respective
commits. They are on two different streams, and putting the warning to
stdout would pollute the output.

-Peff
