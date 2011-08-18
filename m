From: Jeff King <peff@peff.net>
Subject: [PATCH 09/10] diff: don't load color config in plumbing
Date: Wed, 17 Aug 2011 22:05:08 -0700
Message-ID: <20110818050506.GI2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtun8-00083E-Pq
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab1HRFFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:05:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45208
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab1HRFFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:05:13 -0400
Received: (qmail 18454 invoked by uid 107); 18 Aug 2011 05:05:53 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:05:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:05:08 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179566>

The diff config callback is split into two functions: one
which loads "ui" config, and one which loads "basic" config.
The former chains to the latter, as the diff UI config is a
superset of the plumbing config.

The color.diff variable is only loaded in the UI config.
However, the basic config actually chains to
git_color_default_config, which loads color.ui. This doesn't
actually cause any bugs, because the plumbing diff code does
not actually look at the value of color.ui.

However, it is somewhat nonsensical, and it makes it
difficult to refactor the color code. It probably came about
because there is no git_color_config to load only color
config, but rather just git_color_default_config, which
loads color config and chains to git_default_config.

This patch splits out the color-specific portion of
git_color_default_config so that the diff UI config can call
it directly. This is perhaps better explained by the
chaining of callbacks. Before we had:

  git_diff_ui_config
    -> git_diff_basic_config
      -> git_color_default_config
        -> git_default_config

Now we have:

  git_diff_ui_config
    -> git_color_config
    -> git_diff_basic_config
      -> git_default_config

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c |   10 +++++++++-
 color.h |    4 +++-
 diff.c  |    5 ++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/color.c b/color.c
index 8586417..ec96fe1 100644
--- a/color.c
+++ b/color.c
@@ -204,13 +204,21 @@ int want_color(int var)
 	return var > 0;
 }
 
-int git_color_default_config(const char *var, const char *value, void *cb)
+int git_color_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "color.ui")) {
 		git_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
 
+	return 0;
+}
+
+int git_color_default_config(const char *var, const char *value, void *cb)
+{
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
 	return git_default_config(var, value, cb);
 }
 
diff --git a/color.h b/color.h
index d715fd5..5949bcd 100644
--- a/color.h
+++ b/color.h
@@ -74,8 +74,10 @@ extern const int column_colors_ansi_max;
 extern int color_stdout_is_tty;
 
 /*
- * Use this instead of git_default_config if you need the value of color.ui.
+ * Use the first one if you need only color config; the second is a convenience
+ * if you are just going to change to git_default_config, too.
  */
+int git_color_config(const char *var, const char *value, void *cb);
 int git_color_default_config(const char *var, const char *value, void *cb);
 
 int git_config_colorbool(const char *var, const char *value);
diff --git a/diff.c b/diff.c
index 29cecf1..0a22320 100644
--- a/diff.c
+++ b/diff.c
@@ -164,6 +164,9 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.ignoresubmodules"))
 		handle_ignore_submodules_arg(&default_diff_options, value);
 
+	if (git_color_config(var, value, cb) < 0)
+		return -1;
+
 	return git_diff_basic_config(var, value, cb);
 }
 
@@ -212,7 +215,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
-	return git_color_default_config(var, value, cb);
+	return git_default_config(var, value, cb);
 }
 
 static char *quote_two(const char *one, const char *two)
-- 
1.7.6.10.g62f04
