From: Jeff King <peff@peff.net>
Subject: Re: git-log man2html conversion broken:
 http://git-scm.com/docs/git-log
Date: Wed, 8 Oct 2014 22:29:56 -0400
Message-ID: <20141009022956.GA18440@peff.net>
References: <CAMsgyKadiE-HOH_oLK=Fc0UQXnEuUTMHmz3=9zRiMvU0fr4KvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 04:30:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xc3UR-0001Oq-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 04:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaJIC37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 22:29:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:56585 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750922AbaJIC36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 22:29:58 -0400
Received: (qmail 22795 invoked by uid 102); 9 Oct 2014 02:29:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 21:29:58 -0500
Received: (qmail 20650 invoked by uid 107); 9 Oct 2014 02:29:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 22:29:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2014 22:29:56 -0400
Content-Disposition: inline
In-Reply-To: <CAMsgyKadiE-HOH_oLK=Fc0UQXnEuUTMHmz3=9zRiMvU0fr4KvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, 2014 at 12:49:54PM -0500, Derek Moore wrote:

> The HTML for the git-log man page is being misrendered on the official site.
> 
> See the placehoders list under "format:<string>" in the PRETTY FORMATS section.

Thanks for the report. This renders fine locally with asciidoc, but the
git-scm.com site uses the ruby asciidoctor gem. I think the issue is
that the start and end markers for the code block are not identical:

-------
The author of fe6e0ee was Junio C Hamano, 23 hours ago
The title was >>t4119: test autocomputing -p<n> for traditional diff
input.<<

--------

Note that we start with 7 hyphens, but end with 8.

The git-scm issue was already reported here (the site's issues are
tracked separately from the mailing list):

  https://github.com/git/git-scm.com/issues/447

but I doubt if asciidoctor folks have been notified. I'll call their
attention to that issue; they should produce the same output as regular
asciidoc for this case.

In the meantime, I don't know if it is worth us applying this workaround
to the documentation (I'd feel better if I had actually confirmed that
it fixed the problem):

-- >8 --
Subject: docs: use identical start/end lines for code blocks

Some AsciiDoc implementations (like the AsciiDoctor gem) do not
recognize the end of a code block if it does not match the start
line exactly. Those implementations are wrong, but we can work around it
and make our sources look nicer at the same time.

---
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index eecc39d..d3e3d25 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -91,7 +91,7 @@ instead of '\n'.
 E.g, 'format:"The author of %h was %an, %ar%nThe title was >>%s<<%n"'
 would show something like this:
 +
--------
+--------
 The author of fe6e0ee was Junio C Hamano, 23 hours ago
 The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
 
