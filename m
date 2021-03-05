Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4AFC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE5F650A9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCEVtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:49:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59047 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhCEVtg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 16:49:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E664D1212DE;
        Fri,  5 Mar 2021 16:49:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vIMMdYiSeAhd7hs/aA7qjVvsHvk=; b=KeNBn/
        TO7/on5Uxf64wTRggziHDd/2PDlE/b/po0T0mEKpx4NxuO/ReqhLTjcbemtKy3oC
        SyFmJS2usgf/yd0cZnurfgP2qyiVaI0E70AZTezQlhCQUa6Polm2AjFlTHrp0e8j
        wRSMBbqaeDvtABcJL/Zg//A3jCO7Q5yLKEerU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Scm4gsNu9AleeddnqYeRaVTOAXeS0UiS
        4rb3Xl82nwiy4tbGfXOTzB98S7xApJhnR7KwmYx2JtHw/MaQTuGFVZuE9DPeo/fC
        ub8R+6uRt7Sy3mOA8C7pXrpYxQu9IfOq/O1iNmUNiBslAIMvTbAUeV92ybGqggEh
        9243NhbWSCY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DFF831212DD;
        Fri,  5 Mar 2021 16:49:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8BCD91212DA;
        Fri,  5 Mar 2021 16:49:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Brown <michael.brown@discourse.org>
Cc:     git@vger.kernel.org
Subject: Re: "git diff-files" command reports differences that don't exist
References: <4210f5f1-dd7e-f425-6ab2-e220a33e82bf@discourse.org>
Date:   Fri, 05 Mar 2021 13:49:30 -0800
In-Reply-To: <4210f5f1-dd7e-f425-6ab2-e220a33e82bf@discourse.org> (Michael
        Brown's message of "Fri, 5 Mar 2021 14:28:20 -0500")
Message-ID: <xmqqa6rh9sph.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB6782DA-7DFC-11EB-A49E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Brown <michael.brown@discourse.org> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> 1. Be in any existing repository in a clean state (I tested with 2 existing
>    repositories and 1 completely fresh)
> 1. run `git diff-files`, see no output
> 1. touch an existing file: `touch a`
> 1. run `git diff-files`

This is totally expected behaviour.  In general when you are working
with plumbing commands like diff-files and diff-index, you are
expected to do "update-index --refresh" upfront.

A plumbing command "git diff" has an equivalent of "update-index
--refresh" built into it, but the plumbing commands are designed
to be used in scripts, and in order to allow scripting programmers
to avoid making unnecessary "update-index --refresh", e.g.

	git update-index --refresh
	git diff-files | use diff-files output
	git diff-index | use diff-index output

they leave it the responsibility of the calling script (or the end
user who directly use them from the command line) to refresh the
cached stat information as necessary.



