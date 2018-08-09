Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE171F405
	for <e@80x24.org>; Thu,  9 Aug 2018 09:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbeHILiI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 07:38:08 -0400
Received: from ao2.it ([92.243.12.208]:35500 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbeHILiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 07:38:08 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fngzo-0005xp-3Z; Thu, 09 Aug 2018 11:12:40 +0200
Date:   Thu, 9 Aug 2018 11:14:08 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH v2 10/12] t7416: add new test about HEAD:.gitmodules
 and not existing .gitmodules
Message-Id: <20180809111408.3ee7296a8aefd38ea1208547@ao2.it>
In-Reply-To: <CAGZ79kbQ0DsAXZrvpp3_2CrMU6Jburf6UdjTxNSd72JqQCczWQ@mail.gmail.com>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-11-ao2@ao2.it>
        <CAGZ79kbQ0DsAXZrvpp3_2CrMU6Jburf6UdjTxNSd72JqQCczWQ@mail.gmail.com>
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

On Thu, 2 Aug 2018 13:43:05 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
> >
> > git submodule commands can now access .gitmodules from the current
> > branch even when it's not in the working tree, add some tests for that
> > scenario.
> >
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---

[...]
> > +NOTE: "git mv" and "git rm" are still supposed to work even without
> > +a .gitmodules file, as stated in the t3600-rm.sh and t7001-mv.sh tests.
> 
> "supposed to work" != "tested that it works" ?

"git mv submod new_submod" and "git rm submod" are actually expected to
work without the .gitmodules file, and there are tests about that in
t3600-rm.sh and t7001-mv.sh:

t3600-rm.sh:
  'rm does not complain when no .gitmodules file is found'

t7001-mv.sh:
  'git mv moves a submodule with a .git directory and no .gitmodules'  
  'mv does not complain when no .gitmodules file is found'

> I am not sure what the NOTE wants to tell me? (Should I review those
> tests to double check them now? or do we just want to tell future readers
> of this test there are other tangent tests to this?)
>

Admittedly the NOTE is not useful without any context: during the
development of "submodule--helper config --stage" I initially assumed
that "git mv" and "git rm" should fail if .gitmodules was not available,
because these commands modify .gitmodules and I added code for that in
stage_updated_gitmodules().

But then later I found out that my assumption was wrong and that git has
tests to verify that these operations on submodules succeed even when
.gitmodules does not exist, which was a little of a surprise to me.

So I removed all my code that was conflicting with git assumptions, and
added the NOTE. However I guess that was primarily a note to myself, and
it should have not slipped in the public patches.

I think I will remove the note, it can be confusing and does not really
add anything, and even less considering that "submodule--helper config
--stage" is going to be dropped.

[...]
> > +test_expect_success 'not adding submodules when the gitmodules config is not checked out' '
> > +       (cd super &&
> > +               test_must_fail git submodule add ../new_submodule
> > +       )
> > +'
> > +
> > +# "git add" in the test above fails as expected, however it still leaves the
> > +# cloned tree in there and adds a config entry to .git/config. This is because
> > +# no cleanup is done by cmd_add in git-submodule.sh when "git
> > +# submodule--helper config" fails to add a new config setting.
> > +#
> > +# If we added the following commands to the test above:
> > +#
> > +#   rm -rf .git/modules/new_submodule &&
> > +#   git reset HEAD new_submodule &&
> > +#   rm -rf new_submodule
> 
> Alternatively we could check for the existence of .gitmodules
> before starting all these things?
>

You mean in cmd_add(), before doing anything?

The following would anticipates the same check which makes "git submodule
add" fail:

diff --git a/git-submodule.sh b/git-submodule.sh
index ff258e2e8c..b261175143 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -159,6 +159,11 @@ cmd_add()
                shift
        done

+       if test ! -e .gitmodules && git cat-file -e HEAD:.gitmodules
+       then
+                die "$(eval_gettext "please make sure that the .gitmodules file in the current branch is checked out")"
+       fi
+
        if test -n "$reference_path"
        then
                is_absolute_path "$reference_path" ||

This refers to .gitmodules explicitly but we said that we do not care
about that for now, if opaque access was ever needed in the future,
something like "submodule--helper config --is-writeable" could be added.

> I think it is okay to not clean up if we check all "regular" or rather expected
> things such as a non-writable .gitmodules file before actually doing it.
> (This is similar to 'checkout' that walks the whole tree and checks if the
> checkout is possible given the dirtyness of the tree, to either abort early
> or pull through completely. In catastrophic problems such as a full disk
> we'd still die in the middle of work)
> 
> > +#
> > +# then the repository would be in a clean state and the test below would pass.
> > +#
> > +# Maybe cmd_add should do the cleanup from above itself when failing to add
> > +# a submodule.
> > +test_expect_failure 'init submodule after adding failed when the gitmodules config is not checked out' '
> 
> So this comment and test is about explaining why we can fail mid way through,
> which we could not before unless we had the catastrophic event.
> 
> I think we should check for a "writable" .gitmodules file at the beginning,
> which is if (G || (!G && !H)) [using the notation from the cover letter]?
> 
> > +       (cd super &&
> > +               git submodule init

With the change from above this last test passes.

BTW the check I am using here and in the code of submodule--helper,
corresponds indeed to the boolean expression you mentioned, but
simplified and negated.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
