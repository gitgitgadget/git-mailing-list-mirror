From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] branch -h: show usage even in an invalid repository
Date: Fri, 22 Oct 2010 11:30:10 -0700
Message-ID: <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:31:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MOS-00069W-BF
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469Ab0JVSaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:30:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab0JVSaX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:30:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 808BEE11A2;
	Fri, 22 Oct 2010 14:30:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QQD+n1eZrAeGENL11xJ+lZj/UL4=; b=k2Ag6ssTAd0mOWkaDHe1En5
	MlPynCp+Z8zo3UxJKzbsBWtTHmoqsb643bl0ssznZ9HuGjd1ZfJ8tG+AvQ/Ns/af
	bcInudL5bPHWE7bnRMCgDDPsEMd00cxG0GNYzs1C/6IOk6hdacGtDO3pKtG0BbjS
	rXsb3cIZ/nOm5EcCw2qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FAx6lsV5z+jsjpwd7CrMvmzNNuNaROJ0bJj4Groav34J3s9OC
	1B7xZw+O1b14EGGr98QT1B8UVXaVkSmfqpzwlpM321LSFeIRw5U63qwZYWS6d5cD
	Tfppvhft3ys+fpMuJnoFFRS89nwZVwsPYeplY5/2MTWCT/EkCQt9SjSzTU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 48365E119F;
	Fri, 22 Oct 2010 14:30:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6427AE119D; Fri, 22 Oct
 2010 14:30:12 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A864E74-DE0A-11DF-99F9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159724>

Jonathan Nieder <jrnieder@gmail.com> writes:

> [jn: simplified; new commit message, test]

Overall (not just this 1/7) the messages justify the changes a lot
better.  Thanks for a pleasant read ;-).

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index f54a533..f308235 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -26,6 +26,17 @@ test_expect_success \
>       ! test -f .git/refs/heads/--help
>  '
>  
> +test_expect_success 'branch -h in broken repository' '
> +	mkdir broken &&
> +	(
> +		cd broken &&
> +		git init &&
> +		>.git/refs/heads/master &&
> +		test_expect_code 129 git branch -h >usage 2>&1
> +	) &&
> +	grep "[Uu]sage" broken/usage
> +'

A handful of points that struck me (not just test, but taking tests from
other patches together) as slightly odd, all minor:

 - Why '[Uu]sage"?  Should we make the messages consistent further?

 - The final "grep" check may want to make sure that the message is free of
   "fatal" (or "error", "warning", etc.) as well?

 - Each test seems to anticipate a specific kind of breakage tailored for
   the command being tested (e.g. "branch" test does not corrupt config
   nor the index).  Perhaps "lib-corrupt.sh" helper to run the same test
   in variety of corrupt repositories would help improve coverage?  [*1*]

 - Some tests redirect both the standard output and the standard error
   (like this patch) and check the combined result, while some others
   (e.g. 2/7) check only the standard error stream.  Don't we want to be
   testing them more uniformly?

>  test_expect_success \
>      'git branch abc should create a branch' \
>      'git branch abc && test -f .git/refs/heads/abc'

Don't we want to rather use resolve-ref or "rev-parse --verify", just in
case we may later change "git branch" to update packed-refs directly?


[Footnote]

*1* I am of two minds, as for example a corrupt "gc.pruneexpire" cannot
possibly matter for correct operation of "git branch", but am just
throwing out an idea to see if somebody else have clever ideas.
