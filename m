Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382602095E
	for <e@80x24.org>; Sat, 25 Mar 2017 16:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdCYQ6i (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 12:58:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53114 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751258AbdCYQ6i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 12:58:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64E538166F;
        Sat, 25 Mar 2017 12:58:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HymdQuz9qDCv9wD7dGMkW5uZlXk=; b=ao36Ah
        F2sIQXJRl+2o2tX7j1mnUPpoTLJKrqfPrbjJBshHhROEZnMqfop2yTE5EQLvC6kK
        t/cMKmKh1JcBngWlGmMiHcEuIzlu16KQf3+aHTxLv4j0Z1xr5KtqAYKSJIuxTKkC
        6Jr5hyyKMLzrCKrqJ6h645sXt3Yaxdm5HSb4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w4PGStR1HMtguGeNhYS5x/iJas3rui8x
        7hRMY4pTXoBlXmTH7N8vaVJ0CrJQmmpXZh5wRpMQwXX305/NSWiajOG0pQfiKRxW
        we589ph7+LMboojZWyZwIHswGtZP/DuMxovRv8j9Fo7ygiEZdpUbjn6ft6oADUfD
        6Qb8//F0xJk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C7128166E;
        Sat, 25 Mar 2017 12:58:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9C038166D;
        Sat, 25 Mar 2017 12:58:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
        <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 25 Mar 2017 09:58:34 -0700
In-Reply-To: <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Mar 2017 23:37:54 -0700")
Message-ID: <xmqq1stl5m4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 491D9272-117C-11E7-9999-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The hash that names a packfile is constructed by sorting all the
> names of the objects contained in the packfile and running SHA-1
> hash over it.

Sorry, but I need to make a correction here.

This "SHA-1 over sorted object names" is a description of an ancient
behaviour before 1190a1ac ("pack-objects: name pack files after
trailer hash", 2013-12-05) happened.  These days the pack name is
the same as the csum-file checksum of the .pack contents.

This however does not change the fact that the site that feeds us a
packfile is in control of the hash, hence the name we give to the
resulting packfile.  Unlike the use of csum-file for the trailing
hash for the index file, which is only to protect against bit
flipping, "SHA-1 over .pack contents" done here is used to come up
with a unique name used for identification and deduplication (of the
packfile, not of individual objects), and the need for protection
against collision attack attempts does not change between the
implementation before 1190a1ac and after that commit.
