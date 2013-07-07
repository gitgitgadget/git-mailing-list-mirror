From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-config(1): clarify precedence of multiple values
Date: Sun, 7 Jul 2013 20:49:56 +0100
Message-ID: <20130707194956.GU9161@serenity.lan>
References: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
 <7vd2qzfpk9.fsf@alter.siamese.dyndns.org>
 <20130707095026.GR9161@serenity.lan>
 <7v38rq5lad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 21:50:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvuyI-00075z-K6
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 21:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab3GGTuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 15:50:06 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52902 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab3GGTuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 15:50:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D74A26064E4;
	Sun,  7 Jul 2013 20:50:03 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsvKU6K9UGmP; Sun,  7 Jul 2013 20:50:03 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 080A36064AA;
	Sun,  7 Jul 2013 20:49:58 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v38rq5lad.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229801>

In order to clarify which value is used when there are multiple values
defined for a key, re-order the list of file locations so that it runs
from least specific to most specific.  Then add a paragraph which simply
says that the last value will be used.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Sun, Jul 07, 2013 at 10:31:38AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> >> I wondered if we should explain the significance of "last" a bit
> >> more (like "this results in the value from the most specific
> >> configuration file to be used, the ones in $GIT_DIR/config
> >> overriding what is in $HOME/.gitconfig"), but I do not have a strong
> >> opinion either way.  Let's queue this for 'maint' for now.
> >
> > I don't think that change belongs here.  How about doing something like
> > this in the FILES section (the first two hunks are just reordering the
> > existing list, only the last hunk changes the content):
> 
> Sounds like a good change to me ;-).

So here it is as a proper patch :-)

 Documentation/git-config.txt | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index fbad05e..99dc497 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -206,12 +206,8 @@ FILES
 If not set explicitly with '--file', there are four files where
 'git config' will search for configuration options:
 
-$GIT_DIR/config::
-	Repository specific configuration file.
-
-~/.gitconfig::
-	User-specific configuration file. Also called "global"
-	configuration file.
+$(prefix)/etc/gitconfig::
+	System-wide configuration file.
 
 $XDG_CONFIG_HOME/git/config::
 	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
@@ -221,8 +217,12 @@ $XDG_CONFIG_HOME/git/config::
 	you sometimes use older versions of Git, as support for this
 	file was added fairly recently.
 
-$(prefix)/etc/gitconfig::
-	System-wide configuration file.
+~/.gitconfig::
+	User-specific configuration file. Also called "global"
+	configuration file.
+
+$GIT_DIR/config::
+	Repository specific configuration file.
 
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
@@ -230,6 +230,10 @@ file are not available they will be ignored. If the repository configuration
 file is not available or readable, 'git config' will exit with a non-zero
 error code. However, in neither case will an error message be issued.
 
+The files are read in the order given above, with last value found taking
+precedence over values read earlier.  When multiple values are taken then all
+values of a key from all files will be used.
+
 All writing options will per default write to the repository specific
 configuration file. Note that this also affects options like '--replace-all'
 and '--unset'. *'git config' will only ever change one file at a time*.
-- 
1.8.3.2.855.gbc9faed
