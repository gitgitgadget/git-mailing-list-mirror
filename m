Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF6C433E3
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD6020684
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IAcWxXW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGRUao (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:30:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55384 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgGRUao (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 16:30:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 859B373D4A;
        Sat, 18 Jul 2020 16:30:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0zGFu/f8TFe1FmbHKvmeqYVrNCQ=; b=IAcWxX
        W7NhGiLnmEXTAqUecg8yoLC2ex6StkJhkHccR4NK4AL1nghAbLUK86Ky3xuPFhBI
        8cDbjMCK/84QbY9AZJCQ5CMCDrcHW4c+esY4m0m2imRp41MG6MDJIlPDbC6N/R/d
        v4KPfcUYVktXgHgD+h/UbuKMtj0LcgbY+Jj4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=klYsDUWxKBCkHz9pxsx531Busna0SnW/
        TLQDOBI0kIhg8bQyPOYWeAgT04AY2HViE1TFMzEsH2S23hpXMyq6YWVG4onqhNQA
        KsCFanUZdVEqeB0p4sK5qubG0tBZ2/ySd+EDWVpaSTwnE8N1JOWtP+2gzLt++jt8
        7q0cjYwPl8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D3E373D49;
        Sat, 18 Jul 2020 16:30:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B43F673D48;
        Sat, 18 Jul 2020 16:30:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pudinha <rogi@skylittlesystem.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Support nvim as mergetool
References: <20200718192001.27434-1-rogi@skylittlesystem.org>
Date:   Sat, 18 Jul 2020 13:30:40 -0700
In-Reply-To: <20200718192001.27434-1-rogi@skylittlesystem.org> (pudinha's
        message of "Sat, 18 Jul 2020 20:20:02 +0100")
Message-ID: <xmqqd04sbm6n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C994C48-C935-11EA-B0A1-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pudinha <rogi@skylittlesystem.org> writes:

> ---
> Hello giters! Hope you are well!
>
> I made this little patch to support nvim as a merge tool. What do you
> think?

Uninspiring.

But that is not your fault.  

The way vimdiff, vimdiff2 and vimdiff3 waste one file for each just
to have a different name is simply bad, and the way it was extended
to cover gvimdiff family is even more horrible.  This patch makes
the existing mess even worse.  That part is your fault, I'd have to
say.

I'd rather see us explore ways to improve the current arrangement
used to support these 6 variants before adding yet another 3 new
ones.

For example, we could add another method the backends could define,
call it list_tool_variants, and whenever the control flow goes from
run_merge_tool through setup_tool for a tool whose name ends with
[1-9], e.g. "foomerge3", we first see if there is "foomerge" tool
and if there is ask it if it knows about "foomerge3" variant by
calling its list_tool_variants.

That way, we probably can remove the files for vimdiff2, vimdiff3,
gvimdiff2 and gvimdiff3 (gvimdiff needs to stay there, as we do not
want to make the name derivation rule too complex) only to hold a
single line ". vimdiff".  Then the next person who adds yet another
set of backends based on a yet another reimplementation or skin of
vim would only have to add a single file in mergetools/ directory,
not three.

Hmm?
