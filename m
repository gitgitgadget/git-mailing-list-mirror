Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC9A1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 11:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeK1Wc1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 17:32:27 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:45348 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727585AbeK1Wc1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 17:32:27 -0500
Received: from app06-neu.ox.hosteurope.de ([92.51.170.140] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gRy3b-0005Xz-BK; Wed, 28 Nov 2018 12:31:03 +0100
Date:   Wed, 28 Nov 2018 12:31:03 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Message-ID: <1687320635.1640.1543404663287@ox.hosteurope.de>
In-Reply-To: <xmqq4lc96gsg.fsf@gitster-ct.c.googlers.com>
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
 <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <xmqq4lc96gsg.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev42
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1543404667;f8f57bc3;
X-HE-SMSGID: 1gRy3b-0005Xz-BK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> hat am 22. November 2018 um 02:29 geschrieben:
> 
> 
> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
> > The -G <regex> option of log looks for the differences whose patch text
> > contains added/removed lines that match regex.
> >
> > The concept of differences only makes sense for text files, therefore
> > we need to ignore binary files when searching with -G <regex> as well.
> >
> > Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> > ---
> >  Documentation/gitdiffcore.txt |  2 +-
> >  diffcore-pickaxe.c            |  5 +++++
> >  t/t4209-log-pickaxe.sh        | 22 ++++++++++++++++++++++
> >  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> OK.
> 
> > diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> > index c0a60f3158..059ddd3431 100644
> > --- a/Documentation/gitdiffcore.txt
> > +++ b/Documentation/gitdiffcore.txt
> > @@ -242,7 +242,7 @@ textual diff has an added or a deleted line that matches the given
> >  regular expression.  This means that it will detect in-file (or what
> >  rename-detection considers the same file) moves, which is noise.  The
> >  implementation runs diff twice and greps, and this can be quite
> > -expensive.
> > +expensive.  Binary files without textconv filter are ignored.
> 
> OK.
> 
> > diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> > index 69fc55ea1e..8c2558b07d 100644
> > --- a/diffcore-pickaxe.c
> > +++ b/diffcore-pickaxe.c
> > @@ -144,6 +144,11 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
> >  		textconv_two = get_textconv(o->repo->index, p->two);
> >  	}
> >  
> > +	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
> > +	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
> > +	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
> > +		return 0;
> > +
> >  	/*
> >  	 * If we have an unmodified pair, we know that the count will be the
> >  	 * same and don't even have to load the blobs. Unless textconv is in
> 
> Shouldn't this new test come after the existing optimization, which
> allows us to leave without loading the blob contents (which is
> needed once you call diff_filespec_is_binary())?

Yes, good point.

> > diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> > index 844df760f7..42cc8afd8b 100755
> > --- a/t/t4209-log-pickaxe.sh
> > +++ b/t/t4209-log-pickaxe.sh
> > @@ -106,4 +106,26 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
> >  	rm .gitattributes
> >  '
> >  
> > +test_expect_success 'log -G ignores binary files' '
> > +	rm -rf .git &&
> > +	git init &&
> 
> Please never never ever do the above two unless you are writing a
> test that checks low-level repository details.
> 
> If you want a clean history that has specific lineage of commits
> without getting affected by commits that have been made by the
> previous test pieces, it is OK to "checkout --orphan" to create an
> empty history to work with.

Thanks for the hint. I thought I had seen a less intrusive way for getting an empty history. 
Changed.

> > +	printf "a\0b" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git log -G a >result &&
> > +	test_must_be_empty result
> > +'
> > +
> > +test_expect_success 'log -G looks into binary files with textconv filter' '
> > +	rm -rf .git &&
> > +	git init &&
> > +	echo "* diff=bin" > .gitattributes &&
> > +	printf "a\0b" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git -c diff.bin.textconv=cat log -G a >actual &&
> > +	git log >expected &&
> > +	test_cmp actual expected
> > +'
> > +
> >  test_done
>
