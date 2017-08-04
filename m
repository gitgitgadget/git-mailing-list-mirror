Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892DF2047F
	for <e@80x24.org>; Fri,  4 Aug 2017 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdHDTcg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 4 Aug 2017 15:32:36 -0400
Received: from 7.mo64.mail-out.ovh.net ([46.105.63.1]:44372 "EHLO
        7.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdHDTcf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 15:32:35 -0400
X-Greylist: delayed 6961 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Aug 2017 15:32:34 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 6664C6ECE9;
        Fri,  4 Aug 2017 21:32:33 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 4 Aug
 2017 21:32:33 +0200
Subject: Re: [RFC] imap-send: escape backslash in password
To:     Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
 <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Message-ID: <90b60e41-f59f-a141-1c83-3605444333b4@morey-chaisemartin.com>
Date:   Fri, 4 Aug 2017 21:32:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX2.indiv2.local (172.16.2.2) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 14686519860265084893
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrjeehgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 04/08/2017 à 21:09, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:
>
>> Password containing backslashes need to have them doubled to have them properly interpreted by the imap server.
> Please wrap this into lines with reasonable lengths like 72 cols.

I haven't checked the coding style yet. This was a very quick try that I submitted to get some feedback on the approach.
WIll fix for next time though.

>
> Is the quoting rules documented somewhere?  If so, please also give
> a reference to it here.  RFC3501 "6.2.3 LOGIN Command" does not say
> much (other parts of the RFC may specify the rules that apply to
> arguments in general, but I didn't look for them).  Without such
> reference, it is hard to judge if this change is sufficient or even
> correct (in an extreme case, the IMAP server you are talking with
> that prompted you to make this change might be in violation).
>
> For example, FRC3501 "9. Formal Syntax" says that both "password"
> and "userid" are "astring"; it looks strange that the code with this
> patch only touches cred.password while sending cred.username as-is.

Didn't found a RFC doc on this. I hit the bug today and looking at the error message, found a few people who add the issue with different client and required escaping backslashes
It probably applies to the username (would be logicial that both string in the line are parsed the same way) not sure if backslashes are allowed in username though.
With password generator, they are more likely to be there.
But it wouldn't hurt to use the escape function for both.

>> +static char* imap_escape_password(const char *passwd)
> In our codebase, asterisk sticks to identifier, not typename.  I.e.
>
> 	static char *imap_escape(...)
Will do. BTW, is there a checkpatch or similar for git ?
Scrolled quickly through the doc and did not see any reference.

>
>> +{
>> +	const unsigned passwd_len = strlen(passwd);
>> +	char *escaped = xmalloc(2 * passwd_len + 1);
>> +	const char *passwd_cur = passwd;
>> +	char *escaped_cur = escaped;
>> +
>> +	do {
>> +		char *next = strchr(passwd_cur, '\\');
>> +
>> +		if (!next) {
>> +			strcpy(escaped_cur, passwd_cur);
>> +		} else {
>> +			int len = next - passwd_cur + 1;
>> +
>> +			memcpy(escaped_cur, passwd_cur, len);
>> +			escaped_cur += len;
>> +			next++;
>> +			*(escaped_cur++) = '\\';
>> +		}
>> +		passwd_cur = next;
>> +	} while(passwd_cur);
>> +
>> +	return escaped;
>> +}
> I wonder if we should use strbuf here perhaps like so:
>
> 	struct strbuf encoded = STRBUF_INIT;
> 	const char *p;
>
> 	for (p = passwd; *p; p++) {
> 		if (need_bs_quote(*p))
> 			strbuf_addch(&encoded, '\\');
> 		strbuf_addch(&encoded, *p);
> 	}
> 	return strbuf_detach(&encoded, NULL);

I looked at the wrappers and wasn't sure if they were to be used for this (one of the main reason this is an RFC).
I guess it would make sense. I'm not familiar with git code, but is there other escape function of this kind that could be factor ?
Or the function is simple enough not to be worth it ?

Thanks

Nicolas

