From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] [GSoC] Use strchrnul to save additional scan of string
Date: Fri, 14 Mar 2014 22:49:47 -0400
Message-ID: <20140315024946.GA7031@sigill.intra.peff.net>
References: <CACqsmRbYwEKrF2+NbpLLnx2zrovwFV+OQe64Zpzg5WGpRqGfJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Shubham Chaudhary <shubham.chaudhary@kdemail.net>
X-From: git-owner@vger.kernel.org Sat Mar 15 03:49:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOefa-0000T9-Ld
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 03:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbaCOCtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 22:49:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:39853 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754133AbaCOCts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 22:49:48 -0400
Received: (qmail 5524 invoked by uid 102); 15 Mar 2014 02:49:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 21:49:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 22:49:47 -0400
Content-Disposition: inline
In-Reply-To: <CACqsmRbYwEKrF2+NbpLLnx2zrovwFV+OQe64Zpzg5WGpRqGfJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244138>

On Sat, Mar 15, 2014 at 06:19:08AM +0530, Shubham Chaudhary wrote:

> From c422507408824403ed18e89ec0bbc32b8764e09c Mon Sep 17 00:00:00 2001

You can drop this line; it's just part of the mbox format.

> From: Shubham Chaudhary <shubham.chaudhary@kdemail.net>
> Date: Sat, 15 Mar 2014 05:56:18 +0530
> Subject: [PATCH] [GSoC] Use strchrnul to save additional scan of string

And these are redundant with your mail headers. You can drop all of them.

Your patch also appears to be whitespace-damaged (it looks like extra
wrawpping). Consider using git-send-email, which takes care of all of
these issues.

> diff --git a/archive.c b/archive.c
> index 346f3b2..d196215 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -259,8 +259,8 @@ static void parse_treeish_arg(const char **argv,
>  	/* Remotes are only allowed to fetch actual refs */
>  	if (remote) {
>  		char *ref = NULL;
> -		const char *colon = strchr(name, ':');
> -		int refnamelen = colon ? colon - name : strlen(name);
> +		const char *colon = strchrnul(name, ':');
> +		int refnamelen = colon - name;

This one is pretty straightforward, as we do not need ever look at
"colon" after this. But this one:

> diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> index 2c3cd8e..f901cf3 100644
> --- a/builtin/mailinfo.c
> +++ b/builtin/mailinfo.c
> @@ -902,12 +902,8 @@ static void output_header_lines(FILE *fout, const
> char *hdr, const struct strbuf
>  {
>  	const char *sp = data->buf;
>  	while (1) {
> -		char *ep = strchr(sp, '\n');
> -		int len;
> -		if (!ep)
> -			len = strlen(sp);
> -		else
> -			len = ep - sp;
> +		char *ep = strchrnul(sp, '\n');
> +		int len = ep - sp;
>  		fprintf(fout, "%s: %.*s\n", hdr, len, sp);
>  		if (!ep)
>  			break;

...does not look right. Before your patch, "ep" pointed to a newline, or
NULL if we did not find one. After the fprintf, we try to break out of
the loop if we did not find a newline by checking "!ep". But that will
never trigger after your patch, and we loop forever reading bogus data
past the end of the string.

I didn't check the other sites; this might be the only problematic one,
but each one needs to be examined by hand. Please double-check the
result by running "make test", which does find this bug.

-Peff
