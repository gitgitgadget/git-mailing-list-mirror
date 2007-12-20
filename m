From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Make git send-email accept $EDITOR with arguments
Date: Thu, 20 Dec 2007 21:14:06 +0100
Message-ID: <1198181646-28632-1-git-send-email-hendeby@isy.liu.se>
Cc: gitster@pobox.com, Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 21:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Rmt-0004hr-7d
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 21:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758799AbXLTUON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 15:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbXLTUOM
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 15:14:12 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:46912 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758547AbXLTUOK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 15:14:10 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id A29B325AAB;
	Thu, 20 Dec 2007 21:14:07 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 21058-06; Thu, 20 Dec 2007 21:14:06 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id DE3B525AA9;
	Thu, 20 Dec 2007 21:14:06 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id D24141779C; Thu, 20 Dec 2007 21:14:06 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc1.4.gb8173
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69013>

Currently git send-email does not accept $EDITOR with arguments, eg,
emacs -nw, when starting an editor to produce a cover letter.  This fixes
this in the simplest way possible, assume all spaces separates either
the command from the first argument, or two arguments.  This should
work in most cases, but will break with quoted strings embedded spaces.
An example of a problematic case is when there is a space in the path
to the command.

Signed-off-by:  Gustaf Hendeby <hendeby@isy.liu.se>
---

This is related to the problems recently observed in the built in git
commit and git tag.  I guess the behavior of git send-email has been
the same from the start, but having it treat $EDITOR substantially
different from that of git commit and git tag seems like bug or at
least something that should be avoided.

I'm not completely satisfied with the problem with embedded spaces,
but my Perl skills aren't good enough to do anything about it.  If
anyone have any suggestions on how to do it, it would be greatly
appreciated.  None-the-less, even with this shortcoming, I think this
is a step in the right direction.

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 248d035..47ae77c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -400,7 +400,7 @@ EOT
 	close(C);
 
 	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-	system($editor, $compose_filename);
+	system((split ' ', $editor), $compose_filename);
 
 	open(C2,">",$compose_filename . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;
-- 
1.5.4.rc1.3.gc641f
