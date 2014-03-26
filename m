From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] t/perf-lib: factor boilerplate out of test_perf
Date: Wed, 26 Mar 2014 15:34:23 -0700
Message-ID: <xmqqr45oh9n4.fsf@gitster.dls.corp.google.com>
References: <20140326072215.GA31739@sigill.intra.peff.net>
	<20140326072232.GA32193@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Maurer <bmaurer@fb.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:34:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSwP2-0004XF-3c
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471AbaCZWe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:34:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627AbaCZWe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:34:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC4CE78FD2;
	Wed, 26 Mar 2014 18:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4d6sQtqkpqTjA0rl3HqXhfDDnKU=; b=s8t6vT
	XzSJXvynn3eXzeqOkiLXWJ++i/FUrUmtOHgPDfW2ohv2bowF9Yh6Yq595DHhn6fR
	Gcywj+fwOub00mNeNX41aTzsoSXFK9JNxEpdgIgy63mgyZNzy7XFP5LXfds5pVfE
	3KoW48osh6IAXYkFSGBgnwxTyKJWvBKyB3Dic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xE2ywuDbMMLmUSfjOJI+Ld0NTLyVovlA
	1X4VPgqBYpbY5htjMFbi/DTmQdnngS2ZjfEwL77l9sCB4bHlQdom3iFEGVwgZRGW
	nJhgyXOytIFxeRkZpheWt/9nSLjYK1LQTWPmBIhYXUnZHGsWynXAt0wiAu1JCR66
	Rzt3gsd69g0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3BDB78FD1;
	Wed, 26 Mar 2014 18:34:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFCDD78FD0;
	Wed, 26 Mar 2014 18:34:24 -0400 (EDT)
In-Reply-To: <20140326072232.GA32193@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Mar 2014 03:22:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C89E26CE-B536-11E3-995B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245249>

Jeff King <peff@peff.net> writes:

> About half of test_perf() is boilerplate, and half is
> actually related to running the perf test. Let's split it
> into two functions, so that we can reuse the boilerplate in
> future commits.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/perf/perf-lib.sh | 61 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 26 deletions(-)

These early steps somewhat conflict with another topic that is
stalled (due to having no real users) on 'pu'.  I do not think we
would terribly mind dropping tg/perf-lib-test-perf-cleanup and have
it rebased if the author or somebody else wants to have it in my
tree later, but just FYI.

>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index a8c9574..20f306a 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -150,8 +150,8 @@ exit $ret' >&3 2>&4
>  	return "$eval_ret"
>  }
>  
> -
> -test_perf () {
> +test_wrapper_ () {
> +	test_wrapper_func_=$1; shift
>  	test_start_
>  	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
>  	test "$#" = 2 ||
> @@ -162,35 +162,44 @@ test_perf () {
>  		base=$(basename "$0" .sh)
>  		echo "$test_count" >>"$perf_results_dir"/$base.subtests
>  		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
> -		if test -z "$verbose"; then
> -			printf "%s" "perf $test_count - $1:"
> -		else
> -			echo "perf $test_count - $1:"
> -		fi
> -		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
> -			say >&3 "running: $2"
> -			if test_run_perf_ "$2"
> -			then
> -				if test -z "$verbose"; then
> -					printf " %s" "$i"
> -				else
> -					echo "* timing run $i/$GIT_PERF_REPEAT_COUNT:"
> -				fi
> +		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
> +		"$test_wrapper_func_" "$@"
> +	fi
> +
> +	test_finish_
> +}
> +
> +test_perf_ () {
> +	if test -z "$verbose"; then
> +		printf "%s" "perf $test_count - $1:"
> +	else
> +		echo "perf $test_count - $1:"
> +	fi
> +	for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
> +		say >&3 "running: $2"
> +		if test_run_perf_ "$2"
> +		then
> +			if test -z "$verbose"; then
> +				printf " %s" "$i"
>  			else
> -				test -z "$verbose" && echo
> -				test_failure_ "$@"
> -				break
> +				echo "* timing run $i/$GIT_PERF_REPEAT_COUNT:"
>  			fi
> -		done
> -		if test -z "$verbose"; then
> -			echo " ok"
>  		else
> -			test_ok_ "$1"
> +			test -z "$verbose" && echo
> +			test_failure_ "$@"
> +			break
>  		fi
> -		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
> -		"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
> +	done
> +	if test -z "$verbose"; then
> +		echo " ok"
> +	else
> +		test_ok_ "$1"
>  	fi
> -	test_finish_
> +	"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
> +}
> +
> +test_perf () {
> +	test_wrapper_ test_perf_ "$@"
>  }
>  
>  # We extend test_done to print timings at the end (./run disables this
