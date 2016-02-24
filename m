From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git config: do not create .git/ if it does not exist yet
Date: Wed, 24 Feb 2016 03:26:57 -0500
Message-ID: <20160224082657.GD12511@sigill.intra.peff.net>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 09:27:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYUmz-0005XV-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 09:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112AbcBXI1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 03:27:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:48113 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752147AbcBXI1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 03:27:00 -0500
Received: (qmail 22713 invoked by uid 102); 24 Feb 2016 08:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 03:27:00 -0500
Received: (qmail 5614 invoked by uid 107); 24 Feb 2016 08:27:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 03:27:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 03:26:57 -0500
Content-Disposition: inline
In-Reply-To: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287185>

On Wed, Feb 24, 2016 at 08:47:00AM +0100, Johannes Schindelin wrote:

> It is a pilot error to call `git config section.key value` outside of
> any Git worktree.
> 
> Let's report that error instead of creating the .git/ directory and
> writing a fresh config into it.

Hmm.  I get (on my Linux machine):

  $ git config foo.bar baz
  error: could not lock config file .git/config: No such file or directory

which makes sense (though still isn't a great error message, and is kind
of weird if you happen to have a .git directory that isn't a real
repository).

Is Git more aggressive about auto-creating the directory for lockfiles
on Windows? I tried the exact recipe you gave in the linked thread, just
to be sure, but I couldn't replicate it.

> 	I cannot think of a way how to test this: all of the regression
> 	tests run inside Git's own worktree, and we cannot even assume
> 	that /tmp/ is outside of a worktree (or that it exists).

We could make the test conditional on whether we are in a repo. Anybody
who builds from a tarball, or who uses --root would then run the test.

Something like this:

-- >8 --
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 52678e7..9856831 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1201,4 +1201,13 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '
 
+test_expect_success 'set up repo-less tests' '
+	mv .git tmp-git &&
+	{ git rev-parse --git-dir || test_set_prereq REPOLESS; }
+'
+
+test_expect_success REPOLESS 'cannot set repo config outside of a repo' '
+	test_must_fail git config foo.bar baz
+'
+
 test_done
-- 8< --

Though I admit it is pretty gross. It also pollutes the script state, so
anybody adding tests after will be in for a surprise. :)

One solution would be to restore "tmp-git" in the set-up, and then have
each REPOLESS test move it again, and put it back with a
test_when_finished. Or perhaps just make a new script for REPOLESS tests
(config or otherwise).

> diff --git a/builtin/config.c b/builtin/config.c
> index adc7727..78aab95 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -352,6 +352,9 @@ static int get_colorbool(const char *var, int print)
>  
>  static void check_write(void)
>  {
> +	if (!given_config_source.file && !startup_info->have_repository)
> +		die("not in a git directory");
> +
>  	if (given_config_source.use_stdin)
>  		die("writing to stdin is not supported");

I think you'd want to cover "git config --local foo.bar baz" in the same
way. You can check use_local_config for that.

-Peff
