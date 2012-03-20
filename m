From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix missing/buggy diff output prefixes w/ --graph
Date: Tue, 20 Mar 2012 10:55:23 -0700
Message-ID: <7vwr6f5f90.fsf@alter.siamese.dyndns.org>
References: <1332230734-19734-1-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Larry D'Anna" <larry@elder-gods.org>,
	"Bo Yang" <struggleyb.nku@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Timo Hirvonen" <tihirvon@gmail.com>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 18:55:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA3HQ-0003k1-Po
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 18:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab2CTRz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 13:55:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab2CTRz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 13:55:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88B1362D0;
	Tue, 20 Mar 2012 13:55:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uiwJMkSC2F6Jao8/P9uH2GaK0RQ=; b=pVKuIh
	DhboOqpkQlwjHjqMoJqmirbDIJGTMWKL42zsI4yM15epGxKYBUuEBy8nySbvlNFM
	GMa9LV7nar3FyzhWSNBCiYFnhMQe7+Ko6Mz63NtS+0Jg3/nNpImE2CzP3nNrQuf+
	y/NX5xVkYFhRJ2PWP8QBCmJIHlDf+zfcLiKbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5PEYTRMt2dFtOR1N0XhYuixKy0OquB3
	qcy/9JiSf8lyNaXoo8vr7AH9RQlYXayf3R4Xx/eiSaK6ClZpzMg8j3xLu6HIuHEt
	T5VscjI2gL4SDq0927O80SF2uumjk0s7WHh8G6v2eS0CJzZVvb24PJjXmFimv+Kd
	WB41BxVNMuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DC6F62CF;
	Tue, 20 Mar 2012 13:55:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6D3B62CE; Tue, 20 Mar 2012
 13:55:24 -0400 (EDT)
In-Reply-To: <1332230734-19734-1-git-send-email-lucian.poston@gmail.com>
 (Lucian Poston's message of "Tue, 20 Mar 2012 01:05:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEC64230-72B5-11E1-BB45-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193526>

Lucian Poston <lucian.poston@gmail.com> writes:

> Fixed issue with `git log --graph --stat -p` in which the "---" diff output
> header appears before the diff output prefix.
>
> Fixed issue where diff output prefix is absent on empty lines separating diff
> stats and patch.
>
> Added test to verify the graph decoration prefixes of
> `git log --pretty=short --stat -p --graph` are printed correctly.
>
> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
> ---

Same comment as the one for your other patch applies to this.  Especially,
the Subject says "missing/buggy" but it is unclear if "missing" is the
only bugginess you are addressing, or there are other "bugginess" other
than "missing" from no description in the log message.

> diff --git a/diff.c b/diff.c
> index 377ec1e..29003eb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4399,6 +4399,12 @@ void diff_flush(struct diff_options *options)
>  
>  	if (output_format & DIFF_FORMAT_PATCH) {
>  		if (separator) {
> +			if (options->output_prefix) {
> +				struct strbuf *msg = NULL;
> +				msg = options->output_prefix(options,
> +					options->output_prefix_data);
> +				fwrite(msg->buf, msg->len, 1, stdout);
> +			}
>  			putc(options->line_termination, options->file);
>  			if (options->stat_sep) {
>  				/* attach patch instead of inline */

Immediately before a separator (typically LF) that comes between the log
message and the patch text, we forgot to show the ancestry graph lines.
This corresponds to the second paragraph of your log message.

This is a tangent, but I wonder how --graph should interact with stat_sep
(i.e. patch is shown as an attachment) case. Perhaps the combination need
to be forbidden, but we probably do not care (in other words, the user
would get whatever the code happens to produce).

> diff --git a/log-tree.c b/log-tree.c
> index cea8756..3198503 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -710,15 +710,16 @@ int log_tree_diff_flush(struct rev_info *opt)
>  		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
>  		    opt->verbose_header &&
>  		    opt->commit_format != CMIT_FMT_ONELINE) {
> -			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
> -			if ((pch & opt->diffopt.output_format) == pch)
> -				printf("---");
>  			if (opt->diffopt.output_prefix) {
>  				struct strbuf *msg = NULL;
>  				msg = opt->diffopt.output_prefix(&opt->diffopt,
>  					opt->diffopt.output_prefix_data);
>  				fwrite(msg->buf, msg->len, 1, stdout);
>  			}
> +			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;

Moving this line is unnecessary, and introduces decl-after-statement to
break compilation.

> +			if ((pch & opt->diffopt.output_format) == pch) {
> +				printf("---");
> +			}

We used to show the "---" before ancestry graph lines, which was nonsense.
This corresponds to the first paragraph of your log message.

Looks good from a cursory review.  Thanks.
