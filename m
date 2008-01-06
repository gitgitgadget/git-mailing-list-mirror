From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable frozen)
Date: Sun, 6 Jan 2008 06:17:26 -0500
Message-ID: <20080106111725.GA11603@coredump.intra.peff.net>
References: <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org> <7vy7btaf4p.fsf@gitster.siamese.dyndns.org> <7vfxxtu5ov.fsf@gitster.siamese.dyndns.org> <7v63y8ble8.fsf@gitster.siamese.dyndns.org> <20080106042409.GA4843@coredump.intra.peff.net> <20080106042935.GB4843@coredump.intra.peff.net> <7vejcv5is3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 12:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBTWK-0002XK-Gf
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 12:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbYAFLRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 06:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYAFLRa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 06:17:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1537 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791AbYAFLR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 06:17:28 -0500
Received: (qmail 27917 invoked by uid 111); 6 Jan 2008 11:17:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Jan 2008 06:17:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2008 06:17:26 -0500
Content-Disposition: inline
In-Reply-To: <7vejcv5is3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69729>

On Sun, Jan 06, 2008 at 02:51:24AM -0800, Junio C Hamano wrote:

> It may make more sense to:
> 
>  * unset $prompt_color and friends when color.interactive says
>    "not to color the menus";
> 
>  * unset $fraginfo_color and diff related ones when color.diff
>    says "diff is monochrome";
> 
> upfront, and then change "sub colored" to just check if $color
> is unset, instead of checking $use_color.

Something like this (instead of my last patch):

-- >8 --
add--interactive: fix "colored" function semantics

Since color.interactive is just for the menus, the "colored"
function can't use it to determine whether to show colors
(this was visible as a bug in which the headers of split
hunks were not colored if color.diff was set but
color.interactive was not).

The new semantics are:

  - colors which are unused are set to undef; the "colored"
    function knows not to do anything with them

  - menu colors are set only when color.interactive is true

  - diff colors are set only when color.diff is true

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |   39 +++++++++++++++------------------------
 1 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5bdcca8..17ca5b8 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -3,38 +3,29 @@
 use strict;
 use Git;
 
-# Prompt colors:
-my ($prompt_color, $header_color, $help_color, $normal_color);
-# Diff colors:
-my ($fraginfo_color);
-
-my ($use_color, $diff_use_color);
 my $repo = Git->repository();
 
-$use_color = $repo->get_colorbool('color.interactive');
-
-if ($use_color) {
-	# Set interactive colors:
+my $menu_use_color = $repo->get_colorbool('color.interactive');
+my ($prompt_color, $header_color, $help_color) =
+	$menu_use_color ? (
+		$repo->get_color('color.interactive.prompt', 'bold blue'),
+		$repo->get_color('color.interactive.header', 'bold'),
+		$repo->get_color('color.interactive.help', 'red bold'),
+	) : ();
 
-	# Grab the 3 main colors in git color string format, with sane
-	# (visible) defaults:
-	$prompt_color = $repo->get_color("color.interactive.prompt", "bold blue");
-	$header_color = $repo->get_color("color.interactive.header", "bold");
-	$help_color = $repo->get_color("color.interactive.help", "red bold");
-	$normal_color = $repo->get_color("", "reset");
-}
+my $diff_use_color = $repo->get_colorbool('color.diff');
+my ($fraginfo_color) =
+	$diff_use_color ? (
+		$repo->get_color('color.diff.frag', 'cyan'),
+	) : ();
 
-# Do we also set diff colors?
-$diff_use_color = $repo->get_colorbool('color.diff');
-if ($diff_use_color) {
-	$fraginfo_color = $repo->get_color("color.diff.frag", "cyan");
-}
+my $normal_color = $repo->get_color("", "reset");
 
 sub colored {
 	my $color = shift;
 	my $string = join("", @_);
 
-	if ($use_color) {
+	if (defined $color) {
 		# Put a color code at the beginning of each line, a reset at the end
 		# color after newlines that are not at the end of the string
 		$string =~ s/(\n+)(.)/$1$color$2/g;
@@ -300,7 +291,7 @@ sub highlight_prefix {
 		return "$prefix$remainder";
 	}
 
-	if (!$use_color) {
+	if (!$menu_use_color) {
 		return "[$prefix]$remainder";
 	}
 
-- 
1.5.4.rc2.1148.gf9fe3-dirty
