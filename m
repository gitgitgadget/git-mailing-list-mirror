From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] Remove bareword filehandles in git-send-email.perl
Date: Sun, 3 May 2009 16:58:26 -0400
Message-ID: <20090503205826.GF20468@coredump.intra.peff.net>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> <1241010743-7020-2-git-send-email-wfp5p@virginia.edu> <1241010743-7020-3-git-send-email-wfp5p@virginia.edu> <1241010743-7020-4-git-send-email-wfp5p@virginia.edu> <1241010743-7020-5-git-send-email-wfp5p@virginia.edu> <1241010743-7020-6-git-send-email-wfp5p@virginia.edu> <1241010743-7020-7-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Sun May 03 22:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0ili-0007kH-SE
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 22:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbZECU62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbZECU62
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 16:58:28 -0400
Received: from peff.net ([208.65.91.99]:49838 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815AbZECU61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 16:58:27 -0400
Received: (qmail 14475 invoked by uid 107); 3 May 2009 20:58:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 03 May 2009 16:58:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 03 May 2009 16:58:26 -0400
Content-Disposition: inline
In-Reply-To: <1241010743-7020-7-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118192>

On Wed, Apr 29, 2009 at 09:12:23AM -0400, Bill Pemberton wrote:

> The script was using bareword filehandles.  This is considered a bad
> practice so they have been changed to indirect filehandles.

I think this is a real improvement; using indirect filehandles mean they
get scoped properly, which can avoid errors (especially forgetting to
close() them, which happens automagically when they go out of scope).
Assuming, of course, that the scoping added by your change is correct,
and doesn't close a handle during a loop that we may have wanted to keep
open (I didn't check carefully).

But in the patch itself:

> -	open(C,">",$compose_filename)
> +	open my $C,'>',$compose_filename

There are actually two things happening here:

  1. s/C/my $C/, which I think is good

  2. losing the parentheses around open(). This is a style issue, but I
     think we usually prefer the parenthesized form of most perl
     builtins (and certainly in the absence of other information, it
     should be left as-is).

And the style thing that probably _should_ be changed is the spacing: we
typically have a space between function arguments. So:

  open(my $C, '>', $compose_file)

> -	print C <<EOT;
> +	print {$C} <<EOT;

Are the braces really necessary here? Is there a version of perl on
which

  print $C <<EOT;

will not work?

-Peff
