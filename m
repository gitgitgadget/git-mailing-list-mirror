Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_MIXED_ES shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6892C20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 16:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeLMQmY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 11:42:24 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:47015 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeLMQmY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 11:42:24 -0500
Received: from [10.31.188.88] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gXU47-0000Sd-11
        for git@vger.kernel.org; Thu, 13 Dec 2018 11:42:23 -0500
Date:   Thu, 13 Dec 2018 11:42:17 -0500
From:   Yaroslav O Halchenko <debian@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181213164217.GA4633@hopa.kiewit.dartmouth.edu>
References: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
 <20181211040839.17472-1-debian@onerussian.com>
 <20181211040839.17472-2-debian@onerussian.com>
 <CAGZ79kY17gmEh5Sawa+1fG5cXjOReOgCjDyEmGbbpJ5EE1APdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY17gmEh5Sawa+1fG5cXjOReOgCjDyEmGbbpJ5EE1APdw@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 10.31.188.88
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule
 status --recursive to stay intact
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Stefan for the review and please pardon my delay with the
reply, and sorry it got a bit too long by the end ;)

On Wed, 12 Dec 2018, Stefan Beller wrote:
> Thanks for the patches. The first patch looks good to me!

Great!

> > [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule status --recursive to stay intact

> The subject is a bit cryptic (specifically the first part before the
> colon), maybe

>   t7406: compare entire submodule status for --reset-hard mode

> ?


> > For submodule update --reset-hard the best test is comparison of the
> > entire status as shown by submodule status --recursive.  Upon update
> > --reset-hard we should get back to the original state, with all the
> > branches being the same (no detached HEAD) and commits identical to
> > original  (so no merges, new commits, etc).

> "original state" can mean different things to different people. I'd think
> we could be more precise:

>    ... we should get to the state that the submodule is reset to the
>     object id as the superprojects gitlink points at, irrespective of the
>     submodule branch.

ok, I will update the description.  But I wonder if there could be some
short term to be used to describe the composite "git submodule status"
and "git status" (refers to below ;)).

> >  test_expect_success 'submodule update --merge staying on master' '
> >         (cd super/submodule &&
> > -         git reset --hard HEAD~1
> > +        git reset --hard HEAD~1

> unrelated white space change?

I was tuning formatting to be uniform and I guess missed that this is in
the other (not my) test.  I will revert that piece, thanks!

BTW -- should I just squash to PATCHes now?  I kept them separate primarily to
show the use of those helpers:

> >         ) &&
> >         (cd super &&
> >          (cd submodule &&
> > @@ -307,16 +318,28 @@ test_expect_success 'submodule update --merge staying on master' '
> >  '

> >  test_expect_success 'submodule update --reset-hard staying on master' '
> > [..]
> > +'
> > +

> The tests look good to me, though I wonder if we'd rather want to inline
> {record/compare}_submodule_status as then you'd not need to look it up
> and the functions are rather short?

compare_submodules_status  is already a compound action, so code would
become quite more "loaded" if it is expanded, e.g. instead of 

	(cd super &&
	 record_submodules_status &&
	 (cd submodule &&
	  git reset --hard HEAD~1
	 ) &&
	 ! compare_submodules_status &&
	 git submodule update --reset-hard submodule &&
	 compare_submodules_status
	)

it would become something like this I guess?

	(cd super &&
	 git submodule status --recursive >expect &&
	 (cd submodule &&
	  git reset --hard HEAD~1
	 ) &&
	 ! {git submodule status --recursive >actual && 
        test_i18ncmp expect actual;} &&
	 git submodule update --reset-hard submodule &&
	 {git submodule status --recursive >actual && 
      test_i18ncmp expect actual;}
	)

IMHO a bit mouth full.  I was thinking also to extend compare_ with additional
testing e.g. using "git status" since "git submodule status" does not care
about untracked files etc.  For --reset-hard I would like to assure that it is
not just some kind of a mixed reset leaving files behind.  That would make
tests even more overloaded.

On that point: Although I also like explicit calls at times, I also do
like test fixtures as a concept to do more testing around the actual
test-specific code block, thus minimizing boiler plate, which even if explicit
makes code actually harder to grasp (at least to me).  

Since for the majority of the --reset-hard tests the fixture and test(s) are
pretty much the same, actually ideally I would have liked to have
something like this:

test_expect_unchanged_submodule_status 'submodule update --reset-hard staying on master' \
  super \
  '(cd submodule && git reset --hard HEAD~1)' \
  'git submodule update --reset-hard submodule'

where I just pass 
  the path to work in, 
  the test setup function, 
  and the test action.  

The rest (initial cd, record, run setup, verify that there is a change, run
action, verify there is no changes) is done by the
test_expect_unchanged_submodule_status in a uniform way, absorbing all the
boiler plate.  (I am not married to the name, could be more descriptive/generic
may be)

Then we could breed a good number of tests with little to no boiler plate, with
only relevant pieces and as extended as needed testing done by this
test_expect_unchanged_submodule_status helper. e.g smth like

test_expect_unchanged_submodule_status 'submodule update --reset-hard staying on master when I do a new commit' \
  super \
  '(cd submodule && git commit --allow-empty -m "new one"' \
  'git submodule update --reset-hard submodule'

and kaboom -- we have a new test.  If we decide to test more -- just tune up
test_expect_unchanged_submodule_status and done -- all the tests remain
sufficiently prescribed.

What do you think?
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
