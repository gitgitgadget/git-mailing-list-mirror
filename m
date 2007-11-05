From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] parseopt: do not list options with the same name twice
Date: Mon, 5 Nov 2007 13:15:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711051315460.4362@racer.site>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
 <Pine.LNX.4.64.0711051230020.4362@racer.site> <Pine.LNX.4.64.0711051237420.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 14:17:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1p9-0004nY-VL
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 14:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbXKENQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 08:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXKENQt
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 08:16:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:34744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754785AbXKENQs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 08:16:48 -0500
Received: (qmail invoked by alias); 05 Nov 2007 13:16:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 05 Nov 2007 14:16:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DTT1Q6jUDqfxPMX45bqNc9mKa/FvjxqeW1Ar3Ml
	HNRSXQNre6z7zH
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711051237420.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63516>


The option parser will take the first exact match, and happily ignore
it when a later option has the same name.  For example, when you have
something like

	OPT_BOOLEAN('i', NULL, &troz, "blah"),
	OPT_BOOLEAN('i', NULL, &brain, "blub"),

in your options array, a command line "prog -i" will increment the
variable "troz", and leave the variable "brain" alone.

This behavior is all good and well, especially since we plan to
have recursive options, e.g. for the diff options, and in some cases
options should be overridden (see for example format-patch's "-n").

This patch matches the usage to this behavior: whenever an option name
was overridden by another option, it is no longer shown.  In the
example above, that means that the usage would only show

    -i    blah

and not print anything about "blub".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Okay, my plan was borked: the options struct is passed as a
	const.  So this is plan B.

 parse-options.c      |   37 ++++++++++++++++++++++++++-----------
 test-parse-options.c |    2 ++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index ed8e951..83a221b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
+#include "path-list.h"
 
 #define OPT_SHORT 1
 #define OPT_UNSET 2
@@ -261,15 +262,18 @@ int parse_options(int argc, const char **argv, const struct option *options,
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
-static void usage_show_options(const struct option *opts)
+static void usage_show_options(const struct option *opts,
+		char *seen_short_names, struct path_list *seen_long_names)
 {
 	for (; opts->type != OPTION_END; opts++) {
-		size_t pos;
+		const char *before_option = "    ";
+		size_t pos = 0;
 		int pad;
 
 		if (opts->type == OPTION_RECURSE) {
 			const struct option *sub = opts->value;
-			usage_show_options(sub);
+			usage_show_options(sub,
+					seen_short_names, seen_long_names);
 			continue;
 		}
 
@@ -280,13 +284,19 @@ static void usage_show_options(const struct option *opts)
 			continue;
 		}
 
-		pos = fprintf(stderr, "    ");
-		if (opts->short_name)
-			pos += fprintf(stderr, "-%c", opts->short_name);
-		if (opts->long_name && opts->short_name)
-			pos += fprintf(stderr, ", ");
-		if (opts->long_name)
-			pos += fprintf(stderr, "--%s", opts->long_name);
+		if (opts->short_name && !seen_short_names[opts->short_name]) {
+			pos += fprintf(stderr, "%s-%c",
+					before_option, opts->short_name);
+			seen_short_names[opts->short_name] = 1;
+			before_option = ", ";
+		}
+		if (opts->long_name && !path_list_has_path(seen_long_names,
+					opts->long_name)) {
+			pos += fprintf(stderr, "%s--%s",
+					before_option, opts->long_name);
+			path_list_insert(opts->long_name, seen_long_names);
+		} else if (*before_option != ',')
+			continue;
 
 		switch (opts->type) {
 		case OPTION_INTEGER:
@@ -329,6 +339,9 @@ static void usage_show_options(const struct option *opts)
 void usage_with_options(const char * const *usagestr,
                         const struct option *opts)
 {
+	char seen_short_names[256];
+	struct path_list seen_long_names = { NULL, 0, 0, 0 };
+
 	fprintf(stderr, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
 		fprintf(stderr, "   or: %s\n", *usagestr++);
@@ -338,7 +351,9 @@ void usage_with_options(const char * const *usagestr,
 	if (opts->type != OPTION_GROUP)
 		fputc('\n', stderr);
 
-	usage_show_options(opts);
+	memset(seen_short_names, 0, sizeof(seen_short_names));
+	usage_show_options(opts, seen_short_names, &seen_long_names);
+	path_list_clear(&seen_long_names, 0);
 
 	fputc('\n', stderr);
 
diff --git a/test-parse-options.c b/test-parse-options.c
index ee64fb3..56f6f24 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -16,6 +16,7 @@ int main(int argc, const char **argv)
 	struct option sub[] = {
 		OPT_BOOLEAN('n', "narf", &narf, "what are we doing tonight?"),
 		OPT_INTEGER('z', "zort", &zort, "try to take over the world"),
+		OPT_INTEGER('j', NULL, &boolean, "ignored option"),
 		OPT_END(),
 	};
 	struct option options[] = {
@@ -27,6 +28,7 @@ int main(int argc, const char **argv)
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
 		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
+		OPT_INTEGER(0, "string", &boolean, "ignored option"),
 		OPT_END(),
 	};
 	int i;
-- 
1.5.3.5.1549.g91a3
