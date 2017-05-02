Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8B6207D6
	for <e@80x24.org>; Tue,  2 May 2017 03:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdEBDmg (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 23:42:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34047 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdEBDmg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 23:42:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id g23so30318600pfj.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 20:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OG7XbnnpAY3GfkUWgASXB8G/w329+DdCxQeSG/1uupk=;
        b=mnUOiR0QQNAIB9jF2rgu5fEn830qHfyvjWbYVwt4VS1qs/zD/7ofYWvdhI1gTTkUKR
         f6rW9Dq3wLUeA8PUE/Un3XfdcBnrmZtYthPzTEhDk1XDEQTGksaRdFLfxBSLS162EX60
         gvSI1wvCzc7Vq2ZT4Zm3RJRXYchdPVzyf4HcZg6Jm0M5iz0/NatPcHhFQGq9gjbrOKOR
         q4X632yJL6GflmLWmhmGR68aqEroO5CqSzAwuNs+z8BXKQYPAiE1zd73vki11JK0dkbR
         yt67YOu8kdvLfufShy0up3ujvr/kBSD8mCfuJMaSDAppmMiTdKDboCiHX4KicGeIZNY+
         qldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OG7XbnnpAY3GfkUWgASXB8G/w329+DdCxQeSG/1uupk=;
        b=sneSK93a8i4Af3yDHMpkZlVWesqc0+K3Nf8A7fghd4PqZB1uEptXya0ui9nN+OBady
         0R6cCl1HY9D7U/6N5LT5+tReObCqkCYN0OEHigVPqGt0mLC/lr7ACMkQt1G9ss0b1C2r
         mvXU15dV33AytC8JRkUaxKXajlip/Jox7xQbgkxlXhMa8exAfrxxpR5jzrNqnlD0UsmU
         8aQtBu1lEwKlubbuufIfoideXN5dYFyshyFg2ukiERof0e9Zr2tPXHBS1u51qOinIRhk
         eET/9R1pvZGYfOQmR+6eJ1204dTOj98xTUeXQO2UDCWvCIWHG55Zi0PPb25x4HwC3QdB
         uYEA==
X-Gm-Message-State: AN3rC/5/VHo9XkkJykb9Y9LhdWGB10E8FkE9sykMpn5D4sqQsmzmYfnn
        7W6T+vPF+UAFmw==
X-Received: by 10.84.231.16 with SMTP id f16mr37443721plk.58.1493696555378;
        Mon, 01 May 2017 20:42:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id w85sm26933588pfk.62.2017.05.01.20.42.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 20:42:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 23/25] name-rev: avoid leaking memory in the `deref` case
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <cover.1493387231.git.johannes.schindelin@gmx.de>
        <9e897d6f263bcf9a2b2bab613946fe1bf452eb91.1493387231.git.johannes.schindelin@gmx.de>
        <xmqqd1bsdjmw.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 01 May 2017 20:42:33 -0700
In-Reply-To: <xmqqd1bsdjmw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 01 May 2017 20:26:15 -0700")
Message-ID: <xmqq8tmfexg6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> When the `name_rev()` function is asked to dereference the tip name, it
>> allocates memory. But when it turns out that another tip already
>> described the commit better than the current one, we forgot to release
>> the memory.
>
> Very well explained.
>>
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index 92a5d8a5d26..a4ce73fb1e9 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -28,6 +28,7 @@ static void name_rev(struct commit *commit,
>>  	struct rev_name *name = (struct rev_name *)commit->util;
>>  	struct commit_list *parents;
>>  	int parent_number = 1;
>> +	char *p = NULL;
>>  
>>  	parse_commit(commit);
>>  
>> @@ -35,7 +36,7 @@ static void name_rev(struct commit *commit,
>>  		return;
>>  
>>  	if (deref) {
>> -		tip_name = xstrfmt("%s^0", tip_name);
>> +		tip_name = p = xstrfmt("%s^0", tip_name);

I'll rename 'p' to 'to_free' while queuing, though.  Without a
descriptive name, it was confusing to view while resolving conflicts
with another in-flight topic.
