From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] drop unnecessary copying in credential_ask_one
Date: Thu, 02 Jan 2014 11:08:51 -0800
Message-ID: <xmqq7gaiqjzw.fsf@gitster.dls.corp.google.com>
References: <1388624793-5563-1-git-send-email-rctay89@gmail.com>
	<20140102030330.GA10976@sigill.intra.peff.net>
	<20140102073835.GA5431@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 02 20:09:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyndf-0004nD-71
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 20:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbaABTI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 14:08:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaABTI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 14:08:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4CAA5E5C4;
	Thu,  2 Jan 2014 14:08:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bf6u+4azOO5RYwzHvghp8ED6iV8=; b=fo+TzZ
	Xrm5h8VTI3JYoNtd4u6y8fKcJ7sIaRaMp4QvgEZPN4II9MEMKe4rUtoU0K/Jn66S
	czsKw3x6VRNZKnnbBITi8ha+QEYOPwIAXY8GJqned4vhrUHM+sNqBVKQth4roH/r
	OFGQCkrAwvywU6SpUa1WqcaxklrUOfANCumzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NfvAFdgkPMRut904HYbBt41Fm+SpJfEu
	oSWLCvBvquMmPStmqTB4t/K0r1GWe4cMQUo5nhSV4UobVu1CdhlKBV6PV7YICtJ2
	IR318kFZWo39orSc6IivrUKJsUaIHrfBetB20G/pMbsxXJH4VKuzdzj+C0flp7XB
	yaBVpO5fSPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 890565E5C2;
	Thu,  2 Jan 2014 14:08:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D21F05E5C1;
	Thu,  2 Jan 2014 14:08:54 -0500 (EST)
In-Reply-To: <20140102073835.GA5431@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jan 2014 02:38:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5301C86C-73E1-11E3-90EB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239866>

Jeff King <peff@peff.net> writes:

> ... But the test suite, of course, always uses askpass because it
> cannot rely on accessing a terminal (we'd have to do some magic with
> lib-terminal, I think).
>
> So it doesn't detect the problem in your patch, but I wonder if it is
> worth applying the patch below anyway, as it makes the test suite
> slightly more robust.

Sounds like a good first step in the right direction.  Thanks.


> -- >8 --
> Subject: use distinct username/password for http auth tests
>
> The httpd server we set up to test git's http client code
> knows about a single account, in which both the username and
> password are "user@host" (the unusual use of the "@" here is
> to verify that we handle the character correctly when URL
> escaped).
>
> This means that we may miss a certain class of errors in
> which the username and password are mixed up internally by
> git. We can make our tests more robust by having distinct
> values for the username and password.
>
> In addition to tweaking the server passwd file and the
> client URL, we must teach the "askpass" harness to accept
> multiple values. As a bonus, this makes the setup of some
> tests more obvious; when we are expecting git to ask
> only about the password, we can seed the username askpass
> response with a bogus value.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/lib-httpd.sh        | 15 ++++++++++++---
>  t/lib-httpd/passwd    |  2 +-
>  t/t5540-http-push.sh  |  4 ++--
>  t/t5541-http-push.sh  |  6 +++---
>  t/t5550-http-fetch.sh | 10 +++++-----
>  t/t5551-http-fetch.sh |  6 +++---
>  6 files changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index c470784..bfdff2a 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -129,7 +129,7 @@ prepare_httpd() {
>  	HTTPD_DEST=127.0.0.1:$LIB_HTTPD_PORT
>  	HTTPD_URL=$HTTPD_PROTO://$HTTPD_DEST
>  	HTTPD_URL_USER=$HTTPD_PROTO://user%40host@$HTTPD_DEST
> -	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:user%40host@$HTTPD_DEST
> +	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:pass%40host@$HTTPD_DEST
>  
>  	if test -n "$LIB_HTTPD_DAV" -o -n "$LIB_HTTPD_SVN"
>  	then
> @@ -217,7 +217,15 @@ setup_askpass_helper() {
>  	test_expect_success 'setup askpass helper' '
>  		write_script "$TRASH_DIRECTORY/askpass" <<-\EOF &&
>  		echo >>"$TRASH_DIRECTORY/askpass-query" "askpass: $*" &&
> -		cat "$TRASH_DIRECTORY/askpass-response"
> +		case "$*" in
> +		*Username*)
> +			what=user
> +			;;
> +		*Password*)
> +			what=pass
> +			;;
> +		esac &&
> +		cat "$TRASH_DIRECTORY/askpass-$what"
>  		EOF
>  		GIT_ASKPASS="$TRASH_DIRECTORY/askpass" &&
>  		export GIT_ASKPASS &&
> @@ -227,7 +235,8 @@ setup_askpass_helper() {
>  
>  set_askpass() {
>  	>"$TRASH_DIRECTORY/askpass-query" &&
> -	echo "$*" >"$TRASH_DIRECTORY/askpass-response"
> +	echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
> +	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
>  }
>  
>  expect_askpass() {
> diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
> index f2fbcad..99a34d6 100644
> --- a/t/lib-httpd/passwd
> +++ b/t/lib-httpd/passwd
> @@ -1 +1 @@
> -user@host:nKpa8pZUHx/ic
> +user@host:xb4E8pqD81KQs
> diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
> index 01d0d95..5b0198c 100755
> --- a/t/t5540-http-push.sh
> +++ b/t/t5540-http-push.sh
> @@ -154,7 +154,7 @@ test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
>  
>  test_expect_success 'push to password-protected repository (user in URL)' '
>  	test_commit pw-user &&
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git push "$HTTPD_URL_USER/auth/dumb/test_repo.git" HEAD &&
>  	git rev-parse --verify HEAD >expect &&
>  	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git" \
> @@ -168,7 +168,7 @@ test_expect_failure 'user was prompted only once for password' '
>  
>  test_expect_failure 'push to password-protected repository (no user in URL)' '
>  	test_commit pw-nouser &&
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git push "$HTTPD_URL/auth/dumb/test_repo.git" HEAD &&
>  	expect_askpass both user@host
>  	git rev-parse --verify HEAD >expect &&
> diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
> index 470ac54..bfd241e 100755
> --- a/t/t5541-http-push.sh
> +++ b/t/t5541-http-push.sh
> @@ -274,7 +274,7 @@ test_expect_success 'push over smart http with auth' '
>  	cd "$ROOT_PATH/test_repo_clone" &&
>  	echo push-auth-test >expect &&
>  	test_commit push-auth-test &&
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git push "$HTTPD_URL"/auth/smart/test_repo.git &&
>  	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
>  		log -1 --format=%s >actual &&
> @@ -286,7 +286,7 @@ test_expect_success 'push to auth-only-for-push repo' '
>  	cd "$ROOT_PATH/test_repo_clone" &&
>  	echo push-half-auth >expect &&
>  	test_commit push-half-auth &&
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git push "$HTTPD_URL"/auth-push/smart/test_repo.git &&
>  	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
>  		log -1 --format=%s >actual &&
> @@ -316,7 +316,7 @@ test_expect_success 'push into half-auth-complete requires password' '
>  	cd "$ROOT_PATH/half-auth-clone" &&
>  	echo two >expect &&
>  	test_commit two &&
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git push "$HTTPD_URL/half-auth-complete/smart/half-auth.git" &&
>  	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/half-auth.git" \
>  		log -1 --format=%s >actual &&
> diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
> index f7d0f14..8392624 100755
> --- a/t/t5550-http-fetch.sh
> +++ b/t/t5550-http-fetch.sh
> @@ -62,13 +62,13 @@ test_expect_success 'http auth can use user/pass in URL' '
>  '
>  
>  test_expect_success 'http auth can use just user in URL' '
> -	set_askpass user@host &&
> +	set_askpass wrong pass@host &&
>  	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-pass &&
>  	expect_askpass pass user@host
>  '
>  
>  test_expect_success 'http auth can request both user and pass' '
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-both &&
>  	expect_askpass both user@host
>  '
> @@ -77,7 +77,7 @@ test_expect_success 'http auth respects credential helper config' '
>  	test_config_global credential.helper "!f() {
>  		cat >/dev/null
>  		echo username=user@host
> -		echo password=user@host
> +		echo password=pass@host
>  	}; f" &&
>  	set_askpass wrong &&
>  	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-helper &&
> @@ -86,14 +86,14 @@ test_expect_success 'http auth respects credential helper config' '
>  
>  test_expect_success 'http auth can get username from config' '
>  	test_config_global "credential.$HTTPD_URL.username" user@host &&
> -	set_askpass user@host &&
> +	set_askpass wrong pass@host &&
>  	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-user &&
>  	expect_askpass pass user@host
>  '
>  
>  test_expect_success 'configured username does not override URL' '
>  	test_config_global "credential.$HTTPD_URL.username" wrong &&
> -	set_askpass user@host &&
> +	set_askpass wrong pass@host &&
>  	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-user2 &&
>  	expect_askpass pass user@host
>  '
> diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
> index afb439e..a124efe 100755
> --- a/t/t5551-http-fetch.sh
> +++ b/t/t5551-http-fetch.sh
> @@ -119,7 +119,7 @@ test_expect_success 'redirects re-root further requests' '
>  
>  test_expect_success 'clone from password-protected repository' '
>  	echo two >expect &&
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git clone --bare "$HTTPD_URL/auth/smart/repo.git" smart-auth &&
>  	expect_askpass both user@host &&
>  	git --git-dir=smart-auth log -1 --format=%s >actual &&
> @@ -137,7 +137,7 @@ test_expect_success 'clone from auth-only-for-push repository' '
>  
>  test_expect_success 'clone from auth-only-for-objects repository' '
>  	echo two >expect &&
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
>  	expect_askpass both user@host &&
>  	git --git-dir=half-auth log -1 --format=%s >actual &&
> @@ -151,7 +151,7 @@ test_expect_success 'no-op half-auth fetch does not require a password' '
>  '
>  
>  test_expect_success 'redirects send auth to new location' '
> -	set_askpass user@host &&
> +	set_askpass user@host pass@host &&
>  	git -c credential.useHttpPath=true \
>  	  clone $HTTPD_URL/smart-redir-auth/repo.git repo-redir-auth &&
>  	expect_askpass both user@host auth/smart/repo.git
