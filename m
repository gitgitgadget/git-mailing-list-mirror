From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 28 Mar 2013 07:43:29 -0700
Message-ID: <7v38vfy48e.fsf@alter.siamese.dyndns.org>
References: <1364446721-13351-1-git-send-email-jkoleszar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 15:44:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULE3c-0002Fv-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 15:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab3C1Ond (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 10:43:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3C1Onc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 10:43:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F7A2A0CF;
	Thu, 28 Mar 2013 10:43:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q8s87oov4wIcGsr73YqrxXUCpFI=; b=FUEmwd
	oI1Hy3e92P9B+tqwuN4E5XWcUjOIr7rnk4fzIR3QQwkd7tEVl9bAtgiTGSML8zSr
	eRtKPBmPgYW84V2Na9+2r0mcldYkYlLqAcFiJBVZ5iz4Qr3czwnr8cB8VcAsv2kb
	swZC5AOH3+UcRaFnX2L31hanL5rrBT5pRgG/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MqMdYo1aHCS6P4+rje8VhALsOfeyKH3x
	AANdJ+LlC3iy/S240LHhbMr6z45o0VkBsM/XMlKpdGaX81Hdbp1tkFMaS/738ASC
	hgQ0nfNh2kIB4xTVN/jtcX4Oh9W8IoxKrL8iQ5vTllEE10MnpzF4jRwJ1pFnN/Nh
	6xpwg79vDQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84B6CA0CE;
	Thu, 28 Mar 2013 10:43:31 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E09A8A0CC; Thu, 28 Mar 2013
 10:43:30 -0400 (EDT)
In-Reply-To: <1364446721-13351-1-git-send-email-jkoleszar@google.com> (John
 Koleszar's message of "Wed, 27 Mar 2013 21:58:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBEEEC9E-97B5-11E2-BE9D-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219401>

John Koleszar <jkoleszar@google.com> writes:

> diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
> index b5d7fbc..5a19d61 100755
> --- a/t/t5561-http-backend.sh
> +++ b/t/t5561-http-backend.sh
> @@ -134,6 +134,10 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
>  ###
>  GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
>  POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
> +
> +###  namespace test
> +###
> +GET  /smart_namespace/repo.git/info/refs HTTP/1.1 200
>  EOF
>  test_expect_success 'server request log matches test results' '
>  	sed -e "
> diff --git a/t/t556x_common b/t/t556x_common
> index 82926cf..cb9eb9d 100755
> --- a/t/t556x_common
> +++ b/t/t556x_common
> @@ -120,3 +120,19 @@ test_expect_success 'http.receivepack false' '
>  	GET info/refs?service=git-receive-pack "403 Forbidden" &&
>  	POST git-receive-pack 0000 "403 Forbidden"
>  '
> +test_expect_success 'backend respects namespaces' '
> +	log_div "namespace test"
> +	config http.uploadpack true &&
> +	config http.getanyfile true &&
> +
> +	GIT_NAMESPACE=ns && export GIT_NAMESPACE &&

When other people want to enhance this test suite later, their tests
may not want the namespace contaminated with the environment
variable.  You would need to enclose from here to the end inside a
subshell or something.

> +	git push public master:master &&
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +		git for-each-ref | grep /$GIT_NAMESPACE/ >/dev/null
> +	) &&
> +
> +	git ls-remote public >exp &&  
> +	curl "$HTTPD_URL/smart_namespace/repo.git/info/refs" >act &&

Spell out "expect" and "actual".

For some unknwon reason, I am getting an HTTPD_URL at this point,
causing it to fail with:

    curl: (3) <url> malformed

> +	test_cmp exp act &&
> +	(grep /ns/ exp && false || true)

What does that last line even mean?  Both

	false && false || true
        true && false || true

will yield true.  Leftover from your debugging session?
