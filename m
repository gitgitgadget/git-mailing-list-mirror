From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mv: allow moving nested submodules
Date: Mon, 18 Apr 2016 13:54:09 -0700
Message-ID: <xmqqk2ju4ozy.fsf@gitster.mtv.corp.google.com>
References: <1460998489-2155-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gmane@otterhall.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 22:54:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asGBX-0000OD-T2
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 22:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbcDRUyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 16:54:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751120AbcDRUyO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 16:54:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 803251512A;
	Mon, 18 Apr 2016 16:54:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OpxGwmRKTVk5Q4LiDBs4Wo1ul3g=; b=ovt9xg
	NTfq3suyoA+rhfxHmWJT+N81GOoto9V9PxNJNUepQnFeLDEQ08dLALdDQS/PVyAZ
	w7N+n+5GjWwHrWD5imfbSknWfG1KJmWS1q9+AOeKX1FhSb94tSh/mnt2RNmCm729
	bJRs9Lr3tKGv+MVJ/qfV4DXGnY3lCqd78l1ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=krAnAJCgMyh8zFvlLHOUoU4WnOKKgH4H
	rtarmYwop1MbE3LJayEwTxnHyL9qoB+M72Fz9tAzjkJiMGYXvZbcKfuarWAV9qCP
	12+hnSKwybJN6FAxUB2kSDXsoqQmtE9yj6xUm4Wxv040Q/KHekcX1/omnLkQm9II
	V+iytjfWAGs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76B3C15129;
	Mon, 18 Apr 2016 16:54:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBF2B15128;
	Mon, 18 Apr 2016 16:54:11 -0400 (EDT)
In-Reply-To: <1460998489-2155-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 18 Apr 2016 09:54:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B40292C2-05A7-11E6-8CA4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291825>

Stefan Beller <sbeller@google.com> writes:

>  		if (show_only || verbose)
>  			printf(_("Renaming %s to %s\n"), src, dst);
> -		if (!show_only && mode != INDEX) {
> -			if (rename(src, dst) < 0 && !ignore_errors)
> +		if (!show_only) {
> +			if (mode != INDEX &&
> +			    rename(src, dst) < 0 &&
> +			    !ignore_errors)
>  				die_errno(_("renaming '%s' failed"), src);
> +

If ignore-errors is set and rename fails, this would fall through
and try to touch this codepath...

>  			if (submodule_gitfile[i]) {
>  				if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
>  					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);

... but I am not sure if this thing is prepared to cope with such a
case?  src should have been moved to dst but if rename() failed we
wouldn't see what we expect at dst, or would we?

> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 4008fae..4a2570e 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -292,6 +292,9 @@ test_expect_success 'setup submodule' '
>  	echo content >file &&
>  	git add file &&
>  	git commit -m "added sub and file" &&
> +	mkdir -p deep/directory/hierachy &&
> +	git submodule add ./. deep/directory/hierachy/sub &&
> +	git commit -m "added another submodule" &&
>  	git branch submodule
>  '
>  
> @@ -475,4 +478,17 @@ test_expect_success 'mv -k does not accidentally destroy submodules' '
>  	git checkout .
>  '
>  
> +test_expect_success 'moving a submodule in nested directories' '
> +	(
> +		cd deep &&
> +		git mv directory ../ &&
> +		# git status would fail if the update of linking git dir to
> +		# work dir of the submodule failed.
> +		git status &&
> +		git config -f ../.gitmodules submodule.deep/directory/hierachy/sub.path >../actual &&
> +		echo "directory/hierachy/sub" >../expect
> +	) &&
> +	test_cmp actual expect
> +'
> +
>  test_done
