Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271952018F
	for <e@80x24.org>; Tue, 19 Jul 2016 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbcGSUUV (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 16:20:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbcGSUUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 16:20:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF79D2AC48;
	Tue, 19 Jul 2016 16:20:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PRuBcAyqPVP06Jvv23pY+wd5924=; b=gGMpqb
	ARK6WGbD5Upc2FWIJz5eHK4Aowtb1nINe15OVSdaBCZvxLE/sO32MA06vS0rZy58
	bu60Oi36v2DC2YtLaeHqPp1FOSPwfBKPbAgexQNaPlJPvj/G0EqHXEjpYra6Sd7x
	LxUB25kbJ6Mxfb6mEtEy3oIl0ZEVCtwu/oZdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ra3aDX3Gr+FQNT9QOYZuoi03wT3SqjFJ
	C56lxoIGx84oAz+cm8cta5N9zvNtzwOFtDSbit/10CCNlUzuAfe4y2qlh6yygRXz
	iXM2qBW+rJ3LVgnlOX5diMadLlmcrs89jN9BN2DU4+6xUar88g7m0QD6rCOe1TZx
	j1K86BV54L8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D70EA2AC47;
	Tue, 19 Jul 2016 16:20:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58D752AC46;
	Tue, 19 Jul 2016 16:20:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jonathan Nieder <jrnieder@gmail.com>
Cc:	Jonathan Tan <jonathantanmy@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] fetch-pack: grow stateless RPC windows exponentially
References: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com>
	<1468880498-30235-1-git-send-email-jonathantanmy@google.com>
	<CAGZ79kY+2PYx9oz9tvi0zG-oE6qS-Za7D3ocY1XtqcSsDchz0Q@mail.gmail.com>
	<CAGf8dgL3t7uX7yAux0xc2QMJJdmnM0262Quj4o6gDehwA+4JqQ@mail.gmail.com>
	<xmqq8twxfn4j.fsf@gitster.mtv.corp.google.com>
	<20160719195347.GF29326@google.com>
Date:	Tue, 19 Jul 2016 13:20:16 -0700
In-Reply-To: <20160719195347.GF29326@google.com> (Jonathan Nieder's message of
	"Tue, 19 Jul 2016 12:53:47 -0700")
Message-ID: <xmqqzipde5xb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35F80A44-4DEE-11E6-BE80-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> In the stateless-rpc case, linear growth means getting a bounded
> number of 'have's worth of benefit (new 'have's) in each round, in
> exchange for a linearly increasing cost (existing 'have's).  That is a
> high cost for limited benefit.  Exponential growth is a better deal.

Ahh, of course (silly me).  I somehow forgot the cost of having to
repeat what we have already sent to the other side.

