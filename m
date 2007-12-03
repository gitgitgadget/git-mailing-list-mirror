From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] quote_path: fix collapsing of relative paths
Date: Mon, 3 Dec 2007 01:05:57 -0500
Message-ID: <20071203060557.GA13011@coredump.intra.peff.net>
References: <20071203053001.GA12696@coredump.intra.peff.net> <7vabosqq1l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz4Rh-0005oD-4V
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbXLCGGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 01:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbXLCGGA
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:06:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4802 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbXLCGF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:05:59 -0500
Received: (qmail 26394 invoked by uid 111); 3 Dec 2007 06:05:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Dec 2007 01:05:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 01:05:57 -0500
Content-Disposition: inline
In-Reply-To: <7vabosqq1l.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66871>

On Sun, Dec 02, 2007 at 09:56:54PM -0800, Junio C Hamano wrote:

> Somehow I feel it would be simpler and less error prone if you atually
> count to set len to the length if you got negative.
> [...]
> So perhaps this is easier to read?

Yes, I actually wrote the exact same patch but discarded it in favor of
what I sent, because I wanted a minimal change (and I assumed it had
been implemented that way to avoid the extra strlen call). But that is
just premature micro-optimization, and I think the version you posted is
much less subtle.

> The part that follows the patch, there is a line that subtracts a small
> number (off+1) from len --- while it won't have a wraparound issue, it
> feels a bit ugly to rely on the "magic -1" value to stay "magic
> negative" if small positive integers are subtracted from it.

I hadn't considered that, but another good reason to just set len in the
first place.

> Also the reason the updated condition to the while loop does not have to
> check NUL termination upon negative len is because both (prefix[off] !=
> NUL) and (prefix[off] == in[off]) are checked there, which some may find
> subtle.

Yes, I found it subtle, too, which is why I documented it in the commit
message. :)

> -	if (len > 0)
> -		strbuf_grow(out, len);
> -	strbuf_setlen(out, 0);
> +	if (len < 0)
> +		len = strlen(in);
>  
> +	strbuf_grow(out, len);
> +	strbuf_setlen(out, 0);

I wonder if this 'grow' is really all that useful, since we are now
going to overallocate in some cases. Perhaps we should just let strbuf
do its job and grow as necessary. But it likely doesn't matter either
way.

-Peff
