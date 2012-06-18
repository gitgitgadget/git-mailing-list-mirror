From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Mon, 18 Jun 2012 15:45:30 -0400
Message-ID: <20120618194530.GA10725@sigill.intra.peff.net>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 21:46:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sghtr-0008FI-HE
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 21:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab2FRTpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 15:45:33 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:60425
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab2FRTpc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 15:45:32 -0400
Received: (qmail 31768 invoked by uid 107); 18 Jun 2012 19:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jun 2012 15:45:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jun 2012 15:45:30 -0400
Content-Disposition: inline
In-Reply-To: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200161>

On Mon, Jun 18, 2012 at 03:28:24PM -0400, Tim Henigan wrote:

> When running 'git diff --quiet <file1> <file2>', if file1 or file2
> is outside the repository, it will exit(0) even if the files differ.
> It should exit(1) when they differ.

Can we explain in the commit message a bit about why the patch works? If
I hadn't just dug into this a few days ago, the patch would be somewhat
confusing. Maybe something like:

  The problem comes from checking diff_options's found_changes member to
  see whether any changes were found. This flag is set only when we
  actually run xdiff and it finds a change. However, the diff machinery
  will optimize out the actual xdiff call when it is not necessary
  (i.e., when we are doing a straight byte-for-byte comparison and do
  not care about the output). As a result, this flag was never set, and
  we must check the HAS_CHANGES flag instead, just like the regular
  index-aware diff code paths do.

I am also tempted to suggest that found_changes be renamed to
xdiff_found_changes or something similar, because it really is quite
misleading as-is.

> diff --git a/diff-no-index.c b/diff-no-index.c
> index f0b0010..b935d2a 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
>  	 * The return code for --no-index imitates diff(1):
>  	 * 0 = no changes, 1 = changes, else error
>  	 */
> -	exit(revs->diffopt.found_changes);
> +	int result = diff_result_code(&revs->diffopt, 0);
> +	exit(result);

This is a declaration-after-statement, no? We try to stick to C89, which
does not allow this.

I don't see any reason why the extra variable could not be removed
entirely:

  exit(diff_result_code(&revs->diffopt, 0));

-Peff
