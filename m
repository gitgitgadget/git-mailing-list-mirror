From: Jeff King <peff@peff.net>
Subject: Re: Should the --encoding argument to log/show commands make any
 guarantees about their output?
Date: Wed, 17 Jun 2015 14:46:08 -0400
Message-ID: <20150617184607.GA28455@peff.net>
References: <557E91D2.3000908@googlemail.com>
 <xmqqzj3y2snq.fsf@gitster.dls.corp.google.com>
 <5581A964.4000500@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jan-Philip Gehrcke <jgehrcke@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 20:46:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ILo-0001xc-Q1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 20:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbbFQSqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 14:46:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:47553 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755170AbbFQSqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 14:46:10 -0400
Received: (qmail 27655 invoked by uid 102); 17 Jun 2015 18:46:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 13:46:10 -0500
Received: (qmail 27959 invoked by uid 107); 17 Jun 2015 18:46:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 14:46:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 14:46:08 -0400
Content-Disposition: inline
In-Reply-To: <5581A964.4000500@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271879>

On Wed, Jun 17, 2015 at 07:07:48PM +0200, Jan-Philip Gehrcke wrote:

> The two-option scenario is totally clear. Although one must stress that the
> "error-out" option can, as discussed, be kept minimally invasive: it is
> sufficient (and common) to just skip those byte sequences (and replace them
> with a replacement symbol) that would be invalid in the requested output
> encoding. This would retain as much information as possible while
> guaranteeing a subsequent decoder to retrieve valid input.

I think "munge into valid UTF-8, even if it means losing data" is a
totally valid and useful option. I'm not completely sure that git should
do that, though.  E.g., you could just as easily do:

  git log --encoding=utf8 | drop_invalid_utf8 | your_script

Or quite possibly, your_script could do the munging itself while reading
the data. I do not know much about Python's input handling, but in Perl,
it is easy to say "the input is utf8, and replace anything bogus with a
substitution character"[1].

> Should we
> 
> * just make this more clear in the docs and/or
> * should we adjust the behavior of --encoding or
> * should we do something entirely different, like adding a new command line
> option or
> * should we just leave things as they are?

I would vote for a documentation change, perhaps like:

Subject: docs: clarify that --encoding can produce invalid sequences

In the common case that the commit encoding matches the
output encoding, we do not touch the buffer at all, which
makes things much more efficient. But it might be unclear to
a consumer that we will pass through bogus sequences.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-options.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 74aa01a..642af6e 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -37,7 +37,10 @@ people using 80-column terminals.
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
 	preferred by the user.  For non plumbing commands this
-	defaults to UTF-8.
+	defaults to UTF-8. Note that if an object claims to be encoded
+	in `X` and we are outputting in `X`, we will output the object
+	verbatim; this means that invalid sequences in the original
+	commit may be copied to the output.
 
 --notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
-- 
2.4.4.719.g3984bc6
