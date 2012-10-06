From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] add a "lua" pretty format
Date: Sat, 6 Oct 2012 13:33:29 -0400
Message-ID: <20121006173329.GA31012@sigill.intra.peff.net>
References: <20120925002325.GA19560@sigill.intra.peff.net>
 <20120925002539.GC19605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 19:33:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKYG0-0002Hs-5S
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 19:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab2JFRde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 13:33:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43074 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754373Ab2JFRdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 13:33:33 -0400
Received: (qmail 8947 invoked by uid 107); 6 Oct 2012 17:34:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 13:34:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 13:33:29 -0400
Content-Disposition: inline
In-Reply-To: <20120925002539.GC19605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207157>

On Mon, Sep 24, 2012 at 08:25:39PM -0400, Jeff King wrote:

> @@ -1168,7 +1180,11 @@ void format_commit_message(const struct commit *commit,
>  		free(enc);
>  	}
>  
> -	strbuf_expand(sb, format, format_commit_item, &context);
> +	if (pretty_ctx->fmt == CMIT_FMT_USERFORMAT)
> +		strbuf_expand(sb, format, format_commit_item, &context);
> +	else if (pretty_ctx->fmt == CMIT_FMT_LUA)
> +		lua_commit_format(sb, &context);
> +

This hunk breaks lots of tests. I know we are not seriously considering
the lua series as-is, but in case anybody wants to play with it, here is
the fix (and we would need the same fix regardless of language, anyway).

You might want to queue this on jk/lua-hackery (probably it would be
squashed in for a real series).

-- >8 --
Subject: [PATCH] pretty: fix up one-off format_commit_message calls

If the usual pretty-print code invokes format_commit_message,
the "fmt" field of the pretty_print_context will always have
either CMIT_FMT_USERFORMAT or CMIT_FMT_LUA in it, and we can
just choose which to use.

However, many call sites invoke format_commit_message
directly without bothering to set the "fmt" field of the
context; they expect format_commit_message to just default
to CMIT_FMT_USERFORMAT in that case, since previously that
was the only format it handled.

The recent addition of the lua formatter broke that
assumption. Rather than require each caller to be more
strict, let's just default to USERFORMAT when the format is
set to something nonsensical.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index fdd4258..7289590 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1180,10 +1180,10 @@ void format_commit_message(const struct commit *commit,
 		free(enc);
 	}
 
-	if (pretty_ctx->fmt == CMIT_FMT_USERFORMAT)
-		strbuf_expand(sb, format, format_commit_item, &context);
-	else if (pretty_ctx->fmt == CMIT_FMT_LUA)
+	if (pretty_ctx->fmt == CMIT_FMT_LUA)
 		lua_commit_format(sb, &context);
+	else
+		strbuf_expand(sb, format, format_commit_item, &context);
 
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
-- 
1.8.0.rc0.22.g285fd2d
