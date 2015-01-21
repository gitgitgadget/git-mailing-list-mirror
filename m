From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] update-ref: Test handling large transactions properly
Date: Wed, 21 Jan 2015 18:34:57 -0500
Message-ID: <20150121233457.GA11115@peff.net>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
 <1421882625-916-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	loic@dachary.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:35:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4nr-000874-7w
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbbAUXfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:35:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:37087 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754138AbbAUXe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:34:59 -0500
Received: (qmail 2174 invoked by uid 102); 21 Jan 2015 23:34:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 17:34:59 -0600
Received: (qmail 1871 invoked by uid 107); 21 Jan 2015 23:35:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 18:35:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 18:34:57 -0500
Content-Disposition: inline
In-Reply-To: <1421882625-916-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262783>

On Wed, Jan 21, 2015 at 03:23:40PM -0800, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 6805b9e..ea98b9b 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1065,4 +1065,32 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
>  	test_must_fail git rev-parse --verify -q $c
>  '
>  
> +run_with_limited_open_files () {
> +	(ulimit -n 32 && "$@")
> +}
> +
> +test_lazy_prereq ULIMIT 'run_with_limited_open_files true'

We already have a ULIMIT prereq in t7004 that does something similar but
different.  The two do not conflict as long as they are in separate
scripts, but they would if one gets moved into test-lib.sh. Should we
maybe give these more descriptive names? It is not just about "ulimit",
but the individual limit option. I can imagine a platform where "ulimit
-s" works, but "ulimit -n" does not (or the other way around).

I almost also suggested that the two "ulimit -s" instances share the
same function and lazy prereq, but I think that's probably not a good
idea. One cares about limiting the stack, and the other care about
limiting the cmdline size. The latter _happens_ to be done using "ulimit
-s". That works on Linux, but no clue about elsewhere. I could easily
imagine a platform where there is some other way, and we add a run-time
switch.

> +test_expect_failure ULIMIT 'large transaction creating branches does not burst open file limit' '
> +(
> +	for i in $(seq 33)

Use test_seq here, for portability.

> +test_expect_failure ULIMIT 'large transaction deleting branches does not burst open file limit' '
> +(
> +	for i in $(seq 33)

Ditto here.

The rest of the tests looked good to me.

-Peff
