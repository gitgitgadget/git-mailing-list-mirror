From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] "am" state file fix with write_file() clean-up
Date: Mon, 24 Aug 2015 20:02:31 -0400
Message-ID: <20150825000231.GC13261@sigill.intra.peff.net>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
 <1440449890-29490-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 02:02:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU1hG-0003gj-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 02:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbbHYACe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 20:02:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:49424 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751465AbbHYACe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 20:02:34 -0400
Received: (qmail 7611 invoked by uid 102); 25 Aug 2015 00:02:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 19:02:34 -0500
Received: (qmail 29921 invoked by uid 107); 25 Aug 2015 00:02:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 20:02:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 20:02:31 -0400
Content-Disposition: inline
In-Reply-To: <1440449890-29490-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276499>

On Mon, Aug 24, 2015 at 01:58:04PM -0700, Junio C Hamano wrote:

> The workhorse helper function that implements "we have this (short)
> body of text; create a new file that contains it" has a "fatal"
> parameter, to which 1 was passed by almost all callers, but to
> casual readers, it was unclear what that 1 meant.  The patch [3/6]
> splits it to write_file() and write_file_gently() and drops this
> parameter that looks mysterious at the callsites.  A common helper
> function write_file_v() is introduced to implement these two as thin
> wrappers of it.

To be honest, I think the "flags" field is more maintainable going
forward. Now you have _two_ functions, and any features you add to them
have to go in both places. In 4/6 you add the WRITE_FILE_BINARY flag,
but I notice that callers can't actually pass it. And adding it into
write_file() would take us back to square-one with source compatibility.

> The patch [4/6] updates write_file_v() so that it does the "we are
> writing a text file.  Make sure it does not end with an incomplete
> line" logic that [2/6] added only to builtin/am.c, thusly reverting
> what was done to builtin/am.c in [2/6].

I notice this also converts "fatal" to "flags". It seemed weird to me
that did not go into patch 3, but I guess it is OK (we know that
write_file_v has no outstanding callers, since we just added it).

> The patch [5/6] stops all callers that creates a single-liner file
> using write_file() and write_file_gently() from including the final
> LF to the format they pass.  This should not change the behaviour,
> but it probably makes it conceptually cleaner.  You have the contents
> to be placed on a single line, and the helper turns the contents
> into a proper "line".

Nice.

> The patch [6/6] drops the final LF from the parameter to create a
> multi-line file; while this does not hurt in the sense that the
> callee will add a necessary LF back, I do not think it should be
> applied.  Conceptually, if you have a buffer that contains a bunch
> of lines and throw it at a helper to create a file, you'd better
> have the terminating LF yourself before asking the helper to put
> them in the file.

I agree we should drop this one.

-Peff
