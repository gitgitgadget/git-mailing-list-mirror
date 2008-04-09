From: Matthias Kestenholz <mk@spinlock.ch>
Subject: [PATCH] Use color.ui variable in scripts too
Date: Wed,  9 Apr 2008 21:32:06 +0200
Message-ID: <1207769526-14823-1-git-send-email-mk@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <mk@spinlock.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 09 21:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjg91-0003N1-HR
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 21:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbYDITi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 15:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756028AbYDITi4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 15:38:56 -0400
Received: from mail23.bluewin.ch ([195.186.18.67]:42903 "EHLO
	mail23.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586AbYDITiz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 15:38:55 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Apr 2008 15:38:55 EDT
X-FXIT-IP: IPv4[83.78.113.2] Epoch[1207769504]
Received: from [83.78.113.2] ([83.78.113.2:9560] helo=localhost.localdomain)
	by mail23.bluewin.ch (envelope-from <mk@spinlock.ch>)
	(ecelerity 2.2.1.27 r(22433)) with ESMTP
	id 1A/BB-27074-F991DF74; Wed, 09 Apr 2008 19:31:44 +0000
X-Mailer: git-send-email 1.5.5.24.g0eec3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79124>

Signed-off-by: Matthias Kestenholz <mk@spinlock.ch>
---

	This patch adds color.ui support for scripts. It does that by
	modifying `git config --get-colorbool`, because there is no
	way to differentiate between undefined and `false` configuration
	variables in scripts. Additionally, the scripts don't need to be
	changed. I have only tested git add -i; git svn uses the same
	functions in Git.pm, so it should work too.

	Of course, it would have been nicer if I had made this change
	before the release of 1.5.5. The 1.5.5 announcement reminded
	me, that this had yet to be done.

 Documentation/git-config.txt |    2 ++
 builtin-config.c             |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index fa16171..5de5d05 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -144,6 +144,8 @@ See also <<FILES>>.
 	"auto".  If `stdout-is-tty` is missing, then checks the standard
 	output of the command itself, and exits with status 0 if color
 	is to be used, or exits with status 1 otherwise.
+	When the color setting for `name` is undefined, the command uses
+	`color.ui` as fallback.
 
 --get-color name default::
 
diff --git a/builtin-config.c b/builtin-config.c
index c34bc8b..eccb7e7 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -224,6 +224,10 @@ static int git_get_colorbool_config(const char *var, const char *value)
 		get_diff_color_found =
 			git_config_colorbool(var, value, stdout_is_tty);
 	}
+	if (!strcmp(var, "color.ui")) {
+		git_use_color_default = git_config_colorbool(var, value, stdout_is_tty);
+		return 0;
+	}
 	return 0;
 }
 
@@ -251,7 +255,7 @@ static int get_colorbool(int argc, const char **argv)
 		if (!strcmp(get_color_slot, "color.diff"))
 			get_colorbool_found = get_diff_color_found;
 		if (get_colorbool_found < 0)
-			get_colorbool_found = 0;
+			get_colorbool_found = git_use_color_default;
 	}
 
 	if (argc == 1) {
-- 
1.5.5.24.g0eec3.dirty
