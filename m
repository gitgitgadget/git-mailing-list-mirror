From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool--helper: exit when reading a prompt answer fails
Date: Sun, 26 Oct 2014 17:41:49 -0700
Message-ID: <20141027004148.GB81127@gmail.com>
References: <544CAC30.7000607@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 01:41:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiYNR-00023H-Mw
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 01:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbaJ0Alh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 20:41:37 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:41043 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbaJ0Alg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 20:41:36 -0400
Received: by mail-pd0-f175.google.com with SMTP id y13so4561311pdi.20
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 17:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iFub4YZhFjuRfk7uiVxQxx9SQ7HE2SpJDFL+mEHamik=;
        b=vWIT1QA6ObC+p2aGzkP8or/00LR2RCf5eh5ItiBcSqYucdTG3z/DlHpRN8Sdsc/Onv
         0ohX2Ojqabqeg70yCXpTMl5WKMg2LSYnwv6uXzMMDg+k0VjvhGZ1anpoiiO6g/+Nf4vE
         CNytzy2hEjxZhm3/dfyabrFi8YJNDrhHmOSM+dsspaVE9l6AjnPgps7a6714Jmromqwm
         oqPeiUD9EpWPk/Pst2/vBp85XJL9b3FW8dhE7T++HTeqr+mLRx3aO/yAhZc0BzwNfhYt
         epgT2ZcbiHNOhI1eh0HHXlCG9F5u6jKaKiKXjItzJsbxJnaBNoaosAaMYRyvCBbNBU25
         IHlg==
X-Received: by 10.68.107.226 with SMTP id hf2mr20338409pbb.99.1414370495956;
        Sun, 26 Oct 2014 17:41:35 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id km5sm9266355pdb.18.2014.10.26.17.41.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 26 Oct 2014 17:41:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544CAC30.7000607@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 09:09:20AM +0100, Johannes Sixt wrote:
> An attempt to quit difftool by hitting Ctrl-D (EOF) at its prompt does
> not quit it, but is treated as if 'yes' was answered to the prompt and
> all following prompts, which is contrary to the user's intent. Fix the
> error check.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Found while reviewing your latest patch.


Thanks for the careful review.
I have one small question about the test below.

I'll base the reroll of my patch on top of this one so that
I'm including your new test while developing.

Junio, can you please queue this patch before my upcoming v3
patch when I reroll?

I also noticed that I forgot to "git reset --hard" after doing "git add"
in one of the tests I introduced so I'll be adjusting that as well in v3.


>  I chose the 'foo || return' idiom for the error check, but left the
>  'if' for the interesting check, because I feel it is more readable
>  than 'test ... && return'.
> 
>  -- Hannes
> 
>  git-difftool--helper.sh | 3 ++-
>  t/t7800-difftool.sh     | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 7ef36b9..aca0413 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -49,7 +49,8 @@ launch_merge_tool () {
>  		else
>  			printf "Launch '%s' [Y/n]: " "$merge_tool"
>  		fi
> -		if read ans && test "$ans" = n
> +		read ans || return
> +		if test "$ans" = n
>  		then
>  			return
>  		fi
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index dc30a51..9cf5dc9 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -301,6 +301,14 @@ test_expect_success PERL 'say no to the second file' '
>  	! grep br2 output
>  '
>  
> +test_expect_success PERL 'ending prompt input with EOF' '
> +	git difftool -x cat branch </dev/null >output &&
> +	! grep master output &&
> +	! grep branch output &&
> +	! grep m2 output &&
> +	! grep br2 output
> +'

Should we use "test_must_fail grep ..." instead of "! grep ..." here?
-- 
David
