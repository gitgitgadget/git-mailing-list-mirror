Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D546C47409
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AB821734
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/UbI5lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgA3UWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:22:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51587 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgA3UW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:22:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8242F4A541;
        Thu, 30 Jan 2020 15:22:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PXh5bv2s7hd9ItIkIxMAKSMMHTk=; b=c/UbI5
        lrcXKRLYUPORWlu+ZtPzz2+VQ3IPgBhbJ2OXz/4uOXPTaGvzmBU/M21/oqYzoVsr
        jSMmty410mjFwcs+78B1YjswI1o4auknW+BEk0XgWbxHTfLF65Ker941u0jneCco
        GowTpukfdW57c49pUqHlbmGmy3evSAa0tVhM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qgJadCFBf8dZjo7Sl17OeiRX0220OuHx
        zCOcUefk877kW+DdndoN9MbY8CTzNwNYosKr2BmzeJdoUfKubvuQmM0EKvDYaWQt
        mxzu56IUN9BtLnADml2F4vf/htxQ1QSEpTlXKUFZ5eULgi5RqZ3YzisnrP5lOKQR
        exz8DcTdPUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A1684A540;
        Thu, 30 Jan 2020 15:22:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9A014A53F;
        Thu, 30 Jan 2020 15:22:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv1 1/1] git-p4: avoid leak of file handle when cloning
References: <20200130115034.6191-1-luke@diamand.org>
        <20200130115034.6191-2-luke@diamand.org>
Date:   Thu, 30 Jan 2020 12:22:24 -0800
In-Reply-To: <20200130115034.6191-2-luke@diamand.org> (Luke Diamand's message
        of "Thu, 30 Jan 2020 11:50:34 +0000")
Message-ID: <xmqqv9osbsov.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AD42BE8-439E-11EA-862B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> Spotted by Eric Sunshine:
>
>     https://public-inbox.org/git/CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com/
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  git-p4.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index eb5bc28cf9..9a71a6690d 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3563,7 +3563,8 @@ def importRevisions(self, args, branch_arg_given):
>          changes = []
>  
>          if len(self.changesFile) > 0:
> -            output = open(self.changesFile).readlines()
> +            with open(self.changesFile) as f:
> +                output = f.readlines()
>              changeSet = set()
>              for line in output:
>                  changeSet.add(int(line))

I was scratching my head until I realized that this is PATCH 7/6 of
the other 6-patch series.

Will queue together with the other ones.  Thanks.
