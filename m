From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: refuse all commands if one fails in atomic mode
Date: Tue, 16 Dec 2014 12:32:12 -0800
Message-ID: <xmqqfvcf9vzn.fsf@gitster.dls.corp.google.com>
References: <1418755747-22506-6-git-send-email-sbeller@google.com>
	<1418757280-32412-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 21:32:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0yn8-0000G4-0r
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 21:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbaLPUcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 15:32:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750791AbaLPUcR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 15:32:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0031C27A01;
	Tue, 16 Dec 2014 15:32:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BAoRPDcTBcRnbyoSzgWsvMRgYGQ=; b=OKUrDB
	ukIp0gIK55nC4//bS1veplSQyD+KIwS/Cj4iqReaADMXsd1zDaR1M5eGSsvZHa6F
	uRD/2LD7XvpKw5crbfVeem/XLeK/aYxRrg/1Q+k3MBpCSgJEfeC7I9hAWT3aCdGp
	+2qt15kWXWCj7Cxom2WOyQaLQnKXAwzUSJV4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZZRtlDxAQCepFt7EZ9q49c1KHCj5yhzT
	p3QDeDqZXfPFLSvAu3h/wYC38DKT8rCCpo+WbooRmu9SQO5dIsLQ6rueYB7IHnFO
	h8gAB7bKzxcjl3WnZ/8kTe8kCzGl5clpa1IFFaiBp0iGWfDYQiE4+MBoqdxbPFVj
	/3SI/1hgwSY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA9FF27A00;
	Tue, 16 Dec 2014 15:32:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5472B279FF;
	Tue, 16 Dec 2014 15:32:15 -0500 (EST)
In-Reply-To: <1418757280-32412-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 16 Dec 2014 11:14:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F4846C2-8562-11E4-ACAC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261467>

Stefan Beller <sbeller@google.com> writes:

> This patch will be incorporated into the right places in v3 of the series.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     I don't want to resend the patch series today to accumulate comments,
>     but this makes the last test pass, which is the whole point of the series.
>     
>     I'll put it into the right places in a reroll.
>
>  builtin/receive-pack.c | 13 ++++++++++++-
>  t/t5543-atomic-push.sh |  2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 0803fd2..3477f7c 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1122,7 +1122,18 @@ static void execute_commands(struct command *commands,
>  	}
>  
>  	if (use_atomic) {
> -		if (ref_transaction_commit(transaction, &err)) {
> +		/* update(...) may abort early (i.e. because the hook refused to
> +		 * update that ref), which then doesn't even record a transaction
> +		 * regarding that ref. Make sure all commands are without error
> +		 * and then commit atomically. */

	/*
         * The first line of our multi-line comment
         * has only opening slash-asterisk and nothing else.
         * The last line has asterisk-slash and nothing else.
         */

> +		for (cmd = commands; cmd; cmd = cmd->next)
> +			if (cmd->error_string)
> +				break;
> +		if (cmd) {
> +			for (cmd = commands; cmd; cmd = cmd->next)
> +				if (!cmd->error_string)
> +					cmd->error_string = "atomic push failure";
> +		} else if (ref_transaction_commit(transaction, &err)) {
>  			rp_error("%s", err.buf);
>  			for (cmd = commands; cmd; cmd = cmd->next)
>  				cmd->error_string = err.buf;

Makes sense.

> diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
> index 6354fc0..f0e54d9 100755
> --- a/t/t5543-atomic-push.sh
> +++ b/t/t5543-atomic-push.sh
> @@ -142,7 +142,7 @@ test_expect_success 'atomic push fails if one tag fails remotely' '
>  	test_ref_upstream second $(git -C workbench rev-parse --verify HEAD@{1})
>  '
>  
> -test_expect_failure 'atomic push obeys update hook preventing a branch to be pushed' '
> +test_expect_success 'atomic push obeys update hook preventing a branch to be pushed' '
>  	mk_repo_pair &&
>  	(
>  		cd workbench &&
