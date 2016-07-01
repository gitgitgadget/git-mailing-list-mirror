Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E919F2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 15:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbcGAP5A (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 11:57:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751036AbcGAP47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 11:56:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 511F925AC1;
	Fri,  1 Jul 2016 11:56:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EwQjhT7g3ieid0OFyLSCeKTAeXI=; b=c6yC10
	jRtfyCyuPw4Z0x5KdG/dmfa6Y107dEoXgbVKxrkO0SML2xaBl8N/Tz/Hohejl+p2
	XHwTe2cKbn5D01T87f0TMOVpcxeIzOR+6DnfmDjVIpZTe1eC3I1sqJ/3tJV+O4sF
	eH2CHUwZ+cPtbSsFfaT4xBrxahve9RiWF2b+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eswjB7sErHTDFsTuuiRIXCeO3Hncu+Lk
	w2TOKMhW1tgimdkiK+0sVZ53QlwrP1vrfpIzl8GsoUw5KpAgdL7ffyq4hqWUPCUd
	ZN8/5vNHOciQqoQtWiJe+axab1DgdZPXEH56HATNkayXa9wJgByRRAGQASH6eblx
	mrCjrWh/pR4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4903A25ABF;
	Fri,  1 Jul 2016 11:56:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C601225ABE;
	Fri,  1 Jul 2016 11:56:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 4/9] merge_recursive: abort properly upon errors
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<81a74b02ac714a4fa3734dfb774cff6dea3a3471.1467199553.git.johannes.schindelin@gmx.de>
	<xmqqvb0r3gi4.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607011215010.12947@virtualbox>
Date:	Fri, 01 Jul 2016 08:56:55 -0700
In-Reply-To: <alpine.DEB.2.20.1607011215010.12947@virtualbox> (Johannes
	Schindelin's message of "Fri, 1 Jul 2016 12:16:30 +0200 (CEST)")
Message-ID: <xmqqy45lz708.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70A24860-3FA4-11E6-BB33-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >  		saved_b2 = o->branch2;
>> >  		o->branch1 = "Temporary merge branch 1";
>> >  		o->branch2 = "Temporary merge branch 2";
>> > -		merge_recursive(o, merged_common_ancestors, iter->item,
>> > -				NULL, &merged_common_ancestors);
>> > +		if (merge_recursive(o, merged_common_ancestors, iter->item,
>> > +				NULL, &merged_common_ancestors) < 0)
>> > +			return -1;
>> >  		o->branch1 = saved_b1;
>> >  		o->branch2 = saved_b2;
>> >  		o->call_depth--;
>> 
>> I wonder if o->branch[12] need to be restored, though.  The only
>> sensible thing the caller can do is to punt,...
>
> I do not think that the caller can do anything sensible with *o after we
> return an error...

That is totally up to what this patch does, isn't it?

By deliberately keeping o->branch[12] to point at the temporary
names and not restoring, this patch declares "the caller cannot do
anything sensible with *o".  If it restores, the caller still can.
Even with this step as-is, the caller can tell at which recursion
level the merge failed by looking at o->call_depth, for example.

I do not think the current set of callers, and a new one you will be
introducing, would prefer to be able to do something with *o after
the failure return from this function, so in that sense, I do not
care deeply either way.

But if the patch is making a policy decision "*o is undefined upon
error return from this function", it would help people who want to
build on top of this codebase to add that to the comment before the
function, wouldn't it?

