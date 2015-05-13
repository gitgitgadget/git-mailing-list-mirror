From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: fix unmatched code fences
Date: Tue, 12 May 2015 22:15:56 -0400
Message-ID: <20150513021556.GA4160@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 04:16:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsMDO-00010t-MY
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 04:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbbEMCQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 22:16:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:57544 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965002AbbEMCP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 22:15:59 -0400
Received: (qmail 25302 invoked by uid 102); 13 May 2015 02:15:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 21:15:59 -0500
Received: (qmail 6007 invoked by uid 107); 13 May 2015 02:15:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 22:15:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2015 22:15:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268918>

On Tue, May 12, 2015 at 11:45:56AM -0700, Junio C Hamano wrote:

> Jean-Noel Avila <jn.avila@free.fr> writes:
> 
> > This mismatch upsets the renderer on git-scm.com.
> 
> Thanks.
> 
> I do not think this is the first time AsciiDoc(or) rendering glitch
> was reported.  GitHub folks, can you guys think of an automated way
> to spot these?  Relying on site visitors to eyeball and hoping them
> to report is not an ideal approach.

Here's a patch to fix the remaining cases of this particular problem, at
least.

You can build with asciidoctor on the command-line. I don't know if it
would be feasible to diff the asciidoc and asciidoctor output to look
for gratuitous differences (or if the output is so different due to
trivial stuff that the diff is unreadable).

-- >8 --
Subject: doc: fix unmatched code fences in git-stripspace

The asciidoctor renderer is more picky than classic asciidoc,
and insists that the start and end of a code fence be the
same size.

Found with this hacky perl script:

    foreach my $fn (@ARGV) {
      open(my $fh, '<', $fn);
      my ($fence, $fence_lineno, $prev);
      while (<$fh>) {
        chomp;
        if (/^----+$/) {
          if ($fence_lineno) {
            if ($_ ne $fence) {
              print "$fn:$fence_lineno:mismatched fence: ",
                    length($fence), " != ", length($_), "\n";
            }
            $fence_lineno = undef;
          }
	  # hacky check to avoid title-underlining
          elsif ($prev eq '' || $prev eq '+') {
            $fence = $_;
            $fence_lineno = $.;
          }
        }
        $prev = $_;
      }
    }

Signed-off-by: Jeff King <peff@peff.net>
---
With this patch and the one from Jean-Noel, the script above finds only
one hit, which is a false positive. It's at git-commit.txt:233, and it
looks like:

    It is a rough equivalent for:
    ------
            $ git reset --soft HEAD^
            $ ... do something else to come up with the right tree ...
            $ git commit -c ORIG_HEAD

    ------

I have no idea how asciidoc knows that this is a code block and not a
title called "It is a rough...".  So probably in addition to this false
positive, we may be missing some other cases. Doing it right would
probably involve just reusing asciidoc's parser.

 Documentation/git-stripspace.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 6c6e989..60328d5 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -49,7 +49,7 @@ EXAMPLES
 
 Given the following noisy input with '$' indicating the end of a line:
 
---------
+---------
 |A brief introduction   $
 |   $
 |$
@@ -65,7 +65,7 @@ Given the following noisy input with '$' indicating the end of a line:
 
 Use 'git stripspace' with no arguments to obtain:
 
---------
+---------
 |A brief introduction$
 |$
 |A new paragraph$
@@ -79,7 +79,7 @@ Use 'git stripspace' with no arguments to obtain:
 
 Use 'git stripspace --strip-comments' to obtain:
 
---------
+---------
 |A brief introduction$
 |$
 |A new paragraph$
-- 
2.4.0.192.g5f8138b
