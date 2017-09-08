Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB30520286
	for <e@80x24.org>; Fri,  8 Sep 2017 00:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdIHAdq (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 20:33:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61301 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751689AbdIHAdn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 20:33:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89959ADEF8;
        Thu,  7 Sep 2017 20:33:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cK5OpxGxc5QVWaYwDs8eYSRu7Ck=; b=fEXwj5
        G2wGvdxbWNUHHIVEQ/RtUj0Yi8fPMosOfzsaUDb65CM3K1U0Os0SCkwYZ2gwIOlI
        /lB2lYF77P55hzduWjEsElScD5VqEAeYzob59NhR5uIcsbpuLpOIVO0vJmaqzeGI
        z+xuV4kGQ0OVm9mZPNEAOCsxT7SVCnRmBxYKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JyFk7jHC86Dnr9g+PE2yJ0NcgxWueOoF
        oHg+eu2T/F0SwAPnIvpb/1wFLVyHK2n4teTVkpd6gncYzNIRQ8R8Iny7XuFhgCh8
        FfPTXfWpUfOK/K4lBkf/D4lsOSHAQQJJh3ayJgFhpm1esMoKv2e2XXNfHnkk35uK
        WkVdE/KkSiQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 813A4ADEF7;
        Thu,  7 Sep 2017 20:33:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E10B6ADEF6;
        Thu,  7 Sep 2017 20:33:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rene Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 27/34] shortlog: release strbuf after use in insert_one_record()
References: <20170830175005.20756-1-l.s.r@web.de>
        <20170830180037.20950-1-l.s.r@web.de>
        <20170830180037.20950-8-l.s.r@web.de>
        <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
        <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net>
Date:   Fri, 08 Sep 2017 09:33:38 +0900
In-Reply-To: <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 7 Sep 2017 00:33:54 -0400")
Message-ID: <xmqqzia61125.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C329342-942D-11E7-AB3C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 07, 2017 at 04:51:12AM +0900, Junio C Hamano wrote:
>
>> > diff --git a/builtin/shortlog.c b/builtin/shortlog.c
>> > index 43c4799ea9..48af16c681 100644
>> > --- a/builtin/shortlog.c
>> > +++ b/builtin/shortlog.c
>> > @@ -50,66 +50,67 @@ static int compare_by_list(const void *a1, const void *a2)
>> >  static void insert_one_record(struct shortlog *log,
>> >  			      const char *author,
>> >  			      const char *oneline)
>> >  {
>> > ...
>> >  	item = string_list_insert(&log->list, namemailbuf.buf);
>> > +	strbuf_release(&namemailbuf);
>> 
>> As log->list.strdup_strings is set to true in shortlog_init(),
>> namemailbuf.buf will leak without this.
>> 
>> An alterative, as this is the only place we add to log->list, could
>> be to make log->list take ownership of the string by not adding a
>> _release() here but instead _detach(), I guess.
>
> I agree that would be better, but I think it's a little tricky. The
> string_list_insert() call may make a new entry, or it may return an
> existing one. We'd still need to free in the latter case. I'm not sure
> the string_list interface makes it easy to tell the difference.

True; I do not think string_list API does.  But for this particular
application, I suspect that we can by looking at the util field of
the item returned.  A newly created one has NULL, but we always make
it non-NULL before leaving this function.

>> It is also curious that at the end of shortlog_output(), we set the
>> log->list.strdup_strings again to true immediately before calling
>> string_list_clear() on it.  I suspect that is unnecessary?
>
> I think so. I was curious whether I might have introduced this weirdness
> when I refactored this code a year or so ago. But no, it looks like it
> dates all the way back to the very first version of shortlog.c.

Hmph.
