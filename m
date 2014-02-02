From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 10/17] trailer: if no input file is passed, read from stdin
Date: Sun, 2 Feb 2014 04:50:36 -0500
Message-ID: <CAPig+cTVN+MqjhouCsE2gi4GWd14dLH6=5QrbEfTTgz5jLxtKA@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.57934.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Feb 02 10:50:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9thS-0007lB-1u
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 10:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaBBJuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 04:50:44 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:54104 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbaBBJug (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 04:50:36 -0500
Received: by mail-yk0-f171.google.com with SMTP id 142so32712486ykq.2
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=v8HlsvqvftoqRTflc9QqgpfyBntzT/0O3eOVCdplvD0=;
        b=AUtOfdVPhUdIz4rBrgdwCCRRyjWrBpEif6A4v6hBNFNq9nez7MSY1pvwWKxYKdKf48
         NC6AEKcNEdKhF48YVt2xhP/ZiEpJsdzVf7Ul3V+IizTC+TMB/MCyC5AIwefvj2eIa/Uo
         kTV9R4X7ZTxaNPAwoIAUrISEeohyD2Yi/LP/gBtWqv5GCW0DwyzlW5lY7X4P+KobXYCO
         k/LXrbt8JrTbIk8H+sdRaYbNDI+TRKhr4/bq8LjkzVpO+6dPOMSy7dQd5z5cdqiVCE7i
         moszrEHshKedbDEcPMYKGahavT2paa27BtFD/O+ZJIIQIQBr/Mfl2WdP7dhf+ivlhSRr
         fYJA==
X-Received: by 10.236.174.37 with SMTP id w25mr27822442yhl.36.1391334636205;
 Sun, 02 Feb 2014 01:50:36 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Sun, 2 Feb 2014 01:50:36 -0800 (PST)
In-Reply-To: <20140130064921.7504.57934.chriscool@tuxfamily.org>
X-Google-Sender-Auth: ztCZ4FHqlJxfgAONZRKYG5-vNkY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241354>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> It is simpler and more natural if the "git interpret-trailers"
> is made a filter as its output already goes to sdtout.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/trailer.c b/trailer.c
> index 8681aed..73a65e0 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -464,8 +464,13 @@ static struct strbuf **read_input_file(const char *infile)
>  {
>         struct strbuf sb = STRBUF_INIT;
>
> -       if (strbuf_read_file(&sb, infile, 0) < 0)
> -               die_errno(_("could not read input file '%s'"), infile);
> +       if (infile) {
> +               if (strbuf_read_file(&sb, infile, 0) < 0)
> +                       die_errno(_("could not read input file '%s'"), infile);
> +       } else {
> +               if (strbuf_read(&sb, fileno(stdin), 0) < 0)

strbuf_fread(), perhaps?

> +                       die_errno(_("could not read from stdin"));
> +       }
>
>         return strbuf_split(&sb, '\n');
>  }
> @@ -530,10 +535,8 @@ void process_trailers(const char *infile, int trim_empty, int argc, const char *
>
>         git_config(git_trailer_config, NULL);
>
> -       /* Print the non trailer part of infile */
> -       if (infile) {
> -               process_input_file(infile, &infile_tok_first, &infile_tok_last);
> -       }
> +       /* Print the non trailer part of infile (or stdin if infile is NULL) */
> +       process_input_file(infile, &infile_tok_first, &infile_tok_last);
>
>         arg_tok_first = process_command_line_args(argc, argv);
>
> --
> 1.8.5.2.201.gacc5987
