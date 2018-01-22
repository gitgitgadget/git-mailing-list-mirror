Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883971F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeAVXoY (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:44:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59618 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeAVXoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:44:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B358ACC115;
        Mon, 22 Jan 2018 18:44:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=45/YsisZf1wAUcRI347AaQBmRL8=; b=ZZden6
        HBIU8lewQ8Om14BikCH8rmdOLpeIOKlSNCgcMKDW+WNKO2P5cU3fGfQK1zkIPCEp
        6PTNqKzgHa2kKn1hCASONQkFzyW0IduVOv080CC378bUNrfmzzdsCJBDHLuhVSvs
        ut70I05srcryY8JDNnBzQk6b+einIlhFMoFbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ueCaZiyPqAxJR0s/cPtwnyNM7ExVLwTt
        K6fjCgSfo2SkRLTEvTfxdpkPAFMjUfACDW96nAQvA8OcJSwcIKOCHxtoTVp8vYXK
        MGMiLIK/ZV3mrG4gULmyAbKSo6kcrJGoIxNYtRRI7oTXODOScBU60G2mD9Jei1sh
        Y5XXTTv87Vc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB6C0CC114;
        Mon, 22 Jan 2018 18:44:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 265BECC113;
        Mon, 22 Jan 2018 18:44:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Nit] Lots of enumerated type warnings
References: <001601d3917b$c1ade3c0$4509ab40$@nexbridge.com>
        <xmqqo9lljz3l.fsf@gitster.mtv.corp.google.com>
        <001501d393d3$b82150d0$2863f270$@nexbridge.com>
Date:   Mon, 22 Jan 2018 15:44:20 -0800
In-Reply-To: <001501d393d3$b82150d0$2863f270$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 22 Jan 2018 17:52:40 -0500")
Message-ID: <xmqqy3kpihm3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B3B1392-FFCE-11E7-A886-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Here are a few examples, there are more:
>
> auto_crlf = git_config_bool(var, value);
>   		          ^

The carets in your message do not align to what I think they are
trying to point at, but I think the above is pointing at the '=' and
wants to say "auto_crlf variable is enum, it gets assigned an
integer returned from git_config_bool(), and I do not like that
assignment".

For this one I tend to agree with the compiler, meaning that it is
ugly to define "enum auto_crlf" in such a way that the first two
values happen to match what a logically different "enum" (which is
"boolean") assigns the two values to.  And this judgment does not
change whether git_config_bool() actually returns an enum or an int
(the code in reality returns the latter).

I do not think people would terribly mind a patch to turn the above
into:

  auto_crlf = git_config_bool(var, value) ? AUTO_CRLF_FALSE : AUTO_CRLF_TRUE;

> "/home/jenkins/.jenkins/workspace/Build_Git/config.c", line 1147:
> warning(272): 
>           enumerated type mixed with another type
>
> type = sha1_object_info(s->oid.hash, &s->size);
>   			     ^

/* returns enum object_type or negative */
int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)

The function has been like this forever, I suspect, and I would say
"this gives negative when error, or enum we know is non-negative" is
quite a reasonable thing to do, but the enum has OBJ_BAD defined to
be negative, so probably it is more kosher if sha1_object_info() is
declared to return "enum object_type" instead of int.

> "/home/jenkins/.jenkins/workspace/Build_Git/diff.c", line 3618:
> warning(272): 
>           enumerated type mixed with another type
>
> options->color_moved = diff_color_moved_default;
>   	                     ^

If color_moved field is declared to be an enum, the _default
variable should be, too.  I do not think it is such a controversial
fix.
