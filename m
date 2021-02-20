Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593EFC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B4064EE2
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBTDch (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:32:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62225 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBTDcg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 22:32:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51D58A6EC3;
        Fri, 19 Feb 2021 22:31:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0CFVWhuEzyDLWAc99nOf9KbInn0=; b=jS0aGw
        jtdkpp2U6eXZEwo4e8WN1X6iUVRQA64XH3xxOCU9/k2op8BSIRzroXO/+cotZiCL
        Wxf7uiGHUXmFtlf9T2YyS1WN75Oc+RwBmYgyLs9hQWUncvd1GNg2XM0oxG7e9wcF
        5DAvYpwSdn92890mbT74LvxDOkpXYvhAp/Dw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ho8Sml4sB0GXJuO6Kg4DXzPY2lxeb5VM
        anRT45tjB2BBlCbQgtsFLWcIgcRhBtvsRB6qKkeJIQT5fYthGgCIPuXnHDreJfAV
        KnSmzDVjzYGgIuqpZCivLIRx/p21/jPKfF74Eq0fqrpnkERHRFrl2Dg99tZS9cpq
        KWetrYz89v0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48433A6EC2;
        Fri, 19 Feb 2021 22:31:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE4C3A6EC1;
        Fri, 19 Feb 2021 22:31:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH 1/2] rm: changes in the '.gitmodules' are staged after
 using '--cached'
References: <20210218184931.83613-1-periperidip@gmail.com>
        <20210218184931.83613-2-periperidip@gmail.com>
        <xmqqblchdoej.fsf@gitster.g> <20210219152436.GB6254@konoha>
Date:   Fri, 19 Feb 2021 19:31:53 -0800
In-Reply-To: <20210219152436.GB6254@konoha> (Shourya Shukla's message of "Fri,
        19 Feb 2021 20:54:36 +0530")
Message-ID: <xmqqim6n9zyu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D2CBBEA-732C-11EB-B1EE-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

>> Since we won't come to this block when doing index_only, we are
>> allowed to touch the working tree contents and files.  We indeed do
>> "rm -rf" of the submodule working tree and touch .gitmodules file
>> that is in the working tree.
>> 
>> >  			}
>> > +			if (!remove_path_from_gitmodules(path))
>> > +				gitmodules_modified = 1;
>> > +			continue;
>> 
>> But this looks wrong.  It might be OK to remove from the .gitmodules
>> stored in the index, but I fail to see why it is justified to touch
>> the working tree file when "--cached" is given.
>
> No no, you are correct. Phillipe pointed out the same thing. I don't
> know how I made this mistake.
> ...
>> I think you'd need to
>> ...
>
> Yeah, this approach seems perfect. I will do it this way.

OK, then let's go that way.

Thanks.
