From: Jeff King <peff@peff.net>
Subject: Re: log --pretty/--oneline: ignore log.decorate
Date: Thu, 8 Apr 2010 15:42:37 -0400
Message-ID: <20100408194237.GA4222@sigill.intra.peff.net>
References: <7vtyrr6nes.fsf@alter.siamese.dyndns.org>
 <7vmxxggsl4.fsf@alter.siamese.dyndns.org>
 <20100408073014.GA15474@coredump.intra.peff.net>
 <7vljcx6f4f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Steven Drake <sdrake@xnet.co.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 21:42:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzxck-00052H-HB
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 21:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758925Ab0DHTml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 15:42:41 -0400
Received: from peff.net ([208.65.91.99]:53325 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757023Ab0DHTmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 15:42:39 -0400
Received: (qmail 26010 invoked by uid 107); 8 Apr 2010 19:42:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 08 Apr 2010 15:42:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 15:42:37 -0400
Content-Disposition: inline
In-Reply-To: <7vljcx6f4f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144374>

On Thu, Apr 08, 2010 at 10:14:24AM -0700, Junio C Hamano wrote:

> Yeah, I considered to further narrow it down to the --pretty=raw case;
> because that is not something we do for the default --show-notes, I opted
> for consistency.  But a decoration and notes are quite different, and
> such a consistency perhaps is not worth it.  How about this on top?

Since I consider normal output, --pretty=raw, and --oneline to be the
only useful output formats for git-log, I think of the right behavior
as:

  - normal: show both by default, since that is the point of the
    features

  - raw: show neither, since we are probably parsed by a script

  - oneline: don't show notes, as they are inherently multi-line. Do
    show decorations, as they inherently fit the hash+subject model

User-formats are useful, too, but outside the scope, as they should
always show exactly what was requested, and nothing more.

For the other formats, I couldn't care less. So your patch is fine, but
I would also be fine with turning it back on _just_ for --oneline, and
leaving all other pretty formats with it disabled.

The patch itself looks fine. As you know, it needs to revert some of the
test updates from your previous tip.

We should also either apply on top or squash in:

-- >8 --
Subject: [PATCH] script with rev-list instead of log

Because log.decorate now shows decorations for --pretty=oneline,
we must explicitly turn it off when scripting. Otherwise,
users with log.decorate set will get cruft like:

  $ git stash
  Saved working directory and index state WIP on master:
    2c1f7f5 (HEAD, master) commit subject

Instead of adding --no-decorate to the log command line,
let's just use the rev-list plumbing interface instead,
which does the right thing.

git-submodule has a similar call. Since it just counts the
commit lines, nothing is broken, but let's switch it, too,
for the sake of consistency and cleanliness.

Signed-off-by: Jeff King <peff@peff.net>
---
I think these changes are Obviously Correct (tm), but please confirm
that I am not missing something subtle.

 git-stash.sh     |    2 +-
 git-submodule.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 62beae0..abaeee7 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -57,7 +57,7 @@ create_stash () {
 	# state of the base commit
 	if b_commit=$(git rev-parse --verify HEAD)
 	then
-		head=$(git log --no-color --abbrev-commit --pretty=oneline -n 1 HEAD --)
+		head=$(git rev-list --oneline -n 1 HEAD --)
 	else
 		die "You do not have the initial commit yet"
 	fi
diff --git a/git-submodule.sh b/git-submodule.sh
index 2dd372a..187461c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -648,7 +648,7 @@ cmd_summary() {
 				range=$sha1_dst
 			fi
 			GIT_DIR="$name/.git" \
-			git log --pretty=oneline --first-parent $range | wc -l
+			git rev-list --first-parent $range -- | wc -l
 			)
 			total_commits=" ($(($total_commits + 0)))"
 			;;
-- 
1.7.1.rc0.248.g055378.dirty
