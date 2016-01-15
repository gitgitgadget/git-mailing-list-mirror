From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 17/21] cat-file: read batch stream with
 strbuf_getline()
Date: Fri, 15 Jan 2016 15:41:19 -0500
Message-ID: <20160115204118.GG11301@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-18-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:41:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKBBW-00008L-O4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbcAOUlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:41:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:54660 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753295AbcAOUlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:41:22 -0500
Received: (qmail 11194 invoked by uid 102); 15 Jan 2016 20:41:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:41:21 -0500
Received: (qmail 23723 invoked by uid 107); 15 Jan 2016 20:41:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:41:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 15:41:19 -0500
Content-Disposition: inline
In-Reply-To: <1452815916-6447-18-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284214>

On Thu, Jan 14, 2016 at 03:58:32PM -0800, Junio C Hamano wrote:

> It is possible to prepare a text file with a DOS editor and feed it
> as a batch command stream to the command.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/cat-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index d2ebaf1..54db118 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -401,7 +401,7 @@ static int batch_objects(struct batch_options *opt)
>  	save_warning = warn_on_object_refname_ambiguity;
>  	warn_on_object_refname_ambiguity = 0;
>  
> -	while (strbuf_getline_lf(&buf, stdin) != EOF) {
> +	while (strbuf_getline(&buf, stdin) != EOF) {

This function can actually take a pretty wide variety of input. It can
take anything that get_sha1() will handle. So I think that:

  printf ':/foo\r\n' | git cat-file --batch

will behave differently (before, we looked for the literal "foo\r" in a
commit message). That's sufficiently crazy that I'm OK with giving it
up.

A more interesting case is "rev-list" output, combined with "%(rest)".
The former does not quote its filenames.

So in a repo like this:

  echo bar >$(printf 'foo\r')
  git add .
  git commit -m one

you can currently do:

  git rev-list --objects --all |
  git cat-file --batch-check='%(objectsize) %(rest)' |
  cat -A

and get:

  154 $
  32 $
  4 foo^M$

but with your patch, we lose the CR, and get a filename that is not
actually contained in the repo.

I think I'm still in favor of the change, though, for the same reason as
some of the earlier ones. We already can't handle "foo\n", so this
cannot be considered a completely robust interface. And we are much more
likely to do good than harm by stripping such a CR.

-Peff
