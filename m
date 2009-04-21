From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC3.5.1 08/12] send-email: Simplify --compose subject
	sanitation
Date: Mon, 20 Apr 2009 22:34:23 -0400
Message-ID: <20090421023423.GB14479@coredump.intra.peff.net>
References: <1240074128-16132-5-git-send-email-mfwitten@gmail.com> <1240074128-16132-6-git-send-email-mfwitten@gmail.com> <1240074128-16132-7-git-send-email-mfwitten@gmail.com> <1240074128-16132-8-git-send-email-mfwitten@gmail.com> <1240074128-16132-9-git-send-email-mfwitten@gmail.com> <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com> <b4087cc50904181937q38ef45fm7409e020ecf40792@mail.gmail.com> <76718490904190713l3d6b5abcmf54544512de87413@mail.gmail.com> <b4087cc50904190739u54a9a9d7p6f011ab2b47c1d05@mail.gmail.com> <1240159421-5643-1-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 04:36:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw5q7-00070A-Mu
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 04:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbZDUCe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 22:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbZDUCe3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 22:34:29 -0400
Received: from peff.net ([208.65.91.99]:59467 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbZDUCe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 22:34:28 -0400
Received: (qmail 6062 invoked by uid 107); 21 Apr 2009 02:34:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Apr 2009 22:34:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 22:34:23 -0400
Content-Disposition: inline
In-Reply-To: <1240159421-5643-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117077>

On Sun, Apr 19, 2009 at 11:43:41AM -0500, Michael Witten wrote:

>  		} elsif (/^Subject:\s*(.+)\s*$/i) {
> -			$initial_subject = $1;
> -			my $subject = $initial_subject;
> -			$_ = "Subject: " .
> -				($subject =~ /[^[:ascii:]]/ ?
> -				 quote_rfc2047($subject) :
> -				 $subject) .
> -				"\n";
> +			$initial_subject = $need_8bit_cte ? quote_rfc2047($1) : $1;
> +			next;

I don't think this is a good idea. need_8bit_cte is about the _whole_
message, including all headers, and this is just about the subject.
Which means that we end up rfc2047-encoding the subject unnecessarily
quite a bit (since at least in git itself, most of the time the
non-ascii bits are in people's names).

This makes the subject unnecessarily ugly for readers which don't do
rfc2047 decoding. And while I expect that most real MUAs these days
handle the decoding, it also makes life harder for people looking
directly at message, or doing "grep -i ^subject: foo.mbox". Yes, I know
that doesn't even remotely follow the standards (e.g., it won't handle
line-wrapped headers), but I don't see any need to make it worse.

All of that being said, even if we decided that it _is_ OK to quote
even when it wasn't unnecessary, your patch still isn't right.
need_8bit_cte is not "does this message need an 8-bit cte at all?" but
rather "does _we_ need to add an 8-bit cte?". A few lines above the ones
you changed, notice that when we see the message already has a
MIME-Version header, we turn set $need_8bit_cte to 0. But in that case,
we still may need to encode the subject if it has non-ascii characters.

-Peff
