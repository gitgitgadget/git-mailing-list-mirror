Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9DC20281
	for <e@80x24.org>; Sun, 17 Sep 2017 09:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdIQJn2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 05:43:28 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:33885 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750803AbdIQJn1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 05:43:27 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dtW6m-0008Ma-4c; Sun, 17 Sep 2017 10:43:24 +0100
Message-ID: <1505641403.22447.6.camel@hellion.org.uk>
Subject: Re: [PATCH v2 4/4] Subject: filter-branch: stash away ref map in a
 branch
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Date:   Sun, 17 Sep 2017 10:43:23 +0100
In-Reply-To: <20170917073657.31193-4-ijc@hellion.org.uk>
References: <1505633797.22447.4.camel@hellion.org.uk>
         <20170917073657.31193-4-ijc@hellion.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-09-17 at 08:36 +0100, Ian Campbell wrote:
> +if test -n "$state_branch"
> +then
> > +	echo "Saving rewrite state to $state_branch" 1>&2
> > +	state_blob=$(
> > +		perl -e'opendir D, "../map" or die;
> > +			open H, "|-", "git hash-object -w --stdin" or die;
> > +			foreach (sort readdir(D)) {
> > +				next if m/^\.\.?$/;
> > +				open F, "<../map/$_" or die;
> > +				chomp($f = <F>);
> > +				print H "$_:$f\n" or die;
> > +			}
> > +			close(H) or die;' || die "Unable to save state")

One things I've noticed is that for a full Linux tree history the
filter.map file is 50M+ which causes github to complain:

    remote: warning: File filter.map is 54.40 MB; this is larger than GitHub's recommended maximum file size of 50.00 MB

(you can simulate this with `git log --pretty=format:"%H:%H"
upstream/master`.) I suppose that's not a bad recommendation for any
infra, not just GH's.

The blob is compressed in the object store so there isn't _much_ point
in compressing the map (also, it only goes down to ~30MB anyway so we
aren't buying all that much time), but I'm wondering if perhaps I
should look into a more intelligent representation, perhaps hashed by
the first two characters (as .git/objects is) to divide into several
blobs and have two levels.

I'm also wondering if the .git-rewrite/map directory, which will have
70k+ (and growing) directory entries for a modern Linux tree, would
benefit from the same sort of thing. OTOH in this case the extra shell
machinations to turn abcdef123 into ab/cdef123 might overwhelm the
savings in directory lookup time (unless there is a helper already for
that. That assume that directory lookup is even a bottleneck, I've not
measured but anecdotally/gut-feeling the commits-per-second does seem
to be decreasing over the course of the filtering process.

Ian.
