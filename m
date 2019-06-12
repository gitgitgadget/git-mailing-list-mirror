Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C4E1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 21:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfFLVJ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 17:09:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65189 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFLVJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 17:09:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8F2C1535A5;
        Wed, 12 Jun 2019 17:09:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bZ8ayy/JtG7weHKQ7IJmwbvum3w=; b=ni8sQj
        GDjVa6rVElHi/XGxroVA4reVS0a7DjTt43wD5DCoEC8uo0Ml0t2oSNa/EYZ01PPL
        0n8u50uGar3egMWXuLv42yu9HZYRyMhP0VwiwHSgOZRuJ7pjPmfF0987qP7wBC9Y
        0Q4rjH2c2vnkLQOvBf+f80Y9SFIG8P5KsmCBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OL8TfQQ2pWop+R8yshH3JLOm3rTLzaOe
        JMsgoG3ZBeLcTRBbERZXZbLkRLlvI5hKrDeLnCgRrliZ4KR3POQfUuRECS7dbq3V
        0c9zX1p/tH+FEnBJ2yFpDfjEzgVT7ChU5m2nYHLnFgber7WU30Jz9N6EmGRpN2XZ
        65sGClJNAv4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DF521535A4;
        Wed, 12 Jun 2019 17:09:55 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EE3F1535A3;
        Wed, 12 Jun 2019 17:09:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/1] ref-filter: sort detached HEAD lines firstly
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
        <cover.1560277373.git.matvore@google.com>
        <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
        <xmqq7e9rlw72.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 12 Jun 2019 14:09:53 -0700
In-Reply-To: <xmqq7e9rlw72.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Jun 2019 13:10:41 -0700")
Message-ID: <xmqqo932ik7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D3B31DE-8D56-11E9-AB7C-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +		/*
>> +		 * When sorting by name, we should put "detached" head lines,
>> +		 * which are all the lines in parenthesis, before all others.
>> +		 * This usually is automatic, since "(" is before "refs/" and
>> +		 * "remotes/", but this does not hold for zh_CN, which uses
>> +		 * full-width parenthesis, so make the ordering explicit.
>> +		 */
>> +		if (a_detached != (b->kind & FILTER_REFS_DETACHED_HEAD))
>> +			cmp = a_detached ? -1 : 1;
>
> So, comparing a detached and an undetached ones, the detached side
> always sorts lower.  Good.  And ...
>
>> +		else
>> +			cmp = cmp_fn(va->s, vb->s);
>
> ... otherwise we compare the string using the given function.
>
> Sounds sensible.  Will queue.

Stepping back a bit, why are we even allowing the surrounding ()
pair to be futzed by the translators?

IOW, shouldn't our code more like this from the beginning, with or
without Chinese translation?

With a bit more work, we may even be able to lose "make sure this
matches the one in wt-status.c" comment as losing the leading '('
would take us one step closer to have an identical string here as we
have in wt-status.c

 ref-filter.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8500671bc6..7e4705fcb2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1459,20 +1459,22 @@ char *get_head_description(void)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
 	else if (state.detached_from) {
+		strbuf_addch(&desc, '(');
 		if (state.detached_at)
 			/*
 			 * TRANSLATORS: make sure this matches "HEAD
 			 * detached at " in wt-status.c
 			 */
-			strbuf_addf(&desc, _("(HEAD detached at %s)"),
-				state.detached_from);
+			strbuf_addf(&desc, _("HEAD detached at %s"),
+				    state.detached_from);
 		else
 			/*
 			 * TRANSLATORS: make sure this matches "HEAD
 			 * detached from " in wt-status.c
 			 */
-			strbuf_addf(&desc, _("(HEAD detached from %s)"),
+			strbuf_addf(&desc, _("HEAD detached from %s"),
 				state.detached_from);
+		strbuf_addch(&desc, ')');
 	}
 	else
 		strbuf_addstr(&desc, _("(no branch)"));


