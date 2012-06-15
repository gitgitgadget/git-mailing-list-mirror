From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 15:37:24 -0400
Message-ID: <20120615193724.GB26473@sigill.intra.peff.net>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
 <7vzk849zxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 21:38:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfcLH-0006Je-S1
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 21:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab2FOTha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 15:37:30 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57721
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757459Ab2FOTh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 15:37:29 -0400
Received: (qmail 2884 invoked by uid 107); 15 Jun 2012 19:37:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 15:37:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 15:37:24 -0400
Content-Disposition: inline
In-Reply-To: <7vzk849zxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200085>

On Fri, Jun 15, 2012 at 11:45:47AM -0700, Junio C Hamano wrote:

> I think the following may be a lot closer to the correct fix; I
> didn't test many combinations of options with it, though.
> 
>  diff-no-index.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/diff-no-index.c b/diff-no-index.c
> index f0b0010..ed74e27 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -172,7 +172,7 @@ void diff_no_index(struct rev_info *revs,
>  		   int argc, const char **argv,
>  		   int nongit, const char *prefix)
>  {
> -	int i;
> +	int i, result;
>  	int no_index = 0;
>  	unsigned options = 0;
>  
> @@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
>  	 * The return code for --no-index imitates diff(1):
>  	 * 0 = no changes, 1 = changes, else error
>  	 */
> -	exit(revs->diffopt.found_changes);
> +	result = !!diff_result_code(&revs->diffopt, 0);
> +	exit(result);

Hmm. This works because is checks HAS_CHANGES instead of found_changes.
I was somewhat surprised that the former works at all, but it is because
diffcore_std sets it if there is anything in diff_queued_diff. Which
makes sense; found_changes seems to be only about communicating changes
up from builtin_diff to the rest of the diff code; nobody should be
reading it outside of there.

Which left me to wonder how we tell when two files are actually the
same. The answer is that diffcore_skip_stat_unmatch actually loads and
memcmps each pair, removing ones that are identical. And diff_no_index
always sets skip_stat_unmatch, whether diff.autorefreshindex is on or
not.

So the patch I posted elsewhere in the thread is not right; we do not
need to do diff_flush_patch to actually compare, because the
stat_unmatch code will have done everything we want (unless
DIFF_FROM_CONTENTS really is set). And the bug is purely one of looking
at the wrong output flag.

-Peff
