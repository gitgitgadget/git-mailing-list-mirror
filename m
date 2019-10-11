Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B2C1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 05:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfJKFul (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 01:50:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53639 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJKFul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 01:50:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43395994A1;
        Fri, 11 Oct 2019 01:50:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K+ygtX5LX4PYNmG62kY4uosMY84=; b=aYdD1z
        bggRG9hktWlglRXkutayMGDXlCMLnNW2J0pY+VOuqQlrqH+lOObs89KRS9PqzSbD
        QEceYG7FJOfGjB9tWjA0GzlhVGYP9Lr2BRiPsXVU4zHfNbllTitwOxubPgdtAYXY
        t2B5zUyaB7e9DxQFM400rHkpDT4w5RLRpc+qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FO2G9nuqnZHpWIhGbesTsaVCjoM7cz/x
        MsqshLeAlYW7VfKC1t2QmnhxhLoUr+srj2UnO1HzqLzCqAoAJCgrTq1C08YRcRg9
        ZmI+oelM6NeRwwWUEy+yndFonWgtOsTMkhXsk2xIr7zwThwIzdEep88ewfdqemOj
        hU0AqQMThXo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BCDC994A0;
        Fri, 11 Oct 2019 01:50:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6B3429949F;
        Fri, 11 Oct 2019 01:50:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v5] documentation: add tutorial for object walking
References: <20191010151932.2716-1-emilyshaffer@google.com>
Date:   Fri, 11 Oct 2019 14:50:34 +0900
In-Reply-To: <20191010151932.2716-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 10 Oct 2019 08:19:32 -0700")
Message-ID: <xmqqr23jhlud.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C1CA3E4-EBEB-11E9-969D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -77,6 +77,7 @@ API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technica
>  SP_ARTICLES += $(API_DOCS)
>  
>  TECH_DOCS += MyFirstContribution
> +TECH_DOCS += MyFirstRevWalk

s/Rev/Object/ probably (if so I can locally amend).

> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> new file mode 100644
> index 0000000000..7085f17072
> --- /dev/null
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -0,0 +1,905 @@
> +My First Object Walk
> +======================
> +
> +== What's an Object Walk?
> +
> +The object walk is a key concept in Git - this is the process that underpins
> +operations like `git log`, `git blame`, and `git reflog`. Beginning at HEAD, the
> +list of objects is found by walking parent relationships between objects.

The above is more about revision walk, for which we have plenty of
docs already, isn't it?  Walking objects, while walking the commit
DAG, is a lessor concept than the key "revision walk" concept and
underpins different set of operations like object transfer and fsck.

Also, the object walk, unlike the revision walk, follows containment
relationships between objects.

> +A related concept is the revision walk, which is focused on commit objects and
> +their relationships.

Yes, s/their/& parent/ perhaps, to contrast the two a bit better.
`git log` and friends, if they need to be listed, should come on
this side, I think.

