From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git: treat "-C <treat>" as a no-op when <path> is empty
Date: Fri, 06 Mar 2015 17:44:29 -0800
Message-ID: <xmqqfv9hvawy.fsf@gitster.dls.corp.google.com>
References: <1425640688-26513-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 02:44:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU3nB-0000yF-DJ
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 02:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbbCGBoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 20:44:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751145AbbCGBoc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 20:44:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AD1F3F7B2;
	Fri,  6 Mar 2015 20:44:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FZJMecU+gj26GdQwbuFXHwOc8rw=; b=KgCcLM
	Pptg9tdiNFIvWIxs1Q9eQMGgT41m99+X8UN7RXsS3cat5nE4McIUE9icebdDX90B
	2SrUwm8rnTZ8b7nc6OB/wWJmc3X4f+bg6yEnH1JxHys1qH6LqfL4BTMtUUPVg6C6
	dteue6Yai32EAth9BaBgOBHRwpyLqfKWRvEck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZgHgYqOzlvSzqoYsOfO+TOUrqMv16+hB
	g2v51UYJ/lo4cBDHZr+AayRPqWrYoMZQ1SLS7cxhBI0EUtsMKNJZ7uUfTEAeVagY
	gXmkgHtOCN0nwrVoPclh1nRN1ts4TCnhEXMntUV328R7buoMU1YCd0B+Z7MmPRf1
	9nzatbNQarE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 236C33F7B1;
	Fri,  6 Mar 2015 20:44:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B5473F7B0;
	Fri,  6 Mar 2015 20:44:30 -0500 (EST)
In-Reply-To: <1425640688-26513-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Fri, 6 Mar 2015 16:48:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7F6F8638-C46B-11E4-91B3-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264985>

Karthik Nayak <karthik.188@gmail.com> writes:

> 'git -C ""' unhelpfully dies with error "Cannot change to ''",
> whereas the shell treats `cd ""' as a no-op. Taking the shell's
> behavior as a precedent, teach git to treat `-C ""' as a no-op, as
> well.
>
> Test to check the no-op behaviour of "-C <path>" when <path> is
> empty, written by Junio C Hamano.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunchine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---

This iteration looks sensible, except that the Subject reads
strange.  Will queue with minor tweaks to the log message,
and perhaps with a fix to unreadable *(*argv)[1] that was
mentioned elsewhere.

Thanks.

>  git.c            | 10 ++++++----
>  t/t0056-git-C.sh | 10 ++++++++++
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/git.c b/git.c
> index 8c7ee9c..b062e0e 100644
> --- a/git.c
> +++ b/git.c
> @@ -204,10 +204,12 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				fprintf(stderr, "No directory given for -C.\n" );
>  				usage(git_usage_string);
>  			}
> -			if (chdir((*argv)[1]))
> -				die_errno("Cannot change to '%s'", (*argv)[1]);
> -			if (envchanged)
> -				*envchanged = 1;
> +			if (*(*argv)[1]) {
> +				if (chdir((*argv)[1]))
> +					die_errno("Cannot change to '%s'", (*argv)[1]);
> +				if (envchanged)
> +					*envchanged = 1;
> +			}
>  			(*argv)++;
>  			(*argc)--;
>  		} else {
> diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
> index 99c0377..2630e75 100755
> --- a/t/t0056-git-C.sh
> +++ b/t/t0056-git-C.sh
> @@ -14,6 +14,16 @@ test_expect_success '"git -C <path>" runs git from the directory <path>' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success '"git -C <path>" with an empty <path> is a no-op' '
> +	(
> +		mkdir -p dir1/subdir &&
> +		cd dir1/subdir &&
> +		git -C "" rev-parse --show-prefix >actual &&
> +		echo subdir/ >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
>  	test_create_repo dir1/dir2 &&
>  	echo 1 >dir1/dir2/b.txt &&
