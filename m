From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: handle mailmap blobs without trailing newlines
Date: Sun, 25 Aug 2013 04:55:00 -0400
Message-ID: <20130825085500.GA6089@sigill.intra.peff.net>
References: <20130825084549.GA5912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 10:55:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDW6H-0005rZ-Qg
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 10:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab3HYIzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 04:55:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54172 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756129Ab3HYIzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 04:55:03 -0400
Received: (qmail 24352 invoked by uid 102); 25 Aug 2013 08:55:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 25 Aug 2013 03:55:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Aug 2013 04:55:00 -0400
Content-Disposition: inline
In-Reply-To: <20130825084549.GA5912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232940>

On Sun, Aug 25, 2013 at 04:45:50AM -0400, Jeff King wrote:

> This is the minimal fix. Another option would be to switch
> read_mailmap_buf to read_mailmap_string, and I think we could even get
> away with avoiding the extra allocation/copy in the loop (because
> read_mailmap_line seems to cope with newline-or-EOS just fine). But it
> may be better to save that for 'master'.

Hmm, actually, this isn't quite true. read_mailmap_line does handle the
optional trailing newline properly, but the underlying parsing routines
really do want to see a NUL at the end of each line (because they came
from code that just calls fgets). So we really do want to tie off each
line. But given that our only caller is handing us blob contents which
get immediately freed, we could still do that without an extra
allocation if:

  1. We make it clear that the input must be NUL-terminated (i.e., by
     renaming the function and dropping the len parameter).

  2. We drop the "const" from the buf parameter so that we can simply
     terminate each line as we go.

I'll see what the patch looks like.

-Peff
