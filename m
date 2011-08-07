From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] bisect: add tests for bisection on bare repositories
Date: Sun, 7 Aug 2011 08:39:39 -0500
Message-ID: <20110807133939.GA10748@elie.gateway.2wire.net>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
 <1312714240-23647-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 15:39:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq3a7-0003yq-Hq
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 15:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab1HGNju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 09:39:50 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:51438 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab1HGNju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 09:39:50 -0400
Received: by iye16 with SMTP id 16so7132404iye.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lEY4cOX4mJuc8fFdr/MmOrnDLxxTKK5IR19f9qc5pDg=;
        b=mKenxCCks53EDSbafmpOwzwuhk66CrIddFfhyB3pnSXa8QAUdt/HdQAlynL/81OBsl
         NNiQSx/dDwB+uUhxeGe5hH6dvAsjUDHIxf3Jd4BeCJ40w1cq35RGz7P2vkdqLkxc3h8U
         zmxeqNdXZNWgqqJoQAeKIoM88WsrgB7fM7C/k=
Received: by 10.42.29.7 with SMTP id p7mr4871464icc.270.1312724389738;
        Sun, 07 Aug 2011 06:39:49 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.ameritech.net [69.209.49.224])
        by mx.google.com with ESMTPS id h6sm7182250icy.1.2011.08.07.06.39.47
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 06:39:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312714240-23647-3-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178916>

Jon Seymour wrote:

> We add a test to check that bisection works on bare repositories
> both when --no-checkout is specified explicitly and when it
> is defaulted.

Yay!

> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -592,6 +592,34 @@ test_expect_success 'erroring out when using bad path parameters' '
>  	grep "bad path parameters" error.txt
>  '
>  
> +test_expect_success 'create bare repo' '
> +	git clone --bare . bare
> +'

I'd prefer to see separate clones for the two tests, so if one
catastrophically fails it does not affect the other.

> +
> +test_expect_success 'test bisection on bare repo - --no-checkout specified' '
> +	test_when_finished "cd .." &&
> +	cd bare &&
> +	git bisect start --no-checkout &&
> +	git bisect good $HASH1 &&
> +	git bisect bad $HASH4 &&
> +	git bisect run sh -c \
> +		"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
> +		>../my_bisect_log.txt &&
> +	grep "$HASH3 is the first bad commit" ../my_bisect_log.txt &&
> +	git bisect reset'

I worry that "sh" might not actually be a POSIX shell on some systems.
Maybe a subshell could also simplify this.  Like so:

	git clone --bare . bare.nocheckout &&
	(
		cd bare &&
		git bisect start --no-checkout &&
		git bisect good $HASH1 &&
		git bisect bad $HASH4 &&
		git bisect run \
			eval "test \$(... " \
			>../log.nocheckout &&
		git bisect reset
	) &&
	grep "$HASH3 is the first bad commit" log.nocheckout

> +test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '

Perhaps these could share code by using a function defined at the top
of the file.

With or without the changes described above, I like it.  Thanks.
