From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 05/21] check-attr: there are only two possible line
 terminations
Date: Fri, 15 Jan 2016 14:16:11 -0500
Message-ID: <20160115191611.GB11301@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:16:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK9rD-0007iV-MA
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 20:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbcAOTQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 14:16:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:54581 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755486AbcAOTQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 14:16:14 -0500
Received: (qmail 7568 invoked by uid 102); 15 Jan 2016 19:16:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 14:16:13 -0500
Received: (qmail 22878 invoked by uid 107); 15 Jan 2016 19:16:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 14:16:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 14:16:11 -0500
Content-Disposition: inline
In-Reply-To: <1452815916-6447-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284202>

On Thu, Jan 14, 2016 at 03:58:20PM -0800, Junio C Hamano wrote:

> The program by default reads LF terminated lines, with an option to
> use NUL terminated records.  Instead of pretending that there can be
> other useful values for line_termination, use a boolean variable,
> nul_term_line, to tell if NUL terminated records are used, and
> switch between strbuf_getline_{lf,nul} based on it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/check-attr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index 265c9ba..087325e 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -73,12 +73,13 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
>  	struct git_attr_check *check)
>  {
>  	struct strbuf buf, nbuf;
> -	int line_termination = nul_term_line ? 0 : '\n';
> +	strbuf_getline_fn getline_fn;
>  
> +	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
>  	strbuf_init(&buf, 0);
>  	strbuf_init(&nbuf, 0);

Not really relevant to your series, but I find it slightly confusing
when `strbuf_init` is used instead of a static initializer (it makes me
wonder _why_, and whether there are any code paths that miss
initialization).

Maybe worth doing:

  struct strbuf buf = STRBUF_INIT;
  struct strbuf nbuf = STRBUF_INIT;

at the top while we are in the area (and also maybe giving the latter a
more meaningful name!).  But I don't want to derail the main point of
your series.

-Peff
