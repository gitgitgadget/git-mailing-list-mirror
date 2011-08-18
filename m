From: Jeff King <peff@peff.net>
Subject: [PATCH 08/10] config: refactor get_colorbool function
Date: Wed, 17 Aug 2011 22:04:56 -0700
Message-ID: <20110818050455.GH2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:05:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtumx-0007z2-Qw
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab1HRFFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:05:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45203
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab1HRFFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:05:02 -0400
Received: (qmail 18422 invoked by uid 107); 18 Aug 2011 05:05:41 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:05:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:04:56 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179565>

For "git config --get-colorbool color.foo", we use a custom
callback that looks not only for the key that the user gave
us, but also for "diff.color" (for backwards compatibility)
and "color.ui" (as a fallback).

For the former, we use a custom variable to store the
diff.color value. For the latter, though, we store it in the
main "git_use_color_default" variable, turning on color.ui
for any other parts of git that respect this value.

In practice, this doesn't cause any bugs, because git-config
runs without caring about git_use_color_default, and then
exits. But it crosses module boundaries in an unusual and
confusing way, and it makes refactoring color handling
harder than it needs to be.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3a09296..0b4ecac 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -305,6 +305,7 @@ static void get_color(const char *def_color)
 
 static int get_colorbool_found;
 static int get_diff_color_found;
+static int get_color_ui_found;
 static int git_get_colorbool_config(const char *var, const char *value,
 		void *cb)
 {
@@ -313,7 +314,7 @@ static int git_get_colorbool_config(const char *var, const char *value,
 	else if (!strcmp(var, "diff.color"))
 		get_diff_color_found = git_config_colorbool(var, value);
 	else if (!strcmp(var, "color.ui"))
-		git_use_color_default = git_config_colorbool(var, value);
+		get_color_ui_found = git_config_colorbool(var, value);
 	return 0;
 }
 
@@ -327,7 +328,7 @@ static int get_colorbool(int print)
 		if (!strcmp(get_colorbool_slot, "color.diff"))
 			get_colorbool_found = get_diff_color_found;
 		if (get_colorbool_found < 0)
-			get_colorbool_found = git_use_color_default;
+			get_colorbool_found = get_color_ui_found;
 	}
 
 	get_colorbool_found = want_color(get_colorbool_found);
-- 
1.7.6.10.g62f04
