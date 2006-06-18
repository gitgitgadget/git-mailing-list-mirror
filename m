From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Sun, 18 Jun 2006 11:07:49 +0300
Message-ID: <20060618110749.e6fb9030.tihirvon@gmail.com>
References: <1150609831500-git-send-email-octo@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 10:07:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrsK6-0004d2-OB
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWFRIHz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 04:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWFRIHz
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:07:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:47503 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932138AbWFRIHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 04:07:54 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1110437nfa
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 01:07:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Hd1NGeiWwg9n6BgxLuQES2y+lOYOFgHd/botnfB/F5yGw8oCYb6OIltGVXgyRSB6of3Dz8gdtJXrVS0s50VPgnnXircP1sfd7SVqn3CUasLQ8XLKXdgGq+2p48bZFA+i5Kk1DuyqHJPbYtNkkn47usARHrOL/mcv1uuL6d6BKvg=
Received: by 10.48.242.19 with SMTP id p19mr4297892nfh;
        Sun, 18 Jun 2006 01:07:53 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id x24sm5482176nfb.2006.06.18.01.07.51;
        Sun, 18 Jun 2006 01:07:51 -0700 (PDT)
To: octo@verplant.org
In-Reply-To: <1150609831500-git-send-email-octo@verplant.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22055>

Florian Forster <octo@verplant.org> wrote:

> Using this patch I was able to build git with
> $ make CFLAGS="-Wall -Werror -ansi -pedantic -std=c99 -D_XOPEN_SOURCE=500 -D_BSD_SOURCE"
> 
> While most of this patch fixes void-pointer arithmetic and is therefore
> trivial, I had to change the use of a struct with FAMs in `diff-lib.c'. Since
> this is the first time I encountered FAMs it'd probably be a good idea if
> someone who knows would take a look at that.

Many of the void-pointer arithmetic warnings could be fixed by changing
the variable types to char * instead of casting them in many places.

> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -34,21 +34,23 @@ int run_diff_files(struct rev_info *revs
>  			continue;
>  
>  		if (ce_stage(ce)) {
> -			struct {
> -				struct combine_diff_path p;
> -				struct combine_diff_parent filler[5];
> -			} combine;

Yes this is somewhat ugly but avoids a malloc.  You could use alloca but
the man-page says:

    "The alloca() function is machine and compiler dependent. On many systems
     its implementation is buggy. Its use is discouraged."

Leave the code as it is now unless it causes real problems.

>  static inline int needs_quote(int ch)
>  {
> -	switch (ch) {
> -	case '/': case '-': case '.':
> -	case 'A'...'Z':	case 'a'...'z':	case '0'...'9':
> +	if (((ch >= 'A') && (ch <= 'Z'))
> +			|| ((ch >= 'a') && (ch <= 'z'))
> +			|| ((ch >= '0') && (ch <= '9'))
> +			|| (ch == '/')
> +			|| (ch == '-')
> +			|| (ch == '.'))

'A'...'Z' is more readable.  Does some compiler fail to compile it?

> +++ b/http-push.c

>  static inline int needs_quote(int ch)

Hmm.. same function in http-fetch.c.  Lots of common code could be moved
to http.h.

-- 
http://onion.dynserv.net/~timo/
