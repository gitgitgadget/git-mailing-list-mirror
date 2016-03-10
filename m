From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] mergetool: honor tempfile configuration when resolving delete conflicts
Date: Thu, 10 Mar 2016 14:08:48 -0800
Message-ID: <xmqqpov2c7f3.fsf@gitster.mtv.corp.google.com>
References: <1457594039-22629-1-git-send-email-davvid@gmail.com>
	<1457594039-22629-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Joe Einertson <joe@kidblog.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:08:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae8lM-0001jm-50
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 23:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbcCJWIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 17:08:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932453AbcCJWIv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 17:08:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 643A34B38B;
	Thu, 10 Mar 2016 17:08:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gv8ZliKKpTJQN60BnCZnJXkehqE=; b=M1cIH4
	4bxYhHg3f2DMcidh6geOD5mIAPoka2Sl9KTMrxpieVux8Hs2OdjwCS1ECGOOfu5a
	QifTJiz9KWiknti2voPmoNXILLnh5aerXlTXpIwWzqwY7Pa5lhF+IeKCiLovoAHX
	jhHsAkYywU7jazSHWC6UmUo3hSmWu/OmOR9Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RmNlcGAI0hxIk7u7UssK/OzRd2pxfaLj
	Y+RlD6sjQuU8JicvbJafzOGo+GUBpT0QXRhWn50MY+ZnVVE06zXoD2pw6pqMLG2g
	XW5DmKjObro1FpEmvhfPt6t3MOVMZdU7y/vzJg0CedL54cJ6slMKmfb5fhstGfbJ
	Zilg/doiwKA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B2704B38A;
	Thu, 10 Mar 2016 17:08:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C73424B389;
	Thu, 10 Mar 2016 17:08:49 -0500 (EST)
In-Reply-To: <1457594039-22629-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 9 Mar 2016 23:13:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAF27F3A-E70C-11E5-9766-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288651>

David Aguilar <davvid@gmail.com> writes:

> Teach resolve_deleted_merge() to honor the mergetool.keepBackup and
> mergetool.keepTemporaries configuration knobs.
>
> This ensures that the worktree is kept pristine when resolving deletion
> conflicts with the variables both set to false.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Rebased to include tests and test fixes.

Thanks.  Will queue after applying a single fix-up again.

>
>  git-mergetool.sh     | 11 ++++++++++-
>  t/t7610-mergetool.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index b06ae78..f67bab5 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -126,7 +126,12 @@ resolve_deleted_merge () {
>  		case "$ans" in
>  		[mMcC]*)
>  			git add -- "$MERGED"
> -			cleanup_temp_files --save-backup
> +			if test "$merge_keep_backup" = "true"
> +			then
> +				cleanup_temp_files --save-backup
> +			else
> +				cleanup_temp_files
> +			fi
>  			return 0
>  			;;
>  		[dD]*)
> @@ -135,6 +140,10 @@ resolve_deleted_merge () {
>  			return 0
>  			;;
>  		[aA]*)
> +			if test "$merge_keep_temporaries" = "false"
> +			then
> +				cleanup_temp_files
> +			fi
>  			return 1
>  			;;
>  		esac
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 39469d9..db723e8 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -279,6 +279,31 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
>  	: >expect &&
>  	echo d | git mergetool a/a/file.txt 2>actual &&
>  	test_cmp expect actual &&
> +	! test -d a &&
> +	git reset --hard HEAD
> +'
> +
> +test_expect_success 'mergetool honors tempfile config for deleted files' '
> +	test_config mergetool.keepTemporaries false &&
> +	test_must_fail git merge move-to-b &&
> +	echo d | git mergetool a/a/file.txt &&
> +	! test -d a &&
> +	git reset --hard HEAD
> +'
> +
> +test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
> +	test_config mergetool.keepTemporaries true &&
> +	test_must_fail git merge move-to-b &&
> +	! (echo a; echo n) | git mergetool a/a/file.txt &&
> +	test -d a/a &&
> +	cat  >expect <<-\EOF &&
> +	file_BASE_.txt
> +	file_LOCAL_.txt
> +	file_REMOTE_.txt
> +	EOF
> +	ls -1 a/a | sed -e "s/[0-9]*//g" >actual &&
> +	test_cmp expect actual &&
> +	git clean -fdx &&
>  	git reset --hard HEAD
>  '
