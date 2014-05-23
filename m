From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] replace: add --graft option
Date: Fri, 23 May 2014 16:28:53 -0400
Message-ID: <20140523202853.GH19088@sigill.intra.peff.net>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
 <20140522213307.27162.14455.chriscool@tuxfamily.org>
 <20140523195153.GB19088@sigill.intra.peff.net>
 <xmqqlhtsi7l7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:29:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnw5M-00019J-EI
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaEWU24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:28:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:58355 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbaEWU2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:28:55 -0400
Received: (qmail 3984 invoked by uid 102); 23 May 2014 20:28:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 May 2014 15:28:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 May 2014 16:28:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhtsi7l7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250028>

On Fri, May 23, 2014 at 01:05:40PM -0700, Junio C Hamano wrote:

> I just read read_graft_line(); it allows an empty line (both
> length-0 before the terminating LF or CRLF, and a line with
> isspace() only) and ignore them, so "grep '^[^#]'" is not
> sufficient.

Thanks, I missed the space trimming. I think:

  grep '^[^# \t]'

would be enough, though I am not sure that "\t" is portable over a raw
tab.

> > ...this number-based parsing safe, though it would miss removing a stray
> > parent line elsewhere in the commit. It still feels rather magical to
> > me, as we are depending on unspoken format guarantees defined inside
> > parse_commit_buffer.
> 
> Do you mean "we have a carved-in-stone rule that all 'parent ' lines
> must come immediately after a single 'tree ' line, and that is
> implemented in parse_commit_buffer().  The above code follows the
> exact same rule.  It would be nice to have some mechanism to tell
> somebody who wants to update the former that s/he must update this
> new code at the same time"?

Yes, exactly.

> Perhaps a more future-proof way to write Christian's code may be:
> 
>     - find "tree ";
> 
>     - splice the new parents in immediately after that "tree " line;
> 
>     - starting from the end of these new parents, scan up to the end
>       of the header line-by-line, and splice out any line that
>       begins with "parent ".
> 
> which may not be too bad.

Sounds familiar:

  http://article.gmane.org/gmane.comp.version-control.git/249575

-Peff
