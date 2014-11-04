From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] line-log: fix crash when --first-parent is used
Date: Tue, 04 Nov 2014 13:24:57 -0800
Message-ID: <xmqq8ujqpsk6.fsf@gitster.dls.corp.google.com>
References: <1414784636-43155-1-git-send-email-tmikov@gmail.com>
	<1415133217-7824-1-git-send-email-tmikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Vander Weele <ericvw@gmail.com>
To: Tzvetan Mikov <tmikov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 22:25:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XllbC-0000bG-DE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 22:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbaKDVZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 16:25:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751129AbaKDVZB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 16:25:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 285B91A5B5;
	Tue,  4 Nov 2014 16:24:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ATuzdXbSTwUj5Eh9ED0aY7Q86jM=; b=B40ICFPBVouagPr4UEwZ
	dEopjZIXN0yrB9JCqp5aoYc+YJljY8rx9uNZH3uEPCXqMOrxpaLq3nP9D6o++Sbg
	txy5Syl6zNxhM9aDc5qWw1o2uIrgyWQ20LO9GEBH4phRcM1vRfw9VLP5oxNqHq7r
	MIAxB/L3g4Jyqa3/xgmPeYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=A8uiVE9gpt7SA1RqPwFNBsmBp3GjqrVyi+Qheyl8Y9iVvc
	9QSEVXSsMIwNcwxwgQmpLvutV9PBRMkH3WtWHLU+lkgDeMUV6xb2yWDsrwBFdZMl
	r6givA38GQ2HMITVF70gYaReoYpvmPrMU8+0yyeo3jNOHNL/FW7iK4IIIL/2c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E5A51A5B4;
	Tue,  4 Nov 2014 16:24:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D9D01A5B3;
	Tue,  4 Nov 2014 16:24:58 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0753E44E-6469-11E4-8C31-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tzvetan Mikov <tmikov@gmail.com> writes:

> line-log tries to access all parents of a commit, but only the first
> parent has been loaded if "--first-parent" is specified, resulting
> in a crash.
>
> Limit the number of parents to one if "--first-parent" is specified.
>
> Reported-by: Eric N. Vander Weele <ericvw@gmail.com>
> Signed-off-by: Tzvetan Mikov <tmikov@gmail.com>
> ---
>  PATCH v2: Add a test case (thanks Michael J Gruber)

Thanks, both.  The patch looks good (modulo the indentation of
nparents assignment, which I'll locally fix up).

Will queue.

>  line-log.c          | 3 +++
>  t/t4211-line-log.sh | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/line-log.c b/line-log.c
> index 1008e72..86e7274 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1141,6 +1141,9 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
>  	int i;
>  	int nparents = commit_list_count(commit->parents);
>  
> +	if (nparents > 1 && rev->first_parent_only)
> +	    nparents = 1;
> +
>  	diffqueues = xmalloc(nparents * sizeof(*diffqueues));
>  	cand = xmalloc(nparents * sizeof(*cand));
>  	parents = xmalloc(nparents * sizeof(*parents));
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index 7369d3c..0901b30 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -94,4 +94,9 @@ test_expect_success '-L ,Y (Y == nlines + 2)' '
>  	test_must_fail git log -L ,$n:b.c
>  '
>  
> +test_expect_success '-L with --first-parent and a merge' '
> +	git checkout parallel-change &&
> +	git log --first-parent -L 1,1:b.c
> +'
> +
>  test_done
