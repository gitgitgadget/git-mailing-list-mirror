From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Wed, 8 Feb 2012 22:30:59 -0500
Message-ID: <20120209033059.GA4347@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
 <20120207051719.GA11598@sigill.intra.peff.net>
 <CAJDDKr5yiKvNnpVV29jFK1Z1yuUnA-=dn0yMB8iW9y53vRGDHQ@mail.gmail.com>
 <20120207173025.GA22225@sigill.intra.peff.net>
 <m31uq63143.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 04:31:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvKj0-0002cf-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 04:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872Ab2BIDbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 22:31:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59870
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757671Ab2BIDbC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 22:31:02 -0500
Received: (qmail 24001 invoked by uid 107); 9 Feb 2012 03:38:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 22:38:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 22:30:59 -0500
Content-Disposition: inline
In-Reply-To: <m31uq63143.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190267>

On Tue, Feb 07, 2012 at 11:16:47AM -0800, Jakub Narebski wrote:

> Jeff King <peff@peff.net> writes:
> 
> [...]
> > Git-config could potentially help with that (and even simplify the
> > current code) by allowing something like:
> > 
> >   $ git config --list-with-sources
> >   /home/peff/.gitconfig user.name=Jeff King
> >   /home/peff/.gitconfig user.email=peff@peff.net
> >   .git/config core.repositoryformatversion=0
> >   .git/config core.bare=false
> >   [etc]
> > 
> > (you would use the "-z" form, of course, and the filenames would be
> > NUL-separated, but I made up a human-readable output format above for
> > illustration purposes).
> 
> That would be _very_ nice to have (even without includes support).
> 
> Filenames would be git-quoted like in ls-tree / diff-tree output without -z,
> isn't it?  And is that TAB or SPC as a separator?

So the patch would look something like this. However, is the actual
filename really what callers want? It seems like in David's case, an
annotation of "repo", "global", or "system" (possibly in addition to the
filename) would be the most useful (because in the git-cola UI, it is
still nice to list things as "repo" or "global" instead of spewing the
whole filename at the user -- but you would still want the individual
filename for handling updates of includes).

---
 builtin/config.c |   20 ++++++++++++++++++--
 cache.h          |    1 +
 config.c         |    7 +++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d35c06a..e0333f7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "color.h"
 #include "parse-options.h"
+#include "quote.h"
 
 static const char *const builtin_config_usage[] = {
 	"git config [options]",
@@ -41,6 +42,7 @@ static int end_null;
 #define ACTION_SET_ALL (1<<12)
 #define ACTION_GET_COLOR (1<<13)
 #define ACTION_GET_COLORBOOL (1<<14)
+#define ACTION_LIST_WITH_SOURCES (1<<15)
 
 #define TYPE_BOOL (1<<0)
 #define TYPE_INT (1<<1)
@@ -64,6 +66,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "rename-section", &actions, "rename section: old-name new-name", ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, "remove a section: name", ACTION_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, "list all", ACTION_LIST),
+	OPT_BIT(0, "list-with-sources", &actions, "list all variables with sources", ACTION_LIST_WITH_SOURCES),
 	OPT_BIT('e', "edit", &actions, "opens an editor", ACTION_EDIT),
 	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
@@ -86,6 +89,18 @@ static void check_argc(int argc, int min, int max) {
 
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
+	int show_sources = *(int *)cb;
+
+	if (show_sources) {
+		const char *fn = current_config_filename();
+		if (!fn)
+			fn = "";
+		if (end_null)
+			printf("%s%c", fn, '\0');
+		else
+			write_name_quoted(fn, stdout, '\t');
+	}
+
 	if (value_)
 		printf("%s%c%s%c", key_, delim, value_, term);
 	else
@@ -418,9 +433,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
 
-	if (actions == ACTION_LIST) {
+	if (actions == ACTION_LIST || actions == ACTION_LIST_WITH_SOURCES) {
+		int show_sources = actions & ACTION_LIST_WITH_SOURCES ? 1 : 0;
 		check_argc(argc, 0, 0);
-		if (git_config(show_all_config, NULL) < 0) {
+		if (git_config(show_all_config, &show_sources) < 0) {
 			if (config_exclusive_filename)
 				die_errno("unable to read config file '%s'",
 					  config_exclusive_filename);
diff --git a/cache.h b/cache.h
index 9bd8c2d..98b1d09 100644
--- a/cache.h
+++ b/cache.h
@@ -1138,6 +1138,7 @@ extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+extern const char *current_config_filename(void);
 
 extern const char *config_exclusive_filename;
 
diff --git a/config.c b/config.c
index 40f9c6d..7b4094b 100644
--- a/config.c
+++ b/config.c
@@ -1564,3 +1564,10 @@ int config_error_nonbool(const char *var)
 {
 	return error("Missing value for '%s'", var);
 }
+
+const char *current_config_filename(void)
+{
+	if (cf && cf->name)
+		return cf->name;
+	return NULL;
+}
-- 
1.7.9.rc2.14.g3da2b
