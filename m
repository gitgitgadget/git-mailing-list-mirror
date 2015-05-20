From: Jeff King <peff@peff.net>
Subject: [PATCH] stash: complain about unknown flags
Date: Wed, 20 May 2015 14:01:32 -0400
Message-ID: <20150520180132.GB14561@peff.net>
References: <CAEwRq=r=iMmnnzS2F_2rr9Tjem9khn1d=os3krjEjOg5iK5bww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Vincent Legoll <vincent.legoll@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 20:01:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv8JI-0006vN-7f
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 20:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbbETSBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 14:01:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:33259 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753639AbbETSBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 14:01:35 -0400
Received: (qmail 8777 invoked by uid 102); 20 May 2015 18:01:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 13:01:34 -0500
Received: (qmail 25056 invoked by uid 107); 20 May 2015 18:01:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 14:01:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 14:01:32 -0400
Content-Disposition: inline
In-Reply-To: <CAEwRq=r=iMmnnzS2F_2rr9Tjem9khn1d=os3krjEjOg5iK5bww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269484>

The option parser for git-stash stuffs unknown flags into
the $FLAGS variable, where they can be accessed by the
individual commands. However, most commands do not even look
at these extra flags, leading to unexpected results like
this:

  $ git stash drop --help
  Dropped refs/stash@{0} (e6cf6d80faf92bb7828f7b60c47fc61c03bd30a1)

We should notice the extra flags and bail. Rather than
annotate each command to reject a non-empty $FLAGS variable,
we can notice that "stash show" is the only command that
actually _wants_ arbitrary flags. So we switch the default
mode to reject unknown flags, and let stash_show() opt into
the feature.

Reported-by: Vincent Legoll <vincent.legoll@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This takes away the immediate pain. We may also want to
teach "--help" to the option. I guess we cannot do better
than just having it run "git help stash" in all cases (i.e.,
we have no way to get the help for a specific subcommand).

 git-stash.sh     | 6 +++++-
 t/t3903-stash.sh | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7911f30..c6f492c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -301,6 +301,7 @@ list_stash () {
 }
 
 show_stash () {
+	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
 
 	git diff ${FLAGS:---stat} $b_commit $w_commit
@@ -332,13 +333,14 @@ show_stash () {
 #
 #   GIT_QUIET is set to t if -q is specified
 #   INDEX_OPTION is set to --index if --index is specified.
-#   FLAGS is set to the remaining flags
+#   FLAGS is set to the remaining flags (if allowed)
 #
 # dies if:
 #   * too many revisions specified
 #   * no revision is specified and there is no stash stack
 #   * a revision is specified which cannot be resolve to a SHA1
 #   * a non-existent stash reference is specified
+#   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
 #
 
 parse_flags_and_rev()
@@ -372,6 +374,8 @@ parse_flags_and_rev()
 				INDEX_OPTION=--index
 			;;
 			-*)
+				test "$ALLOW_UNKNOWN_FLAGS" = t ||
+					die "$(eval_gettext "unknown option: \$opt")"
 				FLAGS="${FLAGS}${FLAGS:+ }$opt"
 			;;
 		esac
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0746eee..7396ca9 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -100,6 +100,10 @@ test_expect_success 'unstashing in a subdirectory' '
 	)
 '
 
+test_expect_success 'stash drop complains of extra options' '
+	test_must_fail git stash drop --foo
+'
+
 test_expect_success 'drop top stash' '
 	git reset --hard &&
 	git stash list > stashlist1 &&
-- 
2.4.1.396.g7ba6d7b
