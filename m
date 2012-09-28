From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/21] git p4 test: use client_view in t9806
Date: Fri, 28 Sep 2012 12:11:05 -0700
Message-ID: <7v4nmiklbt.fsf@alter.siamese.dyndns.org>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
 <1348833865-6093-7-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:18:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THg5H-0007aE-PO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031076Ab2I1TSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:18:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031074Ab2I1TSd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:18:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C98EB815D;
	Fri, 28 Sep 2012 15:18:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=f4PMbyOdI4RTZmHaD4KKA65aKWk=; b=jT0Mglqb7sHP9HxUTfDa
	+2NGU/V/oPFVsqx8OZdyYUA8/b9cwMZVfwcUsvtlPUKgPF4fecghtlg7RnbaNtgt
	cV9BlSVPvcwQ68WUlujuLr+X0Q2NVd49KbBfszaOYdkdDm8ytbag+RqjuhqKBEPK
	h7RMrnPTGpTnSGkK8r1jnUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=L52VMDog/Gvp0bfLDur0exsQTrSZoPyXsgNByCGwKLHgkl
	5/0wQdIxv4DFYtJ0xMQ1SeoxKrhZGzyVHsKJPlpzHLc8aHO8Z0En53du6tXgjJU+
	h9QTHyRT32kUds1SNqQpZq9370fpU3+8Jzh9zoy8apFBOfXq8sICt6Qnmgekg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B76AB815C;
	Fri, 28 Sep 2012 15:18:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19CE4815A; Fri, 28 Sep 2012
 15:18:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AA31B2C-09A1-11E2-BF4F-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206597>

Pete Wyckoff <pw@padd.com> writes:

> Use the standard client_view function from lib-git-p4.sh
> instead of building one by hand.  This requires a bit of
> rework, using the current value of $P4CLIENT for the client
> name.  It also reorganizes the test to isolate changes to
> $P4CLIENT and $cli in a subshell.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  t/lib-git-p4.sh           |  4 ++--
>  t/t9806-git-p4-options.sh | 50 ++++++++++++++++++++++-------------------------
>  2 files changed, 25 insertions(+), 29 deletions(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 890ee60..d558dd0 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -116,8 +116,8 @@ marshal_dump() {
>  client_view() {
>  	(
>  		cat <<-EOF &&
> -		Client: client
> -		Description: client
> +		Client: $P4CLIENT
> +		Description: $P4CLIENT
>  		Root: $cli
>  		View:
>  		EOF
> diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
> index fa40cc8..37ca30a 100755
> --- a/t/t9806-git-p4-options.sh
> +++ b/t/t9806-git-p4-options.sh
> @@ -126,37 +126,33 @@ test_expect_success 'clone --use-client-spec' '
>  		exec >/dev/null &&
>  		test_must_fail git p4 clone --dest="$git" --use-client-spec
>  	) &&
> -	cli2=$(test-path-utils real_path "$TRASH_DIRECTORY/cli2") &&
> +	# build a different client
> +	cli2="$TRASH_DIRECTORY/cli2" &&
>  	mkdir -p "$cli2" &&
>  	test_when_finished "rmdir \"$cli2\"" &&
>  	test_when_finished cleanup_git &&
> ...
> -	# same thing again, this time with variable instead of option
>  	(
> ...
> +		# group P4CLIENT and cli changes in a sub-shell
> +		P4CLIENT=client2 &&
> +		cli="$cli2" &&
> +		client_view "//depot/sub/... //client2/bus/..." &&
> +		git p4 clone --dest="$git" --use-client-spec //depot/... &&
> +		(
> +			cd "$git" &&
> +			test_path_is_file bus/dir/f4 &&
> +			test_path_is_missing file1
> +		) &&
> +		cleanup_git &&

Hmm, the use of "test-path-utils real_path" to form cli2 in the
original was not necessary at all?

> +		# same thing again, this time with variable instead of option
> +		(
> +			cd "$git" &&
> +			git init &&
> +			git config git-p4.useClientSpec true &&
> +			git p4 sync //depot/... &&
> +			git checkout -b master p4/master &&
> +			test_path_is_file bus/dir/f4 &&
> +			test_path_is_missing file1
> +		)

Do you need a separate sub-shell inside a sub-shell we are already
in that you called client_view in?

>  	)
>  '
