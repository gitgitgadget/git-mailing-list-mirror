Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B4520441
	for <e@80x24.org>; Wed, 28 Dec 2016 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbcL1TTb (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 14:19:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751906AbcL1TTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 14:19:31 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B86C81F01;
        Wed, 28 Dec 2016 19:19:30 +0000 (UTC)
Received: from localhost (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBSJJTwr025071;
        Wed, 28 Dec 2016 14:19:30 -0500
Date:   Wed, 28 Dec 2016 17:19:28 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2] am: add am.signoff add config variable
Message-ID: <20161228191928.GH3441@thinpad.lan.raisama.net>
References: <20161228183501.15068-1-ehabkost@redhat.com>
 <CAGZ79kaBpC5ym2N_fMZHDmL4gGpU8pFAsupCE4aTdENh+=z72g@mail.gmail.com>
 <20161228191142.GF3441@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161228191142.GF3441@thinpad.lan.raisama.net>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 28 Dec 2016 19:19:30 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 05:11:42PM -0200, Eduardo Habkost wrote:
> On Wed, Dec 28, 2016 at 10:51:28AM -0800, Stefan Beller wrote:
> > On Wed, Dec 28, 2016 at 10:35 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
[...]
> > > +       test $(git cat-file commit HEAD | grep -c "Signed-off-by:") -eq 0
> > 
> > and then we check if the top most commit has zero occurrences
> > for lines grepped for sign off. That certainly works, but took me a
> > while to understand (TIL about -c in grep :).
> > 
> > Another way that to write this check, that Git regulars may be more used to is:
> > 
> >     git cat-file commit HEAD | grep "Signed-off-by:" >actual
> >     test_must_be_empty actual
> 
> test_must_be_empty is what I was looking for. But if I do this:
> 
> test_expect_success '--no-signoff overrides am.signoff' '
> 	rm -fr .git/rebase-apply &&
> 	git reset --hard first &&
> 	test_config am.signoff true &&
> 	git am --no-signoff <patch2 &&
> 	printf "%s\n" "$signoff" >expected &&
> 	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
> 	test_cmp expected actual &&
> 	git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
> 	test_must_be_empty actual
> '
> 
> The test fails because the second "grep" command returns a
> non-zero exit code. Any suggestions to avoid that problem in a
> more idiomatic way?

I just found out that "test_must_fail grep ..." is a common
idiom, so what about:

test_expect_success '--no-signoff overrides am.signoff' '
	rm -fr .git/rebase-apply &&
	git reset --hard first &&
	test_config am.signoff true &&
	git am --no-signoff <patch2 &&
	printf "%s\n" "$signoff" >expected &&
	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
	test_cmp expected actual &&
	git cat-file commit HEAD | test_must_fail grep -q "Signed-off-by:"
'

-- 
Eduardo
