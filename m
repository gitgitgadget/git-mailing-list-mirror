From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] http: Add Accept-Language header if possible
Date: Wed, 03 Dec 2014 10:22:20 -0800
Message-ID: <xmqqfvcwiof7.fsf@gitster.dls.corp.google.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
	<1417522356-24212-1-git-send-email-eungjun.yi@navercorp.com>
	<1417522356-24212-2-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 19:22:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwEZL-0006uZ-Iz
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 19:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbaLCSW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 13:22:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750891AbaLCSW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 13:22:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3746922CE0;
	Wed,  3 Dec 2014 13:22:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hDdAtQbYmP1K4b5vQ1kGoPHxC+g=; b=GoThiD
	U1OTnrll1c5fnF5U7IoAsRCO1NEbLEVtVMuZuXnGVF9EuIa4eBgtnlvkvMXHJg/X
	ohLrFDkB3dUN4icawquIfNaB12qn7mwrM/8wJ2Y5EN8b20JVvXQOLd/vkf0PIHdy
	qx4XF/GLtKSo7fdfv2dU7EBfVo/yhNFAT/+rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LtLDtojh8SLCaC9Ir8Q0wx7cc0SK522T
	qwc7eDZ+3NWw49Zuhi9rGDUoxsv+uoXvYe4bPGToNZ1uHIWxFuU+a6YNiITHQriW
	JBvfwZJ4yVGwUcemqiTthtHTn5U/W14ar4eVlmQHhD6wv+NHP13a4AhkQ3kojMKv
	IaNU3/+8pXk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E04022CDF;
	Wed,  3 Dec 2014 13:22:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FB4422CD9;
	Wed,  3 Dec 2014 13:22:21 -0500 (EST)
In-Reply-To: <1417522356-24212-2-git-send-email-eungjun.yi@navercorp.com> (Yi
	EungJun's message of "Tue, 2 Dec 2014 21:12:36 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 528CA75E-7B19-11E4-8A27-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260676>

Yi EungJun <semtlenori@gmail.com> writes:

> From: Yi EungJun <eungjun.yi@navercorp.com>
>
> Add an Accept-Language header which indicates the user's preferred
> languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.
>
> Examples:
>   LANGUAGE= -> ""
>   LANGUAGE=ko:en -> "Accept-Language: ko, en;q=0.9, *;q=0.1"
>   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *;q=0.1"
>   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *;q=0.1"
>
> This gives git servers a chance to display remote error messages in
> the user's preferred language.
>
> Limit the number of languages to 1,000 because q-value must not be
> smaller than 0.001, and limit the length of Accept-Language header to
> 4,000 bytes for some HTTP servers which cannot accept such long header.
>
> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
> ---
>  http.c                     | 154 +++++++++++++++++++++++++++++++++++++++++++++
>  remote-curl.c              |   2 +
>  t/t5550-http-fetch-dumb.sh |  31 +++++++++
>  3 files changed, 187 insertions(+)
>
> diff --git a/http.c b/http.c
> index 040f362..69624af 100644
> --- a/http.c
> +++ b/http.c
> @@ -68,6 +68,8 @@ static struct curl_slist *no_pragma_header;
>  
>  static struct active_request_slot *active_queue_head;
>  
> +static struct strbuf *cached_accept_language;
> +
>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
>  	size_t size = eltsize * nmemb;
> @@ -515,6 +517,9 @@ void http_cleanup(void)
>  		cert_auth.password = NULL;
>  	}
>  	ssl_cert_password_required = 0;
> +
> +	if (cached_accept_language)
> +		strbuf_release(cached_accept_language);

Is this correct?

You still keep cached_accept_language pointer itself, so the next
call to get_accept_language() would say "Ah, cached_accept_language
is there, so its contents (which is empty because we released it
here) must be valid and to be reused".  Perhaps you want to free it,
too, i.e.

	if (cached_accept_language) {
		strbuf_release(cached_accept_language);
                free(cached_accept_language);
                cached_accept_language = NULL;
	}

or something?

> +static struct strbuf *get_accept_language(void)
> +{
> + ...
> +	if (cached_accept_language)
> +		return cached_accept_language;
> +
> +	cached_accept_language = xmalloc(sizeof(struct strbuf));
> + ...
> +	for (max_q = 1, decimal_places = 0;
> +		max_q < num_langs;
> +		decimal_places++, max_q *= 10);

Have that "empty statement" on its own separate line, i.e.

	for (a, counter = 0;
             b;
             c, counter++)
             ; /* just counting */

Alternatively, you can make it more obvious that the purpose of loop
is to count, i.e.

	for (a, counter = 0;
             b;
             c)
             counter++;

> +test_expect_success 'git client does not send Accept-Language' '
> +	test_must_fail env GIT_CURL_VERBOSE=1 LANGUAGE= git clone "$HTTPD_URL/accept/language" 2>stderr &&
> +	! grep "^Accept-Language:" stderr
> +'

Hmph, this test smells a bit brittle.  What is the reason you expect
"git clone" to fail?  Is it because there is no repository at the
named URL at "$HTTPD_URL/accept/language"?  Is that the only plausible
reason for a failure?

It might be better to use the URL to a repository that is expected
to be served by the server started in this test and expect success.
If it bothers you that "clone" creates a new copy that is otherwise
unused by this test, you can use something like "ls-remote" instead,
I would think.
