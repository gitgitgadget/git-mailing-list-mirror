From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] http-push: don't always prompt for password
Date: Wed, 2 Nov 2011 13:23:10 -0400
Message-ID: <20111102172310.GA28525@sigill.intra.peff.net>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com>
 <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
 <4EB104EA.2040001@atlas-elektronik.com>
 <7vk47ijvlv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 18:23:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLeX0-0008Pg-Oy
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 18:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338Ab1KBRXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 13:23:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60249
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755630Ab1KBRXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 13:23:13 -0400
Received: (qmail 14662 invoked by uid 107); 2 Nov 2011 17:29:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 13:29:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 13:23:10 -0400
Content-Disposition: inline
In-Reply-To: <7vk47ijvlv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184649>

On Wed, Nov 02, 2011 at 10:13:32AM -0700, Junio C Hamano wrote:

> This defers the calls to git_getpass* until we get 401 from the server
> side.
> 
> I am guessing the reason why in the current code get_curl_handle() has a
> call to init_curl_http_auth() very early, but only when user_name is set,
> is because it is likely for a site to require authentication when the user
> already has "username@" in its URL, and doing it this way will avoid the
> extra round-trip because by the time we make an HTTP request, we have both
> name and pass. If we apply this patch, the check in init_curl_http_auth()
> that asks for the password only when user_name is set becomes unnecessary.

Yeah, that was my reading, as well. I was tempted to do away with it, as
it makes the code much simpler, at the cost of doing that extra
round-trip. However, most browsers do that round-trip, and I don't think
it's that big a deal.

In the end I decided not to switch it just because I wanted to be as
minimally invasive as possible, just in case somebody did care about the
round trip.

> I think the second hunk at l.846 sort of makes sense, but not quite.
> 
> "We got 401 even though we know we have supplied name and pass" is a valid
> criterion to decide that the name/pass is an invalid combination. But it
> makes me wonder if this code in its early days guaranteed whenever we have
> user_name we always have made sure we have user_pass (otherwise by asking
> for it with git_getpass) and that is the reason why it had to check only
> for user_name, and if that is the case perhaps the real breakage is we are
> not keeping that guarantee in the current code?

All of my patches attempted to keep that condition, as well (because
credential_fill tries to do so). But I didn't think about it during the
re-roll of the patches that are in master now, so maybe that wasn't
kept.

It seems to me that Stefan's patch actually causes that (because he
removes the early "set password if we have a username" logic). But I'll
take another look at what's in master.

-Peff
