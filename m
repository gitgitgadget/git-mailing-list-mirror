From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 01:03:42 -0400
Message-ID: <20160419050342.GA19439@sigill.intra.peff.net>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
 <1461013950-12503-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 07:04:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asNpS-00008y-BA
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 07:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbcDSFDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 01:03:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:51869 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752551AbcDSFDq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 01:03:46 -0400
Received: (qmail 5446 invoked by uid 102); 19 Apr 2016 05:03:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 01:03:45 -0400
Received: (qmail 12867 invoked by uid 107); 19 Apr 2016 05:03:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 01:03:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 01:03:42 -0400
Content-Disposition: inline
In-Reply-To: <1461013950-12503-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291842>

On Mon, Apr 18, 2016 at 02:12:30PM -0700, Stefan Beller wrote:

> +
> +		/*
> +		 * If a group can be moved back and forth, see if there is an
> +		 * blank line in the moving space. If there is a blank line,
> +		 * make sure the last blank line is the end of the group.

s/an/a/ on the first line

> +		 * As we shifted the group forward as far as possible, we only
> +		 * need to shift it back if at all.

Maybe because I'm reading it as a diff that only contains this hunk and
not the whole rest of the function, but the "we" here confused me. You
mean the earlier, existing loop in xdl_change_compact, right?

Maybe something like:

  As we already shifted the group forward as far as possible in the
  earlier loop...

would help.

> +		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
> +			while (ixs > 0 &&
> +			       !is_blank_line(recs, ix - 1, flags) &&
> +			       recs_match(recs, ixs - 1, ix - 1, flags)) {
> +				rchg[--ixs] = 1;
> +				rchg[--ix] = 0;
> +			}
> +		}

This turned out to be delightfully simple (especially compared to the
perl monstrosity).

I tried comparing the output to the perl one, but it's not quite the
same. In that one we had to work with the existing hunks and context
lines, so any hunk that got shifted ended up with extra context on one
side, and too little on the other. But here, we can actually bump the
context lines to give the correct amount on both sides, which is good.

I guess this will invalidate old patch-ids, but there's not much to be
done about that.

-Peff
