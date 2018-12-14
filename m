Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C165211B3
	for <e@80x24.org>; Fri, 14 Dec 2018 18:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbeLNSpi (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 13:45:38 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:39146 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730123AbeLNSph (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Dec 2018 13:45:37 -0500
Received: from app13-neu.ox.hosteurope.de ([92.51.170.147]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gXsSs-0001Rw-DP; Fri, 14 Dec 2018 19:45:34 +0100
Date:   Fri, 14 Dec 2018 19:45:34 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        avarab@gmail.com
Message-ID: <894759854.95158.1544813134339@ox.hosteurope.de>
In-Reply-To: <xmqqa7lsnyu5.fsf@gitster-ct.c.googlers.com>
References: <1535679074.141165.1542834055343@ox.hosteurope.de>
 <c4eac0b0ff0812e5aa8b081e603fc8bdd042ddeb.1543403143.git.thomas.braun@virtuell-zuhause.de>
 <xmqqa7lsnyu5.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v2] log -G: Ignore binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1544813137;5785891d;
X-HE-SMSGID: 1gXsSs-0001Rw-DP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> hat am 29. November 2018 um 08:10 geschrieben:
> 
> 
> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
> > Subject: Re: [PATCH v2] log -G: Ignore binary files
> 
> s/Ig/ig/; (will locally munge--this alone is no reason to reroll).

Done.
 
> The code changes looked sensible.

Thanks.

> > diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> > index 844df760f7..5c3e2a16b2 100755
> > --- a/t/t4209-log-pickaxe.sh
> > +++ b/t/t4209-log-pickaxe.sh
> > @@ -106,4 +106,44 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
> >  	rm .gitattributes
> >  '
> >  
> > +test_expect_success 'log -G ignores binary files' '
> > +	git checkout --orphan orphan1 &&
> > +	printf "a\0a" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git log -Ga >result &&
> > +	test_must_be_empty result
> > +'
> 
> As this is the first mention of data.bin, this is adding a new file
> data.bin that has two 'a' but is a binary file.  And that is the
> only commit in the history leading to orphan1.
> 
> The fact that "log -Ga" won't find any means it missed the creation
> event, because the blob is binary.  Good.
> 
> > +test_expect_success 'log -G looks into binary files with -a' '
> > +	git checkout --orphan orphan2 &&
> > +	printf "a\0a" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> 
> This starts from the state left by the previous test piece, i.e. we
> have a binary data.bin file with two 'a' in it.  We pretend to
> modify and add, but these two steps are no-op if the previous
> succeeded, but even if the previous step failed, we get what we want
> in the data.bin file.  And then we make an initial commit the same
> way.
> 
> > +	git log -a -Ga >actual &&
> > +	git log >expected &&
> 
> And we ran the same test but this time with "-a" to tell Git that
> binary-ness should not matter.  It will find the sole commit.  Good.
> 
> > +	test_cmp actual expected
> > +'
> > +
> > +test_expect_success 'log -G looks into binary files with textconv filter' '
> > +	git checkout --orphan orphan3 &&
> > +	echo "* diff=bin" > .gitattributes &&
> 
> s/> />/; (will locally munge--this alone is no reason to reroll).

Done.

> > +	printf "a\0a" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git -c diff.bin.textconv=cat log -Ga >actual &&
> 
> This exposes a slight iffy-ness in the design.  The textconv filter
> used here does not strip the "binary-ness" from the payload, but it
> is enough to tell the machinery that -G should look into the
> difference.  Is that really desirable, though?
> 
> IOW, if this weren't the initial commit (which is handled by the
> codepath to special-case creation and deletion in diff_grep()
> function), would "log -Ga" show it without "-a"?  Should it?

Yes "log -Ga" will find all three commits (creation, modification, deletion)
which are present in v3 without "-a" and cat as textconv filter.

I can make that more explicit with a textconv filter which removes the binary-ness

git -c diff.bin.textconv="sed -e \"s/\x00//g\"" log -Ga >log &&

(diff.bin.textconv="cat -v" works here as well but seems non-portable)

Now we could also search for "aa" as the NUL separating them is gone but that could
be getting too clever or?

> I think this test piece (and probably the previous ones for "-a" vs
> "no -a" without textconv, as well) should be using a history with
> three commits, where
> 
>     - the root commit introduces "a\0a" to data.bin (creation event)
> 
>     - the second commit adds another instance of "a\0a" to data.bin
>       (forces comparison)
> 
>     - the third commit removes data.bin (deletion event)
> 
> and make sure that the three are treated identically.  If "log -Ga"
> finds one (with the combination of other conditions like use of
> textconv or -a option), it should find all three, and vice versa.

Good point. I've added that.

> > +	git log >expected &&
> > +	test_cmp actual expected
> > +'
> > +
> > +test_expect_success 'log -S looks into binary files' '
> > +	git checkout --orphan orphan4 &&
> > +	printf "a\0a" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git log -Sa >actual &&
> > +	git log >expected &&
> > +	test_cmp actual expected
> > +'
> 
> Likewise.  This would also benefit from a three-commit history.
> 
> Perhaps you can create such a history at the beginning of these
> additions as another "setup -G/-S binary test" step and test
> different variations in subsequent tests without the setup?

Done.
