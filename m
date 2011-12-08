From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] t1006 (cat-file): use test_cmp
Date: Thu, 8 Dec 2011 10:55:12 -0600
Message-ID: <20111208165512.GC2394@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 17:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYhFj-0000Bv-V5
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 17:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab1LHQzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 11:55:19 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38347 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab1LHQzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 11:55:18 -0500
Received: by yenm11 with SMTP id m11so1267216yen.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 08:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EYfcpbGOIsOQrOilML/Z4KAvRa7AxDK3h54c8dyc6W4=;
        b=Fee50i47dax4tLElC55TAGpan9nBW4BcAcTV8aTyQYhAp9uKtpv8p4KOoHoJ4xoi3N
         RDQ8xOxIWvQOs9ei/p+3HCSdL3dGgB2G2R4cg/ybMhLfhWaLc9Phvok7YRgpQi9/GXGC
         iNVCeHm7/EHhkCXCxzicQX9y0rKB2H/Kt8idc=
Received: by 10.236.201.196 with SMTP id b44mr5887392yho.48.1323363317988;
        Thu, 08 Dec 2011 08:55:17 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f17sm15869972ang.20.2011.12.08.08.55.14
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 08:55:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323349817-15737-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186573>

Ramkumar Ramachandra wrote:

> Use test_cmp in preference to repeatedly comparing command outputs by
> hand.

That could mean one of several things.

It could mean:

	1. Use test_cmp instead of open-coding it.
	2. Use test_cmp instead of using our knowledge of the underlying
	   filesystem to retrieve the files from the block device, instead
	   of relying on the perfectly good operating system facilities
	   that could take care of it for us
	3. Use test_cmp instead of calling a human over to compare command
	   outputs by eye, which idiomatically might be described as "by
	   hand".

What I mean is, I actually don't have much of a clue what you mean by
"by hand".  Usually it means "not automated sufficiently", but I think
that is not the entire problem here (since

	test "$expect" = "$actual"

looks no less automatic than

	printf '%s\n' "$expect" >expect &&
	printf '%s\n' "$actual" >actual &&
	test_cmp expect actual

to me).

> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
[...]
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -36,66 +36,41 @@ $content"
[...]
> -	expect="$(maybe_remove_timestamp "$content" $no_ts)"
> -	actual="$(maybe_remove_timestamp "$(git cat-file $type $sha1)" $no_ts)"
> -
> -        if test "z$expect" = "z$actual"
> -	then
> -		: happy
> -	else
> -		echo "Oops: expected $expect"
> -		echo "but got $actual"
> -		false
> -        fi
> +	maybe_remove_timestamp "$content" $no_ts >expect &&
> +	maybe_remove_timestamp "$(git cat-file $type $sha1)" $no_ts >actual &&
> +	test_cmp expect actual

Most of the early part of patch proper looks sane from a quick glance.
Wow, the whitespace is a little strange in the original.

[...]
> @@ -175,30 +153,41 @@ do
>  done
>  
>  test_expect_success "--batch-check for a non-existent named object" '
> -    test "foobar42 missing
> -foobar84 missing" = \
> -    "$( ( echo foobar42; echo_without_newline foobar84; ) | git cat-file --batch-check)"
> +    cat >expect <<\-EOF &&
> +foobar42 missing
> +foobar84 missing
> +EOF
> +    $(echo foobar42; echo_without_newline foobar84) \
> +    | git cat-file --batch-check >actual &&
> +    test_cmp expect actual

Style: the | character goes at the end of the first line (think of it
as a way to save backslashes until they're needed).

How could this $(...) command substitution possibly work?

Later tests have the same problem, so I'm stopping here.

Ciao,
Jonathan
