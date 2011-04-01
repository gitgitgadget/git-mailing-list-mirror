From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git diff -D: omit the preimage of deletes
Date: Fri, 01 Apr 2011 12:26:28 -0700
Message-ID: <7vbp0pg4d7.fsf@alter.siamese.dyndns.org>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
 <b6975fdc80a338e47c1426e8bf8450b68130b84a.1301664623.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:26:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5jze-0003mW-KB
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 21:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab1DAT0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 15:26:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1DAT0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 15:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9DBB4226;
	Fri,  1 Apr 2011 15:28:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YC+f0GYhku6mPm1UkQjFBLmVv1E=; b=TB8RyS
	1VyB9R/TLmQmVqLXrSkgalu35n0+uIF1QvRpdHv521yL9vXbEIiwdcD3ww3px8+1
	XI+zk6BFtcgAZ4oF1qUAP3skov05cC8mBySkjMO7GGeG1zdp8WIROE7I9ZN1wRES
	+dUNl+DJb549Q+PWNsBBt2L7/jYW0k5BHqHIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GtZtSCFuGzYMx5mEtiHO/seUznjRJ1qi
	3lMwExcISu3a1oLcpJ7qoVmCgIvK1+tlvC24d5r7M867HjawaxruTvKEsw762Okz
	7u9UkOmsVFV76778D5xQKF5otPrHHrYWWxQ/VpG7v0ecB60kK7M6pWXaRduBzKH9
	1+8dTRnItUs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8684421F;
	Fri,  1 Apr 2011 15:28:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9340F421B; Fri,  1 Apr 2011
 15:28:20 -0400 (EDT)
In-Reply-To: <b6975fdc80a338e47c1426e8bf8450b68130b84a.1301664623.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 1 Apr 2011 15:31:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35AF3DA4-5C96-11E0-81EC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170608>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/diff.c b/diff.c
> index 5422c43..9ea1de1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4205,7 +4211,7 @@ void diffcore_std(struct diff_options *options)
>  			diffcore_break(options->break_opt);
>  		if (options->detect_rename)
>  			diffcore_rename(options);
> -		if (options->break_opt != -1)
> +		if (options->break_opt != -1 && !options->irreversible_delete)
>  			diffcore_merge_broken();
>  	}
>  	if (options->pickaxe)

Thanks, but this hunk looks fishy.

What happens to a path that was tentatively broken for the purpose of
rename detection with -B -M (break to match with another file) but then
found to be with no counterpart after all after running diffcore_rename(),
which now needs to get merged back?  Such a path is shown as a normal
patch when the dissimlarity between the preimage and postimage is not
large enough and merge-broken is the step that combines such a broken but
unmatched pair back.

I would have expected that the patch relative to jc/diff-irreversible-delete
topic would consist only of changes to diff.c:emit_rewrite_diff(), docs
and tests.
