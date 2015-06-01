From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] t6301: new tests of for-each-ref error handling
Date: Mon, 1 Jun 2015 12:08:34 -0400
Message-ID: <20150601160834.GA15148@peff.net>
References: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
 <1433174031-5471-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:08:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzSGZ-00025r-05
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 18:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbbFAQIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 12:08:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:38943 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752495AbbFAQIh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 12:08:37 -0400
Received: (qmail 5172 invoked by uid 102); 1 Jun 2015 16:08:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 11:08:36 -0500
Received: (qmail 31602 invoked by uid 107); 1 Jun 2015 16:08:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 12:08:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 12:08:34 -0400
Content-Disposition: inline
In-Reply-To: <1433174031-5471-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270432>

On Mon, Jun 01, 2015 at 05:53:49PM +0200, Michael Haggerty wrote:

> Add tests that for-each-ref correctly reports broken loose reference
> files and references that point at missing objects. In fact, two of
> these tests fail, because (1) NULL_SHA1 is not recognized as an
> invalid reference value, and (2) for-each-ref doesn't respect
> REF_ISBROKEN. Fixes to come.

This whole series looks straightforward and correct to me. Thanks for a
pleasant read. I have two minor comments on the tests:

> --- /dev/null
> +++ b/t/t6301-for-each-ref-errors.sh
> @@ -0,0 +1,45 @@
> +#!/bin/sh
> +
> +test_description='for-each-ref errors for broken refs'
> +
> +. ./test-lib.sh
> +
> +ZEROS=0000000000000000000000000000000000000000
> +MISSING=abababababababababababababababababababab

The test suite provides $_z40, so you can skip $ZEROS. I don't think
it's a big deal, though, and it may be nicer to have it explicitly next
to $MISSING here.

> +test_expect_success 'Missing objects are reported correctly' '
> +	r=refs/heads/missing &&
> +	echo $MISSING >.git/$r &&
> +	test_when_finished "rm -f .git/$r" &&
> +	echo "fatal: missing object $MISSING for $r" >missing-err &&
> +	test_must_fail git for-each-ref 2>err &&
> +	test_cmp missing-err err
> +'

Due to b7dd2d2 (that you mentioned in the message for patch 2), we only
sometimes notice the missing objects. Is it worth testing that:

  git for-each-ref --format='%(refname)'

does _not_ barf here?

-Peff
