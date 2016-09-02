Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A541FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 20:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933010AbcIBUNr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 16:13:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:37227 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932694AbcIBUNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 16:13:46 -0400
Received: (qmail 21316 invoked by uid 109); 2 Sep 2016 20:13:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 20:13:23 +0000
Received: (qmail 27298 invoked by uid 111); 2 Sep 2016 20:13:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 16:13:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 16:13:21 -0400
Date:   Fri, 2 Sep 2016 16:13:21 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
Message-ID: <20160902201321.35egsg5l6r2fvrtw@sigill.intra.peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 10:15:39AM -0700, Jonathan Tan wrote:

> connect.c, when processing packfiles, treats a zero ID (with
> `capabilities^{}` in place of the refname) as an actual ref instead of a
> placeholder for a capability declaration, contrary to the specification
> in Reference Discovery in Documentation/technical/pack-protocol.txt.
> This is an issue when interacting with Git implementations that follow
> this specification. For example, `ls-remote` (against a git://
> repository served by such a Git implementation) will report a ref when
> there are none, and `clone` (against something similar) will fail its
> checkout.
> 
> Make connect.c follow the specification with respect to this, while
> maintaining compatibility with existing implementations that do not
> serve the zero ID when a repository has no refs.

Hmm. So since this is backwards-compatible, I'm not overly concerned
with changing the client. But I wonder if you considered that the
documentation is wrong, and that JGit should stop sending the extra
capabilities line?

In either case, there will still be breakage until _somebody_ upgrades
(with your patch, until clients upgrade; with a JGit patch, until the
server upgrades). So perhaps an interesting question would be: if we
were writing this now, what is the correct behavior?

For pushing, it is obviously useful to send capabilities even though
there are no refs (because the client is going to send _you_ something).
And that is why "capabilities^{}" exists; it is a receive-pack feature
(that is actually implemented!), and the documentation (which came after
the implementation) blindly mentioned it for upload-pack, as well.

Is it useful for upload-pack? If we have no refs, there's traditionally
been nothing to fetch. Perhaps that's something that could change,
though. For example, there could be a capability to allow fetching
arbitrary sha1s (we have allowTIPSH1InWant and allowReachableSHA1InWant,
which obviously both require some refs, but allowArbitrarySHA1 does not
seem outside the realm of possibility).

I'll review the rest assuming that this is the direction we want to
go...

> (git-daemon should probably also be changed to serve zero IDs, but such
> a change can be considered independently from this change; even if both
> the client and server changes were made in one commit, it is nearly
> impossible that all Git installations are updated at the same time - an
> updated client would still need to deal with unupdated servers and vice
> versa.)

I'm really not sure what you mean here. How does git-daemon enter into
this at all?

> +		if (is_null_oid(&old_oid)) {
> +			if (strcmp(name, "capabilities^{}"))
> +				warning("zero object ID received that is not accompanied by a "
> +				        "capability declaration, ignoring and continuing anyway");
> +			continue;
> +		}

I agree with Shawn that this should be looking for "capabilities^{}" as
the name of the first entry (and the warning can go away; if we see any
other null sha1, it just gets handled in the usual error code paths).

> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 819b9dd..c6f8b6f 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -207,5 +207,27 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
>  	test_cmp expect actual
>  '
>  
> +test_lazy_prereq GIT_DAEMON '
> +	test_have_prereq JGIT &&
> +	test_tristate GIT_TEST_GIT_DAEMON &&
> +	test "$GIT_TEST_GIT_DAEMON" != false
> +'

GIT_DAEMON depends on JGIT? Should this really be the JGIT_DAEMON
prerequisite?

> +# This test spawns a daemon, so run it only if the user would be OK with
> +# testing with git-daemon.
> +test_expect_success JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
> +	JGIT_DAEMON_PID= &&
> +	git init --bare empty.git &&
> +	touch empty.git/git-daemon-export-ok &&
> +	{
> +		jgit daemon --port="$JGIT_DAEMON_PORT" . &
> +		JGIT_DAEMON_PID=$!
> +	} &&
> +	test_when_finished kill "$JGIT_DAEMON_PID" &&
> +	sleep 1 && # allow jgit daemon some time to set up

We definitely need something more robust than this "sleep". This test is
going to fail racily when the system is under load.

-Peff
