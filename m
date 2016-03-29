From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] submodule update --init: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 16:54:07 -0700
Message-ID: <xmqqoa9wvo0w.fsf@gitster.mtv.corp.google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
	<1459292558-5840-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jacob.keller@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 01:54:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al3Si-0003rp-8s
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784AbcC2XyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:54:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753174AbcC2XyK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:54:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3844516BC;
	Tue, 29 Mar 2016 19:54:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5JbcCC3myFwzfHyoMBsgxGXmRY=; b=sNl639
	6GHCr7+BR4myj1X12dn6CjkL7RLUR0hK22ZD5VtejH8yZXsw6AOjyff89SvJXriu
	JyGKOz2oECIRVQxEOfMgHGCJi2gjmk20NU0hCfZq/c1G1DJvOu/5984cOB+mkRUt
	Hs9Ce1X8OeO6ucuILDvCkO7JO8lK0+aoCL9pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nB2sxC3RHD8E5zIqjl8vtR2xfI2OpYwv
	7r0W7QgXXKxMWxtt9PJv+PqDzuIby83RQmgsdrtzY5QywSKeQMMKlE4AbweOcb4d
	r7mO0sPUEC1DzdZZ6wITiRxhEhAGh1Aq8RrKirr8u6WWQf6ZymfJYZ93RGudo2Kb
	7G+20aTT0+c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BCB1516BB;
	Tue, 29 Mar 2016 19:54:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20F2E516BA;
	Tue, 29 Mar 2016 19:54:09 -0400 (EDT)
In-Reply-To: <1459292558-5840-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 29 Mar 2016 16:02:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8766DC62-F609-11E5-A8CB-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290227>

Stefan Beller <sbeller@google.com> writes:

> The new test demonstrates a failure in the code prior to this patch.
> Instead of getting the expected
>     Submodule 'submodule' (${pwd}/submodule) registered for path '../super/submodule'
> the `super` directory is omitted and you get
>     Submodule 'submodule' (${pwd}/submodule) registered for path '../submodule'
> instead.

Same "is this about test?" comment applies here.

> That happens because the prefix is ignored in `git submodule add`, probably
> because that function itself cannot recurse;

"probably"???

> it may however called by

Probably "be" needs to be somewhere on this line.

> recursive instances of `git submodule update`, so we need to respect the
> `prefix`.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh            |  2 +-
>  t/t7406-submodule-update.sh | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2838069..fdb5fbd 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -474,7 +474,7 @@ cmd_init()
>  		die_if_unmatched "$mode"
>  		name=$(git submodule--helper name "$sm_path") || exit
>  
> -		displaypath=$(relative_path "$sm_path")
> +		displaypath=$(relative_path "$prefix$sm_path")
>  
>  		# Copy url setting when it is not set yet
>  		if test -z "$(git config "submodule.$name.url")"
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 68ea31d..9a4ba41 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -63,6 +63,10 @@ test_expect_success 'setup a submodule tree' '
>  	 git submodule add ../none none &&
>  	 test_tick &&
>  	 git commit -m "none"
> +	) &&
> +	git clone . recursivesuper &&
> +	( cd recursivesuper
> +	 git submodule add ../super super
>  	)
>  '
>  
> @@ -95,6 +99,35 @@ test_expect_success 'submodule update from subdirectory' '
>  	)
>  '
>  
> +supersha1=$(cd super && git rev-parse HEAD)

Perhaps "git -C super rev-parse HEAD"?

> +test_expect_success 'submodule update --init --recursive from subdirectory' '
> +	git -C recursivesuper/super reset --hard HEAD^ &&
> +	(cd recursivesuper &&
> +	 mkdir tmp &&
> +	 cd tmp &&
> +	 git submodule update --init --recursive ../super >../../actual
> +	) &&
> +	test_cmp expect actual
> +'
> +
>  apos="'";
>  test_expect_success 'submodule update does not fetch already present commits' '
>  	(cd submodule &&
