Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6B9203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 08:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbcGZIDW (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 04:03:22 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:55863 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751660AbcGZIDT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2016 04:03:19 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id D032DC4736;
	Tue, 26 Jul 2016 09:03:16 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id C4CE82092C;
	Tue, 26 Jul 2016 09:03:16 +0100 (BST)
X-Quarantine-ID: <q7fJqsTCGm1l>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q7fJqsTCGm1l; Tue, 26 Jul 2016 09:03:15 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id D2C8362000;
	Tue, 26 Jul 2016 09:03:13 +0100 (BST)
Date:	Tue, 26 Jul 2016 09:03:09 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] push: add shorthand for --force-with-lease branch
 creation
Message-ID: <20160726080309.pr46bbtzdvnr7fd3@john.keeping.me.uk>
References: <cover.1469483499.git.john@keeping.me.uk>
 <4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
 <xmqqpoq12w93.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoq12w93.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 03:22:48PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Allow the empty string to stand in for the null SHA-1 when pushing a new
> > branch, like we do when deleting branches.
> >
> > This means that the following command ensures that `new-branch` is
> > created on the remote (that is, is must not already exist):
> >
> > 	git push --force-with-lease=new-branch: origin new-branch
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > New in v2.
> >
> >  Documentation/git-push.txt |  3 ++-
> >  remote.c                   |  2 ++
> >  t/t5533-push-cas.sh        | 12 ++++++++++++
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> > index bf7c9a2..927a034 100644
> > --- a/Documentation/git-push.txt
> > +++ b/Documentation/git-push.txt
> > @@ -201,7 +201,8 @@ if it is going to be updated, by requiring its current value to be
> >  the same as the specified value `<expect>` (which is allowed to be
> >  different from the remote-tracking branch we have for the refname,
> >  or we do not even have to have such a remote-tracking branch when
> > -this form is used).
> > +this form is used).  If `<expect>` is the empty string, then the named ref
> > +must not already exist.
> >  +
> >  Note that all forms other than `--force-with-lease=<refname>:<expect>`
> >  that specifies the expected current value of the ref explicitly are
> > diff --git a/remote.c b/remote.c
> > index a326e4e..af94892 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -2294,6 +2294,8 @@ int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unse
> >  	entry = add_cas_entry(cas, arg, colon - arg);
> >  	if (!*colon)
> >  		entry->use_tracking = 1;
> > +	else if (!colon[1])
> > +		memset(entry->expect, 0, sizeof(entry->expect));
> 
> hashclr()?

Yes (and in the following patch as well).  I hadn't realised that
function exists.

> >  	else if (get_sha1(colon + 1, entry->expect))
> >  		return error("cannot parse expected object name '%s'", colon + 1);
> >  	return 0;
> > diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> > index c732012..5e7f6e9 100755
> > --- a/t/t5533-push-cas.sh
> > +++ b/t/t5533-push-cas.sh
> > @@ -191,4 +191,16 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'new branch covered by force-with-lease (explicit)' '
> > +	setup_srcdst_basic &&
> > +	(
> > +		cd dst &&
> > +		git branch branch master &&
> > +		git push --force-with-lease=branch: origin branch
> > +	) &&
> > +	git ls-remote dst refs/heads/branch >expect &&
> > +	git ls-remote src refs/heads/branch >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_done
