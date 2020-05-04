Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EEBC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80594206B8
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y6m3GtOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgEDTx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:53:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58773 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDTx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 15:53:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A270BC43A;
        Mon,  4 May 2020 15:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PZzkA/7Bgnp0Br9OfDFUaitIEck=; b=Y6m3Gt
        OcXvnvGWsC+01uYEN5zIXRILnY9GiI75RMnV2yNJHHw2G5wSvZPZZBSXNuFtdgM9
        Gb6KzSDBk/nCNkdv90p0d6GSWOzZ4aZSQ6BSzEktkgnT+CBdlIegXt0jMz4Sj9Rn
        y0jxZFimhou9p4MqtNV4v/Rb3qf+IC/Rs6gQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rx8LQR2qEA4AjMsgLBh3R2dIOsTj9md4
        nPJmgQSt/Y/uNSzii5wWb2BlV/byhtILz/76Eu80VdSNMp6C8EUocKgTBrTMXJ2e
        JRBEenGQKWfj4n7vavEjnbeA4hNwMEw9P9UD7FdueGMIS1JuhABNbsY2bKG9X81z
        DTbvoVF7WNI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42A34BC439;
        Mon,  4 May 2020 15:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A9DBBC435;
        Mon,  4 May 2020 15:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] sparse-checkout: stop blocking empty workdirs
References: <pull.624.git.1588616864222.gitgitgadget@gmail.com>
        <CABPp-BGO1AYsW-V1a_bSToihWg8yBYyUe3GFUqfaADFpcfEDoQ@mail.gmail.com>
Date:   Mon, 04 May 2020 12:53:49 -0700
In-Reply-To: <CABPp-BGO1AYsW-V1a_bSToihWg8yBYyUe3GFUqfaADFpcfEDoQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 4 May 2020 11:41:38 -0700")
Message-ID: <xmqqtv0vfpde.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA41813C-8E40-11EA-AC23-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Remove the error condition when updating the sparse-checkout leaves
>> an empty working directory.
>>
>> This behavior was added in 9e1afb167 (sparse checkout: inhibit empty
>> worktree, 2009-08-20). The comment was added in a7bc906f2 (Add
>> explanation why we do not allow to sparse checkout to empty working
>> tree, 2011-09-22) in response to a "dubious" comment in 84563a624
>> (unpack-trees.c: cosmetic fix, 2010-12-22).
> ...
>
> Patch looks good to me.

Thanks, both.

