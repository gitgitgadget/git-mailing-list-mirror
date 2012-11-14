From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] var: accept multiple variables on the command line
Date: Wed, 14 Nov 2012 09:01:48 -0800
Message-ID: <20121114170148.GB6858@elie.Belkin>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165247.GC12626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYgLn-0000lK-46
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 18:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab2KNRBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 12:01:53 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53344 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab2KNRBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 12:01:52 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so496075pbc.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 09:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EjHlfQnI9+F3LnP3XZyL0dSQk/u899x4ygTkHrbvJpk=;
        b=Vzp90W7F0m0vBk5j0iyeVh9+bJjgcLhAnyrAGXVk319IjRvepb+NguJvpmfNuLwNZM
         zpMar/dbtaDTN2mbU7xpWMrYSw7O4kmJ3Ex9TWAiXHv8VR9QY5NlN+xhbe/NH3jTIwnr
         KQEONg82pnh1bGkjejS4931KTegvN6z41dHQxVaSyhLyuM09oj2tRYfb7oyxyEOMi5hN
         8SsTqOuIRi6iS+Vx8nOZg/xwd7lgYA3wuD1H0A4AxPyfEFncAVgSaRScU5wZf+IkNNvu
         e4FFNzgvR3hafX+uL0ccpB/Gkrx+v90OsEJh6TYlm0XRfGDJt1vVCAQsRIxKQ5jfOdxH
         xF9w==
Received: by 10.68.200.38 with SMTP id jp6mr59784474pbc.131.1352912511814;
        Wed, 14 Nov 2012 09:01:51 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id n11sm7987677pby.67.2012.11.14.09.01.50
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 09:01:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121113165247.GC12626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209726>

Jeff King wrote:

> This patch lets callers specify multiple variables, and
> prints one per line.

Yay!

[...]
> --- a/Documentation/git-var.txt
> +++ b/Documentation/git-var.txt
> @@ -9,11 +9,16 @@ git-var - Show a git logical variable
>  SYNOPSIS
>  --------
>  [verse]
> -'git var' ( -l | <variable> )
> +'git var' ( -l | <variable>... )
>  
>  DESCRIPTION
>  -----------
> -Prints a git logical variable.
> +Prints one or more git logical variables, separated by newlines.
> +
> +Note that some variables may contain newlines themselves

Maybe a -z option to NUL-terminate values would be useful some day.

> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -73,8 +73,7 @@ static int show_config(const char *var, const char *value, void *cb)
>  
>  int cmd_var(int argc, const char **argv, const char *prefix)
>  {
> -	const char *val = NULL;
> -	if (argc != 2)
> +	if (argc < 2)
>  		usage(var_usage);
>  
>  	if (strcmp(argv[1], "-l") == 0) {

What should happen if I pass "-l" followed by other arguments?

[...]
> --- /dev/null
> +++ b/t/t0007-git-var.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +
> +test_description='basic sanity checks for git var'
> +. ./test-lib.sh
> +
> +test_expect_success 'get GIT_AUTHOR_IDENT' '
> +	test_tick &&
> +	echo "A U Thor <author@example.com> 1112911993 -0700" >expect &&

Do we need to hardcode the timestamp?  Something like

	test_cmp_filtered () {
		expect=$1 actual=$2 &&
		sed -e 's/[0-9][0-9]* [-+][0-9][0-9][0-9][0-9]/TIMESTAMP" \
			<"$actual" >"$actual.filtered" &&
		test_cmp "$expect" "$actual.filtered"
	}
	...

		echo "A U Thor <author@example.com> $timestamp" >expect &&
		git var GIT_AUTHOR_IDENT >actual &&
		test_cmp_filtered expect actual

should make reordering tests a lot easier, though it has the downside
of not being able to catch a weird bug that would make the timestamp
out of sync with reality.

Hope that helps,
Jonathan
