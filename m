From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 11:08:56 -0400
Message-ID: <20130527150855.GA8250@sigill.intra.peff.net>
References: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
 <1369665359-48242-1-git-send-email-quanxunzhen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Szakmeister <john@szakmeister.net>
To: Xidorn Quan <quanxunzhen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 27 17:09:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugz2n-0003Xf-TD
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 17:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab3E0PI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 11:08:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:44463 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab3E0PI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 11:08:58 -0400
Received: (qmail 29223 invoked by uid 102); 27 May 2013 15:09:37 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 May 2013 10:09:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 May 2013 11:08:56 -0400
Content-Disposition: inline
In-Reply-To: <1369665359-48242-1-git-send-email-quanxunzhen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225597>

On Mon, May 27, 2013 at 10:35:59PM +0800, Xidorn Quan wrote:

> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 3940202..648fadd 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -127,10 +127,14 @@ static void read_credential(void)
>  		*v++ = '\0';
>  
>  		if (!strcmp(buf, "protocol")) {
> -			if (!strcmp(v, "https"))
> +			if (!strcmp(v, "ftp"))
> +				protocol = kSecProtocolTypeFTP;
> +			else if (!strcmp(v, "https"))
>  				protocol = kSecProtocolTypeHTTPS;
>  			else if (!strcmp(v, "http"))
>  				protocol = kSecProtocolTypeHTTP;
> +			else if (!strcmp(v, "smtp"))
> +				protocol = kSecProtocolTypeSMTP;
>  			else /* we don't yet handle other protocols */
>  				exit(0);

This looks good to me. Git will ask for "protocol=ftp" when
accessing the dumb protocol over ftp. And it will ask for smtp via
git-send-email since 4d31a44 (git-send-email: use git credential to
obtain password, 2013-02-12).

While we are in the area it may be worth thinking if there are other
schemes we would want to support. Git might feed any URL scheme that
curl accepts, so I think we would want to handle FTPS alongside FTP, no?

We may also eventually want IMAP for git-imap-send, but we have not yet
implemented credential-helper support there. We may also want http/socks
proxy authentication, but we also have not implemented the git side of
that yet. So I think both of those can wait for now.

-Peff
