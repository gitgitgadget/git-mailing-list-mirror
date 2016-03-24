From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Wed, 23 Mar 2016 20:58:50 -0400
Message-ID: <20160324005849.GA8167@sigill.intra.peff.net>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
 <1458775426-2215-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 01:58:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aitc1-0005cX-VU
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 01:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbcCXA6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 20:58:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:37158 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751157AbcCXA6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 20:58:53 -0400
Received: (qmail 13586 invoked by uid 102); 24 Mar 2016 00:58:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 20:58:52 -0400
Received: (qmail 6986 invoked by uid 107); 24 Mar 2016 00:59:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 20:59:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2016 20:58:50 -0400
Content-Disposition: inline
In-Reply-To: <1458775426-2215-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289703>

On Wed, Mar 23, 2016 at 04:23:41PM -0700, Junio C Hamano wrote:

> So here is the third try (previous round is found at $gmane/289166
> and the very first one is at $gmane/288987).

Is the plan to merge these as-is? The ordering is a bit funny (introduce
breakage, then repair it), and I think the first patch still breaks
t4201.8 (which is then repaired in the fourth one).

I think it would be a lot easier to review as:

  1. Factor out pp_handle_indent(), and any other preparation.

  2. Add --expand-tabs / --no-expand-tabs, with the logic going into
     pp_handle_indent().

  3. Flip the default for some formats to expand-tabs.

Other than that, the end result seems OK to me (I think adding
--expand-tabs would be nice, but I suspect it may need to be marked as
incompatible with some formats; do all formats end up in this same
writing code path?).

> By the way, I have to say that I hate how pretty formatting and
> revision machinery interact with each other.
> 
> pretty.c::commit_formats ought to be the authoritative source of how
> each named format should work, but there are quite a many codepaths
> that just assign CMIT_FMT_SOMETHING to revs->commit_format without
> bothering with other fields in the cmt_fmt_map like is_tformat, and
> I am not sure if they are working correctly even before this patch.

I don't disagree with any of that. I suspect some of the logic may be
complicated for sticking in a table, though. Perhaps we need a:

  void set_pp_format(struct pretty_print_context *ctx, enum cmit_fmt fmt);

that sets up the whole struct based on the given format, and then the
logic can live in C code. I haven't looked closely at that code in a
while, though, so maybe that is overkill.

-Peff
