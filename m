From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH 3/3] submodule: simplify decision tree whether to or
 not to fetch
Date: Mon, 25 Feb 2013 02:06:53 +0100
Message-ID: <5062c014d5567e0b30e12fb1bc084fcfd71d5d0c.1361751905.git.hvoigt@hvoigt.net>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 02:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9mXH-000516-M6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 02:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759517Ab3BYBGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 20:06:55 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:46423 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759492Ab3BYBGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 20:06:55 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1U9mWr-0001wz-Gp; Mon, 25 Feb 2013 02:06:53 +0100
Content-Disposition: inline
In-Reply-To: <cover.1361751905.git.hvoigt@hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217021>

To make extending this logic later easier.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/submodule.c b/submodule.c
index b603000..a6fe16e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -737,6 +737,23 @@ static void calculate_changed_submodule_paths(void)
 	submodule_config_cache_free(&submodule_config_cache);
 }
 
+static int get_fetch_recurse_config(const char *name, int command_line_option)
+{
+	if (command_line_option != RECURSE_SUBMODULES_DEFAULT)
+		return command_line_option;
+
+	struct string_list_item *fetch_recurse_submodules_option;
+	fetch_recurse_submodules_option = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
+	if (fetch_recurse_submodules_option)
+		/* local config overrules everything except commandline */
+		return (intptr_t)fetch_recurse_submodules_option->util;
+
+	if (gitmodules_is_unmerged)
+		return RECURSE_SUBMODULES_OFF;
+
+	return config_fetch_recurse_submodules;
+}
+
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet)
@@ -781,32 +798,19 @@ int fetch_populated_submodules(const struct argv_array *options,
 		if (name_for_path)
 			name = name_for_path->util;
 
-		default_argv = "yes";
-		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-			struct string_list_item *fetch_recurse_submodules_option;
-			fetch_recurse_submodules_option = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
-			if (fetch_recurse_submodules_option) {
-				if ((intptr_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_OFF)
-					continue;
-				if ((intptr_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_names, name))
-						continue;
-					default_argv = "on-demand";
-				}
-			} else {
-				if ((config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF) ||
-				    gitmodules_is_unmerged)
-					continue;
-				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_names, name))
-						continue;
-					default_argv = "on-demand";
-				}
-			}
-		} else if (command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
+		switch (get_fetch_recurse_config(name, command_line_option)) {
+		default:
+		case RECURSE_SUBMODULES_DEFAULT:
+		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!unsorted_string_list_lookup(&changed_submodule_names, name))
 				continue;
 			default_argv = "on-demand";
+			break;
+		case RECURSE_SUBMODULES_ON:
+			default_argv = "yes";
+			break;
+		case RECURSE_SUBMODULES_OFF:
+			continue;
 		}
 
 		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
-- 
1.8.2.rc0.25.g5062c01
