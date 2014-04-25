From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v11 03/11] trailer: read and process config information
Date: Fri, 25 Apr 2014 21:06:54 +0200
Message-ID: <20140425190703.28550.22898.chriscool@tuxfamily.org>
References: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:08:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlTs-0003tp-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbaDYTHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:07:51 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:56433 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588AbaDYTHq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:07:46 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 0F6D844;
	Fri, 25 Apr 2014 21:07:44 +0200 (CEST)
X-git-sha1: 171998f0229f1736ad8a97fd0007e6be67112db6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247096>

Read the configuration to get trailer information, and then process
it and store it in a doubly linked list.

The config information is stored in the list whose first item is
pointed to by:

static struct trailer_item *first_conf_item;

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/trailer.c b/trailer.c
index 52108c2..f376be5 100644
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
@@ -245,3 +247,147 @@ static void process_trailers_lists(struct trailer_item **in_tok_first,
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
+		return -1;
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
+		return -1;
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
+		return -1;
+	return 0;
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
+enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
+			 TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
+
+static struct {
+	const char *name;
+	enum trailer_info_type type;
+} trailer_config_items[] = {
+	{ "key", TRAILER_KEY },
+	{ "command", TRAILER_COMMAND },
+	{ "where", TRAILER_WHERE },
+	{ "ifexists", TRAILER_IF_EXISTS },
+	{ "ifmissing", TRAILER_IF_MISSING }
+};
+
+static int git_trailer_config(const char *conf_key, const char *value, void *cb)
+{
+	const char *trailer_item, *variable_name;
+	struct trailer_item *item;
+	struct conf_info *conf;
+	char *name = NULL;
+	enum trailer_info_type type;
+	int i;
+
+	trailer_item = skip_prefix(conf_key, "trailer.");
+	if (!trailer_item)
+		return 0;
+
+	variable_name = strrchr(trailer_item, '.');
+	if (!variable_name) {
+		warning(_("two level trailer config variable %s"), conf_key);
+		return 0;
+	}
+
+	variable_name++;
+	for (i = 0; i < ARRAY_SIZE(trailer_config_items); i++) {
+		if (strcmp(trailer_config_items[i].name, variable_name))
+			continue;
+		name = xstrndup(trailer_item,  variable_name - trailer_item - 1);
+		type = trailer_config_items[i].type;
+		break;
+	}
+
+	if (!name)
+		return 0;
+
+	item = get_conf_item(name);
+	conf = &item->conf;
+	free(name);
+
+	switch (type) {
+	case TRAILER_KEY:
+		if (conf->key)
+			warning(_("more than one %s"), conf_key);
+		conf->key = xstrdup(value);
+		break;
+	case TRAILER_COMMAND:
+		if (conf->command)
+			warning(_("more than one %s"), conf_key);
+		conf->command = xstrdup(value);
+		break;
+	case TRAILER_WHERE:
+		if (set_where(conf, value))
+			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
+		break;
+	case TRAILER_IF_EXISTS:
+		if (set_if_exists(conf, value))
+			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
+		break;
+	case TRAILER_IF_MISSING:
+		if (set_if_missing(conf, value))
+			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
+		break;
+	default:
+		die("internal bug in trailer.c");
+	}
+	return 0;
+}
-- 
1.9.1.636.g20d5f34
