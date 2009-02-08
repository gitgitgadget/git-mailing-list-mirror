From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] add -p: get rid of Git.pm warnings about unitialized values
Date: Sun,  8 Feb 2009 18:40:39 +0100
Message-ID: <1234114839-11958-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 08 18:42:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWDfj-0001D8-Q5
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 18:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbZBHRkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 12:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbZBHRkz
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 12:40:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:38065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752161AbZBHRky (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 12:40:54 -0500
Received: (qmail invoked by alias); 08 Feb 2009 17:40:52 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp037) with SMTP; 08 Feb 2009 18:40:52 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1871uUWU147BsBxWPcElNpvz8IB3A7IqJcwfPaWB7
	wC3smAARoAo+vN
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LWDe3-00037N-C4; Sun, 08 Feb 2009 18:40:39 +0100
X-Mailer: git-send-email 1.6.2.rc0.446.g760ba.dirty
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108994>

After invoking git add -p I always got the warnings:

 Use of uninitialized value $_[3] in exec at Git.pm line 1282.
 Use of uninitialized value $args[2] in join or string at Git.pm line 1264.

A bisect showed that these warnings occur in a301973 "add -p: print errors
in separate color" the first time.

They can be reproduced by setting color.ui (or color.interactive) to "auto"
and unsetting color.interactive.help and color.interactive.error.
I am using Perl 5.10.0.

The reason of the warning is that color.interactive.error defaults to
color.interactive.help which defaults to nothing in the specific codepath.
It defaults to 'red bold' some lines above which could lead to the wrong
assumption that it always defaults to 'red bold' now.

This patch lets it default to 'red bold', blowing the warnings away.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-add--interactive.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ec47888..5f129a4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -14,7 +14,8 @@ my ($prompt_color, $header_color, $help_color) =
 	) : ();
 my $error_color = ();
 if ($menu_use_color) {
-	my $help_color_spec = $repo->config('color.interactive.help');
+	my $help_color_spec = ($repo->config('color.interactive.help') or
+				'red bold');
 	$error_color = $repo->get_color('color.interactive.error',
 					$help_color_spec);
 }
-- 
1.6.2.rc0.446.g760ba.dirty
