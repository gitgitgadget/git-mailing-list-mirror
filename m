From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] teach replace objects to sha1_object_info_extended()
Date: Mon, 2 Dec 2013 09:52:25 -0500
Message-ID: <20131202145225.GA12457@sigill.intra.peff.net>
References: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Joey Hess <joey@kitenet.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 02 15:52:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnUrQ-00068J-BP
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 15:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab3LBOw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 09:52:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:49026 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132Ab3LBOw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 09:52:27 -0500
Received: (qmail 20634 invoked by uid 102); 2 Dec 2013 14:52:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Dec 2013 08:52:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Dec 2013 09:52:25 -0500
Content-Disposition: inline
In-Reply-To: <20131130133934.2697.75781.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238632>

On Sat, Nov 30, 2013 at 02:51:18PM +0100, Christian Couder wrote:

> Here is a patch series to improve the way sha1_object_info_extended()
> behaves when it is passed a replaced object.
> [...]
> Christian Couder (5):
>   replace_object: don't check read_replace_refs twice
>   introduce lookup_replace_object_extended() to pass flags
>   Add an "unsigned flags" parameter to sha1_object_info_extended()
>   t6050: show that git cat-file --batch fails with replace objects
>   sha1_file: perform object replacement in sha1_object_info_extended()

Overall looks OK to me.

I find it a little funny that we reuse the READ_SHA1_FILE_REPLACE flag
directly in lookup_replace_object. That means that it is now a
meaningful flag for sha1_object_info_extended, even though the name does
not say so. It also means that the two may have to coordinate further
flags (since a portion of their flag namespace is shared by
lookup_replace_object). I don't foresee adding a lot of new flags,
though, so it probably isn't a huge deal.

I also would have expected sha1_object_info_extended to simply receive
the new flag via the struct object_info. Again, probably not a big deal,
because there aren't many callsites that needed updating. But if we were
not sharing flags with read_sha1_file, I think doing it as a flag in the
struct would be nicer.

I checked the resulting behavior against the list I made earlier; looks
like all of the _extended callsites are doing the right thing.

I do think the checks you added in 277336a (replace: forbid replacing an
object with one of a different type, 2013-09-06) need updating. I
started on that, but I wonder if all of cmd_replace should simply turn
off read_replace_refs. I'd think it would always want to be dealing with
the true objects.

-Peff
