From: Jeff King <peff@peff.net>
Subject: [PATCH 2/1] stash: recognize "--help" for subcommands
Date: Wed, 20 May 2015 14:17:46 -0400
Message-ID: <20150520181746.GC14561@peff.net>
References: <CAEwRq=r=iMmnnzS2F_2rr9Tjem9khn1d=os3krjEjOg5iK5bww@mail.gmail.com>
 <20150520180132.GB14561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Vincent Legoll <vincent.legoll@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 20:18:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv8Z5-0007ja-SX
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 20:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbbETSRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 14:17:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:33269 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754471AbbETSRt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 14:17:49 -0400
Received: (qmail 11188 invoked by uid 102); 20 May 2015 18:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 13:17:49 -0500
Received: (qmail 25181 invoked by uid 107); 20 May 2015 18:17:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 14:17:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 14:17:46 -0400
Content-Disposition: inline
In-Reply-To: <20150520180132.GB14561@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269486>

On Wed, May 20, 2015 at 02:01:32PM -0400, Jeff King wrote:

> This takes away the immediate pain. We may also want to
> teach "--help" to the option. I guess we cannot do better
> than just having it run "git help stash" in all cases (i.e.,
> we have no way to get the help for a specific subcommand).

That actually turns out to be pretty painless...

-- >* --
Subject: stash: recognize "--help" for subcommands

If you run "git stash --help", you get the help for stash
(this magic is done by the git wrapper itself). But if you
run "git stash drop --help", you get an error. We
cannot show help specific to "stash drop", of course, but we
can at least give the user the normal stash manpage.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-stash.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index c6f492c..1f5ea87 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -219,6 +219,9 @@ save_stash () {
 		-a|--all)
 			untracked=all
 			;;
+		--help)
+			show_help
+			;;
 		--)
 			shift
 			break
@@ -307,6 +310,11 @@ show_stash () {
 	git diff ${FLAGS:---stat} $b_commit $w_commit
 }
 
+show_help () {
+	exec git help stash
+	exit 1
+}
+
 #
 # Parses the remaining options looking for flags and
 # at most one revision defaulting to ${ref_stash}@{0}
@@ -373,6 +381,9 @@ parse_flags_and_rev()
 			--index)
 				INDEX_OPTION=--index
 			;;
+			--help)
+				show_help
+			;;
 			-*)
 				test "$ALLOW_UNKNOWN_FLAGS" = t ||
 					die "$(eval_gettext "unknown option: \$opt")"
-- 
2.4.1.396.g7ba6d7b
