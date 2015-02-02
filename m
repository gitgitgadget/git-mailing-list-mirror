From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodules.sh: fix '/././' path normalization
Date: Mon, 02 Feb 2015 21:02:12 +0100
Message-ID: <54CFD7C4.4030000@web.de>
References: <1422630843-9559-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 21:02:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINCg-0004Hm-DD
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbbBBUCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:02:34 -0500
Received: from mout.web.de ([212.227.17.12]:49459 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbbBBUCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:02:33 -0500
Received: from [192.168.178.41] ([79.193.69.156]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Md4pC-1Y09Yd2P3q-00IGHm; Mon, 02 Feb 2015 21:02:13
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1422630843-9559-1-git-send-email-ps@pks.im>
X-Provags-ID: V03:K0:iiGhArEAW9bVh0tAqlGMxzIj6FRSU9mTY6vpK4Cyj0o89TdC/fv
 fHvz4W2zaGO+da+LN/A5Z58iMzggdbCyYnUavo2kFwg9vszQ8Su38CtAJRu3xro5GRVr7ue
 HkwuTlW8VQqlCJFzXIkrcDeArXOcYc0U73U5vBAIjdWAGOVGw5eCFbazajxtMXL3QJKqRYQ
 mH9qYMiusuD99SDXZLb/g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263281>

Am 30.01.2015 um 16:14 schrieb Patrick Steinhardt:
> When we add a new submodule the path of the submodule is being normalized. We
> fail to normalize multiple adjacent '/./', though. Thus 'path/to/././submodule'
> will become 'path/to/./submodule' where it should be 'path/to/submodule'
> instead.

Thanks, nicely done and fixes the issue you noticed: Ack from me.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   git-submodule.sh           |  2 +-
>   t/t7400-submodule-basic.sh | 17 +++++++++++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9245abf..36797c3 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -423,7 +423,7 @@ cmd_add()
>   		sed -e '
>   			s|//*|/|g
>   			s|^\(\./\)*||
> -			s|/\./|/|g
> +			s|/\(\./\)*|/|g
>   			:start
>   			s|\([^/]*\)/\.\./||
>   			tstart
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 7c88245..5811a98 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -171,6 +171,23 @@ test_expect_success 'submodule add with ./ in path' '
>   	test_cmp empty untracked
>   '
>
> +test_expect_success 'submodule add with /././ in path' '
> +	echo "refs/heads/master" >expect &&
> +	>empty &&
> +
> +	(
> +		cd addtest &&
> +		git submodule add "$submodurl" dotslashdotsubmod/././frotz/./ &&
> +		git submodule init
> +	) &&
> +
> +	rm -f heads head untracked &&
> +	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
> +	test_cmp expect heads &&
> +	test_cmp expect head &&
> +	test_cmp empty untracked
> +'
> +
>   test_expect_success 'submodule add with // in path' '
>   	echo "refs/heads/master" >expect &&
>   	>empty &&
>
