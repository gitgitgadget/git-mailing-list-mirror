From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 2/3] ident: add user.useConfigOnly boolean for when
 ident shouldn't be guessed
Date: Fri, 5 Feb 2016 14:18:05 -0500
Message-ID: <20160205191805.GA7245@sigill.intra.peff.net>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
 <1454658148-3031-3-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:18:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRltW-0007bN-G8
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbcBETSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:18:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:38307 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752407AbcBETSH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:18:07 -0500
Received: (qmail 28607 invoked by uid 102); 5 Feb 2016 19:18:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 14:18:07 -0500
Received: (qmail 17316 invoked by uid 107); 5 Feb 2016 19:18:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 14:18:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2016 14:18:05 -0500
Content-Disposition: inline
In-Reply-To: <1454658148-3031-3-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285596>

On Fri, Feb 05, 2016 at 09:42:27AM +0200, Dan Aloni wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 02bcde6bb596..25cf7ce4e83a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2821,6 +2821,15 @@ user.name::
>  	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
>  	environment variables.  See linkgit:git-commit-tree[1].
>  
> +user.useConfigOnly::
> +	This instruct Git to avoid trying to guess defaults for 'user.email'

s/instruct/instructs/

> +	and 'user.name' other than strictly from environment or config.

I find mention of the environment a bit ambiguous. Given our discussion,
I'm sure you mean $GIT_AUTHOR_EMAIL, etc, and not $EMAIL. But I don't
think that is clear to somebody who has not been looking at this patch
series.

I actually think we could simply say "other than strictly from the
config", as people don't generally use $GIT_* themselves (rather, they
get used mostly for inter-process communication, so at most script
authors need to know about them).

> +	If you have multiple email addresses that you would like to set
> +	up per repository, you may want to set this to 'true' in the global

I parsed this sentence as "multiple addresses per repository". Maybe:

  If you have multiple email addresses and would like to use a different
  one for each repository, you may...

would be more clear?

> +test_description='per-repo forced setting of email address'
> +
> +. ./test-lib.sh
> +
> +prepare () {
> +	# Have a non-empty repository
> +	rm -fr .git
> +	git init
> +	echo "Initial" >foo &&
> +	git add foo &&
> +	git commit -m foo &&
> +
> +	# Setup a likely user.useConfigOnly use case
> +	sane_unset GIT_AUTHOR_NAME &&
> +	sane_unset GIT_AUTHOR_EMAIL &&
> +	test_unconfig --global user.name &&
> +	test_unconfig --global user.email &&
> +	test_config user.name "test" &&
> +	test_unconfig user.email &&
> +	test_config_global user.useConfigOnly true
> +}
> +
> +about_to_commit () {
> +	echo "Second" >>foo &&
> +	git add foo
> +}
> +
> +test_expect_success 'fails committing if clone email is not set' '
> +	prepare && about_to_commit &&
> +
> +	test_must_fail git commit -m msg
> +'

The flow of this test script is a bit different than what we usually
write. Typically we have some early test_expect_success blocks do setup
for the whole script, and then progress through a sequence (and we rely
on the test harness to do things like "git init").

IOW, most of your "prepare" would go in the first block, and then the
rest of the tests rely on it.

The only thing I really see that needs to be repeated for each test is
setting up the "about to commit" scenario. But you can simply use
"commit --allow-empty" so that the tests work no matter what state the
previous test left us in. We care about the ident, not what gets
committed.

-Peff
