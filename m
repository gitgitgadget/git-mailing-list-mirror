From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] submodule status: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 16:55:48 -0700
Message-ID: <xmqqk2kkvny3.fsf@gitster.mtv.corp.google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
	<1459292558-5840-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jacob.keller@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 01:55:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al3UK-0004Se-45
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471AbcC2Xzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:55:52 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754461AbcC2Xzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:55:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 867195172A;
	Tue, 29 Mar 2016 19:55:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=89K4Ml6pc8q+1rVJJPOXVruu3Js=; b=c0W7Pa
	yLlaqtKfpIuPTOFU3w3p4aNiZuOVur1PibwD7m+E2F3vSC5JL+mNTT6pWY2ae/h2
	/eK6di/U5KdI2Q23eR5MoLeV07mqxLrRGjwOVmeWlW/16NxQb2pO4cxMr5ALqhzf
	f/9ygYgS1F0WGcHlBg2U83aOJgYwaYIapGG4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=buQYZQR3nDOjqTsUpWymCYZ2AsXR281A
	dxPcOgHgep8Zdlc4+Np/o4otC3hgPC3HXV3WW/mTGEJRxKO09jZN2Jm8zpFjGRE2
	DhsTutIeuh1ODcEGIukGVpM7EjFTmuZnocciC+huueg831+Zgsperh5X6uzXNw+0
	T0gwwanRaC8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70C7C51728;
	Tue, 29 Mar 2016 19:55:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE3AC51725;
	Tue, 29 Mar 2016 19:55:49 -0400 (EDT)
In-Reply-To: <1459292558-5840-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 29 Mar 2016 16:02:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C377DC74-F609-11E5-A8D4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290228>

Stefan Beller <sbeller@google.com> writes:

> The new test which is a replica of the previous test except
> that it executes from a sub directory. Prior to this patch
> the test failed by having too many '../' prefixed:
>
>   --- expect	2016-03-29 19:02:33.087336115 +0000
>   +++ actual	2016-03-29 19:02:33.359343311 +0000
>   @@ -1,7 +1,7 @@
>     b23f134787d96fae589a6b76da41f4db112fc8db ../nested1 (heads/master)
>   -+25d56d1ddfb35c3e91ff7d8f12331c2e53147dcc ../nested1/nested2 (file2)
>   - 5ec83512b76a0b8170b899f8e643913c3e9b72d9 ../nested1/nested2/nested3 (heads/master)
>   - 509f622a4f36a3e472affcf28fa959174f3dd5b5 ../nested1/nested2/nested3/submodule (heads/master)
>   ++25d56d1ddfb35c3e91ff7d8f12331c2e53147dcc ../../nested1/nested2 (file2)
>   + 5ec83512b76a0b8170b899f8e643913c3e9b72d9 ../../../nested1/nested2/nested3 (heads/master)
>   + 509f622a4f36a3e472affcf28fa959174f3dd5b5 ../../../../nested1/nested2/nested3/submodule (heads/master)
>     0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f ../sub1 (0c90624)
>     0c90624ab7f1aaa301d3bb79f60dcfed1ec4897f ../sub2 (0c90624)
>     509f622a4f36a3e472affcf28fa959174f3dd5b5 ../sub3 (heads/master)
>
> The path code in question:
>   displaypath=$(relative_path "$prefix$sm_path")
>   prefix=$displaypath
>   if recursive:
>     eval cmd_status
>
> That way we change `prefix` each iteration to contain another
> '../', because of the the relative_path computation is done
> on an already computed relative path.
>
> We must call relative_path exactly once with `wt_prefix` non empty.
> Further calls in recursive instances to to calculate the displaypath
> already incorporate the correct prefix from before. Fix the issue by
> clearing `wt_prefix` in recursive calls.

OK, nicely analyzed and explained.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh             |  1 +
>  t/t7407-submodule-foreach.sh | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index fdb5fbd..11ed32a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1160,6 +1160,7 @@ cmd_status()
>  			(
>  				prefix="$displaypath/"
>  				clear_local_git_env
> +				wt_prefix=
>  				cd "$sm_path" &&
>  				eval cmd_status
>  			) ||

Makes sense.

Thanks.


> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 776b349..4b35e12 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -277,6 +277,27 @@ test_expect_success 'ensure "status --cached --recursive" preserves the --cached
>  	test_cmp expect actual
>  '
>  
> +nested2sha1=$(git -C clone3/nested1/nested2 rev-parse HEAD)
> +
> +cat > expect <<EOF
> + $nested1sha1 ../nested1 (heads/master)
> ++$nested2sha1 ../nested1/nested2 (file2)
> + $nested3sha1 ../nested1/nested2/nested3 (heads/master)
> + $submodulesha1 ../nested1/nested2/nested3/submodule (heads/master)
> + $sub1sha1 ../sub1 ($sub1sha1_short)
> + $sub2sha1 ../sub2 ($sub2sha1_short)
> + $sub3sha1 ../sub3 (heads/master)
> +EOF
> +
> +test_expect_success 'test "status --recursive" from sub directory' '
> +	(
> +		cd clone3 &&
> +		mkdir tmp && cd tmp &&
> +		git submodule status --recursive > ../../actual
> +	) &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'use "git clone --recursive" to checkout all submodules' '
>  	git clone --recursive super clone4 &&
>  	(
