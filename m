From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] submodule foreach: correct path display in recursive submodules
Date: Tue, 29 Mar 2016 16:49:31 -0700
Message-ID: <xmqqshz8vo8k.fsf@gitster.mtv.corp.google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
	<1459292558-5840-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jacob.keller@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 01:49:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al3OM-0002Gq-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758530AbcC2Xtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:49:40 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758524AbcC2Xtj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:49:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 334DC515FC;
	Tue, 29 Mar 2016 19:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ye7DAR7Hc4cvrCWr//zRJ3zPWTg=; b=ZXwlFR
	M4max+h+gH75TsaqBxNOD1A1sKKLPfDF8AifmtZSnXiIERmVlPiFdv77tQcbpKhU
	Uj6sPpXCBMoyOTNbMsaWH/zjnNp6W8Zf1vzgpeHPx385/ovO7nlPtj+XaqzNaKoz
	ZmsE3bpwKTlqETYQA7LeCWIxYm2ZDosa2jUxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hgPC5pHDDFbMniaMiAHvfC2FfHgSLpDW
	5KmTrDaqRr8Rj0zNAstJzr5g5Ls+kdY+VkHY0WyRwnl96quPNwbugTSjhIOird/Y
	abScGTEmgaGCMxO2INHBUub3aoNd4dAtMaUH5xZxaeuO1zCdQ1Weu4MoWKeIiDEH
	U7sy0VlPreU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B003515FA;
	Tue, 29 Mar 2016 19:49:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A20E515F9;
	Tue, 29 Mar 2016 19:49:32 -0400 (EDT)
In-Reply-To: <1459292558-5840-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 29 Mar 2016 16:02:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E297E50A-F608-11E5-977E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290226>

Stefan Beller <sbeller@google.com> writes:

> The new test replicates the previous test with the difference of executing
> from a sub directory. By executing from a sub directory all we would
> expect all displayed paths to be prefixed by '../'.

-ECANTPARSE on the last sentence.  Remove the first "all" perhaps?

As this patch is no longer about a new test but is about a fix of a
problem, for which a new test serves as a typical example, it sounds
somewhat funny to start the log message with description of the test.

> Prior to this patch the test would report
>     Entering 'nested1/nested2/../nested3'
> instead of the expected
>     Entering '../nested1/nested2/nested3'
>
> because the prefix is put unconditionally in front and after that a
> computed display path with is affected by `wt_prefix`.

-ECANTPARSE even though I can guess what you want to say.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 43c68de..2838069 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -417,10 +417,11 @@ cmd_foreach()
>  			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
>  			name=$(git submodule--helper name "$sm_path")
>  			(
> -				prefix="$prefix$sm_path/"
> +				prefix="$(relative_path $prefix$sm_path)/"

What happens when prefix or sm_path has $IFS whitespace?  Imitate the
correct quoting you do three lines below, i.e.

	prefix=$(relative_path "$prefix$sm_path")/

>  				clear_local_git_env
>  				cd "$sm_path" &&
>  				sm_path=$(relative_path "$sm_path") &&
> +				wt_prefix=
>  				# we make $path available to scripts ...
>  				path=$sm_path &&
>  				if test $# -eq 1
