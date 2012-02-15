From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: allow overriding smtp-encryption config
 to 'none'
Date: Wed, 15 Feb 2012 17:06:29 -0500
Message-ID: <20120215220629.GA17672@sigill.intra.peff.net>
References: <1329342178-14540-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 23:06:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxmzl-0002jT-GW
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 23:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab2BOWGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 17:06:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37352
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755139Ab2BOWGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 17:06:32 -0500
Received: (qmail 23883 invoked by uid 107); 15 Feb 2012 22:13:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Feb 2012 17:13:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2012 17:06:29 -0500
Content-Disposition: inline
In-Reply-To: <1329342178-14540-1-git-send-email-computersforpeace@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190862>

On Wed, Feb 15, 2012 at 01:42:58PM -0800, Brian Norris wrote:

> According to the manpage:
> 
>  --smtp-encryption=<encryption>
>         Specify the encryption to use, either ssl or tls. Any other value
> 	reverts to plain SMTP.  Default is the value of
>         sendemail.smtpencryption.
> 
> However, if I have already set sendemail.smtpencryption but try to override
> it with something like 'no', the authentication code block still tries to ask
> for a password (and fails).

Sounds reasonable.

> This patch forces $smtp_encryption to 'none' when a proper encryption type is
> not provided, then checks $smtp_encryption before proceeding to authentication.

Defaulting everything except "ssl" or "tls" to "none" seems risky to me.
If I am understanding your patch correctly, then doing this:

  git send-email --smtp-encryption=SSL

will silently treat that as "don't do encryption", which could have
surprising security implications for the user. I chose all-caps as it is
an obvious mistake to make. We probably should treat it the same as
lowercase "ssl", but the same argument applies to other typos like
"tsl".

It seems like a much safer default would be to die() on an invalid
encryption specifier.

-Peff
