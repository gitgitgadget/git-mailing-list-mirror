From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] filter-branch: fix variable export logic
Date: Wed, 14 May 2008 00:57:17 -0400
Message-ID: <20080514045717.GA16592@sigill.intra.peff.net>
References: <20080513084338.GA23729@sigill.intra.peff.net> <20080513084638.GD23799@sigill.intra.peff.net> <7v7idxr00i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 06:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw94B-000619-Be
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 06:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYENE5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 00:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbYENE5Z
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 00:57:25 -0400
Received: from peff.net ([208.65.91.99]:2495 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbYENE5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 00:57:24 -0400
Received: (qmail 4455 invoked by uid 111); 14 May 2008 04:57:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 14 May 2008 00:57:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 May 2008 00:57:17 -0400
Content-Disposition: inline
In-Reply-To: <7v7idxr00i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82069>

On Tue, May 13, 2008 at 09:18:53PM -0700, Junio C Hamano wrote:

> I was confused by this description ("short-circuit logic"), but I do not
> think there is no short-circuit going on.  This is a simple ignorance of
> shell syntax.

Sorry, I meant "you might think we are not going to run this because of
short circuit, but we always will." So I think the original author was
confused.

But please feel free to reword in a way that makes more sense.

> I have a mild suspecion that this was simply an artifcat of a careless
> conversion from export var="$val" form we did in the past.  I should have
> caught them back then.

Nope, it was originally that way (46eb449). Thank goodness for
git-blame! :)

> The patch is fine, but I find this easier to read:
> 
> +test -z "$ORIG_GIT_DIR" || {
> +	GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
> +}
> +test -z "$ORIG_GIT_WORK_TREE" || {
> +	GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
> +	export GIT_WORK_TREE
> +}
> +test -z "$ORIG_GIT_INDEX_FILE" || {
> +	GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
> +	export GIT_INDEX_FILE
> +}

Yes, that is easier to read. Although what also confused me at first was
the double negation. It is trying to say "if the original existed,
restore it", but it is written as "the original has no content, OR
restore it". So

  if test -n "$ORIG_GIT_DIR"
  then
    ...
  fi

would be even clearer, though I'm not sure if "-n" has any portability
concerns.

-Peff
