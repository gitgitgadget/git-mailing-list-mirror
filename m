Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3631F424
	for <e@80x24.org>; Mon, 18 Dec 2017 22:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935607AbdLRWc0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 17:32:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62423 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935088AbdLRWcX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 17:32:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17EBAC6C4E;
        Mon, 18 Dec 2017 17:32:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qtbjxjFAXGlGu/aACyJveZ1wq/E=; b=EmlpU5
        sQkkRW2PBrepjbJlJ7UgUKVjm//hmcsc1nH2kIR3+m/CeM0bJDNYUJKs7vvuTk4k
        Qx13alM+qv+YsjfS9V4FM6HYI8j2GJIwwy/zeSuVP3toQ0R5183MOnEGnyAiNJad
        9SQBia9To0DEw0qC5m6RlIlwgv8GArDoju9fU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MbzNMrGcvMEskZcOJupfH1uS23d62Acr
        Bcy8qcOIgVHKc7pT3cav+T54daB8HN61ECzeq7Y0ep+ZD41bhZ239lYG48dxEUNe
        9+lr1tNzt4nVptY1cNhianOJFAuI0LEJmk/h1u9Iw/febmY5dOmTg0QljkIAv352
        RKEmmkCvb+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E6E3C6C4C;
        Mon, 18 Dec 2017 17:32:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76847C6C4B;
        Mon, 18 Dec 2017 17:32:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Doron Behar <doron.behar@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
Subject: Re: [PATCH v3] imap-send: URI encode server folder
References: <CAPig+cSOn8PV52aL0Ky5uUwFfNMWye93UQGioRiXjj0ze9HX+g@mail.gmail.com>
        <20171218191113.18600-1-kaartic.sivaraam@gmail.com>
Date:   Mon, 18 Dec 2017 14:32:20 -0800
In-Reply-To: <20171218191113.18600-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 19 Dec 2017 00:41:13 +0530")
Message-ID: <xmqq7etjy8ej.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50160EDE-E443-11E7-A8C2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> From: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
>
> When trying to send a patch using 'imap-send' with 'curl' and the
> following configuration:
>
> [imap]
> 	folder = "[Gmail]/Drafts"
> 	host = imaps://imap.gmail.com
> 	port = 993
> 	sslverify = false
>
> results in the following error,
>
>     curl_easy_perform() failed: URL using bad/illegal format or missing URL
>
> This is a consequence of not URI-encoding the folder portion of
> the URL which contains characters such as '[' which are not
> allowed in a URI. According to RFC3986, these characters should be
> URI-encoded.
>
> So, URI-encode the folder before adding it to the URI to ensure it doesn't
> contain characters that aren't allowed in a URI.
>
> Reported-by: Doron Behar <doron.behar@gmail.com>
> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> Changes in v3:
>     - updated commit message as suggested by Eric (convert past tense
>       to present tense) and added a few tweaks to it that striked me
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> Thanks for taking up the slack.
>
> You're welcome. It was easier than waiting for this patch to be
> updated so it could get into 'pu' ;-)

Looks good.  Thanks.


>  imap-send.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 54e6a80fd..36c7c1b4f 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1412,6 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>  {
>  	CURL *curl;
>  	struct strbuf path = STRBUF_INIT;
> +	char *uri_encoded_folder;
>  
>  	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
>  		die("curl_global_init failed");
> @@ -1429,7 +1430,12 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>  	strbuf_addstr(&path, server.host);
>  	if (!path.len || path.buf[path.len - 1] != '/')
>  		strbuf_addch(&path, '/');
> -	strbuf_addstr(&path, server.folder);
> +
> +	uri_encoded_folder = curl_easy_escape(curl, server.folder, 0);
> +	if (!uri_encoded_folder)
> +		die("failed to encode server folder");
> +	strbuf_addstr(&path, uri_encoded_folder);
> +	curl_free(uri_encoded_folder);
>  
>  	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
>  	strbuf_release(&path);
