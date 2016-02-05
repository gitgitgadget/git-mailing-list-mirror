From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 2/2] ident: add user.useConfigOnly boolean for when
 ident shouldn't be guessed
Date: Fri, 5 Feb 2016 16:48:33 -0500
Message-ID: <20160205214832.GA10052@sigill.intra.peff.net>
References: <1454707746-18672-1-git-send-email-alonid@gmail.com>
 <1454707746-18672-3-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:48:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRoF5-0006Lm-Ti
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbcBEVsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:48:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:38461 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbcBEVsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 16:48:35 -0500
Received: (qmail 4013 invoked by uid 102); 5 Feb 2016 21:48:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 16:48:35 -0500
Received: (qmail 19658 invoked by uid 107); 5 Feb 2016 21:48:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 16:48:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2016 16:48:33 -0500
Content-Disposition: inline
In-Reply-To: <1454707746-18672-3-git-send-email-alonid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285639>

On Fri, Feb 05, 2016 at 11:29:06PM +0200, Dan Aloni wrote:

> diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
> new file mode 100755
> index 000000000000..f2b33881e46b
> --- /dev/null
> +++ b/t/t9904-per-repo-email.sh

Is t9904 the right place for this? Usually t99xx is for very separate
components.

This is sort-of about "commit", which would put it in the t75xx range.
But in some ways, it is even more fundamental than that. We don't seem
to have a lot of tests for ident stuff. The closest is the strict ident
stuff in t0007.

> +reprepare () {
> +	git reset --hard initial
> +}

Do we need this reprepare stuff at all now? The tests don't care which
commit we're at when they start.

> +test_expect_success setup '
> +	# Initial repo state
> +	echo "Initial" >foo &&
> +	git add foo &&
> +	git commit -m foo &&
> +	git tag initial &&

A shorter way of saying this is "test_commit foo".

I almost thought we could get rid of this part entirely; the commit
tests don't care. But we do still need _a_ commit for the clone test,
since we want to make sure a reflog is written. It would be nice to push
it down there, but our test environment doesn't allow creating commits,
because of of useConfigOnly. So it's probably fine to leave it here.

Technically, the final "commit" test does make a commit for us to push,
but we do generally try to avoid unnecessary dependencies between the
individual tests.

So all together, maybe:

diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
index f2b3388..5694b84 100755
--- a/t/t9904-per-repo-email.sh
+++ b/t/t9904-per-repo-email.sh
@@ -7,48 +7,31 @@ test_description='per-repo forced setting of email address'
 
 . ./test-lib.sh
 
-reprepare () {
-	git reset --hard initial
-}
-
-test_expect_success setup '
-	# Initial repo state
-	echo "Initial" >foo &&
-	git add foo &&
-	git commit -m foo &&
-	git tag initial &&
-
-	# Setup a likely user.useConfigOnly use case
+test_expect_success 'setup a likely user.useConfigOnly use case' '
+	# we want to make sure a reflog is written, since that needs
+	# a non-strict ident. So be sure we have an actual commit.
+	test_commit foo &&
+
 	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
 	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
 	git config user.name "test" &&
-	git config --global user.useConfigOnly true &&
-
-	reprepare
+	git config --global user.useConfigOnly true
 '
 
 test_expect_success 'fails committing if clone email is not set' '
-	test_when_finished reprepare &&
-
 	test_must_fail git commit --allow-empty -m msg
 '
 
 test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
-	test_when_finished reprepare &&
-
 	test_must_fail env EMAIL=test@fail.com git commit --allow-empty -m msg
 '
 
 test_expect_success 'succeeds committing if clone email is set' '
-	test_when_finished reprepare &&
-
 	test_config user.email "test@ok.com" &&
 	git commit --allow-empty -m msg
 '
 
 test_expect_success 'succeeds cloning if global email is not set' '
-	test_when_finished reprepare &&
-
 	git clone . clone
 '
 
