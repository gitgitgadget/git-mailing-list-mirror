From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/6] test-lib: verbose mode for only tests matching a
 pattern
Date: Tue, 18 Jun 2013 01:37:12 -0400
Message-ID: <20130618053710.GB5916@sigill.intra.peff.net>
References: <cover.1371460265.git.trast@inf.ethz.ch>
 <8739d3ba5947c60d402030fc35d47115e7a51b0f.1371460265.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 18 07:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uooba-0001wy-HQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 07:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab3FRFhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 01:37:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:34265 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab3FRFhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 01:37:15 -0400
Received: (qmail 21540 invoked by uid 102); 18 Jun 2013 05:38:12 -0000
Received: from mobile-032-141-227-127.mycingular.net (HELO sigill.intra.peff.net) (32.141.227.127)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 00:38:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 01:37:12 -0400
Content-Disposition: inline
In-Reply-To: <8739d3ba5947c60d402030fc35d47115e7a51b0f.1371460265.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228154>

On Mon, Jun 17, 2013 at 11:18:48AM +0200, Thomas Rast wrote:

> As suggested by Jeff King, this takes care to wrap the entire test_expect_*
> block, but nothing else, in the verbose toggling.  To that end we use
> a new pair of hook functions.  The placement is a bit weird because we
> need to wait until the beginning of test_skip for $test_count to be
> incremented.

I guess it is not surprising because I suggested it, but I find the new
setup/teardown logic easier to follow than the old toggle. The weird
placement did throw me for a minute while reading the patch. I wonder if
it is worth pulling the increment out of test_skip, to have something
like this in test_expect_*:

  test_start ;# increment number, run setup hooks
  if ! test_skip
  then
    ...
  fi
  test_finish ;# teardown hooks

Then it is a bit easier to see that each start has a finish (whereas in
the current version, the setups in test_skip are matched by individual
teardowns in each caller). I did not look too hard at it, though, so I
wouldn't be surprised if there is some other hidden order dependency
that makes that not work. :)

> +# Called from test_skip after it has incremented $test_count.  This
> +# means it runs before any test-specific code and output.
> +test_setup_hook_ () {
> +	maybe_setup_verbose
> +}
> +
> +# Called at the end of test_expect_*.  This means it runs after all
> +# test-specific code and output.
> +test_teardown_hook_ () {
> +	maybe_teardown_verbose
> +}

So these do your verbose setup/teardown. Makes sense.

But then what is this hunk doing:

>  test_eval_ () {
>  	# This is a separate function because some tests use
>  	# "return" to end a test_expect_success block early.
> @@ -358,9 +399,7 @@ test_run_ () {
>  
>  	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
>  	then
> -		setup_malloc_check
>  		test_eval_ "$test_cleanup"
> -		teardown_malloc_check
>  	fi
>  	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
>  	then

At first I thought these should go into your setup/teardown hooks, but I
don't think so. They are made redundant by patch 1/6, which wraps all of
test_eval with malloc setup/teardown, aren't they? Should this hunk be
in patch 1?

-Peff
