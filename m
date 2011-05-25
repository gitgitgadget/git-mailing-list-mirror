From: Jeff King <peff@peff.net>
Subject: Re: Merge made by recursive?
Date: Wed, 25 May 2011 17:25:10 -0400
Message-ID: <20110525212510.GA14214@sigill.intra.peff.net>
References: <loom.20110525T192418-887@post.gmane.org>
 <7vvcwy37de.fsf@alter.siamese.dyndns.org>
 <20110525195032.GC27260@sigill.intra.peff.net>
 <7vei3m3571.fsf@alter.siamese.dyndns.org>
 <7vzkma1p95.fsf@alter.siamese.dyndns.org>
 <20110525210254.GA29716@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 23:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPLZx-0008AX-NC
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 23:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab1EYVZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 17:25:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46289
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289Ab1EYVZN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 17:25:13 -0400
Received: (qmail 6139 invoked by uid 107); 25 May 2011 21:25:12 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 17:25:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 17:25:10 -0400
Content-Disposition: inline
In-Reply-To: <20110525210254.GA29716@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174466>

On Wed, May 25, 2011 at 05:02:54PM -0400, Jeff King wrote:

> On Wed, May 25, 2011 at 01:47:34PM -0700, Junio C Hamano wrote:
> 
> > I am reluctant to do this (including the rewording of the end-user facing
> > message) until we decide what to do with the reflog. Right now, I think no
> > tool looks at the reflog, but contaminating the reflog with translatable
> > messages mean that we will never be able to support "3 merges ago" just
> > like we support "the previous branch".
> 
> The reflog messages look like:
> 
>   merge $branch: Merge made by recursive.

While peeking in my reflog, I noticed some very confusing entries, which
this patch addresses.

-- >8 --
Subject: [PATCH] reset: give more verbose reflog messages

The reset command creates its reflog entry from argv.
However, it does so after having run parse_options, which
means the only thing left in argv is any non-option
arguments. Thus you would end up with confusing reflog
entries like:

  $ git reset --hard HEAD^
  $ git reset --soft HEAD@{1}
  $ git log -2 -g --oneline
  8e46cad HEAD@{0}: HEAD@{1}: updating HEAD
  1eb9486 HEAD@{1}: HEAD^: updating HEAD

This patch sets up the reflog before argv is munged, so you
get the command name and any other options, like:

  8e46cad HEAD@{0}: reset --soft HEAD@{1}: updating HEAD
  1eb9486 HEAD@{1}: reset --hard HEAD^: updating HEAD

Signed-off-by: Jeff King <peff@peff.net>
---
I am not sure if this was the original intent of the code or not; I had
to update a test vector which codified it. Any options like "--hard" or
"--soft" are actually superfluous to the ref update (not to mention
something like "-q"). So another option would be to just take what's
left after parsing options and putting "reset" in front of it, like:

  8e46cad HEAD@{0}: reset: HEAD^: updating HEAD

which is a little more readable. Though if we are going to change it, I
think my preference would actually be:

  8e46cad HEAD@{0}: reset: moving to HEAD^

which reads better. The "updating HEAD" is just pointless. Of course
we're updating HEAD; we're in the HEAD reflog and we're running reset!

However, if GIT_REFLOG_ACTION is already set (by a script calling us),
then we won't say "reset". So for example, I have entries in my reflog
like:

  944af8c HEAD@{311}: rebase -i (squash): updating HEAD

So maybe it makes sense to leave those ones as-is, and adjust only the
case where GIT_REFLOG_ACTION is unset.

 builtin/reset.c        |    5 +++--
 t/t1412-reflog-loop.sh |    8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 98bca04..77103fb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -259,11 +259,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
-						PARSE_OPT_KEEP_DASHDASH);
 	reflog_action = args_to_str(argv);
 	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
 
+	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
+						PARSE_OPT_KEEP_DASHDASH);
+
 	/*
 	 * Possible arguments are:
 	 *
diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
index 7f519e5..a92875f 100755
--- a/t/t1412-reflog-loop.sh
+++ b/t/t1412-reflog-loop.sh
@@ -21,10 +21,10 @@ test_expect_success 'setup reflog with alternating commits' '
 
 test_expect_success 'reflog shows all entries' '
 	cat >expect <<-\EOF
-		topic@{0} two: updating HEAD
-		topic@{1} one: updating HEAD
-		topic@{2} two: updating HEAD
-		topic@{3} one: updating HEAD
+		topic@{0} reset two: updating HEAD
+		topic@{1} reset one: updating HEAD
+		topic@{2} reset two: updating HEAD
+		topic@{3} reset one: updating HEAD
 		topic@{4} branch: Created from HEAD
 	EOF
 	git log -g --format="%gd %gs" topic >actual &&
-- 
1.7.4.5.34.g0787f
