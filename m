From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Wed, 03 Apr 2013 11:04:00 -0700
Message-ID: <7vfvz75w4v.fsf@alter.siamese.dyndns.org>
References: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
 <1365004329-15264-1-git-send-email-jkoleszar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Jeff King <peff@peff.net>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 20:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNS30-0000wx-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 20:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762953Ab3DCSEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 14:04:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762890Ab3DCSEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 14:04:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D023129B6;
	Wed,  3 Apr 2013 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GV0SHauyLTBTioGFrHl2kccV3n8=; b=Guxkw7
	9mxAiJYUOm+qcMUBJqsK3VPNSu9dtL/fOMknQiKKG+wXWfyU6MIOX2dz0Dx68OIg
	2Rq10jV0oHtY2YbvS+dnWh5IiN09nK43F6XKEjmlyF9dAHOdu1rgKmHqRCcRMFg/
	vrtZECayMPBGeLuERTJaqzuWVRFCoAuxfhKNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WUD3mfFzRRTQB8qSAv815U8XjyZmdT3s
	xrUd6nJFvPDm7YzVW8Y0jHOGI8UC8r/AyiOEaL8gKu/Qp3AO9fYA9o1KR+aMKJ2h
	2uIJM76pZRvJTSIBtBTBMWNIbZyVdunoVZOtKI+kTECH7LlmEe+Ty6kxAm6mbXm2
	j8uwQwfCqT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5231F129B5;
	Wed,  3 Apr 2013 18:04:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BC59129B3; Wed,  3 Apr
 2013 18:04:02 +0000 (UTC)
In-Reply-To: <1365004329-15264-1-git-send-email-jkoleszar@google.com> (John
 Koleszar's message of "Wed, 3 Apr 2013 08:52:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDDFDFF4-9C88-11E2-9A9A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219956>

John Koleszar <jkoleszar@google.com> writes:

> diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
> index b5d7fbc..97f97a1 100755
> --- a/t/t5561-http-backend.sh
> +++ b/t/t5561-http-backend.sh
> @@ -23,6 +23,10 @@ GET() {
>  	test_cmp exp act
>  }
>  
> +GET_BODY() {
> +	curl "$HTTPD_URL/$SMART/repo.git/$1"
> +}
> +
>  POST() {
>  	curl --include --data "$2" \
>  	--header "Content-Type: application/x-$1-request" \
> @@ -134,6 +138,13 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
>  ###
>  GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
>  POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
> +
> +###  namespace test
> +###
> +GET  /smart/repo.git/info/refs HTTP/1.1 200
> +GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
> +GET  /smart_namespace/repo.git/info/refs HTTP/1.1 200
> +GET  /smart_namespace/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
>  EOF
>  test_expect_success 'server request log matches test results' '
>  	sed -e "
> diff --git a/t/t556x_common b/t/t556x_common
> index 82926cf..6c34f33 100755
> --- a/t/t556x_common
> +++ b/t/t556x_common
> @@ -120,3 +120,28 @@ test_expect_success 'http.receivepack false' '
>  	GET info/refs?service=git-receive-pack "403 Forbidden" &&
>  	POST git-receive-pack 0000 "403 Forbidden"
>  '
> +test_expect_success 'backend respects namespaces' '(

A blank line before this new test would be easier to read.


> +	log_div "namespace test"
> +	config http.uploadpack true &&
> +	config http.getanyfile true &&
> +
> +	NS=ns &&
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +		git update-ref refs/namespaces/$NS/refs/heads/master HEAD
> +	) &&
> +
> +	SMART=smart
> +	git ls-remote public >expected &&  
> +	grep /$NS/ expected >/dev/null &&

The standard output is not shown while running tests without "-v",
and matches like these are useful while diagnosing what went wrong,
so there is no upside in sending it to >/dev/null in general.

> +	GET_BODY "info/refs" >actual &&
> +	test_cmp expected actual &&
> +	GET_BODY "info/refs?service=git-upload-pack" | grep /$NS/ >/dev/null &&

Can GET_BODY fail for some reason with non-zero status (perhaps the
backend by mistake barfs, refuses to serve that request and dies)?
It does not sounds like a good idea to hide that status behind a pipe.

> +	SMART=smart_namespace &&
> +	GIT_NAMESPACE=$NS && export GIT_NAMESPACE &&
> +	git ls-remote public >expected &&  
> +	! grep /$NS/ expected>/dev/null &&

Is it sufficient to make sure that GIT_NAMESPACE hides /ns/ from the
advertisement and not test that everything in that namespace is
actually shown?

> +	GET_BODY "info/refs" >actual &&
> +	test_cmp expected actual &&
> +	! (GET_BODY "info/refs?service=git-upload-pack" | grep /$NS/ >/dev/null)

Likewise, also for the pipe.  If GET_BODY died and failed to produce
any output, we would certainly not see /ns/ in its output and the
test will pass.

> +)'
