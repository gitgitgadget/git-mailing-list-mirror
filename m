From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 03/11] trailer: read and process config information
Date: Thu, 06 Mar 2014 23:14:00 +0100
Message-ID: <20140306221409.29648.10706.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 07:20:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLo97-00089r-4a
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 07:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbaCGGUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 01:20:24 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:38294 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbaCGGUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 01:20:23 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 01CAA3F;
	Fri,  7 Mar 2014 07:20:21 +0100 (CET)
X-git-sha1: 97dc016e1b87e444a6a33bd655730e6cdedbbd17 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243593>

This patch implements reading the configuration
to get trailer information, and then processing
it and storing it in a doubly linked list.

The config information is stored in the list
whose first item is pointed to by:

static struct trailer_item *first_conf_item;

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/trailer.c b/trailer.c
index 52108c2..7a6d35d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -25,6 +25,8 @@ struct trailer_item {
 	struct conf_info conf;
 };
 
+static struct trailer_item *first_conf_item;
+
 static int same_token(struct trailer_item *a, struct trailer_item *b, int alnum_len)
 {
 	return !strncasecmp(a->token, b->token, alnum_len);
@@ -245,3 +247,135 @@ static void process_trailers_lists(struct trailer_item **in_tok_first,
 		apply_arg_if_missing(in_tok_first, in_tok_last, arg_tok);
 	}
 }
+
+static int set_where(struct conf_info *item, const char *value)
+{
+	if (!strcasecmp("after", value))
+		item->where = WHERE_AFTER;
+	else if (!strcasecmp("before", value))
+		item->where = WHERE_BEFORE;
+	else
+		return 1;
+	return 0;
+}
+
+static int set_if_exists(struct conf_info *item, const char *value)
+{
+	if (!strcasecmp("addIfDifferent", value))
+		item->if_exists = EXISTS_ADD_IF_DIFFERENT;
+	else if (!strcasecmp("addIfDifferentNeighbor", value))
+		item->if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
+	else if (!strcasecmp("add", value))
+		item->if_exists = EXISTS_ADD;
+	else if (!strcasecmp("overwrite", value))
+		item->if_exists = EXISTS_OVERWRITE;
+	else if (!strcasecmp("doNothing", value))
+		item->if_exists = EXISTS_DO_NOTHING;
+	else
+		return 1;
+	return 0;
+}
+
+static int set_if_missing(struct conf_info *item, const char *value)
+{
+	if (!strcasecmp("doNothing", value))
+		item->if_missing = MISSING_DO_NOTHING;
+	else if (!strcasecmp("add", value))
+		item->if_missing = MISSING_ADD;
+	else
+		return 1;
+	return 0;
+}
+
+enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
+			 TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
+
+static int set_name_and_type(const char *conf_key, const char *suffix,
+			     enum trailer_info_type type,
+			     char **pname, enum trailer_info_type *ptype)
+{
+	int ret = ends_with(conf_key, suffix);
+	if (ret) {
+		*pname = xstrndup(conf_key, strlen(conf_key) - strlen(suffix));
+		*ptype = type;
+	}
+	return ret;
+}
+
+static struct trailer_item *get_conf_item(const char *name)
+{
+	struct trailer_item *item;
+	struct trailer_item *previous;
+
+	/* Look up item with same name */
+	for (previous = NULL, item = first_conf_item;
+	     item;
+	     previous = item, item = item->next) {
+		if (!strcasecmp(item->conf.name, name))
+			return item;
+	}
+
+	/* Item does not already exists, create it */
+	item = xcalloc(sizeof(struct trailer_item), 1);
+	item->conf.name = xstrdup(name);
+
+	if (!previous)
+		first_conf_item = item;
+	else {
+		previous->next = item;
+		item->previous = previous;
+	}
+
+	return item;
+}
+
+static int git_trailer_config(const char *conf_key, const char *value, void *cb)
+{
+	if (starts_with(conf_key, "trailer.")) {
+		const char *orig_conf_key = conf_key;
+		struct trailer_item *item;
+		struct conf_info *conf;
+		char *name;
+		enum trailer_info_type type;
+
+		conf_key += 8;
+		if (!set_name_and_type(conf_key, ".key", TRAILER_KEY, &name, &type) &&
+		    !set_name_and_type(conf_key, ".command", TRAILER_COMMAND, &name, &type) &&
+		    !set_name_and_type(conf_key, ".where", TRAILER_WHERE, &name, &type) &&
+		    !set_name_and_type(conf_key, ".ifexists", TRAILER_IF_EXISTS, &name, &type) &&
+		    !set_name_and_type(conf_key, ".ifmissing", TRAILER_IF_MISSING, &name, &type))
+			return 0;
+
+		item = get_conf_item(name);
+		conf = &item->conf;
+		free(name);
+
+		switch (type) {
+		case TRAILER_KEY:
+			if (conf->key)
+				warning(_("more than one %s"), orig_conf_key);
+			conf->key = xstrdup(value);
+			break;
+		case TRAILER_COMMAND:
+			if (conf->command)
+				warning(_("more than one %s"), orig_conf_key);
+			conf->command = xstrdup(value);
+			break;
+		case TRAILER_WHERE:
+			if (set_where(conf, value))
+				warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
+			break;
+		case TRAILER_IF_EXISTS:
+			if (set_if_exists(conf, value))
+				warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
+			break;
+		case TRAILER_IF_MISSING:
+			if (set_if_missing(conf, value))
+				warning(_("unknown value '%s' for key '%s'"), value, orig_conf_key);
+			break;
+		default:
+			die("internal bug in trailer.c");
+		}
+	}
+	return 0;
+}
-- 
1.8.5.2.204.gcfe299d.dirty
