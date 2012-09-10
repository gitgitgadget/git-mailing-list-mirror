From: Jeff King <peff@peff.net>
Subject: Re: Probable bug in file run-command.c function
 clear_child_for_cleanup
Date: Mon, 10 Sep 2012 09:44:06 -0400
Message-ID: <20120910134406.GA7496@sigill.intra.peff.net>
References: <504CAB66.1050003@optimisefitness.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Gould <david@optimisefitness.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 15:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB4Hm-0006GI-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 15:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab2IJNoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 09:44:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39565 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab2IJNoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 09:44:13 -0400
Received: (qmail 27531 invoked by uid 107); 10 Sep 2012 13:44:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 09:44:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 09:44:06 -0400
Content-Disposition: inline
In-Reply-To: <504CAB66.1050003@optimisefitness.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205124>

On Sun, Sep 09, 2012 at 03:44:54PM +0100, David Gould wrote:

> static void clear_child_for_cleanup(pid_t pid)
> {
> 	struct child_to_clean **last, *p;
> 
> 	last = &children_to_clean;
> 	for (p = children_to_clean; p; p = p->next) {
> 		if (p->pid == pid) {
> 			*last = p->next;
> 			free(p);
> 			return;
> 		}
> 	}
> }
> 
> It appears that last is intended to point to the next field that's
> being updated, but fails to "follow" the p pointer along the chain.
> The result is that children_to_clean will end up pointing to the
> entry after the deleted one, and all the entries before it will be
> lost. It'll only be fine in the case that the pid is that of the
> first entry in the chain.

Yes, it's a bug. We should update "last" on each iteration.

> You want something like:
> 
> for (... {
> 	if (... {
> 		...
> 	}
> 	last = &p->next;
> }
> 
> or (probably clearer, but I haven't read your coding style guide, if
> there is one, and some people don't like this approach)

Yes, that's the correct fix. Care to submit a patch?

> for (p = children_to_clean; p; last = &p->next, p = p->next) {
> 	...

That is OK, too, but I think I prefer the first one.

-Peff
