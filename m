From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] prefix_path(): Unconditionally free result of prefix_path
Date: Mon, 4 May 2015 23:21:59 -0400
Message-ID: <20150505032158.GA23587@peff.net>
References: <1430766714-22368-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 05 05:22:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpTQw-0006rJ-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 05:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbbEEDWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 23:22:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752235AbbEEDWC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 23:22:02 -0400
Received: (qmail 7601 invoked by uid 102); 5 May 2015 03:22:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 May 2015 22:22:01 -0500
Received: (qmail 4050 invoked by uid 107); 5 May 2015 03:22:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 May 2015 23:22:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 May 2015 23:21:59 -0400
Content-Disposition: inline
In-Reply-To: <1430766714-22368-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268382>

On Mon, May 04, 2015 at 12:11:54PM -0700, Stefan Beller wrote:

> prefix_path() always returns a newly allocated string since
> d089eba (setup: sanitize absolute and funny paths in get_pathspec(),
> 2008-01-28)
> 
> Additionally the const is dropped from the pointers, so the call to
> free doesn't need a cast.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Notes:
>     Thanks for all the suggestions!
>     They are incorporated into this version of the patch.
> 
>  builtin/checkout-index.c | 10 ++++------
>  builtin/update-index.c   |  5 ++---
>  2 files changed, 6 insertions(+), 9 deletions(-)

Should we also squash in these sites? I think they are adequately
covered under the proposed log message.

Found by grepping for prefix_path calls. The only remainders are:

  1. in blame, we assign the result to a const char that may also point
     straight into to argv, but we never actually free either way

  2. test-path-utils does not free at all, but we probably don't care
     either way

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a92eed2..0665b31 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -870,14 +870,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_DONE:
 		{
 			const char *path = ctx.argv[0];
-			const char *p;
+			char *p;
 
 			setup_work_tree();
 			p = prefix_path(prefix, prefix_length, path);
 			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			free((char *)p);
+			free(p);
 			ctx.argc--;
 			ctx.argv++;
 			break;
@@ -908,7 +908,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 		setup_work_tree();
 		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
-			const char *p;
+			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
 				if (unquote_c_style(&nbuf, buf.buf, NULL))
@@ -919,7 +919,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			free((char *)p);
+			free(p);
 		}
 		strbuf_release(&nbuf);
 		strbuf_release(&buf);
