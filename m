From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] test that git status works with merge conflict
 in .gitmodules
Date: Thu, 12 May 2011 22:47:09 -0700
Message-ID: <7v1v03b19e.fsf@alter.siamese.dyndns.org>
References: <4DCC4A9D.3060007@web.de> <4DCC4AE0.6020902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri May 13 07:47:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKlDh-0003YE-ND
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 07:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab1EMFrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 01:47:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1EMFrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 01:47:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C17133E7;
	Fri, 13 May 2011 01:49:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MwDE5HJt5TKHXiO8iDkaqq4hNfc=; b=QZmaJz
	daCF2ZRAPuhBGESby8egopMpOvheYymvwMDVWZMgDeT+WBI4L6pBQCMSlAxnJN5R
	pCZS4l4j19PhixgS0oL99kuwzVMBB4CIu6BmLX/b6Nrqzqo746numTYh4QZ3xmQQ
	Z67vrLsTl9bJW+nTUkMtcvrdUuyKTUTYGhpso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uheUpGt7i9agCpU6JHOdTvZEQKRN9Dp+
	sZonsNrEK6aBYWfQxspcVPLAzbBsFqaSg1pSIKgtuSQM2l4yYHxaVgkIVHe5nNAP
	12TxnEDDs23UJw8g8BtcSRtPtLzdIRebDUQgoesSxe94xJH7nsgk+KHmPYK7v8xz
	fIyGNh0Irms=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A28233E6;
	Fri, 13 May 2011 01:49:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A715233E2; Fri, 13 May 2011
 01:49:17 -0400 (EDT)
In-Reply-To: <4DCC4AE0.6020902@web.de> (Jens Lehmann's message of "Thu, 12
 May 2011 23:02:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C04BD4A0-7D24-11E0-A77D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173504>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> From: Heiko Voigt <hvoigt@hvoigt.net>
>
> For example: Two users independently adding a submodule will result in a
> merge conflict in .gitmodules. Since configuration of the status and
> diff machinery depends on the file being parseable they currently
> fail to produce useable output in case .gitmodules is marked with a
> merge conflict.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

The basic idea (both patches) seems sound.

> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> index c8d50a6..3b1806c 100755
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh
> @@ -4,17 +4,21 @@ test_description='git status for submodule'
>
>  . ./test-lib.sh
>
> -test_expect_success 'setup' '
> -	test_create_repo sub &&
> +test_create_repo_with_commit () {
> +	test_create_repo $1 &&
>  	(
> -		cd sub &&
> +		cd $1 &&

Missing dq, i.e. "$1" (two instances).

> +cat > status_expect << EOF

	cat >status_expect <<\EOF

Unless you actively mean the here-text has variables that need to be
substituted, always quote the end-of-here-text delimiter.  That would
reduce the mental burden of people who have to read the script, as they
do not have to look for a potential substitution that does not exist.

> +# On branch merge_conflict_gitmodules
> +# Changes to be committed:
> +#
> +#	new file:   sub1
> +#
> +# Unmerged paths:
> +#   (use "git add/rm <file>..." as appropriate to mark resolution)
> +#
> +#	both added:         .gitmodules
> +#
> +EOF

Is it absolutely necessary to run this test by comparing the output of
human readable version of "git status" output?  It makes it impossible to
test under gettext-poison.  Can you use "git status -s" output instead?

> ...
> +test_expect_failure 'diff --submodule with merge conflict in .gitmodules' '
> +	(
> +		cd super &&
> +		git diff --submodule > ../diff_submodule_actual 2>&1
> +	) &&
> +	test_cmp diff_submodule_actual diff_submodule_expect
> +'

You have too many ">" redirect followed by an unnecessary SP. There are
existing examples in the test, please do not make things worse.
