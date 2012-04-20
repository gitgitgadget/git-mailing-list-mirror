From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] push: introduce new push.default mode "simple"
Date: Fri, 20 Apr 2012 13:33:25 -0700
Message-ID: <20120420203324.GB13103@sigill.intra.peff.net>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
 <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1334933944-13446-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:33:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLKWi-00058h-T9
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab2DTUdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:33:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39349
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab2DTUda (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 16:33:30 -0400
Received: (qmail 14372 invoked by uid 107); 20 Apr 2012 20:33:39 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Apr 2012 16:33:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Apr 2012 13:33:25 -0700
Content-Disposition: inline
In-Reply-To: <1334933944-13446-3-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196020>

On Fri, Apr 20, 2012 at 04:59:02PM +0200, Matthieu Moy wrote:

> it has the same name remotely. If not, give an error that suggest the
> right command to push explicitely to 'upstream' or 'current'.

s/suggest/&s/

> beneficial on the next pull. Lacking better argument, we chose to deny
> the push, because it will be easier to change in the future is someone
> shows us wrong.

s/is/if/

> Original-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Except for the broken-ness, this adds the last line in the warning message:
> 
> "To chose either option permanently, read about push.default in git-config(1)"

I don't think that makes sense if I have set "push.default" to "simple"
myself. IOW, shouldn't that get added later, when it eventually becomes
the default (and then, only when it was chosen because it is the
default, not because somebody explicitly said they wanted it)?

> @@ -837,7 +839,7 @@ static int git_default_push_config(const char *var, const char *value)
>  			push_default = PUSH_DEFAULT_CURRENT;
>  		else {
>  			error("Malformed value for %s: %s", var, value);
> -			return error("Must be one of nothing, matching, "
> +			return error("Must be one of simple, nothing, matching, "
>  				     "tracking or current.");

Not your fault, but should this be s/tracking/upstream/ in the context
line?

> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index c334c51..949dbdf 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -13,6 +13,22 @@ test_expect_success 'setup bare remotes' '
>  	git push parent2 HEAD
>  '
>  
> +# $1 = local revision
> +# $2 = remote repository
> +# $3 = remote revision (tested to be equal to the local one)
> +check_pushed_commit () {
> +	git rev-parse "$1" > expect &&
> +	git --git-dir="$2" rev-parse "$3" > actual &&
> +	test_cmp expect actual
> +}

This is an extremely minor nit, but a test failure is often easier to
read if you use "log -1 --format=%s" here, assuming that the commits are
given reasonable subjects (so you get "-two\n+one" or similar instead of
some commit ids which aren't meaningful).

Also, I notice you take a repo argument here, but then all of the
callers just pass "repo1" (and the test_push_success function hardcodes
repo1).

> +test_expect_success 'push to existing branch, upstream configured with different name' '
> +	test_config branch.master.remote repo1 &&
> +	test_config branch.master.merge refs/heads/other-name &&
> +	git checkout master &&
> +	test_commit eight &&
> +	test_push_success upstream other-name &&
> +	test_commit nine &&
> +	test_must_fail git -c push.default=simple push &&
> +	test_push_success current master &&
> +	test_must_fail check_pushed_commit HEAD repo1 other-name
> +'

In the final must_fail, wouldn't it be more robust to use an affirmative
check that it was not touched, instead of checking that we failed to
find it to be equal (which could fail for other, unrelated reasons)?
Like this:

  check_pushed_commit HEAD^ repo1 other-name

I also wonder if it would make sense to wrap the whole "failed push"
thing in a function like this:

  test_push_failure() {
          git --git-dir=repo1 log -1 --format=%s "$2" >expect &&
          test_must_fail git -c push.default="$1" &&
          git --git-dir=repo1 log -1 --format=%s "$2" >actual &&
          test_cmp expect actual
  }

and then the earlier failures could also get this extra double-check for
free (that push not only reported failure, but that it failed without
actually touching the remote end, not for some unrelated reason).

That's all minor stuff; the bulk of the patch looks good to me.

-Peff
