Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266301FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933519AbdCaRfL (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:35:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53342 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933495AbdCaRfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:35:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5445E7B7C2;
        Fri, 31 Mar 2017 13:35:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yh8q0QQjgCBOIcY+0obZ4PpSug4=; b=Xi3E5G
        4Hsb/vErNjJ48XAsJGTyMc4BheK0ZyvEoD+qereLzhfpi9UzgTAEnJHP65CU+gKi
        fY2pOljh5dHfUpsymMket9niguMTfBp2IMp1OFLn/SMuUQtyaYxWe73+W9yM+e3p
        PKFhXOhlXymao+pZfGyBOIO2Di7ARjKMEVc2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CY8dmnL/ErS4PMM3JJd9ULfbbzpzfILZ
        A8olITmXDXiGwBdqDsoD+B7Vzh0WtI2ypYtaz5TcP4S+M/FRDQYQM6FZuaQ3sNnQ
        ldiuc9SePfbRzxiZ06p/wvJrTARZbAfwvLaKegbLyRyYdZFFzhbUYRw1AqKWRCSN
        n8A/CRj8O04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DA1B7B7C1;
        Fri, 31 Mar 2017 13:35:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB7E27B7BF;
        Fri, 31 Mar 2017 13:35:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: SHA1 collision in production repo?! (probably not)
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
Date:   Fri, 31 Mar 2017 10:35:06 -0700
In-Reply-To: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com> (Lars
        Schneider's message of "Fri, 31 Mar 2017 18:05:17 +0200")
Message-ID: <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 620DEB04-1638-11E7-8BC3-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Hi,
>
> I just got a report with the following output after a "git fetch" operation
> using Git 2.11.0.windows.3 [1]:
>
> remote: Counting objects: 5922, done.
> remote: Compressing objects: 100% (14/14), done.
> error: inflate: data stream error (unknown compression method)
> error: unable to unpack 6acd8f279a8b20311665f41134579b7380970446 header
> fatal: SHA1 COLLISION FOUND WITH 6acd8f279a8b20311665f41134579b7380970446 !
> fatal: index-pack failed
>
> I would be really surprised if we discovered a SHA1 collision in a production
> repo. My guess is that this is somehow triggered by a network issue (see data
> stream error). Any tips how to debug this?

Perhaps the first thing to do is to tweak the messages in builtin/index-pack.c
to help you identify which one of identical 5 messages is firing.

My guess would be that the code saw an object that came over the
wire, hashed it to learn that its object name is
6acd8f279a8b20311665f41134579b7380970446, noticed that it locally
already has the object with the same name, and tried to make sure
they have identical contents (otherwise, what came over the wire is
a successful second preimage attack).  But your loose object on disk
you already had was corrupt and didn't inflate correctly when
builtin/index-pack.c::compare_objects() or check_collision() tried
to.  The code saw no data, or truncated data, or
whatever---something different from what the other data that hashed
down to 6acd8..., and reported a collision when there is no
collision.

