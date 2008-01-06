From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable frozen)
Date: Sat, 5 Jan 2008 23:24:09 -0500
Message-ID: <20080106042409.GA4843@coredump.intra.peff.net>
References: <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org> <7vy7btaf4p.fsf@gitster.siamese.dyndns.org> <7vfxxtu5ov.fsf@gitster.siamese.dyndns.org> <7v63y8ble8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 05:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBN44-0006uY-EB
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 05:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbYAFEYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 23:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753558AbYAFEYO
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 23:24:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1045 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbYAFEYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 23:24:13 -0500
Received: (qmail 26723 invoked by uid 111); 6 Jan 2008 04:24:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 05 Jan 2008 23:24:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2008 23:24:09 -0500
Content-Disposition: inline
In-Reply-To: <7v63y8ble8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69711>

On Sat, Jan 05, 2008 at 02:46:07AM -0800, Junio C Hamano wrote:

>  * Jeff's git-add--interactive change to always honor color.diff
>    regardless of color.interactive.
> 
>    I'd probably apply this, along with the patch to redefine
>    what color.interactive means.  "git am -i" could also learn
>    to use colors in the future.
> 
>    Incidentally I noticed that many of the color.diff.* palette
>    options are read by "git-add -i" but never used by the
>    script.  We might want to fix this while we are at it.

Here is the palette cleanup patch, on top of my others (it should still
be done even if the other patches aren't taken, but backporting it
should be fairly obvious).

-- >8 --
add--interactive: remove unused diff colors

When color support was added, we colored the diffs
ourselves. However, 4af756f3 changed this to simply run
"git diff-files" twice, keeping the colored output
separately.

This makes the internal diff color variables obsolete with
one exception: when splitting hunks, we have to manually
recreate the fragment for each part of the split. Thus we
keep $fraginfo_color around to do that correctly.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index aaa9b24..5bdcca8 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -6,7 +6,7 @@ use Git;
 # Prompt colors:
 my ($prompt_color, $header_color, $help_color, $normal_color);
 # Diff colors:
-my ($new_color, $old_color, $fraginfo_color, $metainfo_color, $whitespace_color);
+my ($fraginfo_color);
 
 my ($use_color, $diff_use_color);
 my $repo = Git->repository();
@@ -27,11 +27,7 @@ if ($use_color) {
 # Do we also set diff colors?
 $diff_use_color = $repo->get_colorbool('color.diff');
 if ($diff_use_color) {
-	$new_color = $repo->get_color("color.diff.new", "green");
-	$old_color = $repo->get_color("color.diff.old", "red");
 	$fraginfo_color = $repo->get_color("color.diff.frag", "cyan");
-	$metainfo_color = $repo->get_color("color.diff.meta", "bold");
-	$whitespace_color = $repo->get_color("color.diff.whitespace", "normal red");
 }
 
 sub colored {
-- 
1.5.4.rc2.1147.gaecdf-dirty
