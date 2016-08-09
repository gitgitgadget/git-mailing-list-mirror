Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48481F859
	for <e@80x24.org>; Tue,  9 Aug 2016 19:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbcHITzS (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 15:55:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752301AbcHITzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 15:55:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 34ADB34699;
	Tue,  9 Aug 2016 15:49:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3l+zsZzMExIU8VoAVZ1S4qiPQ0g=; b=pPcVgz
	jtEiAM8j9TAvd2HGj+1Q2SnHx7x9r3kgtxduq1Rjiyc4hG8NnOqFCOq5Gs12f95J
	3gbbuN165J+DHKpBJfhh0+dQVwg0TGlLR2QByGAInlwYv99eWo2LkHe9e7m3sx9Q
	M0gNmMWvrbiIS9osF135HeT5ZGJ0mDfoY+bgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s4C2fyoiS8VRD1fkcr6jAdkGZ5bvOjmN
	lqAzMLIKirR/Y8Xx66/Ow8/vdn2+cfV6zy+tDCDVemT/iZewKSka5DU+bhPs4B0g
	utrey2cVemdsLTJe8ZME/nY4gul6fiFJ3z7UZZAMhdHnnVMprUigpshdR5mSF0hg
	yZFK6sIqMMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D42A34698;
	Tue,  9 Aug 2016 15:49:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB4C434697;
	Tue,  9 Aug 2016 15:49:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to respect --local, --honor-pack-keep and --incremental
References: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
	<20160808181942.GD3995@teco.navytux.spb.ru>
	<xmqqoa53dpue.fsf@gitster.mtv.corp.google.com>
	<20160809112123.GA14273@teco.navytux.spb.ru>
	<xmqqtwetc2bh.fsf@gitster.mtv.corp.google.com>
	<20160809192858.GA25822@teco.navytux.spb.ru>
Date:	Tue, 09 Aug 2016 12:49:09 -0700
In-Reply-To: <20160809192858.GA25822@teco.navytux.spb.ru> (Kirill Smelkov's
	message of "Tue, 9 Aug 2016 22:29:02 +0300")
Message-ID: <xmqqmvkl90zu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5806FE60-5E6A-11E6-819D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> On Tue, Aug 09, 2016 at 09:52:18AM -0700, Junio C Hamano wrote:
>> "touch A" forcess the readers wonder "does the timestamp of A
>> matter, and if so in what way?" and "does any later test care what
>> is _in_ A, and if so in what way?"  Both of them is wasting their
>> time when there is no reason why "touch" should have been used. 
>
> I see, thanks for explaining. I used to read it a bit the other way;

Surely ">A" may invite "Hmm, is it important that A gets empty?", so
the choice between the two is not so black-and-white.  It just is
that "touch" has a more specific "update the timestamp while keeping
its contents intact" meaning, compared to ">A", which _could_ be
read as "make it empty and update its mtime" but most people would
not (i.e. "update its mtime" is a side effect for any modification).

> Ok, makes sense. Both patches adjusted and will be reposted.

Thanks.
