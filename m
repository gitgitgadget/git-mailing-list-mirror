From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 03/11] trailer: read and process config information
Date: Mon, 15 Sep 2014 07:31:33 +0200
Message-ID: <20140915053142.26573.44975.chriscool@tuxfamily.org>
References: <20140915052330.26573.34823.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 07:51:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTPBz-00043W-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 07:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbaIOFvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 01:51:11 -0400
Received: from delay-3y.bbox.fr ([194.158.98.73]:55897 "EHLO delay-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbaIOFvK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 01:51:10 -0400
Received: from mail-2y.bbox.fr (bt8sssoo.cs.dolmen.bouyguestelecom.fr [172.24.208.129])
	by delay-3y.bbox.fr (Postfix) with ESMTP id 35744A7BE9
	for <git@vger.kernel.org>; Mon, 15 Sep 2014 07:36:27 +0200 (CEST)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A2A8474;
	Mon, 15 Sep 2014 07:34:05 +0200 (CEST)
X-git-sha1: f0c59db82fe484e93167e6784bf61aa00727976f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140915052330.26573.34823.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257045>

Read the configuration to get trailer information, and then process
it and store it in a doubly linked list.

The config information is stored in the list whose first item is
pointed to by:

static struct trailer_item *first_conf_item;

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/trailer.c b/trailer.c
index 4940e06..2d391f3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -272,3 +272,188 @@ static void process_trailers_lists(struct trailer_item **in_tok_first,
 					     arg_tok);
 	}
 }
+
+static int set_where(struct conf_info *item, const char *value)
+{
+	if (!strcasecmp("after", value))
+		item->where = WHERE_AFTER;
+	else if (!strcasecmp("before", value))
+		item->where = WHERE_BEFORE;
+	else if (!strcasecmp("end", value))
+		item->where = WHERE_END;
+	else if (!strcasecmp("start", value))
+		item->where = WHERE_START;
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
+	else if (!strcasecmp("replace", value))
+		item->if_exists = EXISTS_REPLACE;
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
+static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
+{
+	*dst = *src;
+	if (src->name)
+		dst->name = xstrdup(src->name);
+	if (src->key)
+		dst->key = xstrdup(src->key);
+	if (src->command)
+		dst->command = xstrdup(src->command);
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
+	duplicate_conf(&item->conf, &default_conf_info);
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
+static int git_trailer_default_config(const char *conf_key, const char *value, void *cb)
+{
+	const char *trailer_item, *variable_name;
+
+	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
+		return 0;
+
+	variable_name = strrchr(trailer_item, '.');
+	if (!variable_name) {
+		if (!strcmp(trailer_item, "where")) {
+			if (set_where(&default_conf_info, value) < 0)
+				warning(_("unknown value '%s' for key '%s'"),
+					value, conf_key);
+		} else if (!strcmp(trailer_item, "ifexists")) {
+			if (set_if_exists(&default_conf_info, value) < 0)
+				warning(_("unknown value '%s' for key '%s'"),
+					value, conf_key);
+		} else if (!strcmp(trailer_item, "ifmissing")) {
+			if (set_if_missing(&default_conf_info, value) < 0)
+				warning(_("unknown value '%s' for key '%s'"),
+					value, conf_key);
+		} else if (!strcmp(trailer_item, "separators")) {
+			separators = xstrdup(value);
+		}
+	}
+	return 0;
+}
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
+	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
+		return 0;
+
+	variable_name = strrchr(trailer_item, '.');
+	if (!variable_name)
+		return 0;
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
2.0.3.960.g41c6e4c
