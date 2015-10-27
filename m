From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] ref-filter: fallback on alphabetical comparison
Date: Tue, 27 Oct 2015 12:50:38 -0700
Message-ID: <xmqq7fm8ozu9.fsf@gitster.mtv.corp.google.com>
References: <1445972456-5621-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:50:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrAGd-0000jG-T5
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 20:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbbJ0Tum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 15:50:42 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932110AbbJ0Tul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 15:50:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CE48240D4;
	Tue, 27 Oct 2015 15:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gsDzpOgXEGMm4HcqTTEd4SSHbs8=; b=SwFSf2
	JMuTtU/ls8id8maKDDQMpDKTfDnVWuWjUStLx0RdSxEDGOwPs7V+n6sMF1uN+Zfq
	enqBZYR9yDgDaiLsKuryrLaQO/2npepgvAbPN5lG1gc0p5cU5SpYehTUw+q5PvwJ
	4ultTtVun/HYyIKOhTIIpHVpaT2nKcB92Z9+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vhtVrIV/nvPZus3fefRPMuIUUGXCo9kb
	M4lLKRB8hJnxaUimFYgSLQBTC4XfuTr+1bzrdQj/yeat8b2rdMJfah8Vh4LcQ/yt
	ahk0yTnY/4eODaJiB66XRX4QqlxCGgeP3b0OZoCnUADFXR40Yz3yjh2nRlPk4YSU
	IC7uPOCtc9E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63680240D2;
	Tue, 27 Oct 2015 15:50:40 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DAB2D240D1;
	Tue, 27 Oct 2015 15:50:39 -0400 (EDT)
In-Reply-To: <1445972456-5621-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Wed, 28 Oct 2015 00:30:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0000680E-7CE4-11E5-BA84-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280294>

Karthik Nayak <karthik.188@gmail.com> writes:

> In ref-filter.c the comparison of refs while sorting is handled by
> cmp_ref_sorting() function. When sorting as per numerical values
> (e.g. --sort=objectsize) there is no fallback comparison when both
> refs hold the same value. This can cause unexpected results (i.e. the
> order of listing refs with equal values cannot be pre-determined) as
> pointed out by Johannes Sixt ($gmane/280117).

As we use qsort(), if two members compare as equal, their order in
the sorted array is undefined.  I think this is a good change.

> Hence, fallback to alphabetical comparison based on the refname
> whenever the other criterion is equal. Fix the test in t3203 in this
> regard.

It is unclear what "in this regard" is.  Do you mean this (I am not
suggesting you to spell these out in a very detailed way in the
final log message; I am deliberately being detailed here to help me
understand what you really mean)?

    A test in t3203 was expecting that branch-two sorts before HEAD,
    which happened to be how qsort(3) on Linux sorted the array, but
    (1) that outcome was not even guaranteed, and (2) once we start
    breaking ties with the refname, "HEAD" should sort before
    "branch-two" so the original expectation was inconsistent with
    the criterion we now use.

    Update it to match the new world order, which we can now depend
    on being stable.

I am not sure about "HEAD" and "branch-two" in the above (it may be
comparison between "HEAD" and "refs/heads/branch-two", for example).

> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c             | 2 +-
>  t/t3203-branch-output.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 046e73b..7b33cb8 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1698,7 +1698,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>  		if (va->ul < vb->ul)
>  			cmp = -1;
>  		else if (va->ul == vb->ul)
> -			cmp = 0;
> +			cmp = strcmp(a->refname, b->refname);
>  		else
>  			cmp = 1;
>  	}
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index f77971c..9f2d482 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -158,8 +158,8 @@ EOF
>  
>  test_expect_success 'git branch `--sort` option' '
>  	cat >expect <<-\EOF &&
> -	  branch-two
>  	* (HEAD detached from fromtag)
> +	  branch-two
>  	  branch-one
>  	  master
>  	EOF
