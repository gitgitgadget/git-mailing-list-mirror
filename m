Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B1420193
	for <e@80x24.org>; Thu, 11 Aug 2016 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbcHKPLj (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 11:11:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932227AbcHKPLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 11:11:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 792B733634;
	Thu, 11 Aug 2016 11:11:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04iRDnqFHFqVyiVnl6UxhGoISSU=; b=Ydh3d9
	4o7lFQADMs3Pp0nRDHErx5bDCc7d+SgmeESJA7VL1kIZl1Fr26ULD4FkIir5S/dA
	/4z78P09YPe56sK32Ih499ycjym9sUlViRoLHkfByKzfom+cX7ENOK9wQaBxIrEw
	U+2omgVYLROux/nCSSI9uQxFKMBs9Yyh/zTvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vN/zKxbprwqMC9HMYcA/xKoXZTQgiG1f
	c9chT4QS/iP9+i2sPYgA7+D3Jv5jAL4XGD2WlIcCKbQCxw5HnF3isjqm0DcoZloe
	9fDqlpgBsGArIfdJD/0WV7NEKADzbtYhA9ppHwQRcuzvMyObYjgW5ZBr+2ISLLyz
	CxzYU4BFpaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70BDF33633;
	Thu, 11 Aug 2016 11:11:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB9A433632;
	Thu, 11 Aug 2016 11:11:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5] pack-objects mru
References: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
	<20160810120248.i2hvm2q6ag3rvsk4@sigill.intra.peff.net>
	<xmqqr39w4bvx.fsf@gitster.mtv.corp.google.com>
	<20160811050252.g3iusy7bp3j6tzte@sigill.intra.peff.net>
	<20160811065751.p64bi3sngbeotwc3@sigill.intra.peff.net>
	<20160811092030.my5c4x6wplxaf7wz@sigill.intra.peff.net>
	<20160811095710.p2bffympjlwmv3gc@sigill.intra.peff.net>
Date:	Thu, 11 Aug 2016 08:11:33 -0700
In-Reply-To: <20160811095710.p2bffympjlwmv3gc@sigill.intra.peff.net> (Jeff
	King's message of "Thu, 11 Aug 2016 05:57:10 -0400")
Message-ID: <xmqqmvkj2vdm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E53910E0-5FD5-11E6-B3D1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So considering "--depth" as a space-saving measure for --aggressive does
> not seem that effective. But it feels weird to quietly drop actions
> people might have done with previous aggressive runs.

That argument cuts both ways, doesn't it?

If the user explicitly asks to use lower "--depth" from the command
line when the second repack runs, the intention is clear: the
existing pack may use delta chains that are too long and is
detrimental to the run-time performance, and the user wants to
correct it by repacking with shorter delta chain.

Should the act of letting "gc --auto" use lower "--depth", by not
configuring to always use deeper chain, be interpreted the same way?
I am not sure.  The old packing with large --depth is something the
user did long time ago, and the decision the user made not to use
large depth always is also something the user did long time ago.  I
do not think it is so cut-and-dried which one of the two conflicting
wishes we should honor when running the second repack, especially
when it is run unattended like "gc --auto" does.



