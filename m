From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] cherry-pick: add failing test for out-of-order pick
Date: Thu, 12 Jan 2012 13:33:12 -0600
Message-ID: <20120112193312.GC6038@burratino>
References: <20120112183246.GB6038@burratino>
 <1326395132-18947-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlQOp-0001Al-Tv
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071Ab2ALTdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 14:33:20 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41156 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab2ALTdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 14:33:19 -0500
Received: by yhjj63 with SMTP id j63so1141900yhj.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EJqr8vmi+2am/5Ht9CVJV3XJvhsMWJdetEHuTyUGuos=;
        b=F33wKCV1xk5ltXyRGEkUEev6IMEhyxAN98kYzy5r45jjSgvuCEf/OPGRCe3WsoJR7h
         bYNl2QbnepHuRe1GhHcVhmoL+7hmqh/xt1/39BwsYmu5N5TN4kNexkSb2svYMnoGUYMJ
         ZeqSJNoYyFhKXaCWrvfepHqr3p+q5BIMACyo0=
Received: by 10.236.138.131 with SMTP id a3mr7840141yhj.101.1326396798686;
        Thu, 12 Jan 2012 11:33:18 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m10sm11398739ank.19.2012.01.12.11.33.17
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 11:33:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326395132-18947-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188476>

Ramkumar Ramachandra wrote:

>  Had some weird compulsion to conform to the style of the other tests
>  in the previous iteration.

The tests you're talking about were introduced in commit 7b53b92f to
check for a buglet that made --strategy suppress the progress
reporting ("Finished one cherry-pick.") output cherry-pick normally
would emit.  

So no inconsistency here --- those tests are _intending_ to check the
output format and that cherry-pick, unlike cherry-pick --ff, produces
new commits (though it would probably be clearer to put checks for
these behaviors in separate test assertions), while the new failing
test you are introducing is not about those things.

Striving for a consistent style is certainly not weird.

> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -59,6 +59,23 @@ test_expect_success 'cherry-pick first..fourth works' '
[...]
> +	git cherry-pick fourth second third &&
> +	{
> +		git rev-list --reverse HEAD |
> +		git diff-tree --stdin -s --format=%s
> +	} >actual &&
> +	cat >expect <<-\EOF &&
> +	fourth
> +	second
> +	third
> +	EOF
> +	test_cmp expect actual

This still feels more convoluted than expected (e.g., why --reverse?).
Something like

	printf "%s\n" third second fourth >expect &&
	...
	git log --format=%s >actual &&
	test_cmp expect actual

should be plenty.
