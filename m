From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Wait help.autocorrect deciseconds before running corrected
	command
Date: Wed, 23 Jul 2008 18:41:10 +0200
Message-ID: <20080723164109.GA5283@blimp.local>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local> <alpine.DEB.1.00.0807222207110.8986@racer> <20080722212633.GF5113@blimp.local> <alpine.DEB.1.00.0807222242160.8986@racer> <7vsku1jz4u.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhPp-0002g1-Vu
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbYGWQlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbYGWQlN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:41:13 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:63704 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYGWQlM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:41:12 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5EC7
Received: from tigra.home (Faf34.f.strato-dslnet.de [195.4.175.52])
	by post.webmailer.de (fruni mo49) (RZmta 16.47)
	with ESMTP id Y03197k6NGBZG6 ; Wed, 23 Jul 2008 18:41:10 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 45197277BD;
	Wed, 23 Jul 2008 18:41:10 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 2DA1736D18; Wed, 23 Jul 2008 18:41:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsku1jz4u.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89704>

Suggested by Junio, so he has a chance to hit Ctrl-C.
---
Junio C Hamano, Wed, Jul 23, 2008 01:08:17 +0200:
> 
> Please make autocorrect not a binary but optionally the number of
> deciseconds before it continues, so that I have a chance to hit ^C ;-)

on top of the last patch.

 Documentation/config.txt |    9 +++++++++
 help.c                   |    7 ++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e784805..5bf1d0d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -771,6 +771,15 @@ help.format::
 	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
 	the default. 'web' and 'html' are the same.
 
+help.autocorrect::
+	Automatically correct and execute mistyped commands after
+	waiting for the given number of deciseconds (0.1 sec). If more
+	than one command can be deduced from the entered text, nothing
+	will be executed.  If the value of this option is negative,
+	the corrected command will be executed immediately. If the
+	value is 0 - the command will be just shown but not executed.
+	This is the default.
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
diff --git a/help.c b/help.c
index 8b25a55..4d52781 100644
--- a/help.c
+++ b/help.c
@@ -271,7 +271,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
 	if (!prefixcmp(var, "man."))
 		return add_man_viewer_info(var, value);
 	if (!strcmp(var, "help.autocorrect"))
-		autocorrect = git_config_bool(var,value);
+		autocorrect = git_config_int(var,value);
 
 	return git_default_config(var, value, cb);
 }
@@ -722,6 +722,11 @@ const char *help_unknown_cmd(const char *cmd)
 			"which does not exist.\n"
 			"Continuing under the assumption that you meant '%s'\n",
 			cmd, main_cmds.names[0]->name);
+		if (autocorrect > 0) {
+			fprintf(stderr, "in %0.1f seconds automatically...\n",
+				(float)autocorrect/10.0);
+			poll(NULL, 0, autocorrect * 100);
+		}
 		return main_cmds.names[0]->name;
 	}
 
-- 
1.6.0.rc0.50.g9c23
