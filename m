From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] fetch-pack: fix object_id of exact sha1
Date: Mon, 29 Feb 2016 05:00:30 -0500
Message-ID: <20160229100030.GB2950@sigill.intra.peff.net>
References: <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com>
 <1456698144-11519-1-git-send-email-gabrielfrancosouza@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 11:00:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaKd3-0008SC-Rk
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 11:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbcB2KAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 05:00:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:51250 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751126AbcB2KAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 05:00:33 -0500
Received: (qmail 10687 invoked by uid 102); 29 Feb 2016 10:00:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 05:00:33 -0500
Received: (qmail 24313 invoked by uid 107); 29 Feb 2016 10:00:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 05:00:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 05:00:30 -0500
Content-Disposition: inline
In-Reply-To: <1456698144-11519-1-git-send-email-gabrielfrancosouza@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287817>

On Sun, Feb 28, 2016 at 07:22:24PM -0300, Gabriel Souza Franco wrote:

> Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
> 2013-12-05) added support for specifying a SHA-1 as well as a ref name.
> Add support for specifying just a SHA-1 and set the ref name to the same
> value in this case.
> 
> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
> ---
> 
> Not the cleanest conditional I've ever written, but it should handle
> all cases correctly.

I think it does. But I wonder if it wouldn't be more readable to cover
the three formats independently, like:

  if (!get_oid_hex(name, &ref->old_oid) && name[GIT_SHA1_HEXSZ] == ' ') {
	/* <sha1> <ref>, find refname */
	name += GIT_SHA1_HEXSZ + 1;
  } else if (!get_oid_hex(name, &ref->old_oid) && name[GIT_SHA1_HEXSZ] == '\0') {
	/* <sha1>, leave sha1 as name */
  } else {
	/* <ref>, clear any cruft from get_oid_hex */
	oidclr(&ref->old_oid);
  }

And as a bonus you get rid of the separate "oid".  That does call into
get_oid_hex twice, but I doubt the performance impact is measurable.

We could also do:

  if (!get_oid_hex(name, &ref->old_oid)) {
	if (name[GIT_SHA1_HEXSZ] == ' ') {
		/* <sha1> <ref>, find refname */
		name += GIT_SHA1_HEXSZ + 1;
	} else if (name[GIT_SHA1_HEXSZ] == '\0') {
		/* <sha1>, leave sha1 as name */
	} else {
		/* <ref>, clear cruft from oid */
		oidclr(&ref->old_oid);
	}
  } else {
	/* <ref>, clear cruft from get_oid_hex */
	oidclr(&ref->old_oid);
  }

if you want to minimize the calls at the expense of having to repeat the
oidclr().

-Peff
