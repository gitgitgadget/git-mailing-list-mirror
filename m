From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Makefile: use curl-config to determine curl flags
Date: Mon, 28 Apr 2014 12:56:54 -0700
Message-ID: <xmqqtx9dp6rd.fsf@gitster.dls.corp.google.com>
References: <1398713704-15428-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:57:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Werfo-0003zs-M5
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933301AbaD1T5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:57:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932750AbaD1T47 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:56:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E79C5816A8;
	Mon, 28 Apr 2014 15:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pbs0oxtYq856tBpf+xcVM6886mE=; b=RxTIMW
	8S1jaPyAgDW9oM6S7dnIUXZYZ7dZdAj4xwkIMiBSIEBShlEo8EALg8q3AV6y3OJr
	ohrhjF5nOXwEcNZhpiKtj208qVbQUpMa68vxww2LdlMcc9jdkCTF/XmVLVGUEX0C
	NoifOnlgKzHCXISpiXh5fUQmHVprdju78k3us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nleB0O36D708WZJXjG+MbfrgN+FQ/svS
	hzd4JReEsPouvKOtHqMt1OJLi8Drh+eAm23OM3tsDe1/6m3KUkDmHGG812f2QCd5
	mqv0fe5k80WCltwDJe87g9IX9mOrVjeATqDN6xryouWxVgYTc9Jp1k470j5JPwjH
	V/bCAMvqFCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C35B0816A7;
	Mon, 28 Apr 2014 15:56:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2267B816A1;
	Mon, 28 Apr 2014 15:56:56 -0400 (EDT)
In-Reply-To: <1398713704-15428-1-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Mon, 28 Apr 2014 12:35:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 405366C4-CF0F-11E3-B32F-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247429>

Dave Borowitz <dborowitz@google.com> writes:

> Use this only when CURLDIR is not explicitly specified, to continue
> supporting older builds. Moreover, if CURL_CONFIG is unset or running
> it returns no results (e.g. because it is missing), default to the old
> behavior of blindly setting -lcurl.
>  	ifdef CURLDIR
> +		CURL_LIBCURL=
>  	else
> +		CURL_CONFIG ?= curl-config
> +		ifeq "$(CURL_CONFIG)" ""
> +			CURL_LIBCURL =
> +		else
> +			CURL_LIBCURL := $(shell $(CURL_CONFIG) --libs)
>  		endif

This "ifeq" is redundant and will never set CURL_LIBCURL to empty
without running the "else" part, I think.  In a Makefile, a variable
explicitly set to empty and a variable that is unset are treated the
same.

	$ cat >Makefile <<EOF
	CURL_CONFIG ?= curl-config
	ifeq "$(CURL_CONFIG)" ""
		X=Empty
	else
		X=NotEmpty
	endif

	ifdef "$(CURL_CONFIG)"
		Z=Defined
	else
		Z=Undefined
	endif

	all::
		@echo "$(X) $(Z)"
	EOF
	$ make -f Makefile CURL_CONFIG=""
	Empty Undefined

That does not mean the patch will give us a broken behaviour,
though.  It just means the ifeq/else part will be redundant.

>  	endif
> +
> +	ifeq "$(CURL_LIBCURL)" ""

This will catch the "$(shell $(CURL_CONFIG) --libs) assigned an
empty string to CURL_LIBCURL" case, so the result is good.

I haven't checked what it would look like if we turn this into an
incremental patch to be applied on top of 'master' (which would give
us a place to document better why we do not rely on the presense of
curl-config), but if we can do so, that would be more preferable
than having to revert the merge of the previous one and then
applying these two patches anew.

Thanks.

> +		ifdef CURLDIR
> +			# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
> +			BASIC_CFLAGS += -I$(CURLDIR)/include
> +			CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
> +		else
> +			CURL_LIBCURL = -lcurl
> +		endif
> +		ifdef NEEDS_SSL_WITH_CURL
> +			CURL_LIBCURL += -lssl
> +			ifdef NEEDS_CRYPTO_WITH_SSL
> +				CURL_LIBCURL += -lcrypto
> +			endif
> +		endif
> +		ifdef NEEDS_IDN_WITH_CURL
> +			CURL_LIBCURL += -lidn
> +		endif
> +	else
> +		BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
>  	endif
>  
>  	REMOTE_CURL_PRIMARY = git-remote-http$X
