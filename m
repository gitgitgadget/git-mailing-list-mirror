From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] blame: test to describe use of blame --reverse --first-parent
Date: Fri, 30 Oct 2015 15:30:38 -0700
Message-ID: <xmqq611oj8fl.fsf@gitster.mtv.corp.google.com>
References: <1446181313-15094-1-git-send-email-max@max630.net>
	<1446181313-15094-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:30:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsICB-0006uI-Uh
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 23:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031425AbbJ3Wam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 18:30:42 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031420AbbJ3Wak (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 18:30:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9CEF272DA;
	Fri, 30 Oct 2015 18:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z00iyyS5LaMSnqoivUoMWhMwnWI=; b=IsjTXd
	xSuCih62y4NgWwTn/O1RDphmD+xDlEl1aqEetwO4NiX3ki9RYkmJJT3WE0p3h/LS
	M2CUh4lyWr1Zzg8s+BDrKCUSlB7pl06mMWzQ7KR/Mugbgx7tnmTukzctgQ+3Jfw7
	1WGC8vH5o1eT9i8rNbAjZXSykWqEe6GaPaHzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=caJYDYlbV3aKfH0HCxsDy3gon4cAyfwC
	cnQcSsI7wS8UpgAiXzUGEA7FwUC5OJqy3Sg+oVCmGdU/o50/Xgwb2fmUaqfJwfcW
	bCSrAsKOU5xv/zpjdgymsOpLpoZ+k0zHRcMmRbqcTrAkZKSpr9G0AykYxoEeyKt+
	z4t2qRjCon0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A15A6272D8;
	Fri, 30 Oct 2015 18:30:39 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1BA13272D7;
	Fri, 30 Oct 2015 18:30:39 -0400 (EDT)
In-Reply-To: <1446181313-15094-2-git-send-email-max@max630.net> (Max
	Kirillov's message of "Fri, 30 Oct 2015 07:01:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8D20C5A-7F55-11E5-8340-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280554>

Max Kirillov <max@max630.net> writes:

> Reverse blame can be used to locate removal of lines which does not
> change adjacent lines. Such edits do not appear in non-reverse blame,
> because the adjacent lines last changed commit is older history, before
> the edit.
>
> For a big and active project which uses topic branches, or analogous
> feature, for example pull-requests, the history can contain many
> concurrent branches, and even after an edit merged into the target
> branch, there are still many (sometimes several tens or even hundreds)
> topic branch which do not contain it:
>
>  a0--a1-----*a2-*a3-a4...-*a100
>  |\         /   /         /
>  | b0-B1..bN   /         /
>  |\           /         /
>  | c0..   ..cN         /
>  \                    /
>   z0..            ..zN
>
> Here, the '*'s mark the first parent in merge, and uppercase B1 - the
> commit where the line being blamed for was removed. Since commits cN-zN
> do not contain the B1, the still have the line removed in B1, and
> reverce blame can report that the last commit for the line was zN
> (meaning that it was removed in a100). In fact it really does return
> some very late commit, and this makes it unusable for finding the B1
> commit.
>
> The search could be done by blame --reverse --first-parent. For range
> a0..a100 it would return a1, and then only one additional blame along
> the a0..bN will return the desired commit b0. But combining --reverse
> and --first-parent was forbidden in 95a4fb0eac, because incorrectly
> specified range could produce unexpected and meaningless result.
>
> Add test which describes the expected behavior of
> `blame --reverse --first-parent` in the case described above.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---

There were a few obvious typos I spotted but other than that a very
understandable description.  Will queue.

Thanks.

>  t/t8009-blame-vs-topicbranches.sh | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100755 t/t8009-blame-vs-topicbranches.sh
>
> diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbranches.sh
> new file mode 100755
> index 0000000..175ad37
> --- /dev/null
> +++ b/t/t8009-blame-vs-topicbranches.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +
> +test_description='blaming trough history with topic branches'
> +. ./test-lib.sh
> +
> +# Creates the history shown below. '*'s mark the first parent in the merges.
> +# The only line of file.t is changed in commit B2
> +#
> +#        +---C1
> +#       /      \
> +# A0--A1--*A2--*A3
> +#   \     /
> +#    B1-B2
> +#
> +test_expect_success setup '
> +	test_commit A0 file.t line0 &&
> +	test_commit A1 &&
> +	git reset --hard A0 &&
> +	test_commit B1 &&
> +	test_commit B2 file.t line0changed &&
> +	git reset --hard A1 &&
> +	test_merge A2 B2 &&
> +	git reset --hard A1 &&
> +	test_commit C1 &&
> +	git reset --hard A2 &&
> +	test_merge A3 C1
> +	'
> +
> +test_expect_failure 'blame --reverse --first-parent finds A1' '
> +	git blame --porcelain --reverse --first-parent A0..A3 -- file.t >actual_full &&
> +	head -n 1 <actual_full | sed -e "s/ .*//" >actual &&
> +	git rev-parse A1 >expect &&
> +	test_cmp expect actual
> +	'
> +
> +test_done
