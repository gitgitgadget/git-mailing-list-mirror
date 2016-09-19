Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993F92070F
	for <e@80x24.org>; Mon, 19 Sep 2016 19:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbcIST6T (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 15:58:19 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:48284 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbcIST6S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 15:58:18 -0400
Received: from [84.168.70.3] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bm4hh-0007gh-Hj; Mon, 19 Sep 2016 21:58:13 +0200
Date:   Mon, 19 Sep 2016 21:58:12 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 3/2] batch check whether submodule needs pushing into one
 call
Message-ID: <20160919195812.GC62429@book.hvoigt.net>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
 <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
 <20160914173124.GA7613@sandbox>
 <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
 <20160915121044.GA96648@book.hvoigt.net>
 <xmqq8turlo8m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8turlo8m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 10:59:37AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > +static void check_has_hash(const unsigned char sha1[20], void *data)
> > +{
> > +	int *has_hash = (int *) data;
> > +
> > +	if (!lookup_commit_reference(sha1))
> > +		*has_hash = 0;
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
> I think you meant well, but this optimization is wrong.  A mere
> presence of an object does not mean that the current tip can reach
> that object.  Imagine you pushed commit A earlier to them at the
> tip, then pushed commit A~ to them at the tip, which is the current
> state of the remote of the submodule, and since them they may have
> GC'ed.  They no longer have the commit A.
> 
> For that matter, because you are doing this check by pretending as
> if all the submodule objects are in the object store of the current
> superproject you are working in, and saying "it exists there in the
> submodule repository" when the only thing you know is it exists in
> an object store of either the submodule repository, the superproject
> repository, or any of the other submodule repositories, you really
> cannot tell much from a mere presence of an object.  Not just the
> remote of the submodule repository you are interested in, but the
> submodule repository you are interested in itself, may not have that
> object.
> 
> Drop the previous two helper functions and this short-cut.

This is nothing I added. This came from the original code which I simply
extended to check for all sha1's. The diff is a little bit misleading. This
would be the local diff:

-       if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
+       if (!submodule_has_hashes(path, hashes))
                return 0;

I think that this is more a shortcut for: If we can not find the sha1, we do
not need to bother spawning a process for the real check. We default to the
answer no in that case.

It looks like the reason for the sha1 check is to avoid error output from the
spawned 'rev-list' process. The error output might be confusing to the user in
case the sha1 does not exist in the submodule. We should probably die here
since we were not able to check a submodule that has a diff in the revisions we
would push.

After thinking about this further: I think it is actually bad to proceed here,
as the current revisions (just in the superproject) would still be pushed and
the user possibly gets an inconsistent state on the remote side which he tried
to avoid with check/on-demand-push enabled.

So in short this deserves some further love. Will have a look into adding
another patch for this if we agree on my suggestion to die above.

Cheers Heiko
