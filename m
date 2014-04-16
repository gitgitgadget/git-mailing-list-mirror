From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Wed, 16 Apr 2014 11:46:54 -0400
Message-ID: <20140416154653.GB4691@sigill.intra.peff.net>
References: <20140416141519.GA9684@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 17:47:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaS3A-00056N-IX
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 17:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161786AbaDPPq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 11:46:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:60888 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161580AbaDPPqz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 11:46:55 -0400
Received: (qmail 24938 invoked by uid 102); 16 Apr 2014 15:46:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Apr 2014 10:46:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Apr 2014 11:46:54 -0400
Content-Disposition: inline
In-Reply-To: <20140416141519.GA9684@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246339>

On Wed, Apr 16, 2014 at 04:15:19PM +0200, Stepan Kasal wrote:

> From: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
> Date: Sat, 10 Nov 2012 18:36:10 +0100
> 
> In large repos, the recursion implementation of contains(commit,
> commit_list) may result in a stack overflow. Replace the recursion with
> a loop to fix it.
> 
> This problem is more apparent on Windows than on Linux, where the stack
> is more limited by default.

I think this is a good thing to be doing, and it looks mostly good to
me. A few comments:

> -static int contains_recurse(struct commit *candidate,
> +/*
> + * Test whether the candidate or one of its parents is contained in the list.
> + * Do not recurse to find out, though, but return -1 if inconclusive.
> + */
> +static int contains_test(struct commit *candidate,
>  			    const struct commit_list *want)

Can we turn this return value into

  enum {
	CONTAINS_UNKNOWN = -1,
	CONTAINS_NO = 0,
	CONTAINS_YES = 1,
  } contains_result;

to make the code a little more self-documenting?

>  static int contains(struct commit *candidate, const struct commit_list *want)
>  {
> -	return contains_recurse(candidate, want);
> +	struct stack stack = { 0, 0, NULL };
> +	int result = contains_test(candidate, want);
> +
> +	if (result >= 0)
> +		return result;

Then this can become:

  if (result != CONTAINS_UNKNOWN)
	return result;

> +		if (!parents) {
> +			commit->object.flags = UNINTERESTING;
> +			stack.nr--;
> +		}

Shouldn't this be "|=" when setting the flag?

> +		/*
> +		 * If we just popped the stack, parents->item has been marked,
> +		 * therefore contains_test will return a meaningful 0 or 1.
> +		 */
> +		else switch (contains_test(parents->item, want)) {
> +		case 1:
> +			commit->object.flags |= TMP_MARK;
> +			stack.nr--;
> +			break;
> +		case 0:
> +			entry->parents = parents->next;
> +			break;
> +		default:
> +			push_to_stack(parents->item, &stack);
> +			break;
> +		}

And if we have an enum, this switch() becomes more readable (the
"default" here threw me off initially, because it is actually just
looking for "-1").

> +>expect
> +# ulimit is a bash builtin; we can rely on that in MinGW, but nowhere else
> +test_expect_success MINGW '--contains works in a deep repo' '
> +	ulimit -s 64

It would be nice to test this on Linux.

Can we do something like:

  test_lazy_prereq BASH 'bash --version'

  test_expect_success BASH '--contains works in a deep repo' '
	... setup repo ...
	bash -c "ulimit -s 64 && git tag --contains HEAD" >actual &&
	test_cmp expect actual
  '

As a bonus, then our "ulimit" call does not pollute the environment of
subsequent tests.

-Peff
