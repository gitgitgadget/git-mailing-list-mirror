From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/17] Let fetch_pack() inform caller about number of
 unique heads
Date: Thu, 23 Aug 2012 04:54:10 -0400
Message-ID: <20120823085409.GD6963@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Aug 23 10:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4TBI-0006j5-EF
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab2HWIyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:54:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45976 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833Ab2HWIyO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 04:54:14 -0400
Received: (qmail 19373 invoked by uid 107); 23 Aug 2012 08:54:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 04:54:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 04:54:10 -0400
Content-Disposition: inline
In-Reply-To: <1345709442-16046-7-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204138>

On Thu, Aug 23, 2012 at 10:10:31AM +0200, mhagger@alum.mit.edu wrote:

> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> fetch_pack() remotes duplicates from the list (nr_heads, heads),
> thereby shrinking the list.  But previously, the caller was not
> informed about the shrinkage.  This would cause a spurious error
> message to be emitted by cmd_fetch_pack() if "git fetch-pack" is
> called with duplicate refnames.
> 
> So change the signature of fetch_pack() to accept nr_heads by
> reference, and if any duplicates were removed then modify it to
> reflect the number of remaining references.
> 
> The last test of t5500 inexplicably *required* "git fetch-pack" to
> fail when fetching a list of references that contains duplicates;
> i.e., it insisted on the buggy behavior.  So change the test to expect
> the correct behavior.

Eek, yeah, the current behavior is obviously wrong. The
remove_duplicates code comes from 310b86d (fetch-pack: do not barf when
duplicate re patterns are given, 2006-11-25) and clearly meant for
fetch-pack to handle this case gracefully.

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 3cc3346..0d4edcb 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -391,7 +391,7 @@ test_expect_success 'fetch mixed refs from cmdline and stdin' '
>  test_expect_success 'test duplicate refs from stdin' '
>  	(
>  	cd client &&
> -	test_must_fail git fetch-pack --stdin --no-progress .. <../input.dup
> +	git fetch-pack --stdin --no-progress .. <../input.dup
>  	) >output &&
>  	cut -d " " -f 2 <output | sort >actual &&
>  	test_cmp expect actual

It's interesting that the output was the same before and after the fix.
I guess that is because the error comes at the very end, when we are
making sure all of the provided heads have been consumed.

-Peff
