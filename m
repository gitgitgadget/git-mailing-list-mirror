Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE7E1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbdKJSW1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:22:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60193 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751142AbdKJSW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:22:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 186409EA56;
        Fri, 10 Nov 2017 13:22:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XVbgJTCtRUyfeB4NMq0PmnSvc6E=; b=jfqGth
        sDYE9wkawAbRfSQIaP8cCgnvVPBHFosQSTAjlQR8SLza71ilvYfJKWijoOX70OTj
        uGBhUlVRzHDML7Nj+qKGyYiood02R8LCCz6iowpGzzjBLL8/P84seX+pP+vbzYOZ
        6EVgbstFtZMPe2wpAsij+8H7INfLn0dOaHKSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YMUhOHkQDIRgzBB8lcRVOzinVi1+Gp4E
        /7t8RHkUxNzxnSnuUNGjBiePkCWJNnspxkzt6+UJZpG2mjaCnxd9CiiHEedrBhOX
        O6yZfjmwgS0LSrGnvGlF+IBIwfwvJF4N/5iknoAFNPGtLVrRSNaQ8jm86Qd0d134
        xw1QVhso+lA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FCA09EA54;
        Fri, 10 Nov 2017 13:22:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82E049EA52;
        Fri, 10 Nov 2017 13:22:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] cover-at-tip
References: <357e8afb-4814-c950-1530-530bb6dd5f5a@suse.de>
        <e1d3ab5b-82e6-8490-8f2e-00c1359c6deb@suse.de>
Date:   Sat, 11 Nov 2017 03:22:24 +0900
In-Reply-To: <e1d3ab5b-82e6-8490-8f2e-00c1359c6deb@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Fri, 10 Nov 2017 16:37:49 +0100")
Message-ID: <xmqqbmkaf0yn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A11338A-C644-11E7-9E77-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

> I would need to add "some" level of parsing to am.c to make sure
> the patch content is just garbage and that there are no actual
> hunks for that.
>
> I did not find any public API that would allow me to do that,
> although apply_path/parse_chunk would fit the bill.  Is that the
> right way to approach this ?

I do not think you would want this non-patch cruft seen at the apply
layer at all.  Reading a mailbox, with the help of mailsplit and
mailinfo, and being the driver to create a series of commits is what
"am" is about, and it would have to notice that the non-patch cruft
at the beginning is not a patch at all and defer creation of an
empty commit with that cover material at the end.  For each of the
other messages in the series that has patches, it will need to call
apply to update the index and the working tree so that it can make a
commit, but there is NO reason whatsoever to ask help from apply, whose
sole purpose is to read a patch and make modifications to the index
and the working tree, to handle the cover material.


