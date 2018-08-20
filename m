Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B161F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeHTUDT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:03:19 -0400
Received: from ao2.it ([92.243.12.208]:52403 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeHTUDT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:03:19 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1frnIl-0007vp-Vb; Mon, 20 Aug 2018 18:45:12 +0200
Date:   Mon, 20 Aug 2018 18:46:53 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 3/7] t7411: be nicer to future tests and really clean
 things up
Message-Id: <20180820184653.1ad1d5bc72effe4e995cff18@ao2.it>
In-Reply-To: <xmqq7eks1z6h.fsf@gitster-ct.c.googlers.com>
References: <20180814110525.17801-1-ao2@ao2.it>
        <20180814110525.17801-4-ao2@ao2.it>
        <xmqq7eks1z6h.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Aug 2018 13:16:38 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
[...]
> >  test_expect_success 'error message contains blob reference' '
> > +	# Remove the error introduced in the previous test.
> > +	# It is not needed in the following tests.
> > +	test_when_finished "git -C super reset --hard HEAD^" &&
> 
> Hmm, that is ugly.  Depending on where in the subshell the previous
> test failed, you'd still be taking us to an unexpected place.
> Imagine if "git commit -m 'add error'" failed, for example, in the
> test before this one.
> 
> I am wondering if the proper fix is to merge the previous one and
> this one into a single test.  The combined test would
> 
>     - remember where the HEAD in super is and arrange to come back
>       to it when test is done
>     - break .gitmodules and commit it
>     - run test-tool and check its output
>     - also check its error output
> 
> in a single test_expect_success.
>

I will try that.

> > @@ -123,6 +126,7 @@ test_expect_success 'using different treeishs works' '
> >  '
> >  
> >  test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
> > +	test_when_finished "git -C super reset --hard HEAD^" &&
> >  	(cd super &&
> >  		git config -f .gitmodules \
> >  			submodule.submodule.fetchrecursesubmodules blabla &&
> > @@ -134,8 +138,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
> >  			HEAD b \
> >  			HEAD submodule \
> >  				>actual &&
> > -		test_cmp expect_error actual  &&
> > -		git reset --hard HEAD^
> > +		test_cmp expect_error actual
> >  	)
> >  '
> 
> If we want to be more robust, you'd probably need to find a better
> anchoring point than HEAD, which can be pointing different commit
> depending on where in the subshell the process is hit with ^C,
> i.e.
> 
> 	ORIG=$(git -C super rev-parse HEAD) &&
> 	test_when_finished "git -C super reset --hard $ORIG" &&
> 	(
> 		cd super &&
> 		...
>

I see, ORIG is set and evaluated immediately but the value will be
used only at a later time.

I remember that you raised concerns also in the previous review round
but I didn't quite get what you meant, now I think I do.

> The patch is still an improvement compared to the current code,
> where a broken test-tool that does not produce expected output in
> the file 'actual' is guaranteed to leave us at a commit that we do
> not expect to be at, but not entirely satisfactory.

I can do a v4 with these fixes since there are also some comments about
other patches.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
