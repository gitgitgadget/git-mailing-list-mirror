From: Jeff King <peff@peff.net>
Subject: Re: [RFH/PATCH] imap-send: support SNI (RFC4366)
Date: Thu, 21 Feb 2013 00:48:03 -0500
Message-ID: <20130221054803.GB25943@sigill.intra.peff.net>
References: <7vbobey0xv.fsf@alter.siamese.dyndns.org>
 <7vr4kaw7or.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 06:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8P1E-0008SY-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 06:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001Ab3BUFsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 00:48:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55186 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988Ab3BUFsG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 00:48:06 -0500
Received: (qmail 24393 invoked by uid 107); 21 Feb 2013 05:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 00:49:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 00:48:03 -0500
Content-Disposition: inline
In-Reply-To: <7vr4kaw7or.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216754>

On Wed, Feb 20, 2013 at 09:35:16PM -0800, Junio C Hamano wrote:

>>  (2) I do not know if everybody has SSL_set_tslext_host_name() macro
>>      defined, so this patch may be breaking build for people with
>>      different versions of OpenSSL.
> [...]
>
> +#ifdef SSL_CTRL_SET_TLSEXT_HOSTNAME
> +	/*
> +	 * SNI (RFC4366)
> +	 * OpenSSL does not document this function, but the implementation
> +	 * returns 1 on success, 0 on failure after calling SSLerr().
> +	 */
> +	ret = SSL_set_tlsext_host_name(sock->ssl, server.host);
> +	if (ret != 1)
> +		warning("SSL_set_tslext_host_name(%s) failed.\n", server.host);
> +#endif

Yes, I think this is the right macro to check. According to OpenSSL's
CHANGES file, it was introduced between 0.9.8n and 1.0.0 (Mar 2010). But
I note that the use of the same macro in libcurl dates to 2008. Curious.

Note that you have a typo in your warning text (tslext) and an
extra newline.

As far as testing goes, I don't have an SNI IMAP server handy, but I
think you can simulate one with "openssl s_server". It may be a good
long-term goal to test any ssl-specific code against that in our test
suite (on the other hand, most of the interesting stuff is https, where
the details are all handled by curl).

-Peff
