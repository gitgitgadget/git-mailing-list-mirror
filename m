From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t5570: use explicit push refspec
Date: Sun, 15 Apr 2012 21:52:35 +0200
Message-ID: <20120415195231.GB1960@ecki>
References: <20120414182907.GA3915@ecki>
 <20120414183225.GB3915@ecki>
 <7viph1288e.fsf@alter.siamese.dyndns.org>
 <20120415001133.GB32140@ecki>
 <7v7gxg2461.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:13:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVoj-0006Nb-Um
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 22:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab2DOUM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 16:12:27 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:47229 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab2DOUM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 16:12:27 -0400
Received: from [127.0.0.1] (p5B22C962.dip.t-dialin.net [91.34.201.98])
	by bsmtp.bon.at (Postfix) with ESMTP id 38C25A7EB2;
	Sun, 15 Apr 2012 22:13:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7gxg2461.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195585>

On Sun, Apr 15, 2012 at 12:20:06PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > On Sat, Apr 14, 2012 at 04:40:01PM -0700, Junio C Hamano wrote:
> >> Clemens Buchacher <drizzd@aon.at> writes:
> >> 
> >> > The default mode for push without arguments will change. Some warnings
> >> > are about to be enabled for such use, which causes some t5570 tests to
> >> > fail because they do not expect this output. Fix this by passing an
> >> > explicit refspec to git push.
> >> 
> >> I wonder if a better fix is to configure "push.default = matching" in the
> >> test repository.  Otherwise wouldn't the result of the push change once
> >> the default changes?
> >
> > The push.default option matters only if a refspec is not specified. By
> > adding a refspec, push.default should not matter any more. Unless that
> > is going to change as well?
> 
> No, I was thinking more about testing cases where there is no refspec on
> the command line, which we used to test, but with your patch we no longer
> do.  In other words, your fix not just squelches the advice message and
> make them pass, but it changes the way the command behaves, no?

It does exactly the same thing it did before, since there is only one
local branch. The goal of the test is not to check behavior of git push
without arguments. Since that is subject to change, and is causing
causing the test to fail already for no good reason, I think it better
to use the more explicit version of the command.

> Besides, that way you do not have to swap the parameters to test_remote_error
> so we do not have scratch our heads wondering why we have changes to test
> vectors that run clones and fetches.

In my opinion, this change is also an improvement in itself, since now
we can more easily pass extra arguments to test_remote_error. Maybe the
scratching of heads can be alleviated by amending the commit message
like so?

-->o--
Subject: [PATCH] t5570: use explicit push refspec

The default mode for push without arguments will change. Some warnings
are about to be enabled for such use, which causes some t5570 tests to
fail because they do not expect this output.

Fix this by passing an explicit refspec to git push. To that end, change
the calling conventions of test_remote_error in order to accomodate
extra command arguments.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5570-git-daemon.sh |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 7cbc999..a3a4e47 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -103,14 +103,12 @@ test_remote_error()
 		esac
 	done
 
-	if test $# -ne 3
-	then
-		error "invalid number of arguments"
-	fi
-
+	msg=$1
+	shift
 	cmd=$1
-	repo=$2
-	msg=$3
+	shift
+	repo=$1
+	shift || error "invalid number of arguments"
 
 	if test -x "$GIT_DAEMON_DOCUMENT_ROOT_PATH/$repo"
 	then
@@ -122,7 +120,7 @@ test_remote_error()
 		fi
 	fi
 
-	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" 2>output &&
+	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" "$@" 2>output &&
 	echo "fatal: remote error: $msg: /$repo" >expect &&
 	test_cmp expect output
 	ret=$?
@@ -131,18 +129,18 @@ test_remote_error()
 }
 
 msg="access denied or repository not exported"
-test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git '$msg'"
-test_expect_success 'push disabled'      "test_remote_error    push  repo.git    '$msg'"
-test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    '$msg'"
-test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    '$msg'"
+test_expect_success 'clone non-existent' "test_remote_error    '$msg' clone nowhere.git    "
+test_expect_success 'push disabled'      "test_remote_error    '$msg' push  repo.git master"
+test_expect_success 'read access denied' "test_remote_error -x '$msg' fetch repo.git       "
+test_expect_success 'not exported'       "test_remote_error -n '$msg' fetch repo.git       "
 
 stop_git_daemon
 start_git_daemon --informative-errors
 
-test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git 'no such repository'"
-test_expect_success 'push disabled'      "test_remote_error    push  repo.git    'service not enabled'"
-test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    'no such repository'"
-test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    'repository not exported'"
+test_expect_success 'clone non-existent' "test_remote_error    'no such repository'      clone nowhere.git    "
+test_expect_success 'push disabled'      "test_remote_error    'service not enabled'     push  repo.git master"
+test_expect_success 'read access denied' "test_remote_error -x 'no such repository'      fetch repo.git       "
+test_expect_success 'not exported'       "test_remote_error -n 'repository not exported' fetch repo.git       "
 
 stop_git_daemon
 test_done
-- 
1.7.9.6
