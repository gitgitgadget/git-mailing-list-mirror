From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 19/32] commit_lock_file(): rollback lock file on
 failure to rename
Date: Wed, 10 Sep 2014 03:55:19 -0400
Message-ID: <20140910075519.GA16413@peff.net>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
 <1409989846-22401-20-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 10 09:55:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRckR-0003Ky-VN
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 09:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbaIJHzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 03:55:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:46407 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750937AbaIJHzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 03:55:23 -0400
Received: (qmail 11802 invoked by uid 102); 10 Sep 2014 07:55:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 02:55:23 -0500
Received: (qmail 14855 invoked by uid 107); 10 Sep 2014 07:55:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 03:55:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 03:55:19 -0400
Content-Disposition: inline
In-Reply-To: <1409989846-22401-20-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256727>

On Sat, Sep 06, 2014 at 09:50:33AM +0200, Michael Haggerty wrote:

> If rename() fails, call rollback_lock_file() to delete the lock file
> (in case it is still present) and reset the filename field to the
> empty string so that the lockfile object is left in a valid state.

Unlike the previous patch, in this case the contents of the lockfile
_are_ defined. So in theory a caller could somehow retry.

I don't see any callers that want to do that, though (and besides, they
would not know if the error came from the close or the rename), so I
think we can consider that an uninteresting case until somebody
creates such a caller (at which point they can take responsibility for
extending the API).

BTW, while grepping for commit_lock_file calls, I notice we often commit
the shallow file without checking the return code. I'm not sure what we
should do in each case, but I imagine that calling die() is probably
better than continuing as if it succeeded. +cc Duy

-Peff
