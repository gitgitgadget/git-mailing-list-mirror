From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] t/t5528-push-default: test pushdefault workflows
Date: Wed, 19 Jun 2013 15:17:11 -0700
Message-ID: <7v8v25ycd4.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 00:17:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpQgp-0003tR-F2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935275Ab3FSWRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 18:17:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935231Ab3FSWRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 18:17:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3AE72990E;
	Wed, 19 Jun 2013 22:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gt8ErUfpz4ajDUhtSvK9pEOIp4o=; b=NgIVhs
	eVsg/0DCX0WIie84i2K6tts6DECm/8MNhrah8f6HJw1JoX2adoM5fsOlL6IP+3Sz
	YbrF1gehvOTvWEXvFYaN1WDv+HeA4AKiqY/Wr2PlJiioMPNj41RGbFpWUAdndAd7
	5tH2rVHK81HqCiviowT1Y++cQMr4xHolb+cig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jxxrir9gjuRi30ZBiwbz17HZiQtBIDN2
	wgzJrXtxTZxNh5gvtjxu0RwWznLD8rDRWMNKf2i1cdntaw6E8oPej+ZcWafkNdFA
	h494dRXQDypW7SZueMRGXYUY0bMbtSDR24JOBbjeH0sHsJEORFxoPPud3PoL1NMa
	LO/TMU3DBB4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A6F42990D;
	Wed, 19 Jun 2013 22:17:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CED272990A;
	Wed, 19 Jun 2013 22:17:12 +0000 (UTC)
In-Reply-To: <1371640304-26019-7-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 16:41:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDC0CD38-D92D-11E2-B58D-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228428>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Introduce test_pushdefault_workflows(), and test that all push.default
> modes work with central and triangular workflows as expected.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5528-push-default.sh | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index b599186..eabc09d 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -39,6 +39,26 @@ test_push_failure () {
>  	test_cmp expect actual
>  }
>  
> +# $1 = success or failure
> +# $2 = push.default value
> +# $3 = branch to check for actual output (master or foo)
> +# $4 = [optional] switch to triangular workflow
> +test_pushdefault_workflow () {
> +	workflow=central
> +	pushdefault=parent1
> +	if test -n "${4-}"; then
> +		workflow=triangular
> +		pushdefault=parent2
> +	fi
> +test_expect_success "push.default = $2 $1 in $workflow workflows" "
> +	test_config branch.master.remote parent1 &&
> +	test_config branch.master.merge refs/heads/foo &&
> +	test_config remote.pushdefault $pushdefault &&
> +	test_commit commit-for-$2${4+-triangular} &&
> +	test_push_$1 $2 $3 ${4+repo2}
> +"

Please indent the above; it is hard to spot where the actual test
begins and ends otherwise.

> +}
> +
>  test_expect_success '"upstream" pushes to configured upstream' '
>  	git checkout master &&
>  	test_config branch.master.remote parent1 &&
> @@ -115,4 +135,20 @@ test_expect_success 'push to existing branch, upstream configured with different
>  	test_cmp expect-other-name actual-other-name
>  '
>  
> +## test_pushdefault_workflow() arguments:
> +# $1 = success or failure
> +# $2 = push.default value
> +# $3 = branch to check for actual output (master or foo)
> +# $4 = [optional] switch to triangular workflow

What happens in current/upstream/simple modes is affected by the
current branch, but it is unclear on what branch do these all run at
the first glance.  It would be helpful to add a comment here that
says what the starting condition is, something like:

    # We are on 'master', which integrates with 'foo' from parent1
    # Both parent1 and parent2 repositories have 'master' and 'foo'
    # branches.

here.  It took me a while to tell what some of these comments wanted
to say without such a comment.

> +test_pushdefault_workflow success current master  # breaks push/pull symmetry

On 'master', push.default = current and we are in central workflow.
Because we do not use upstream but current, that deliberately breaks
the symmetry.  We make sure that 'master' is updated.

Looks correct.

> +test_pushdefault_workflow success upstream foo    # preserves push/pull symmetry

We use 'upstream'; current branch is set to integrate with 'foo' and
that is what is updated.  Looks good.

> +test_pushdefault_workflow failure simple master   # errors out on asymmetry

Simple is a safer form of 'current' in the central workflow.
The current branch is set to integrate with 'foo', which is
different name from the current branch'es name 'master', and the
push fails.

Looks correct, but do we want to make sure 'foo' is not updated
here as well?

> +test_pushdefault_workflow success matching master # always works

This also should update 'foo'; do we want to make sure that happens
too?

Otherwise we won't be able to tell between matching and current.

> +test_pushdefault_workflow success current master triangular  # always works

OK.

> +test_pushdefault_workflow failure upstream foo triangular    # always errors out

OK.

> +test_pushdefault_workflow success simple master triangular   # works like current

OK, because in triangular it is like current.

> +test_pushdefault_workflow success matching master triangular # always works

OK.

As this step adds a useful helper function for testing, it appears
to me that the helper can and should check the postcondition more
carefully, e.g. not just making sure what should be updated is
updated, but what should not be updated is not touched.

Other than that, looks fine to me.

> +
>  test_done
