From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-parse --namespace
Date: Sun, 17 Jan 2010 14:08:27 -0500
Message-ID: <20100117190827.GA31536@coredump.intra.peff.net>
References: <1263735931-20227-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100117162712.GB7153@sigill.intra.peff.net>
 <20100117164057.GA20554@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:08:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWaUQ-00084I-T1
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420Ab0AQTIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403Ab0AQTIb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:08:31 -0500
Received: from peff.net ([208.65.91.99]:60840 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351Ab0AQTIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:08:31 -0500
Received: (qmail 27621 invoked by uid 107); 17 Jan 2010 19:13:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 17 Jan 2010 14:13:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 14:08:27 -0500
Content-Disposition: inline
In-Reply-To: <20100117164057.GA20554@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137308>

On Sun, Jan 17, 2010 at 06:40:57PM +0200, Ilari Liusvaara wrote:

> On Sun, Jan 17, 2010 at 11:27:12AM -0500, Jeff King wrote:
> > On Sun, Jan 17, 2010 at 03:45:31PM +0200, Ilari Liusvaara wrote:
> > 
> > > Add --namespace=<namespace> option to rev-parse and everything that
> > > accepts its options. This option matches all refs in some subnamespace
> > > of refs hierarchy, and is useful for selecting everything reachable from
> > > one or few, but not all remotes (--namespace=remotes/foo).
> > 
> > If I understand it correctly, isn't the same as
> > 
> >   git for-each-ref refs/remotes/foo
> 
> Nope. Compare:
> 
> 'git log --branches --not --namespace=remotes/origin' 
> 
> with whatever you would have to currently type...

OK, that makes sense and is actually useful. That is the sort of
motivation that should go in the commit message. Mentioning "rev-parse"
is a bit of a red herring.

As for the patch text itself, it looks correct, though I have a few
nits:

> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 82045a2..af4605a 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -112,6 +112,10 @@ OPTIONS
>  --remotes::
>  	Show tag refs found in `$GIT_DIR/refs/remotes`.
>  
> +--namespace=namespace-prefix::
> +	Show refs found in `$GIT_DIR/namespace-prefix`. If namespace
> +	specified lacks leading 'refs/', it is automatically prepended.
> +

This is not a new problem you are introducing, as you are just following
the template of of --remotes and others above, but is "show" really the
right word? In the rev-list page these entries talk about "pretend as if
these refs were given on the command line". Isn't that also the case
here? If I say "git rev-parse --not --remotes" (or --namespace=), I will
get "^"-lines.

Also, I notice in the context that the remotes entry says "Show tag
refs" which is obviously wrong. Again, not your problem, but something
to clean up while in the area.

> +			if (!prefixcmp(arg, "--namespace=")) {
> +				set_for_each_namespace(arg + 12);
> +				for_each_namespace_ref(show_reference, NULL);
> +				continue;
> +			}

I was going to complain about the use of a global variable here when we
could simply pass the namespace into the function, but I see that in the
other call here:

> diff --git a/revision.c b/revision.c
> index 25fa14d..9e1d960 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1352,6 +1352,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  				handle_refs(revs, flags, for_each_remote_ref);
>  				continue;
>  			}
> +			if (!prefixcmp(arg, "--namespace=")) {
> +				set_for_each_namespace(arg + 12);
> +				handle_refs(revs, flags, for_each_namespace_ref);
> +				continue;
> +			}

...that giving the for_each_namespace_ref function a different signature
than the other for_each_* functions would complicate things. OTOH,
handle_refs is only a 4 line helper to set up the callback struct, so
perhaps it is better to simply duplicate it rather than introduce a new
global.

Too bad we can't do currying in C. :)

> +void set_for_each_namespace(const char *ref_namespace)
> +{
> +	size_t alloclen, origlen;
> +	if (prefix_namespace)
> +		free(prefix_namespace);
> +
> +	/* Compute the length of true prefix. */
> +	origlen = alloclen = strlen(ref_namespace);
> +	if (*ref_namespace && ref_namespace[origlen - 1] != '/')
> +		alloclen++;
> +	if (prefixcmp(ref_namespace, "refs/"))
> +		alloclen += 5;		/* 'refs/' */
> +
> +	/* Allocate and build it (assume alloclen is "small") */
> +	prefix_namespace = xmalloc(alloclen + 1);
> +	*prefix_namespace = 0;
> +	if (prefixcmp(ref_namespace, "refs/"))
> +		strcat(prefix_namespace, "refs/");
> +	strcat(prefix_namespace, ref_namespace);
> +	if (*ref_namespace && ref_namespace[origlen - 1] != '/')
> +		strcat(prefix_namespace, "/");
> +}

Wouldn't this be much simpler and more readable using a strbuf? As in:

  strbuf_reset(&prefix_namespace);
  if (prefixcmp(ref_namespace, "refs/"))
    strbuf_addstr(&prefix_namespace, "refs/");
  strbuf_addstr(&prefix_namespace, ref_namespace);
  if (prefix_namespace.buf[prefix_namespace.len-1] != '/')
    strbuf_addch(&prefix_namespace, '/');

?

> +test_expect_success 'setup' '
> +
> +	commit master &&
> +	git checkout -b subspace/one master
> +	commit one &&
> +	git checkout -b subspace/two master
> +	commit two &&
> +	git checkout -b other/three master
> +	commit three &&
> +	git checkout -b someref master
> +	commit some &&
> +	git checkout master
> +	commit master2
> +'

Missing '&&' on the checkout lines?

> +test_expect_success 'rev-parse --namespace=refs/heads/subspace/' '
> +
> +	test 2 = $(git rev-parse --namespace=refs/heads/subspace/ | wc -l)
> +
> +'

This is perhaps a minor nit, but I really prefer to write this by
putting the expected output in a file and using test_cmp, because:

  1. You actually test that rev-parse exits correctly.

  2. You test that it actually produced the correct output, and not
     simply two lines which are presumably correct.

  3. If it _does_ fail, the output from test_cmp is a nicely readable
     diff between expected and actual output. Your test produces no
     output.

We also had some problems with different implementations of "wc"
producing different amounts of whitespace, but I don't think that is a
problem here since the shell should eat any whitespace outside of
quotation marks.

-Peff
