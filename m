Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01CA2036D
	for <e@80x24.org>; Sun, 26 Nov 2017 09:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbdKZJiJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 04:38:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58990 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752090AbdKZJiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 04:38:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A345B1493;
        Sun, 26 Nov 2017 04:38:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GCI/zRc6QNWsl8sLq1++HXi2Pag=; b=k7yUtS
        cnrO16J5EhZUr4RDU4j7vL1bE8Sbd04Up9QefPm60xJZ9raiUBlRZJEQZyYAx4yz
        X/5z1v5SSC3u2AR8wQh400N/yjUV42F422NZuw/IrAiNW6XPgjBzCY7EHieHEYCs
        VP0tzPNjA05Kg+VXpraEqfNTOSZkHZCgjkPYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tc9L3s3nuQozCRWSnjv24kNYsfoSVwAZ
        P6emItVLlv8KWjKb6BVly2fihtR2Ju9Z5VD1JopJBldbFreaQXE/vG1LAtAEZX/E
        6w74VFvALJ/2449DZTuGH0cOy7V6kIRkueqUnO/0EULYkjNulrO/XU4rVMYjhIIP
        dkKstxwwLPU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70678B1491;
        Sun, 26 Nov 2017 04:38:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1DD3B1490;
        Sun, 26 Nov 2017 04:38:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20171126015448.24111-1-max@max630.net>
        <20171126015448.24111-2-max@max630.net>
        <xmqqo9npitx7.fsf@gitster.mtv.corp.google.com>
        <20171126081329.GD26158@jessie.local>
Date:   Sun, 26 Nov 2017 18:38:06 +0900
In-Reply-To: <20171126081329.GD26158@jessie.local> (Max Kirillov's message of
        "Sun, 26 Nov 2017 10:13:30 +0200")
Message-ID: <xmqq3751idmp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82717318-D28D-11E7-9E2B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> I'm afraid I did not get the reasonsing and not fully the
> desired change. Is this http-backend code change (compared
> to the last patch) what you mean?

Exactly.  

The fact that the parsed string happens to come from CONTENT_LENGTH
environment variable is http's business, not parsers for various
types of values that come in the form of strings.

> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -346,9 +346,18 @@ static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **o
>  	}
>  }
>  
> +static ssize_t env_content_length()

We need s/length()/length(void)/; though.

> +{
> +	const char *str = getenv("CONTENT_LENGTH");
> +	ssize_t val = -1;
> +	if (str && !git_parse_ssize_t(str, &val))
> +		die("failed to parse CONTENT_LENGTH: %s", str);
> +	return val;
> +}
> +
>  static ssize_t read_request(int fd, unsigned char **out)
>  {
> -	ssize_t req_len = git_env_ssize_t("CONTENT_LENGTH", -1);
> +	ssize_t req_len = env_content_length();
>  	if (req_len < 0)
>  		return read_request_eof(fd, out);
>  	else
