From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t3404: preserve test_tick state across short SHA-1
 collision test
Date: Sat, 24 Aug 2013 22:55:50 -0700
Message-ID: <20130825055550.GN2882@elie.Belkin>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
 <1377112378-45511-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:56:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDTJ3-0005OJ-Um
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab3HYFz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:55:56 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61430 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996Ab3HYFzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:55:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so2211531pad.33
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RXPf7CbVvwCT3TVZ2YMh0SW9e6bdkyYb1490OAKS4Qc=;
        b=BRPRAOsLzIMsbl9j/qLAvxY4+FTqXH1Oze30Zwj5ei/w0+HZm8lOcXmZiZU3IGNLd9
         QsVFFZzaPJDGTlS6nN8qTisDw2J+zUyYHq74BDcoa4yuISIfcKalIAbX2RcAzugQrPjZ
         4w9VVUsxqCFZaXaFEirj4fF2EZ0E6TqXhucKZCUJXmaZAtLYY/CT6c54klqrdnMbFG9p
         fzcfS+urfGJY6n18xpHCnuZcnB0YvZZ5RiC9HY9DaJo4aZF814gmdZg0jm2wP8rsweFU
         bg+G5Tqi0EMkO176uVDElOp/b1dB/C9tqzvGRh1e0vzmiaQ6SfFqE/+UYOOYxeeKMsNM
         Cvtw==
X-Received: by 10.66.158.196 with SMTP id ww4mr7840838pab.57.1377410154874;
        Sat, 24 Aug 2013 22:55:54 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ai6sm11641537pad.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 22:55:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377112378-45511-2-git-send-email-sunshine@sunshineco.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232925>

Hi,

Eric Sunshine wrote:

> The short SHA-1 collision test requires carefully crafted commits in
> order to ensure a collision at rebase time.

Yeah, this breaks the usual rule that tests should be independent
of hashing function.  But it's the best we can do, I think.

[...]
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -994,17 +994,23 @@ test_expect_success 'short SHA-1 setup' '
>  	test_when_finished "git checkout master" &&
>  	git checkout --orphan collide &&
>  	git rm -rf . &&
> +	(
>  	unset test_tick &&
>  	test_commit collide1 collide &&
>  	test_commit --notick collide2 collide &&
>  	test_commit --notick "collide3 115158b5" collide collide3 collide3
> +	)

Would be clearer if the code in a subshell were indented:

	(
		unset test_tick &&
		test_commit ...
	)

[...]
>  test_expect_success 'short SHA-1 collide' '
>  	test_when_finished "reset_rebase && git checkout master" &&
>  	git checkout collide &&
> +	(
> +	unset test_tick &&
> +	test_tick &&
>  	FAKE_COMMIT_MESSAGE="collide2 815200e" \
>  	FAKE_LINES="reword 1 2" git rebase -i HEAD~2
> +	)

Likewise.

Hope that helps,
Jonathan
