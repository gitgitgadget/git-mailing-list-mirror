Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CF52070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbcGHROm (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:14:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932486AbcGHROh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 13:14:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 785C227DDE;
	Fri,  8 Jul 2016 13:14:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ujiBDq0LnABLTABM2HBam4SIJc=; b=F8G5Eo
	MZWnoK3E8IG2XdAZls4twpj0nhA1ia9RG3j6HLM3IvnqG3YYIO8bF8SVZt7SToc0
	XtakvZhxia1a/v4Md1SmjDTKe7EWH/Il1ecOFzMQ1MCttbca3l3xNQnIWKVa3aKU
	oD+clPRDoLRpsROyOvggcUUaHrGmKjnVcgx8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ovY3/KOk6x1j9cVKkSTw6mI1CsQikaP0
	BRLZiB+0htFjLNw6plAX3TuFc3agmrHIE+0RRy95sAK4ro96uBpoG9x8/nNnDjAo
	MbdnJrJv32kEEoD7ohnXGOOaq3vYeoAvIhoDQ8s5Tsec+wlbqOnu2vm8dSG3qHXN
	///gpl/m+n8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4667827DDD;
	Fri,  8 Jul 2016 13:14:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C400A27DDC;
	Fri,  8 Jul 2016 13:14:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
References: <20160708025948.GA3226@x>
	<xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
	<20160708064448.GA18043@x>
Date:	Fri, 08 Jul 2016 10:14:33 -0700
In-Reply-To: <20160708064448.GA18043@x> (Josh Triplett's message of "Thu, 7
	Jul 2016 23:44:49 -0700")
Message-ID: <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71E78330-452F-11E6-9D34-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> That sounds reasonable.  And if they *do* end up taking any time to
> traverse, it's because they weren't reachable from other anchoring
> points, so taking the extra time to traverse them seems fine.

The only thing that is hard is to clearly define _what_ are the new
anchoring points.

It cannot be "anything directly under .git that has all-caps name
that ends with _HEAD".  The ones we write we know are going to be
removed at some point in time (e.g. "git reset", "git bisect reset",
"git merge --abort", etc.).  We do not have any control on random
ones that the users and third-party tools leave behind, holding onto
irrelevant objects forever.
