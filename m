From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] merge-one-file: use empty blob for add/add base
Date: Tue, 23 Feb 2016 01:04:41 -0500
Message-ID: <20160223060441.GA3205@sigill.intra.peff.net>
References: <20160223060338.GA2912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:04:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY65X-0007lK-P7
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbcBWGEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:04:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:47309 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932171AbcBWGEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:04:43 -0500
Received: (qmail 8856 invoked by uid 102); 23 Feb 2016 06:04:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:04:44 -0500
Received: (qmail 25843 invoked by uid 107); 23 Feb 2016 06:04:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:04:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 01:04:41 -0500
Content-Disposition: inline
In-Reply-To: <20160223060338.GA2912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287018>

When we see an add/add conflict on a file, we generate the
conflicted content by doing a 3-way merge with a "virtual"
base consisting of the common lines of the two sides. This
strategy dates back to cb93c19 (merge-one-file: use common
as base, instead of emptiness., 2005-11-09).

Back then, the next step was to call rcs merge to generate
the 3-way conflicts. Using the virtual base produced much
better results, as rcs merge does not attempt to minimize
the hunks. As a result, you'd get a conflict with the
entirety of the files on either side.

Since then, though, we've switched to using git-merge-file,
which uses xdiff's "zealous" merge. This will find the
minimal hunks even with just the simple, empty base.

Let's switch to using that empty base. It's simpler, more
efficient, and reduces our dependencies (we no longer need a
working diff binary). It's also how the merge-recursive
strategy handles this same case.

We can almost get rid of git-sh-setup's create_virtual_base,
but we don't here, for two reasons:

  1. The functions in git-sh-setup are part of our public
     interface, so it's possible somebody is depending on
     it. We'd at least need to deprecate it first.

  2. It's also used by mergetool's p4merge driver. It's
     unknown whether its 3-way merge is as capable as git's;
     if not, then it is benefiting from the function.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-merge-one-file.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index cdc02af..424b034 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -120,8 +120,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	case "$1" in
 	'')
 		echo "Added $4 in both, but differently."
-		orig=$(git-unpack-file $2)
-		create_virtual_base "$orig" "$src2"
+		orig=$(git-unpack-file e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
 		;;
 	*)
 		echo "Auto-merging $4"
-- 
2.7.2.645.g4e1306c
