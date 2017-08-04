Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA722047F
	for <e@80x24.org>; Fri,  4 Aug 2017 19:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbdHDTKD (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 15:10:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50728 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751343AbdHDTKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 15:10:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71B9E9C75C;
        Fri,  4 Aug 2017 15:09:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Av931ek1L6vMh8wwUGtVUOW8YXg=; b=gJRxe4
        DJw38MtKenSIvYcZpSPeXWekIer/gO4Jj5CiaQHbWKgkSPeDDp7TZf7p8NBUqPKp
        VynEn4m4v5aaS1gNDHunyeNUm0HxnECiT2j+5taIxuszvVdhXjXzCWA6lR7CZVVC
        dUQT+7lBY5gG/gozG4O+uw8/R5eMDTq38aI84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AKzB6yfE4rLzwzGWNprPFfQQ6cT/nGOR
        WbWpo/9k73jcGcJ4tl3OIrbRXRF9T62oVmnGvC0uqE1XDNpwcYYkfc8Oymv7L04p
        tpqWMqoxQZODtxyjcKEKm/5L4z1qVdytR9RxlfIqrBhfvTMQhllrhKPrDkfyOu2M
        a1JOr8WhRyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68C879C75B;
        Fri,  4 Aug 2017 15:09:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B94D79C75A;
        Fri,  4 Aug 2017 15:09:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFC] imap-send: escape backslash in password
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
Date:   Fri, 04 Aug 2017 12:09:52 -0700
In-Reply-To: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Fri, 4 Aug 2017 18:16:53
        +0200")
Message-ID: <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F425214-7948-11E7-964B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> Password containing backslashes need to have them doubled to have them properly interpreted by the imap server.

Please wrap this into lines with reasonable lengths like 72 cols.

Is the quoting rules documented somewhere?  If so, please also give
a reference to it here.  RFC3501 "6.2.3 LOGIN Command" does not say
much (other parts of the RFC may specify the rules that apply to
arguments in general, but I didn't look for them).  Without such
reference, it is hard to judge if this change is sufficient or even
correct (in an extreme case, the IMAP server you are talking with
that prompted you to make this change might be in violation).

For example, FRC3501 "9. Formal Syntax" says that both "password"
and "userid" are "astring"; it looks strange that the code with this
patch only touches cred.password while sending cred.username as-is.

> +static char* imap_escape_password(const char *passwd)

In our codebase, asterisk sticks to identifier, not typename.  I.e.

	static char *imap_escape(...)

> +{
> +	const unsigned passwd_len = strlen(passwd);
> +	char *escaped = xmalloc(2 * passwd_len + 1);
> +	const char *passwd_cur = passwd;
> +	char *escaped_cur = escaped;
> +
> +	do {
> +		char *next = strchr(passwd_cur, '\\');
> +
> +		if (!next) {
> +			strcpy(escaped_cur, passwd_cur);
> +		} else {
> +			int len = next - passwd_cur + 1;
> +
> +			memcpy(escaped_cur, passwd_cur, len);
> +			escaped_cur += len;
> +			next++;
> +			*(escaped_cur++) = '\\';
> +		}
> +		passwd_cur = next;
> +	} while(passwd_cur);
> +
> +	return escaped;
> +}

I wonder if we should use strbuf here perhaps like so:

	struct strbuf encoded = STRBUF_INIT;
	const char *p;

	for (p = passwd; *p; p++) {
		if (need_bs_quote(*p))
			strbuf_addch(&encoded, '\\');
		strbuf_addch(&encoded, *p);
	}
	return strbuf_detach(&encoded, NULL);

>  static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
>  {
>  	struct credential cred = CREDENTIAL_INIT;
> @@ -1090,7 +1116,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
>  			if (!srvc->user)
>  				srvc->user = xstrdup(cred.username);
>  			if (!srvc->pass)
> -				srvc->pass = xstrdup(cred.password);
> +				srvc->pass = imap_escape_password(cred.password);
>  		}
>  
>  		if (srvc->auth_method) {

Thanks.
