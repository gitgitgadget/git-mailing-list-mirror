From: Jeff King <peff@peff.net>
Subject: Re: Re* [BUG] "git checkout -b" erronously thinks a branch already
 exists
Date: Mon, 6 Jun 2011 12:05:38 -0400
Message-ID: <20110606160538.GA11485@sigill.intra.peff.net>
References: <201106051305.13723.stefano.lattarini@gmail.com>
 <7v62ojbuyh.fsf@alter.siamese.dyndns.org>
 <7v1uz7bkc9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:05:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTcJP-0004yy-UD
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 18:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab1FFQFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 12:05:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35504
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab1FFQFt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 12:05:49 -0400
Received: (qmail 7037 invoked by uid 107); 6 Jun 2011 16:05:53 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jun 2011 12:05:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2011 12:05:38 -0400
Content-Disposition: inline
In-Reply-To: <7v1uz7bkc9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175130>

On Sun, Jun 05, 2011 at 10:27:34PM -0700, Junio C Hamano wrote:

> Let's do this instead. I don't know what I was thinking when I wrote that
> inefficient "loop refs to see if there is that one" patch.
> 
> -- >8 --
> Subject: [PATCH] checkout -b <name>: correctly detect existing branch

Yeah, I did a double-take seeing your other patch and wondering why you
weren't just using resolve_ref.

So this patch looks good to me.

> +int ref_exists(char *refname)
> +{
> +	unsigned char sha1[20];
> +	return !!resolve_ref(refname, sha1, 1, NULL);
> +}

I was tempted to suggest that ref_exists could be used in lots of other
places to make the code slightly more readable. But in many cases, the
variable holding the dummy sha1 cannot go away (because it is used
elsewhere in the function), which means manually figuring out whether or
not the sha1 was actually a dummy or not[1]. So it's probably not worth
the effort for such minor gain.

-Peff

[1] For example, the one in create_branch is OK to change, but the one
in delete_branch is not.
