From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable frozen)
Date: Sat, 5 Jan 2008 23:29:35 -0500
Message-ID: <20080106042935.GB4843@coredump.intra.peff.net>
References: <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org> <7vy7btaf4p.fsf@gitster.siamese.dyndns.org> <7vfxxtu5ov.fsf@gitster.siamese.dyndns.org> <7v63y8ble8.fsf@gitster.siamese.dyndns.org> <20080106042409.GA4843@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 05:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBN9A-0007e6-Jx
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 05:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbYAFE3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 23:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbYAFE3i
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 23:29:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3730 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbYAFE3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 23:29:37 -0500
Received: (qmail 26748 invoked by uid 111); 6 Jan 2008 04:29:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 05 Jan 2008 23:29:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2008 23:29:35 -0500
Content-Disposition: inline
In-Reply-To: <20080106042409.GA4843@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69712>

On Sat, Jan 05, 2008 at 11:24:09PM -0500, Jeff King wrote:

> >  * Jeff's git-add--interactive change to always honor color.diff
> >    regardless of color.interactive.
> > 
> >    I'd probably apply this, along with the patch to redefine
> >    what color.interactive means.  "git am -i" could also learn
> >    to use colors in the future.
> 
> Here is the palette cleanup patch, on top of my others (it should still

And while tracking down the $fraginfo usage, I noticed that my original
patches introduce a bug. Fix is below (it is on top of palette cleanup).

I can also resubmit these in a more sensible order (palette cleanup,
then the other three squashed together) if you prefer.

-- >8 --
add--interactive: colorize split hunk fragment headers

The only diff element which we still color in perl is the
"fraginfo" for the split hunks. When honoring color.diff
without color.interactive, we were failing to actually color
this because the "colored" function checks for interactive
color. Instead, let's just color it by hand (the simple
approach is OK because we know we have a single line
string).

Signed-off-by: Jeff King <peff@peff.net>
---
This is a little uglier than it could be because the "colored" function
does two things: correctly colorize a string, and check the global
$use_color. We could do something like:

  local $use_color = 1;
  $display_head = colored($fraginfo_color, $head);

which is arguably less ugly. Or we could refactor "colored", which is a
larger change.

 git-add--interactive.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5bdcca8..76dc4e6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -21,8 +21,8 @@ if ($use_color) {
 	$prompt_color = $repo->get_color("color.interactive.prompt", "bold blue");
 	$header_color = $repo->get_color("color.interactive.header", "bold");
 	$help_color = $repo->get_color("color.interactive.help", "red bold");
-	$normal_color = $repo->get_color("", "reset");
 }
+$normal_color = $repo->get_color("", "reset");
 
 # Do we also set diff colors?
 $diff_use_color = $repo->get_colorbool('color.diff');
@@ -648,7 +648,8 @@ sub split_hunk {
 		my $display_head = $head;
 		unshift @{$hunk->{TEXT}}, $head;
 		if ($diff_use_color) {
-			$display_head = colored($fraginfo_color, $head);
+			$display_head = join('', $fraginfo_color, $head,
+				$normal_color, "\n");
 		}
 		unshift @{$hunk->{DISPLAY}}, $display_head;
 	}
-- 
1.5.4.rc2.1147.gaecdf-dirty
