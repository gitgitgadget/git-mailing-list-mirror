From: Jeff King <peff@peff.net>
Subject: Re: error pushing stash ?
Date: Tue, 28 Oct 2008 17:23:28 -0400
Message-ID: <20081028212327.GA25358@sigill.intra.peff.net>
References: <20081007003435.GZ5774@eratosthenes.cryptobackpack.org> <20081007004051.GA18889@spearce.org> <20081028211755.GA8074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Bryson <david@statichacks.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 22:25:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuw3t-0001Bk-UM
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 22:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYJ1VXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 17:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbYJ1VXc
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 17:23:32 -0400
Received: from peff.net ([208.65.91.99]:3523 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbYJ1VXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 17:23:31 -0400
Received: (qmail 23764 invoked by uid 111); 28 Oct 2008 21:23:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 17:23:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 17:23:28 -0400
Content-Disposition: inline
In-Reply-To: <20081028211755.GA8074@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99325>

On Tue, Oct 28, 2008 at 05:17:55PM -0400, Jeff King wrote:

> Since no version of receive-pack accepts these "funny refs", perhaps we
> should mirror the check when considering the list of refs to send. IOW,
> don't even make them eligible for matching or mirroring. Patch is below.
> [...]
> +	/* we already know it starts with refs/ to get here */
> +	if (check_ref_format(refname + 5))
> +		return 0;

It occurs to me that since I didn't give a good commit message, and
since I replied to a several-weeks-old message, this might be confusing.
But what I am suggesting is that git-push should not bother trying to
send something that it knows git-receive-pack will refuse. So this check
goes into builtin-send-pack.c, and is an exact mirror of the one in
builtin-receive-pack.c:

 $ sed -n 177,181p builtin-receive-pack.c
        /* only refs/... are allowed */
        if (prefixcmp(name, "refs/") || check_ref_format(name + 5)) {
                error("refusing to create funny ref '%s' remotely", name);
                return "funny refname";
        }

-Peff
