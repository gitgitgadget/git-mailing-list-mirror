From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] Don't rely on strerror text when testing rmdir failure
Date: Sat, 29 Mar 2014 16:48:44 +0100
Message-ID: <5336EB5C.6040103@web.de>
References: <1396107541-22974-1-git-send-email-cbailey32@bloomberg.net> <1396107541-22974-3-git-send-email-cbailey32@bloomberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 16:49:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTvVG-00088r-Ri
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 16:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbaC2Pst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 11:48:49 -0400
Received: from mout.web.de ([212.227.17.11]:52789 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbaC2Pss (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 11:48:48 -0400
Received: from [192.168.178.41] ([84.132.177.211]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lqleo-1Wy3Jf0AE6-00eIJM; Sat, 29 Mar 2014 16:48:45
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1396107541-22974-3-git-send-email-cbailey32@bloomberg.net>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:D0PuNAhKIomTaxRSu5DqKRUmLbjPhSF6fTFkh3+mL+Dpxl1HF+S
 G1/0kmQxvQG89igs/yTRrRlU7JZMX65YxBZ9Nj7NvA1iCHd0Qj/WDgwAt7h8h+jn8K7dvSX
 2AgwY7jxIQdN6m5DlWIMXb7Z+QYsPCaqKtQqiqKi7aahoRQAnZkO7XRu1qW4Jzvr3BwLtgI
 bMnqfqwNqKXV40V8MITxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245437>

Am 29.03.2014 16:39, schrieb Charles Bailey:
> AIX doesn't make a distiction between EEXIST and ENOTEMPTY so relying on
> the strerror string for the rmdir failure is fragile. Just test that the
> start of the string matches the Git controlled "failed to rmdir..."
> error. The exact text of the OS generated error string isn't important
> to the test.

Makes sense.

> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
> ---
>  t/t3600-rm.sh | 5 ++---
>  t/t7001-mv.sh | 3 +--
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 3d30581..23eed17 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -709,10 +709,9 @@ test_expect_success 'checking out a commit after submodule removal needs manual
>  	git commit -m "submodule removal" submod &&
>  	git checkout HEAD^ &&
>  	git submodule update &&
> -	git checkout -q HEAD^ 2>actual &&
> +	git checkout -q HEAD^ 2>/dev/null &&

Isn't this unrelated to the strerror issue you are fixing here?
Why not just drop the redirection completely? But maybe I'm just
being to pedantic here ;-)

>  	git checkout -q master 2>actual &&
> -	echo "warning: unable to rmdir submod: Directory not empty" >expected &&
> -	test_i18ncmp expected actual &&
> +	test_i18ngrep "^warning: unable to rmdir submod:" actual &&
>  	git status -s submod >actual &&
>  	echo "?? submod/" >expected &&
>  	test_cmp expected actual &&
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 215d43d..34fb1af 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -447,8 +447,7 @@ test_expect_success 'checking out a commit before submodule moved needs manual u
>  	git mv sub sub2 &&
>  	git commit -m "moved sub to sub2" &&
>  	git checkout -q HEAD^ 2>actual &&
> -	echo "warning: unable to rmdir sub2: Directory not empty" >expected &&
> -	test_i18ncmp expected actual &&
> +	test_i18ngrep "^warning: unable to rmdir sub2:" actual &&
>  	git status -s sub2 >actual &&
>  	echo "?? sub2/" >expected &&
>  	test_cmp expected actual &&
> 
