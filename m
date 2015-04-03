From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Thu, 2 Apr 2015 21:24:30 -0400
Message-ID: <20150403012430.GA16173@peff.net>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
 <20150330221635.GB25212@peff.net>
 <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yi EungJun <semtlenori@gmail.com>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 03:24:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdqLj-0008Fx-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 03:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbbDCBYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 21:24:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:41731 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753431AbbDCBYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 21:24:33 -0400
Received: (qmail 14238 invoked by uid 102); 3 Apr 2015 01:24:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 20:24:33 -0500
Received: (qmail 18114 invoked by uid 107); 3 Apr 2015 01:24:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 21:24:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2015 21:24:30 -0400
Content-Disposition: inline
In-Reply-To: <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266698>

On Thu, Apr 02, 2015 at 05:49:24PM -0700, Kyle J. McKay wrote:

> Subject: [PATCH v2] diff-highlight: do not split multibyte characters
> 
> When the input is UTF-8 and Perl is operating on bytes instead
> of characters, a diff that changes one multibyte character to
> another that shares an initial byte sequence will result in a
> broken diff display as the common byte sequence prefix will be
> separated from the rest of the bytes in the multibyte character.

Thanks, I had a feeling we should be able to do something with perl's
builtin utf8 support.  This doesn't help people with other encodings,
but I'm not sure the original was all that helpful either (in that we
don't actually _know_ the file encodings in the first place).

I briefly confirmed that this seems to do the right thing on po/bg.po,
which has a couple of sheared characters when viewed with the existing
code.

I timed this one versus the existing diff-highlight. It's about 7%
slower. That's not great, but is acceptable to me. The String::Multibyte
version was a lot faster, which was nice (but I'm still unclear on
_why_).

> Fix this by putting Perl into character mode when splitting the
> line and then back into byte mode after the split is finished.

I also wondered if we could simply put stdin into utf8 mode. But it
looks like it will barf whenever it gets invalid utf8. Checking for
valid utf8 and only doing the multi-byte split in that case (as you do
here) is a lot more robust.

> While the utf8::xxx functions are built-in and do not require
> any 'use' statement, the utf8::is_utf8 function did not appear
> until Perl 5.8.1, but is identical to the Encode::is_utf8
> function which is available in 5.8 so we use that instead of
> utf8::is_utf8.

Makes sense. I'm happy enough listing perl 5.8 as a dependency.

EungJun, does this version meet your needs?

-Peff
