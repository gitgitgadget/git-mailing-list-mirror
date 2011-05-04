From: Jeff King <peff@peff.net>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Wed, 4 May 2011 03:38:50 -0400
Message-ID: <20110504073850.GA8512@sigill.intra.peff.net>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 09:38:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHWfj-0007S6-3l
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 09:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156Ab1EDHiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 03:38:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33599
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab1EDHix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 03:38:53 -0400
Received: (qmail 15875 invoked by uid 107); 4 May 2011 07:40:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 May 2011 03:40:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2011 03:38:50 -0400
Content-Disposition: inline
In-Reply-To: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172722>

On Tue, May 03, 2011 at 04:33:41PM -0700, Junio C Hamano wrote:

> But the implementation of require_work_tree we have today is quite
> different.  I don't have energy to dig the history, but currently it says:
> 
>  	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
>  	die "fatal: $0 cannot be used without a working tree."
> 
> Which is completely bogus.  Even though we may happen to be just outside
> of it right now, we may have a working tree that we can cd_to_toplevel
> back to.

Yeah, I ran into this just recently when converting merge-one-file to
use git-sh-setup. I was surprised that require_work_tree also required
one to be inside it. My solution was to call cd_to_toplevel first, as
you noted.

> I think the right solution would be to apply the attached patch; and then
> audit all the callers that call "require_work_tree" to see if any of them
> meant "No, it is not Ok just to have working tree somewhere! I want you to
> be IN that working tree when you call me", and convert them to call the
> new require_to_be_in_work_tree instead.

Your proposed semantics for require_work_tree make much more sense to
me, but I worry about compatibility. We can audit our in-tree scripts,
but git-sh-setup is part of the recommended API for external scripts,
no? This change might break those scripts, so we would need to do the
usual deprecation thing. I'm also concerned that the breakage might be
pretty severe. As in, not just "script doesn't work" but "script
silently produces incorrect results" or "script deletes data".

For example, the merge-one-file bug I fixed recently was silently
producing bogus merges because of a confusion over whether it was in the
workdir. Something like "git clean" would be even worse.

-Peff
