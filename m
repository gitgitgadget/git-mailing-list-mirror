From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Tue, 19 May 2015 18:09:18 -0400
Message-ID: <20150519220918.GA779@peff.net>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
 <1431806796-28902-1-git-send-email-gjthill@gmail.com>
 <xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
 <xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
 <20150519063716.GA22771@peff.net>
 <xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 00:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuphY-0000nK-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbbESWJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:09:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:32856 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752162AbbESWJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:09:21 -0400
Received: (qmail 18896 invoked by uid 102); 19 May 2015 22:09:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 17:09:20 -0500
Received: (qmail 17610 invoked by uid 107); 19 May 2015 22:09:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 18:09:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 18:09:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269415>

On Tue, May 19, 2015 at 11:11:38AM -0700, Junio C Hamano wrote:

> Subject: [PATCH] copy.c: make copy_fd() report its status silently
> 
> When copy_fd() function encounters errors, it emits error messages
> itself, which makes it impossible for callers to take responsibility
> for reporting errors, especially when they want to ignore certaion
> errors.
> 
> Move the error reporting to its callers in preparation.
> [...]

Looks good to me. And thank you for being thorough in analyzing the
impact on all the callers.

>  - hold_lock_file_for_append(), when told to die on error, used to
>    exit(128) relying on the error message from copy_fd(), but now it
>    does its own die() instead.  Note that the callers that do not
>    pass LOCK_DIE_ON_ERROR need to be adjusted for this change, but
>    fortunately there is none ;-)

Not related to your patch, but I've often wondered if we can just get
rid of hold_lock_file_for_append. There's exactly one caller, and I
think it is doing the wrong thing. It is add_to_alternates_file(), but
shouldn't it probably read the existing lines to make sure it is not
adding a duplicate? IOW, I think hold_lock_file_for_append is a
fundamentally bad interface, because almost nobody truly wants to _just_
append.

And I have not investigated it carefully, but I suspect that we do not
even have to be that careful. The only time we write the file is during
clone, and I suspect we could just use a string_list, and then write it
out. We probably don't even need to lock (it's not like we take a lock
before creating the "objects" directory in the first place).

Anyway, end mini-rant. It is probably not hurting anyone and does not
need to be dealt with anytime soon.

-Peff
