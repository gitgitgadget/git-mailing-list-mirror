From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/21] checkout-index: there are only two possible
 line terminations
Date: Fri, 15 Jan 2016 15:08:56 -0500
Message-ID: <20160115200856.GC11301@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-9-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:09:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKAgB-0007lG-M1
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbcAOUJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:09:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:54603 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751135AbcAOUI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:08:59 -0500
Received: (qmail 9782 invoked by uid 102); 15 Jan 2016 20:08:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:08:58 -0500
Received: (qmail 23224 invoked by uid 107); 15 Jan 2016 20:09:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:09:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 15:08:56 -0500
Content-Disposition: inline
In-Reply-To: <1452815916-6447-9-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284204>

On Thu, Jan 14, 2016 at 03:58:23PM -0800, Junio C Hamano wrote:

> @@ -144,10 +145,7 @@ static int option_parse_u(const struct option *opt,
>  static int option_parse_z(const struct option *opt,
>  			  const char *arg, int unset)
>  {
> -	if (unset)
> -		line_termination = '\n';
> -	else
> -		line_termination = 0;
> +	nul_term_line = !unset;
>  	return 0;
>  }

Is it worth doing this on top?

-- >8 --
Subject: [PATCH] checkout-index: simplify "-z" option parsing

Now that we act as a simple bool, there's no need to use a
custom callback.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout-index.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index d8d7bd3..3b913d1 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -142,13 +142,6 @@ static int option_parse_u(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_z(const struct option *opt,
-			  const char *arg, int unset)
-{
-	nul_term_line = !unset;
-	return 0;
-}
-
 static int option_parse_prefix(const struct option *opt,
 			       const char *arg, int unset)
 {
@@ -192,9 +185,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
 			N_("update stat information in the index file"),
 			PARSE_OPT_NOARG, option_parse_u },
-		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			N_("paths are separated with NUL character"),
-			PARSE_OPT_NOARG, option_parse_z },
+		OPT_BOOL('z', NULL, &nul_term_line,
+			N_("paths are separated with NUL character")),
 		OPT_BOOL(0, "stdin", &read_from_stdin,
 			N_("read list of paths from the standard input")),
 		OPT_BOOL(0, "temp", &to_tempfile,
-- 
2.7.0.244.g0701a9d
