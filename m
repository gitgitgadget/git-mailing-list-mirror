From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 08/16] remote-helpers: Support custom transport options
Date: Mon, 12 Oct 2009 19:25:07 -0700
Message-ID: <1255400715-10508-9-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDB-0004cs-8J
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758838AbZJMC0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758811AbZJMC0h
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:37 -0400
Received: from george.spearce.org ([209.20.77.23]:56210 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758814AbZJMC0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id BC9CA382A4; Tue, 13 Oct 2009 02:25:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BD99138200;
	Tue, 13 Oct 2009 02:25:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130110>

Some transports, like the native pack transport implemented by
fetch-pack, support useful features like depth or include tags.
These should be exposed if the underlying helper knows how to
use them and is based upon the same infrastructure.

Helpers must advertise the options they support, any attempt
to set an unsupported option will cause a failure.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-remote-helpers.txt |   20 ++++++++++
 remote-curl.c                        |   16 ++++++-
 transport-helper.c                   |   70 ++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index e10ce99..334ab30 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -46,6 +46,7 @@ Supported if the helper has the "fetch" capability.
 'fetch-multiple'::
 	Fetches multiple objects at once.  The fetch-multiple
 	command is followed by one or more 'fetch' lines as above,
+	zero or more 'option' lines for the supported options,
 	and then a blank line to terminate the batch.  Outputs a
 	single blank line when the entire batch is complete.
 	Optionally may output a 'lock <file>' line indicating a
@@ -69,6 +70,9 @@ CAPABILITIES
 'fetch-multiple'::
 	This helper supports the 'fetch-multiple' command.
 
+'option' <name>::
+	This helper supports the option <name> under fetch-multiple.
+
 REF LIST ATTRIBUTES
 -------------------
 
@@ -76,10 +80,26 @@ None are defined yet, but the caller must accept any which are supplied.
 
 FETCH OPTIONS
 -------------
+To enable an option the helper must list it in 'capabilities'.
 
 'option verbose'::
 	Print more verbose activity messages to stderr.
 
+'option uploadpack' <command>::
+	The program to use on the remote side to generate a pack.
+
+'option depth' <depth>::
+	Deepen the history of a shallow repository.
+
+'option keep'::
+	Keep the transferred pack(s) with .keep files.
+
+'option followtags'::
+	Aggressively fetch annotated tags if possible.
+
+'option thin'::
+	Transfer the data as a thin pack if possible.
+
 Documentation
 -------------
 Documentation by Daniel Barkalow.
diff --git a/remote-curl.c b/remote-curl.c
index 34ca4e7..e5d9768 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -86,7 +86,12 @@ static struct ref *get_refs(void)
 	return refs;
 }
 
-static int fetch_dumb(int nr_heads, struct ref **to_fetch)
+struct fetch_args {
+	unsigned verbose : 1;
+};
+
+static int fetch_dumb(struct fetch_args *args,
+	int nr_heads, struct ref **to_fetch)
 {
 	char **targets = xmalloc(nr_heads * sizeof(char*));
 	int ret, i;
@@ -98,7 +103,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 	walker->get_all = 1;
 	walker->get_tree = 1;
 	walker->get_history = 1;
-	walker->get_verbosely = 0;
+	walker->get_verbosely = args->verbose;
 	walker->get_recover = 0;
 	ret = walker_fetch(walker, nr_heads, targets, NULL, NULL);
 
@@ -115,7 +120,9 @@ static void parse_fetch(struct strbuf *buf, int multiple)
 	struct ref *list_head = NULL;
 	struct ref **list = &list_head;
 	int alloc_heads = 0, nr_heads = 0;
+	struct fetch_args args;
 
+	memset(&args, 0, sizeof(args));
 	do {
 		if (!prefixcmp(buf->buf, "fetch ")) {
 			char *p = buf->buf + strlen("fetch ");
@@ -144,6 +151,8 @@ static void parse_fetch(struct strbuf *buf, int multiple)
 			if (!multiple)
 				break;
 		}
+		else if (!strcmp(buf->buf, "option verbose"))
+			args.verbose = 1;
 		else
 			die("http transport does not support %s", buf->buf);
 
@@ -154,7 +163,7 @@ static void parse_fetch(struct strbuf *buf, int multiple)
 			break;
 	} while (1);
 
-	if (fetch_dumb(nr_heads, to_fetch))
+	if (fetch_dumb(&args, nr_heads, to_fetch))
 		exit(128); /* error already reported */
 	free_refs(list_head);
 	free(to_fetch);
@@ -208,6 +217,7 @@ int main(int argc, const char **argv)
 		} else if (!strcmp(buf.buf, "capabilities")) {
 			printf("fetch\n");
 			printf("fetch-multiple\n");
+			printf("option verbose\n");
 			printf("\n");
 			fflush(stdout);
 		} else {
diff --git a/transport-helper.c b/transport-helper.c
index eb66e0c..bb6cd1b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -5,12 +5,15 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "string-list.h"
+
 
 struct helper_data
 {
 	const char *name;
 	struct child_process *helper;
 	FILE *out;
+	struct string_list options;
 	unsigned fetch : 1,
 		fetch_multiple : 1;
 };
@@ -51,6 +54,11 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "fetch-multiple"))
 			data->fetch_multiple = 1;
+		if (!prefixcmp(buf.buf, "option ")) {
+			const char *name = buf.buf + strlen("option ");
+			if (!string_list_lookup(name, &data->options))
+				string_list_insert(xstrdup(name), &data->options);
+		}
 	}
 	return data->helper;
 }
@@ -68,6 +76,65 @@ static int disconnect_helper(struct transport *transport)
 		free(data->helper);
 		data->helper = NULL;
 	}
+	string_list_clear(&data->options, 1);
+	free(data);
+	return 0;
+}
+
+static int save_option(struct transport *transport,
+			  const char *name, const char *value)
+{
+	struct helper_data *data = transport->data;
+	struct string_list_item *s;
+
+	s = string_list_lookup(name, &data->options);
+	if (!s)
+		return 1;
+	free(s->util);
+	s->util = value ? xstrdup(value) : NULL;
+	return 0;
+}
+
+static int set_helper_option(struct transport *transport,
+			  const char *name, const char *value)
+{
+	struct helper_data *data = transport->data;
+	int is_bool = 0;
+
+	get_helper(transport);
+
+	if (!data->fetch_multiple)
+		return 1;
+
+	if (!strcmp(name, TRANS_OPT_THIN))
+		is_bool = 1;
+	else if (!strcmp(name, TRANS_OPT_KEEP))
+		is_bool = 1;
+	else if (!strcmp(name, TRANS_OPT_FOLLOWTAGS))
+		is_bool = 1;
+
+	if (is_bool)
+		value = value ? "" : NULL;
+	return save_option(transport, name, value);
+}
+
+static void standard_options(struct transport *transport)
+{
+	save_option(transport, "verbose", transport->verbose ? "" : NULL);
+}
+
+static int print_options(struct string_list_item *s, void *arg)
+{
+	struct strbuf *buf = arg;
+	char *name = s->string;
+	char *value = s->util;
+
+	if (!value)
+		return 0;
+	else if (*value)
+		strbuf_addf(buf, "option %s %s\n", name, value);
+	else
+		strbuf_addf(buf, "option %s\n", name);
 	return 0;
 }
 
@@ -114,6 +181,8 @@ static int fetch_with_fetch(struct transport *transport,
 	}
 
 	if (data->fetch_multiple) {
+		standard_options(transport);
+		for_each_string_list(print_options, &data->options, &buf);
 		strbuf_addch(&buf, '\n');
 		perform_fetch_command(transport, &buf);
 	}
@@ -191,6 +260,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	data->name = name;
 
 	transport->data = data;
+	transport->set_option = set_helper_option;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
 	transport->disconnect = disconnect_helper;
-- 
1.6.5.52.g0ff2e
