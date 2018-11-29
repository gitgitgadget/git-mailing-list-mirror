Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A12211B4
	for <e@80x24.org>; Thu, 29 Nov 2018 07:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeK2SOy (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 13:14:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50090 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeK2SOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 13:14:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E14C106883;
        Thu, 29 Nov 2018 02:10:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HoP5Bt8+PyuW3HHoJ/Bf4x2gPrY=; b=E7WC6I
        mQon3n5rWNPBZkQo+jabGPY9XkNJinVo1J4WgH6yCVNnIyfM/RBIj2atxzEd9jw+
        WXVc5L0mCxx1KyI/dbkkzznlozXOe+QtRYIwjcYIBAFUW4Ns2uGtcb9bnUErbV8C
        UuY+Ih37Q6sl8+8qcf9/QxHauTw8BN5nfIivY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YDgl4TDzYj3UcTY5O6N3q/Tg2L412mnA
        mhEB6lAqTzBTiaizODtAp8h/IKC4LnJpBsx7hwigw6Xu0RzbBlEFgK39CwwfDz29
        g+5R/cY3X7bGyxrVs+ZZZFMEQ+Enq9sU5UPgxmLzuYonT8icv1MfxbyQ47NjFotT
        PbfDrimzMfw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95F83106881;
        Thu, 29 Nov 2018 02:10:28 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0678C106880;
        Thu, 29 Nov 2018 02:10:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v2] log -G: Ignore binary files
References: <1535679074.141165.1542834055343@ox.hosteurope.de>
        <c4eac0b0ff0812e5aa8b081e603fc8bdd042ddeb.1543403143.git.thomas.braun@virtuell-zuhause.de>
Date:   Thu, 29 Nov 2018 16:10:26 +0900
In-Reply-To: <c4eac0b0ff0812e5aa8b081e603fc8bdd042ddeb.1543403143.git.thomas.braun@virtuell-zuhause.de>
        (Thomas Braun's message of "Wed, 28 Nov 2018 12:32:57 +0100")
Message-ID: <xmqqa7lsnyu5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9955D78-F3A5-11E8-9CA0-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> Subject: Re: [PATCH v2] log -G: Ignore binary files

s/Ig/ig/; (will locally munge--this alone is no reason to reroll).

The code changes looked sensible.

> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 844df760f7..5c3e2a16b2 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -106,4 +106,44 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
>  	rm .gitattributes
>  '
>  
> +test_expect_success 'log -G ignores binary files' '
> +	git checkout --orphan orphan1 &&
> +	printf "a\0a" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -Ga >result &&
> +	test_must_be_empty result
> +'

As this is the first mention of data.bin, this is adding a new file
data.bin that has two 'a' but is a binary file.  And that is the
only commit in the history leading to orphan1.

The fact that "log -Ga" won't find any means it missed the creation
event, because the blob is binary.  Good.

> +test_expect_success 'log -G looks into binary files with -a' '
> +	git checkout --orphan orphan2 &&
> +	printf "a\0a" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&

This starts from the state left by the previous test piece, i.e. we
have a binary data.bin file with two 'a' in it.  We pretend to
modify and add, but these two steps are no-op if the previous
succeeded, but even if the previous step failed, we get what we want
in the data.bin file.  And then we make an initial commit the same
way.

> +	git log -a -Ga >actual &&
> +	git log >expected &&

And we ran the same test but this time with "-a" to tell Git that
binary-ness should not matter.  It will find the sole commit.  Good.

> +	test_cmp actual expected
> +'
> +
> +test_expect_success 'log -G looks into binary files with textconv filter' '
> +	git checkout --orphan orphan3 &&
> +	echo "* diff=bin" > .gitattributes &&

s/> />/; (will locally munge--this alone is no reason to reroll).

> +	printf "a\0a" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git -c diff.bin.textconv=cat log -Ga >actual &&

This exposes a slight iffy-ness in the design.  The textconv filter
used here does not strip the "binary-ness" from the payload, but it
is enough to tell the machinery that -G should look into the
difference.  Is that really desirable, though?

IOW, if this weren't the initial commit (which is handled by the
codepath to special-case creation and deletion in diff_grep()
function), would "log -Ga" show it without "-a"?  Should it?

I think this test piece (and probably the previous ones for "-a" vs
"no -a" without textconv, as well) should be using a history with
three commits, where

    - the root commit introduces "a\0a" to data.bin (creation event)

    - the second commit adds another instance of "a\0a" to data.bin
      (forces comparison)

    - the third commit removes data.bin (deletion event)

and make sure that the three are treated identically.  If "log -Ga"
finds one (with the combination of other conditions like use of
textconv or -a option), it should find all three, and vice versa.

> +	git log >expected &&
> +	test_cmp actual expected
> +'
> +
> +test_expect_success 'log -S looks into binary files' '
> +	git checkout --orphan orphan4 &&
> +	printf "a\0a" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -Sa >actual &&
> +	git log >expected &&
> +	test_cmp actual expected
> +'

Likewise.  This would also benefit from a three-commit history.

Perhaps you can create such a history at the beginning of these
additions as another "setup -G/-S binary test" step and test
different variations in subsequent tests without the setup?

>  test_done
