From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: correctly identify mergetag signature verification
 status
Date: Fri, 27 Jun 2014 20:44:59 -0400
Message-ID: <20140628004458.GB13228@sigill.intra.peff.net>
References: <53AD6C6E.1080208@drmicha.warpmail.net>
 <41f5b516d13fd02408f66ee38704a6c1bb09cbb3.1403875032.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:45:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0glR-0007VD-El
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbaF1ApB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:45:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:52382 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750831AbaF1ApB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:45:01 -0400
Received: (qmail 24032 invoked by uid 102); 28 Jun 2014 00:45:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jun 2014 19:45:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jun 2014 20:44:59 -0400
Content-Disposition: inline
In-Reply-To: <41f5b516d13fd02408f66ee38704a6c1bb09cbb3.1403875032.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252592>

On Fri, Jun 27, 2014 at 03:18:36PM +0200, Michael J Gruber wrote:

> A wrong '}' made our code record the results of mergetag signature
> verification incorrectly.
> 
> Fix it.

I think this is the right thing to do, but we went from:

  if (...)
	if (...) {
		if (...)
			...
		else
			...
	}

to:

  if (...)
	if (...) {
		if (...)
			...
	}
	else
		...

I think part of the point of the original {} was to make it more clear
which else went with which if. Perhaps we should use more here.

I also find the logic a bit hard to follow in that the outer conditions are:

  if (needed_for_goodsig)
	if (sig_is_not_good)
		...

Perhaps it would be easier to read (and would have made the logic error
you are fixing more obvious) as:

  if (extra->len > payload_size) {
	if (!verify_signed_buffer(...))
		status = 0; /* good; all other code paths leave it as -1 */
	else if (verify_message.len <= gpg_message_offset)
		strbuf_addstr(&verify_message, "No signature\n");
  }

That is, for each conditional to check one more thing needed for a good
signature, and then know that all other code paths leave status as -1.

-Peff
