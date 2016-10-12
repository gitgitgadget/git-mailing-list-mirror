Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25AC2207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 13:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933781AbcJLNew (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:34:52 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:45280 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932754AbcJLNee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 09:34:34 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1buJfB-00028p-N3; Wed, 12 Oct 2016 15:33:41 +0200
Date:   Wed, 12 Oct 2016 15:33:38 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 3/3] batch check whether submodule needs pushing into
 one call
Message-ID: <20161012133338.GD84247@book.hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net>
 <cover.1475851621.git.hvoigt@hvoigt.net>
 <67d4c48dc0129f20041c88d27a49c7a21188c882.1475851621.git.hvoigt@hvoigt.net>
 <xmqqlgxvbype.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgxvbype.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 03:56:13PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > -static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
> > +static int check_has_hash(const unsigned char sha1[20], void *data)
> >  {
> > -	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
> > +	int *has_hash = (int *) data;
> > +
> > +	if (!lookup_commit_reference(sha1))
> > +		*has_hash = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int submodule_has_hashes(const char *path, struct sha1_array *hashes)
> > +{
> > +	int has_hash = 1;
> > +
> > +	if (add_submodule_odb(path))
> > +		return 0;
> > +
> > +	sha1_array_for_each_unique(hashes, check_has_hash, &has_hash);
> > +	return has_hash;
> > +}
> > +
> > +static int submodule_needs_pushing(const char *path, struct sha1_array *hashes)
> > +{
> > +	if (!submodule_has_hashes(path, hashes))
> >  		return 0;
> 
> Same comment about naming.  
> 
> What do check-has-hash and submodule-has-hashes exactly mean by
> "hash" in their names?  Because I think what is checked here is
> "does the local submodule repository have _all_ the commits
> referenced from the superproject commit we are pushing?", so I'd
> prefer to see "commit" in their names.
> 
> If we do not even have these commits locally, then there is no point
> attempting to push, so returning 0 (i.e. it is not "needs pushing"
> situation) is correct but it is a but subtle.  It's not "we know
> they already have them", but it is "even if we tried to push, it
> won't do us or the other side any good."  A single-liner in-code
> comment may help.

First the naming part. How about:

	submodule_has_commits()

?

Second as mentioned a previous answer[1] to this part: I would actually
like to have a die() here instead of blindly proceeding. Since the user
either specified --recurse-submodules=... at the commandline or it was
implicitly enabled because we have submodules in the tree we should be
careful and not push revisions referencing submodules that are not
available at a remote. If we can not properly figure it out I would
suggest to stop and tell the user how to solve the situation. E.g.
either she clones the appropriate submodules or specifies
--no-recurse-submodules on the commandline to tell git that she does not
care.

Returning 0 here means: "No push needed" but the correct answer would
be: "We do not know". Question is what we should do here which I am
planning to address in a separate patch series since that will be
changing behavior.

So how about:


	if (!submodule_has_hashes(path, hashes))
		/* NEEDSWORK: The correct answer here is "We do not
		 * know" instead of "No". We currently proceed pushing
		 * here as if the submodules commits are available on a
		 * remote, which is not always correct. */
		return 0;

What do you think?

Cheers Heiko

[1] http://public-inbox.org/git/20160919195812.GC62429@book.hvoigt.net/
