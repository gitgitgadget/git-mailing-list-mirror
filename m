From: Jeff King <peff@peff.net>
Subject: Re: [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 04:41:50 -0400
Message-ID: <20160610084149.GA14592@sigill.intra.peff.net>
References: <20160610075043.GA13411@sigill.intra.peff.net>
 <575A7AD1.50604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:42:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBI0t-0002tN-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbcFJIlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:41:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:52367 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750975AbcFJIlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 04:41:53 -0400
Received: (qmail 31165 invoked by uid 102); 10 Jun 2016 08:41:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 04:41:53 -0400
Received: (qmail 32156 invoked by uid 107); 10 Jun 2016 08:42:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 04:42:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jun 2016 04:41:50 -0400
Content-Disposition: inline
In-Reply-To: <575A7AD1.50604@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296959>

On Fri, Jun 10, 2016 at 10:31:13AM +0200, Michael Haggerty wrote:

> I've often thought that indentation would be a good, fairly universal
> signal for diff to use when deciding how to slide hunks around. Most
> source code is indented in a way that shows its structure.
> 
> I propose the following heuristic:
> 
> * Prefer to start and end hunks following lines with the least
>   indentation.
> 
> * Define the "indentation" of a blank line to be the indentation of
>   the previous non-blank line minus epsilon.
> 
> * In the case of a tie, prefer to slide the hunk down as far as
>   possible.

Hmm. That might help this case, but the original motivation for this
heuristic was something like:

  ##
  # foo
  def foo
    something
  end

  ##
  # bar
  def bar
    something_else
  end

where we add the first function above the second. We end up with:

diff --git a/file.rb b/file.rb
index 1f9b151..f991c76 100644
--- a/file.rb
+++ b/file.rb
@@ -1,4 +1,10 @@
 ##
+# foo
+def foo
+  something
+end
+
+##
 # bar
 def bar
   something else

I.e., crediting the "##" to the wrong spot (or in C, the "/*"). I don't
think indentation helps us there (sliding-up would, but like
sliding-down, it just depends on the order of the hunks).

So I agree that adding indentation to the mix might help, but I don't
think it can replace this heuristic.

-Peff
