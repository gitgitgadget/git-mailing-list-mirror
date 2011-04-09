From: Jeff King <peff@peff.net>
Subject: Re: git rebase --continue automatic --skip?
Date: Fri, 8 Apr 2011 20:03:51 -0400
Message-ID: <20110409000351.GA7445@sigill.intra.peff.net>
References: <BANLkTi=Vc6kB5fvZrqMwDD+yHFb5qENQ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 09 02:04:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Leh-0000L2-Gr
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 02:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757961Ab1DIADz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 20:03:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45395
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab1DIADy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 20:03:54 -0400
Received: (qmail 7318 invoked by uid 107); 9 Apr 2011 00:04:42 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 20:04:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 20:03:51 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=Vc6kB5fvZrqMwDD+yHFb5qENQ8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171176>

On Fri, Apr 08, 2011 at 01:30:01PM -0700, skillzero@gmail.com wrote:

> Is there a way to make git rebase --continue automatically do a --skip
> if a conflict resolution ends up not needing the patch? Normally, git
> rebase will just silently skip a patch if it's not needed, but if a
> patch results in a conflict and I use git mergetool and end up
> deleting all the changes, git rebase --continue stops and makes me
> explicitly use --skip.

This is something I have often wanted, too. The patch would look
something like this:

diff --git a/git-rebase.sh b/git-rebase.sh
index 7a54bfc..cec15ae 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -319,6 +319,11 @@ continue)
 		echo "mark them as resolved using git add"
 		exit 1
 	}
+	if git diff-index --quiet HEAD --; then
+		test -z "$GIT_QUIET" &&
+			echo >&2 "Commit has no changes -- skipping"
+		action=skip
+	fi
 	read_basic_state
 	run_specific_rebase
 	;;

that is based on what is in "next", as there has been a lot of cleanup
in git-rebase recently[1].

I put it in rebase and not straight into "git am", as I'm not sure that
"am" would want to share the same behavior. I'm not sure why we haven't
done this up until now. Maybe there is some corner case I'm not thinking
of where the user would want to do something besides skip when we hit
this situation. I dunno.

Potentially this should also go into the rebase--am specific script. I
haven't really thought it through.

-Peff

[1] I hadn't really been following Martin's rebase cleanup, but it is
    _way_ nicer to look at these days.
