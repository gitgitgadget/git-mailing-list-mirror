From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] showing existing ws breakage
Date: Wed, 27 May 2015 03:22:19 -0400
Message-ID: <20150527072218.GB6898@peff.net>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
 <1432708232-29892-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVfX-00006A-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 09:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbbE0HWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 03:22:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:36527 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750812AbbE0HWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 03:22:21 -0400
Received: (qmail 1467 invoked by uid 102); 27 May 2015 07:22:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:22:21 -0500
Received: (qmail 5230 invoked by uid 107); 27 May 2015 07:22:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 03:22:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 03:22:19 -0400
Content-Disposition: inline
In-Reply-To: <1432708232-29892-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270033>

On Tue, May 26, 2015 at 11:30:28PM -0700, Junio C Hamano wrote:

> The fourth one in v2 used a new option "--[no-]ws-check-deleted",
> but in this round a new option "--ws-error-highlight=<kinds>" is
> defined instead.  With that, you can say
> 
> 	diff --ws-error-highlight=new,old
> 
> to say "I want to see whitespace errors on new and old lines", and
> 
> 	diff --ws-error-highlight=new,old,context
> 	diff --ws-error-highlight=all
> 	
> can be used to also see whitespace errors on context lines.  Being
> able to see whitespace errors on context lines, i.e. the ones that
> were there in the original and you left intact, would help you see
> how prevalent whitespace errors are in the original and hopefully
> would make it easier for you to decide if a separate preliminary
> clean-up to only fix these whitespace errors is warranted.

That makes sense. Neat feature.

In color.diff.*, these are called "new", "old", and "plain". I am of the
opinion that "context" is a far better name than "plain", but perhaps we
should support both for consistency.

Here's a patch for the color.diff side, if we want to go that route.

-- >8 --
Subject: diff: accept color.diff.context as a synonym for "plain"

The term "plain" is a bit ambiguous; let's allow the more
specific "context", but keep "plain" around for
compatibility.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't bother mentioning the historical "plain" in the documentation.
I don't know if it's better to (for people who find it in the wild and
wonder what it means) or if it simply clutters the description. It may
also be that people don't find "plain" as meaningless as I do, and would
rather leave it as the primary in the documentation (and accepting
"context" is just a nicety).

I also resisted the urge to refactor every internal variable and enum
mentioning "plain" into "context". I guess whether that is a good idea
depends on how strongly you agree that "plain" is a bad name. :)

 Documentation/config.txt | 2 +-
 diff.c                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f76e8c..34ef9fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -914,7 +914,7 @@ command line with the `--color[=<when>]` option.
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
-	of `plain` (context text), `meta` (metainformation), `frag`
+	of `context` (context text), `meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
 	`new` (added lines), `commit` (commit headers), or `whitespace`
 	(highlighting whitespace errors).
diff --git a/diff.c b/diff.c
index 7500c55..27bd371 100644
--- a/diff.c
+++ b/diff.c
@@ -54,7 +54,7 @@ static char diff_colors[][COLOR_MAXLEN] = {
 
 static int parse_diff_color_slot(const char *var)
 {
-	if (!strcasecmp(var, "plain"))
+	if (!strcasecmp(var, "context") || !strcasecmp(var, "plain"))
 		return DIFF_PLAIN;
 	if (!strcasecmp(var, "meta"))
 		return DIFF_METAINFO;
-- 
2.4.1.552.g6de66a4
