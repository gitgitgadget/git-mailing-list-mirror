Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D6F20441
	for <e@80x24.org>; Wed, 28 Dec 2016 19:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbcL1TLp (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 14:11:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbcL1TLo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 14:11:44 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F09C3B720;
        Wed, 28 Dec 2016 19:11:44 +0000 (UTC)
Received: from localhost (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBSJBhVZ012701;
        Wed, 28 Dec 2016 14:11:43 -0500
Date:   Wed, 28 Dec 2016 17:11:42 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2] am: add am.signoff add config variable
Message-ID: <20161228191142.GF3441@thinpad.lan.raisama.net>
References: <20161228183501.15068-1-ehabkost@redhat.com>
 <CAGZ79kaBpC5ym2N_fMZHDmL4gGpU8pFAsupCE4aTdENh+=z72g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaBpC5ym2N_fMZHDmL4gGpU8pFAsupCE4aTdENh+=z72g@mail.gmail.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Dec 2016 19:11:44 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 10:51:28AM -0800, Stefan Beller wrote:
> On Wed, Dec 28, 2016 at 10:35 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > git-am has options to enable --message-id and --3way by default,
> > but no option to enable --signoff by default. Add a "am.signoff"
> > config option.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * Added documentation to Documentation/git-am.txt and
> >   Documentation/config.txt
> > * Added test cases to t4150-am.sh
> 
> Thanks!
> Documentation and code looks good to me, for the test a small nit below.
> 
> > +test_expect_success '--no-signoff overrides am.signoff' '
> > +       rm -fr .git/rebase-apply &&
> > +       git reset --hard first &&
> > +       test_config am.signoff true &&
> > +       git am --no-signoff <patch2 &&
> > +       printf "%s\n" "$signoff" >expected &&
> 
> "expected" is never read in this test, so we can omit this line?
> 

Oops, I have deleted a "test_cmp expected actual" line by mistake.

> > +       git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
> 
> So we check if the previous commit is not tampered with,

We do, but only if we have a "test_cmp expected actual" line
here.

Fixed by:

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 41b5481c9..d4b6a832f 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -486,6 +486,7 @@ test_expect_success '--no-signoff overrides am.signoff' '
 	git am --no-signoff <patch2 &&
 	printf "%s\n" "$signoff" >expected &&
 	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
+	test_cmp expected actual &&
 	test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
 '
 
> 
> > +       test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
> 
> and then we check if the top most commit has zero occurrences
> for lines grepped for sign off. That certainly works, but took me a
> while to understand (TIL about -c in grep :).
> 
> Another way that to write this check, that Git regulars may be more used to is:
> 
>     git cat-file commit HEAD | grep "Signed-off-by:" >actual
>     test_must_be_empty actual

test_must_be_empty is what I was looking for. But if I do this:

test_expect_success '--no-signoff overrides am.signoff' '
	rm -fr .git/rebase-apply &&
	git reset --hard first &&
	test_config am.signoff true &&
	git am --no-signoff <patch2 &&
	printf "%s\n" "$signoff" >expected &&
	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
	test_cmp expected actual &&
	git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
	test_must_be_empty actual
'

The test fails because the second "grep" command returns a
non-zero exit code. Any suggestions to avoid that problem in a
more idiomatic way?

> 
> I would have suggested to grep for $signoff instead of "Signed-off-by:",
> but it turns out being fuzzy here is better and would also catch e.g.
> a broken sign off.

Yes, I want to ensure no extra Signed-off-by line is present
except for $signof (that is already present in the original
e-mail).

> 
> > +test_expect_success 'am.signoff adds Signed-off-by: line' '
> > +       rm -fr .git/rebase-apply &&
> > +       git reset --hard first &&
> > +       test_config am.signoff true &&
> > +       git am <patch2 &&
> > +       printf "%s\n" "$signoff" >expected &&
> > +       echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >>expected &&
> > +       git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
> > +       test_cmp expected actual &&
> > +       echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
> > +       git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
> > +       test_cmp expected actual
> > +'
> 
> This test looks good to me,
> 
> Thanks,
> Stefan

-- 
Eduardo
