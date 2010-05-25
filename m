From: Jeff King <peff@peff.net>
Subject: Re: 'git pull --dry-run' accepted, but moves HEAD and changes
 working tree
Date: Tue, 25 May 2010 02:07:25 -0400
Message-ID: <20100525060725.GA10898@coredump.intra.peff.net>
References: <20100524135823.GC19861@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue May 25 08:07:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGnId-0007T6-Oa
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 08:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab0EYGHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 02:07:30 -0400
Received: from peff.net ([208.65.91.99]:54695 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835Ab0EYGH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 02:07:29 -0400
Received: (qmail 15704 invoked by uid 107); 25 May 2010 06:07:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 02:07:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 02:07:25 -0400
Content-Disposition: inline
In-Reply-To: <20100524135823.GC19861@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147665>

On Mon, May 24, 2010 at 08:58:23AM -0500, Jeff Epler wrote:

> I don't recall why I initially typed it, I was surprised to discover
> that 'git pull --dry-run' moves HEAD and modifies the working tree.

Yeah, that's bad.

> (I assume it's passing --dry-run to fetch, which does accept it, but
> that doesn't ensure that there's nothing at all to merge)

That is exactly what is happening.

> Maybe 'git pull --dry-run' should just be forbidden, or maybe it could
> tell the user whether the result of the pull would be a merge, FF, or no
> change.

We can't tell what would have happened, because the dry-run fetch
doesn't write anything into FETCH_HEAD (which is where we would look to
see what was merge-able or not). But we can at least stop at the fetch
dry-run to prevent any further damage.

I have no problem with simply reporting an error, but it is easy enough
to also just have it stop after doing the fetch dry-run, as below.

-- >8 --
Subject: [PATCH] pull: do nothing on --dry-run

Pull was never meant to take --dry-run at all. However, it
passes unknown arguments to git-fetch, which does do a
dry-run. Unfortunately, pull then attempts to merge whatever
cruft was in FETCH_HEAD (which the dry-run fetch will not
have written to).

Even though we never advertise --dry-run as something that
should work, it is still worth being defensive because:

  1. Other commands (including fetch) take --dry-run, so a
     user might try it.

  2. Rather than simply producing an error, it actually
     changes the repository in totally unexpected ways.

This patch makes "pull --dry-run" equivalent to "fetch
--dry-run".

Signed-off-by: Jeff King <peff@peff.net>
---
 git-pull.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 1a4729f..a09a44e 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -43,6 +43,7 @@ merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
+dry_run=
 while :
 do
 	case "$1" in
@@ -104,6 +105,9 @@ do
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
 		;;
+	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
+		dry_run=--dry-run
+		;;
 	-h|--h|--he|--hel|--help)
 		usage
 		;;
@@ -216,7 +220,8 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress --update-head-ok "$@" || exit 1
+git fetch $verbosity $progress $dry_run --update-head-ok "$@" || exit 1
+test -z "$dry_run" || exit 0
 
 curr_head=$(git rev-parse -q --verify HEAD)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
-- 
1.7.1.226.g770c5.dirty
