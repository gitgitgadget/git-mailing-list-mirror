Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E960420988
	for <e@80x24.org>; Tue, 18 Oct 2016 17:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760629AbcJRRPR (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 13:15:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58415 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756000AbcJRRPP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 13:15:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 486CB4765C;
        Tue, 18 Oct 2016 13:15:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RRjB8M8aQBKUixa2okG5RwzptGo=; b=GgO+a+
        GwQNJTzDoD/BGT7TBXLetMA9ms5wpsMI/CnOqVlzJJBTLSd53In7vcoJQjV83huP
        a51PihSFya15zjrg/fVgOGk8mnZofE/NBGqttdSzXv1KSAlN41yC3eIA5wMZUmFk
        yYw84enxg27lxRwDIIuOtvjp2Cr5Yth2qKEr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vxb29pEjcDqeAvGTYw581EqYwNQzweUr
        yetp7KJhk7HIlIPnZhqug6BbpyecqFc2kXIdFlmROZ9oerY4spXnIXF+IUksg16t
        5hrLSx1qXxl6XCjUWrt8OJc3X7H7l5MLElOZg1kOm+1CFY03PpBCren29UPZq2Lm
        f7chWLOXd0Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F64947659;
        Tue, 18 Oct 2016 13:15:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C99F47654;
        Tue, 18 Oct 2016 13:15:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     j6t@kdbg.org, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        venv21@gmail.com, dennis@kaarsemaker.net, jrnieder@gmail.com
Subject: Re: [PATCH] submodule--helper: normalize funny urls
References: <20161017221623.7299-1-sbeller@google.com>
        <xmqqbmyisiae.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 18 Oct 2016 10:15:10 -0700
In-Reply-To: <xmqqbmyisiae.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 17 Oct 2016 15:49:13 -0700")
Message-ID: <xmqqr37dpoip.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E092A9E-9556-11E6-8407-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +static void strip_url_ending(char *url, size_t *_len)
>> +{
>> +	int check_url_stripping = 1;
>> +	size_t len = _len ? *_len : strlen(url);
>> +
>> +	while (check_url_stripping) {
>> +		check_url_stripping = 0;
>> +		if (is_dir_sep(url[len-2]) && url[len-1] == '.') {
>
> This is "strip /. at the end" it seems.
>
> Does anything in the loop control guarantees 2 <= len at this point?
>
>> +			url[len-2] = '\0';
>> +			len -= 2;
>> +			check_url_stripping = 1;
>> +		}
>> +
>> +		if (is_dir_sep(url[len-1])) {
>
> This is "strip / at the end" it seems.
>
> Does anything in the loop control guarantees 1 <= len at this point?
>
>> +			url[len-1] = '\0';
>> +			len--;
>> +			check_url_stripping = 1;
>> +		}
>> +	}

I also somehow find the "check-url-stripping" variable ugly.

	while (URL still has something that could be stripped) {
		if (ends with "/.") {
			strip "/.";
			continue;
		}
		if (ends with "/") {
			strip "/";
			continue;
		}
		break;
	}

perhaps?
