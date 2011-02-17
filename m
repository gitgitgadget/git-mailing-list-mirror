From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] Introduce CHERRY_PICK_HEAD
Date: Thu, 17 Feb 2011 12:01:30 -0800
Message-ID: <7vipwibfc5.fsf@alter.siamese.dyndns.org>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 21:01:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqA2v-0005bC-62
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 21:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab1BQUBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 15:01:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab1BQUBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 15:01:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 622C3325B;
	Thu, 17 Feb 2011 15:02:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AxE8jzsQD8TJMtdcacObiPwqPXM=; b=Rg4hkDiqTMk1vWMyrvQMukV
	1RpO4f07qp3yFVbCbY8AB5f2Qg0A/R4QBJnCLF7ig2umucQP0cNGLmAe4MY/cNmJ
	nq7NTungROpSGWzZVF0N2GZR5kx06PDvlZS7QrMTGYoniqC8DWdEEqu+jnbRGBHI
	SH51cLzBZL5BRWWG1dGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ZE/ZAi4dVet440Og9BI+QMVbL3GyF2glpDKuQQ8M3xX/iEO48
	mtJN5SuQJYpCq2KczIHVF13M5SM2QWSMz/MKFlJ4lqFA60LAPK2hkDq29J1KtDTQ
	55BFZLp3H0SH3fBo7WI8UYuRa+E4xRKaFqZl1V02pl2s1cXqoTgV0GL0lQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D62A325A;
	Thu, 17 Feb 2011 15:02:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B55313255; Thu, 17 Feb 2011
 15:02:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E29EECE0-3AD0-11E0-87A3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167109>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 9403747..454dad2 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -971,6 +971,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		else
>  			die("You have not concluded your merge (MERGE_HEAD exists).");
>  	}
> +	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
> +		if (advice_resolve_conflict)
> +			die("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
> +			    "Please, commit your changes before you can merge.");
> +		else
> +			die("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).");
> +	}

Micronit: "Please, commit your changes before you can merge."

 - We are not merging in this codepath to begin with;

 - I'd suggest rephrasing this (together with "MERGE_HEAD" codepath) to
   something like:

	"Commit your changes first before retrying."

> +test_expect_success 'cherry-pick --no-commit sets CHERRY_PICK_HEAD' '
> +
> +	git checkout -f initial^0 &&
> +	git read-tree -u --reset HEAD &&
> +	git clean -d -f -f -q -x &&
> +
> +	git update-index --refresh &&
> +	git diff-index --exit-code HEAD &&

Getting tired of seeing these five lines repeated over and over.  Perhaps
it is time to introduce:

	pristine_detach () {
        	git checkout -f "$1^0" &&
                git read-tree -u --reset HEAD &&
                git clean -d -f -f -q -x
	}

I don't think "diff-index --exit-code HEAD" is necessary as the point of
this testsuite is not about testing "read-tree --reset", and the index
refresh is just a prerequisite for diff-index that can go together with
it.

> +	git cherry-pick --no-commit base &&
> +
> +	test_cmp_rev base CHERRY_PICK_HEAD

If the next "git commit" would notice and use this information, that would
introduce an unpleasant regression to one use case in my workflow, which
is to pick and consolidate one or more small pieces made on a private
"misc" branch, possibly with a bit of further work, into a new commit with
a readable explanation that is unrelated to any of the original commits:

	git cherry-pick --no-commit $some_commit
	git cherry-pick --no-commit $another_commit ;# optional
	edit ;# optional
        git commit

I'd prefer to see a way to tell cherry-pick not to leave CHERRY_PICK_HEAD
behind when "cherry-pick --no-commit" results in a successful cherry-pick
to avoid a backward incompatibility surprise.  Otherwise people need to
retrain their fingers to say --reset-author when they run "git commit".

Other then the above three points, this patch looks good.  Thanks.
