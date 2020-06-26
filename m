Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D9C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056E7208C7
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EuYUA1uH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgFZVNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:13:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56843 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFZVNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:13:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE6CC6C288;
        Fri, 26 Jun 2020 17:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8QjZL7ja9x1lioTHRQVrAGQKg34=; b=EuYUA1
        uHMZBDCIZ1ltXlHbra3ybugrzYusoDEk2L7BqJcHE8jrMOh2uQcLJQxjAhDW0g9Q
        wRGpir0jvQU/oe46K1OKt4iOVwybhJZiYWLHgy/Y+9+WAvS1LXz8137vxNo8voj0
        GHYQG0eZJGtU9Fs0DxSZCj17T3cniQeGUxaNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bQEbAYHdmApMI5dnOouERuWhcaIheCli
        PIct/cd6qeAF9VJdImXiBG4L8kMm4YQL+QXdnWuzykcXHz0c8yofGuiOQhMbJMPT
        O/hiHim6RhmuQLmQLk3zSKtbCOsKhDD2xlemDMm9Pxr0eA2M41wQPE8rniNd6OWG
        vD0yLG+4tdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A72BF6C287;
        Fri, 26 Jun 2020 17:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38C986C286;
        Fri, 26 Jun 2020 17:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Static Linking git for HPE NonStop
References: <011901d64bf9$0235d2b0$06a17810$@nexbridge.com>
Date:   Fri, 26 Jun 2020 14:13:43 -0700
In-Reply-To: <011901d64bf9$0235d2b0$06a17810$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 26 Jun 2020 16:33:05 -0400")
Message-ID: <xmqq366hh6ns.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EACC1C3C-B7F1-11EA-8D35-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> ... Is there anyway to force a static
> linkage instead of using DLLs so that we can isolate this for installations
> who want to be insulated from the confusion?
>
> We currently have everything encoded in config.mak.uname and do not use make
> configure or configure explicitly. Just make.

A quick scan of our Makefile seems to say that LDFLAGS is left open
for builder's use (i.e. we don't add hardcoded "always link
dynamically" etc. in there, so that somebody doing a build for a
particular use case can tell the linker "I want things linked
statically" by adding appropriate and linker specific flags to it,
and that propagates to ALL_LDFLAGS to be used at the last stage of
linking the git binary itself.

