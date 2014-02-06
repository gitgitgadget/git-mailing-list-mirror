From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 03/14] trailer: read and process config information
Date: Thu, 06 Feb 2014 21:19:52 +0100
Message-ID: <20140206202004.325.65208.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:21:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVRz-0003kv-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbaBFUVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:21:22 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:43372 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbaBFUVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:21:21 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id E02AC5A;
	Thu,  6 Feb 2014 21:21:19 +0100 (CET)
X-git-sha1: 53db5b106aad59b4a4cc0b4d493ea9f60e6f5ec4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140206194123.325.99451.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241728>

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
index ba0cfe0..f844f46 100644
--- a/trailer.c
+++ b/trailer.c
@@ -25,6 +25,8 @@ struct trailer_item {
 	struct conf_info *conf;
 };
 
+static struct trailer_item *first_conf_item;
+
 static inline int same_token(struct trailer_item *a, struct trailer_item *b, int alnum_len)
 {
 	return !strncasecmp(a->token, b->token, alnum_len);
@@ -233,3 +235,135 @@ static void process_trailers_lists(struct trailer_item **infile_tok_first,
 		apply_arg_if_missing(infile_tok_first, infile_tok_last, arg_tok);
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
+static int set_if_exist(struct conf_info *item, const char *value)
+{
+	if (!strcasecmp("addIfDifferent", value))
+		item->if_exist = EXIST_ADD_IF_DIFFERENT;
+	else if (!strcasecmp("addIfDifferentNeighbor", value))
+		item->if_exist = EXIST_ADD_IF_DIFFERENT_NEIGHBOR;
+	else if (!strcasecmp("add", value))
+		item->if_exist = EXIST_ADD;
+	else if (!strcasecmp("overwrite", value))
+		item->if_exist = EXIST_OVERWRITE;
+	else if (!strcasecmp("doNothing", value))
+		item->if_exist = EXIST_DO_NOTHING;
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
+			 TRAILER_IF_EXIST, TRAILER_IF_MISSING };
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
+		if (!strcasecmp(item->conf->name, name))
+			return item;
+	}
+
+	/* Item does not already exists, create it */
+	item = xcalloc(sizeof(struct trailer_item), 1);
+	item->conf = xcalloc(sizeof(struct conf_info), 1);
+	item->conf->name = xstrdup(name);
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
+		    !set_name_and_type(conf_key, ".ifexist", TRAILER_IF_EXIST, &name, &type) &&
+		    !set_name_and_type(conf_key, ".ifmissing", TRAILER_IF_MISSING, &name, &type))
+			return 0;
+
+		item = get_conf_item(name);
+		conf = item->conf;
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
+		case TRAILER_IF_EXIST:
+			if (set_if_exist(conf, value))
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
1.8.5.2.206.g98f5689.dirty
