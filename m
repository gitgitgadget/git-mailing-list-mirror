From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/20] safe_create_leading_directories_const(): preserve
 errno
Date: Tue, 16 Feb 2016 18:45:00 -0500
Message-ID: <20160216234500.GA30631@sigill.intra.peff.net>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
 <1ff7b215e37593e935d8db81ea43c3c864161f71.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karl Moskowski <kmoskowski@me.com>,
	Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:45:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVpIr-0001wS-AD
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933338AbcBPXpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 18:45:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:43707 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933256AbcBPXpD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:45:03 -0500
Received: (qmail 9606 invoked by uid 102); 16 Feb 2016 23:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 18:45:03 -0500
Received: (qmail 303 invoked by uid 107); 16 Feb 2016 23:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 18:45:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 18:45:00 -0500
Content-Disposition: inline
In-Reply-To: <1ff7b215e37593e935d8db81ea43c3c864161f71.1455626201.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286460>

On Tue, Feb 16, 2016 at 02:22:14PM +0100, Michael Haggerty wrote:

> Theoretically, free() is allowed to change errno. So preserve the errno
> from safe_create_leading_directories() across the call to free().

I wondered if this was actually a problem in practice. POSIX forbids
recreational setting of errno to "0" , and there are no errors defined
for free(). But apparently it is indeed a thing:

  https://sourceware.org/bugzilla/show_bug.cgi?id=17924

and our desired behavior will even become the standard in a future
POSIX (not that we can rely on that for a long time...).

I suspect in practice that most allocators would use the sbrk() heap for
a small allocation like this, so we wouldn't run into any munmap()
errors during the free. But obviously that's being way more intimate
with the allocator than we should be, and your patch is a simple
protection that works either way.

-Peff
