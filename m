Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53EBC433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 19:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387017AbiEBTIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387033AbiEBTIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 15:08:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8171B871
        for <git@vger.kernel.org>; Mon,  2 May 2022 12:04:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91D96137B38;
        Mon,  2 May 2022 15:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YKcyfKHvND1gyRnjrLK/zry+7mrxRmVcuVkgo6
        rRz0A=; b=fKsKESRYbbc2MCVnKHLM8srSM9ORN2vA+EExms+/21ITlgOevwgzyn
        XUh+CfoeuCdW5p04qwAcpOrkMncksZicSiMcNk2LoxYMovlb6nZREreHnK7eAsQY
        auiE1KBNSQOYos9uJpwu6RILR7Cix8tOQ1zCPV3GaqDdmFwb99Eas=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89785137B37;
        Mon,  2 May 2022 15:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6010137B36;
        Mon,  2 May 2022 15:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: Re: [PATCH] http: add custom hostname to IP address resolves
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
Date:   Mon, 02 May 2022 12:04:42 -0700
In-Reply-To: <20220502083639.610279-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 2 May 2022 10:36:39 +0200")
Message-ID: <xmqqfslrycvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA0F3B8E-CA4A-11EC-9344-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Subject: Re: [PATCH] http: add custom hostname to IP address resolves

I can guess what you means, but I am not able to quite parse the
above.  I guess the phrase that makes me hiccup when I read is
"resolve" used as a noun.

> Libcurl has a CURLOPT_RESOLVE easy option that allows
> hostname resolve information in the following form to

The same here, "... allows the result of hostname resolution in the
following format ...", perhaps?

> be passed:
>
> 	[+]HOST:PORT:ADDRESS[,ADDRESS]
>
> This way, redirects and everything operating against the
> HOST+PORT will use the provided ADDRESS(s).
>
> The following form is also allowed to stop using these
> resolves:
>
> 	-HOST:PORT

The above is a reasonable summary of CURLOPT_RESOLVE documentation
that is appropriate to have here for those of us who are not
familiar with it.  For those of us who may want to learn more, it
would help to have an URL to the canonical documentation page, e.g.
https://curl.se/libcurl/c/CURLOPT_RESOLVE.html but it is not
required.  People should be able to find it easily.

> Let's add a corresponding "http.hostResolve" config
> option that takes advantage of CURLOPT_RESOLVE.

CURLOPT_RESOLVE allows us to feed cURL a list of these <host,port>
-> <address> mappings, so we use that mechansim to feed the values
listed on the multi-valued configuration variable (spell it out as
such, by the way, instead of saying "config option", which may give
a false impression that it is a last-one-wins single string with
many such mapping entries on it).

OK.

> Each value configured for the "http.hostResolve" key
> is passed "as is" to curl through CURLOPT_RESOLVE, so it
> should be in one of the above 2 forms. This keeps the
> implementation simple and makes us consistent with
> libcurl's CURLOPT_RESOLVE, and with curl's corresponding
> `--resolve` command line option.

OK.

> I am not sure if some tests could/should be added. Ideas about how to
> test this are welcome.

It should.  Perhaps invent a totally bogus domain name, map that to
localhost ::1, run a test server locally, and try to clone from that
bogus domain?

> +http.hostResolve::

Is "host" a good prefix for it?  

In the context of HTTP(s), if there is no other thing than host that
we resolve, "http.resolve" may be sufficient.  For those who are
looking for CURLOPT_RESOLVE equivalent, "http.curloptResolve" may
make it easier to find.

> +	Hostname resolve information that will be used first when sending
> +	HTTP requests.  This information should be in one of the following
> +	forms:
> +
> +	- [+]HOST:PORT:ADDRESS[,ADDRESS]
> +	- -HOST:PORT
> +
> ++
> +The first form redirects all requests to the given `HOST:PORT`
> +to the provided `ADDRESS`(s). The second form clears all previous
> +config values for that `HOST:PORT` combination.  To allow easy
> +overriding of all the settings inherited from the system config,
> +an empty value will reset all resolve information to the empty
> +list.

If I understand your use case correctly, this is not something you
would want to hardcode in your configuration files for long term, is
it?  I am wondering if we want to mention the expected use case here
as well, something like

    This is designed to be used primarily from the command line
    configuration variable override, e.g.

	$ git -c http.resolve=example.com:443:127.0.0.1 \
	    clone https://example.com/user/project.git

perhaps?  Not a suggestion, but soliciting thoughts.

> diff --git a/http.c b/http.c
> index 229da4d148..e9cc46ee52 100644
> --- a/http.c
> +++ b/http.c
> @@ -128,6 +128,9 @@ static struct curl_slist *pragma_header;
>  static struct curl_slist *no_pragma_header;
>  static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
>  
> +static struct curl_slist *host_resolves;
> +static struct string_list http_host_resolve = STRING_LIST_INIT_DUP;
> +
>  static struct active_request_slot *active_queue_head;
>  
>  static char *cached_accept_language;
> @@ -393,6 +396,17 @@ static int http_options(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.hostresolve", var)) {
> +		if (!value) {
> +			return config_error_nonbool(var);
> +		} else if (!*value) {
> +			string_list_clear(&http_host_resolve, 0);


OK, this is a way to "clear" the list of entries accumulated on this
multi-valued configuration variable so far.  And it is documented in
the above, too.  Good.

> +		} else {
> +			string_list_append(&http_host_resolve, value);
> +		}
> +		return 0;
> +	}
> +
>  	if (!strcmp("http.followredirects", var)) {
>  		if (value && !strcmp(value, "initial"))
>  			http_follow_config = HTTP_FOLLOW_INITIAL;
> @@ -985,6 +999,17 @@ static void set_from_env(const char **var, const char *envname)
>  		*var = val;
>  }
>  
> +static struct curl_slist *http_copy_host_resolve(void)
> +{
> +	struct curl_slist *hosts = NULL;
> +	const struct string_list_item *item;
> +
> +	for_each_string_list_item(item, &http_host_resolve)
> +		hosts = curl_slist_append(hosts, item->string);
> +
> +	return hosts;
> +}
> +
>  void http_init(struct remote *remote, const char *url, int proactive_auth)
>  {
>  	char *low_speed_limit;
> @@ -1048,6 +1073,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	no_pragma_header = curl_slist_append(http_copy_default_headers(),
>  		"Pragma:");
>  
> +	host_resolves = http_copy_host_resolve();

This is curious.  I imagined that the reason why you keep the
original in a string_list and copy it to a curl_slist was perhaps
because you'll lose the latter every time you make a curl request,
but it does not appear to be the case.  You http_init() just once
and then the same CURL *curl instance will be reused until you clear
it with http_cleanup().  So I do not see offhand the need to have
the string_list at all.

Does it work equally well if you used curl_slist_append() in
http_options() and maintain ONLY the curl_slist version of the
host_resolve list?  That would make it unnecessary to keep
http_host_resolve and add http_copy_host_resolve() function, no?

Thanks.
