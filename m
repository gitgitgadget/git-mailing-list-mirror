From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Introduce <branch>@{upstream} as shortcut to the
 tracked branch
Date: Thu, 10 Sep 2009 11:55:47 -0400
Message-ID: <20090910155547.GA12409@coredump.intra.peff.net>
References: <20090907084324.GB17997@coredump.intra.peff.net>
 <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
 <20090909104550.GA20108@coredump.intra.peff.net>
 <7vzl93cncn.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
 <20090910141618.GB4942@coredump.intra.peff.net>
 <20090910142628.GA7275@coredump.intra.peff.net>
 <alpine.DEB.1.00.0909101723260.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909101724520.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 17:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlm08-0007pG-Fd
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 17:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbZIJPzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 11:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZIJPzu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 11:55:50 -0400
Received: from peff.net ([208.65.91.99]:59633 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbZIJPzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 11:55:50 -0400
Received: (qmail 2081 invoked by uid 107); 10 Sep 2009 15:56:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Sep 2009 11:56:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Sep 2009 11:55:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0909101724520.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128123>

On Thu, Sep 10, 2009 at 05:25:57PM +0200, Johannes Schindelin wrote:

> 	Changes since v1:
> 	- changed to @{upstream} (and @{u})

Hmm. After applying v2, I accidentally tried "git rev-parse @{t}" and
was surprised to find that it worked! The problem, of course, is that we
saw that it was not one of our keywords and therefore dumped it into
approxidate, which happily converted it into the current time, and
provided me with HEAD@{now}.

Which is sad, because it means "HEAD@{usptream}" will silently produce
incorrect results.

I don't see a way around it, though, short of tightening approxidate's
parsing. Maybe it could keep a flag for "I noticed _anything_ of value
in this string", and we could barf if it isn't set. That would still
allow arbitrary stuff like:

  the 6th of july

and keep Linus' favorite

  I ate 6 hot dogs in July.

but disallow the most obviously wrong dates like:

  t
  usptream
  total bogosity

> +	ret = tracked_suffix(*string, *len);
> +	if (ret) {
> +		char *ref = xstrndup(*string, *len - ret);
> +		struct branch *tracking = branch_get(*ref ? ref : NULL);
> +
> +		free(ref);
> +		if (!tracking)
> +			die ("No tracking branch found for '%s'", ref);
> +		if (tracking->merge && tracking->merge[0]->dst) {
> +			*string = xstrdup(tracking->merge[0]->dst);
> +			*len = strlen(*string);
> +			return (char *)*string;
> +		}
> +	}
> +

I don't think it is a good idea to die for !tracking, but not for
!tracking->merge. That leads to inconsistent user-visible results:

  $ git checkout HEAD^0
  $ git rev-parse HEAD@{u}
  fatal: No tracking branch found for 'HEAD'
  $ git rev-parse bogus@{u}
  bogus@{u}
  fatal: ambiguous argument 'bogus@{u}': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

Shouldn't both cases say the same thing?

Also, your die message has two problems:

 1. It looks at ref immediately after it is free'd, spewing junk.

 2. Ref can be the empty string, which gives you the ugly:

       fatal: No tracking branch found for ''

    Should we munge that into HEAD (or "the current branch") for the
    user?

-Peff
