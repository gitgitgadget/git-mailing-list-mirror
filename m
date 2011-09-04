From: Nix <nix@esperi.org.uk>
Subject: [PATCH] Support sizes >=2G in various config options accepting 'g' sizes.
Date: Sun, 04 Sep 2011 22:03:15 +0100
Message-ID: <87obz0nhpo.fsf@spindle.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 23:25:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0KBi-0003Mx-KX
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 23:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab1IDVZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 17:25:05 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:48881 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab1IDVZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 17:25:03 -0400
X-Greylist: delayed 1306 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Sep 2011 17:25:03 EDT
Received: from esperi.org.uk (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.4/8.14.3) with ESMTP id p84L3F0l002431
	for <git@vger.kernel.org>; Sun, 4 Sep 2011 22:03:15 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.14.4/8.12.11/Submit) id p84L3FFo003029;
	Sun, 4 Sep 2011 22:03:15 +0100
Emacs: you'll understand when you're older, dear.
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-DCC-URT-Metrics: spindle 1060; Body=1 Fuz1=1 Fuz2=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180704>

The config options core.packedGitWindowSize, core.packedGitLimit,
core.deltaBaseCacheLimit and core.bigFileThreshold all claim
to support suffixes up to and including 'g'.  This implies that
they should accept sizes >=2G on 64-bit systems: certainly,
specifying a size of 3g should not silently be translated to zero
or transformed into a large negative value due to integer
overflow.  However, due to use of git_config_int() rather than
git_config_ulong(), that is exactly what happens:

% git config core.bigFileThreshold 2g
% git gc --aggressive # with extra debugging code to print out
                      # core.bigfilethreshold after parsing
bigfilethreshold: -2147483648
[...]

This is probably irrelevant for core.deltaBaseCacheLimit, but
is problematic for the other values.  (It is particularly
problematic for core.packedGitLimit, which can't even be set to
its default value in the config file due to this bug.)

I haven't tried to fix things on 32-bit platforms, because there
is no real point setting any values to >2G on such platforms
anyway, and minimal likelihood that anyone would try.  The only
real fix possible would be a diagnostic warning of an attempt to
set a ridiculously high value, unless we want to use 'long long'
everywhere, which I doubt.

Signed-off-by: Nick Alcock <nix@esperi.org.uk>
---
 config.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 4183f80..919f581 100644
--- a/config.c
+++ b/config.c
@@ -550,7 +550,7 @@ static int git_default_core_config(const char *var, const char *value)
 
 	if (!strcmp(var, "core.packedgitwindowsize")) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_int(var, value);
+		packed_git_window_size = git_config_ulong(var, value);
 
 		/* This value must be multiple of (pagesize * 2) */
 		packed_git_window_size /= pgsz_x2;
@@ -561,18 +561,18 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.bigfilethreshold")) {
-		long n = git_config_int(var, value);
+		long n = git_config_ulong(var, value);
 		big_file_threshold = 0 < n ? n : 0;
 		return 0;
 	}
 
 	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_int(var, value);
+		packed_git_limit = git_config_ulong(var, value);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_int(var, value);
+		delta_base_cache_limit = git_config_ulong(var, value);
 		return 0;
 	}
 
-- 
1.7.6.1.138.g03ab.dirty
