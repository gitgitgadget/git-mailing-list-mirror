From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v3 09/17] remote-helpers: Support custom transport options
Date: Wed, 14 Oct 2009 20:36:46 -0700
Message-ID: <1255577814-14745-10-git-send-email-spearce@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 05:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyHFS-0007IV-E7
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 05:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762473AbZJODid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 23:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762469AbZJODid
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 23:38:33 -0400
Received: from george.spearce.org ([209.20.77.23]:33053 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762444AbZJODiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 23:38:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id E6E933821F; Thu, 15 Oct 2009 03:37:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 5A76B38239;
	Thu, 15 Oct 2009 03:36:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130373>

Some transports, like the native pack transport implemented by
fetch-pack, support useful features like depth or include tags.
These should be exposed if the underlying helper knows how to
use them.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-remote-helpers.txt |   38 +++++++++++++++
 remote-curl.c                        |   74 ++++++++++++++++++++++++++++-
 transport-helper.c                   |   88 +++++++++++++++++++++++++++++++++-
 3 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index e44d821..1133f04 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -35,6 +35,16 @@ Commands are given by the caller on the helper's standard input, one per line.
 	the name; unrecognized attributes are ignored. After the
 	complete list, outputs a blank line.
 
+'option' <name> <value>::
+	Set the transport helper option <name> to <value>.  Outputs a
+	single line containing one of 'ok' (option successfully set),
+	'unsupported' (option not recognized) or 'error <msg>'
+	(option <name> is supported but <value> is not correct
+	for it).  Options should be set before other commands,
+	and may how those commands behave.
++
+Supported if the helper has the "option" capability.
+
 'fetch' <sha1> <name>::
 	Fetches the given object, writing the necessary objects
 	to the database.  Fetch commands are sent in a batch, one
@@ -63,11 +73,39 @@ CAPABILITIES
 'fetch'::
 	This helper supports the 'fetch' command.
 
+'option'::
+	This helper supports the option command.
+
 REF LIST ATTRIBUTES
 -------------------
 
 None are defined yet, but the caller must accept any which are supplied.
 
+OPTIONS
+-------
+'option verbosity' <N>::
+	Change the level of messages displayed by the helper.
+	When N is 0 the end-user has asked the process to be
+	quiet, and the helper should produce only error output.
+	N of 1 is the default level of verbosity, higher values
+	of N correspond to the number of -v flags passed on the
+	command line.
+
+'option progress' \{'true'|'false'\}::
+	Enable (or disable) progress messages displayed by the
+	transport helper during a command.
+
+'option depth' <depth>::
+	Deepen the history of a shallow repository.
+
+'option followtags' \{'true'|'false'\}::
+	If enabled the helper should automatically fetch annotated
+	tag objects if the object the tag points at was transferred
+	during the fetch command.  If the tag is not fetched by
+	the helper a second fetch command will usually be sent to
+	ask for the tag specifically.  Some helpers may be able to
+	use this option to avoid a second network connection.
+
 Documentation
 -------------
 Documentation by Daniel Barkalow.
diff --git a/remote-curl.c b/remote-curl.c
index 22cd5c5..0951f11 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -9,12 +9,61 @@ static struct remote *remote;
 static const char *url;
 static struct walker *walker;
 
+struct options {
+	int verbosity;
+	unsigned long depth;
+	unsigned progress : 1,
+		followtags : 1;
+};
+static struct options options;
+
 static void init_walker(void)
 {
 	if (!walker)
 		walker = get_http_walker(url, remote);
 }
 
+static int set_option(const char *name, const char *value)
+{
+	if (!strcmp(name, "verbosity")) {
+		char *end;
+		int v = strtol(value, &end, 10);
+		if (value == end || *end)
+			return -1;
+		options.verbosity = v;
+		return 0;
+	}
+	else if (!strcmp(name, "progress")) {
+		if (!strcmp(value, "true"))
+			options.progress = 1;
+		else if (!strcmp(value, "false"))
+			options.progress = 0;
+		else
+			return -1;
+		return 1 /* TODO implement later */;
+	}
+	else if (!strcmp(name, "depth")) {
+		char *end;
+		unsigned long v = strtoul(value, &end, 10);
+		if (value == end || *end)
+			return -1;
+		options.depth = v;
+		return 1 /* TODO implement later */;
+	}
+	else if (!strcmp(name, "followtags")) {
+		if (!strcmp(value, "true"))
+			options.followtags = 1;
+		else if (!strcmp(value, "false"))
+			options.followtags = 0;
+		else
+			return -1;
+		return 1 /* TODO implement later */;
+	}
+	else {
+		return 1 /* unsupported */;
+	}
+}
+
 static struct ref *get_refs(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
@@ -99,7 +148,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 	walker->get_all = 1;
 	walker->get_tree = 1;
 	walker->get_history = 1;
-	walker->get_verbosely = 0;
+	walker->get_verbosely = options.verbosity >= 3;
 	walker->get_recover = 0;
 	ret = walker_fetch(walker, nr_heads, targets, NULL, NULL);
 
@@ -173,6 +222,9 @@ int main(int argc, const char **argv)
 		return 1;
 	}
 
+	options.verbosity = 1;
+	options.progress = !!isatty(2);
+
 	remote = remote_get(argv[1]);
 
 	if (argc > 2) {
@@ -198,8 +250,28 @@ int main(int argc, const char **argv)
 			}
 			printf("\n");
 			fflush(stdout);
+		} else if (!prefixcmp(buf.buf, "option ")) {
+			char *name = buf.buf + strlen("option ");
+			char *value = strchr(name, ' ');
+			int result;
+
+			if (value)
+				*value++ = '\0';
+			else
+				value = "true";
+
+			result = set_option(name, value);
+			if (!result)
+				printf("ok\n");
+			else if (result < 0)
+				printf("error invalid value\n");
+			else
+				printf("unsupported\n");
+			fflush(stdout);
+
 		} else if (!strcmp(buf.buf, "capabilities")) {
 			printf("fetch\n");
+			printf("option\n");
 			printf("\n");
 			fflush(stdout);
 		} else {
diff --git a/transport-helper.c b/transport-helper.c
index 9de3408..577abc6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -5,13 +5,15 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "quote.h"
 
 struct helper_data
 {
 	const char *name;
 	struct child_process *helper;
 	FILE *out;
-	unsigned fetch : 1;
+	unsigned fetch : 1,
+		option : 1;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -48,6 +50,8 @@ static struct child_process *get_helper(struct transport *transport)
 			break;
 		if (!strcmp(buf.buf, "fetch"))
 			data->fetch = 1;
+		if (!strcmp(buf.buf, "option"))
+			data->option = 1;
 	}
 	return data->helper;
 }
@@ -65,9 +69,88 @@ static int disconnect_helper(struct transport *transport)
 		free(data->helper);
 		data->helper = NULL;
 	}
+	free(data);
 	return 0;
 }
 
+static const char *unsupported_options[] = {
+	TRANS_OPT_UPLOADPACK,
+	TRANS_OPT_RECEIVEPACK,
+	TRANS_OPT_THIN,
+	TRANS_OPT_KEEP
+	};
+static const char *boolean_options[] = {
+	TRANS_OPT_THIN,
+	TRANS_OPT_KEEP,
+	TRANS_OPT_FOLLOWTAGS
+	};
+
+static int set_helper_option(struct transport *transport,
+			  const char *name, const char *value)
+{
+	struct helper_data *data = transport->data;
+	struct child_process *helper = get_helper(transport);
+	struct strbuf buf = STRBUF_INIT;
+	int i, ret, is_bool = 0;
+
+	if (!data->option)
+		return 1;
+
+	for (i = 0; i < ARRAY_SIZE(unsupported_options); i++) {
+		if (!strcmp(name, unsupported_options[i]))
+			return 1;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(boolean_options); i++) {
+		if (!strcmp(name, boolean_options[i])) {
+			is_bool = 1;
+			break;
+		}
+	}
+
+	strbuf_addf(&buf, "option %s ", name);
+	if (is_bool)
+		strbuf_addstr(&buf, value ? "true" : "false");
+	else
+		quote_c_style(value, &buf, NULL, 0);
+	strbuf_addch(&buf, '\n');
+
+	if (write_in_full(helper->in, buf.buf, buf.len) != buf.len)
+		die_errno("cannot send option to %s", data->name);
+
+	strbuf_reset(&buf);
+	if (strbuf_getline(&buf, data->out, '\n') == EOF)
+		exit(128); /* child died, message supplied already */
+
+	if (!strcmp(buf.buf, "ok"))
+		ret = 0;
+	else if (!prefixcmp(buf.buf, "error")) {
+		ret = -1;
+	} else if (!strcmp(buf.buf, "unsupported"))
+		ret = 1;
+	else {
+		warning("%s unexpectedly said: '%s'", data->name, buf.buf);
+		ret = 1;
+	}
+	strbuf_release(&buf);
+	return ret;
+}
+
+static void standard_options(struct transport *t)
+{
+	char buf[16];
+	int n;
+	int v = t->verbose;
+	int no_progress = v < 0 || (!t->progress && !isatty(1));
+
+	set_helper_option(t, "progress", !no_progress ? "true" : "false");
+
+	n = snprintf(buf, sizeof(buf), "%d", v + 1);
+	if (n >= sizeof(buf))
+		die("impossibly large verbosity value");
+	set_helper_option(t, "verbosity", buf);
+}
+
 static int fetch_with_fetch(struct transport *transport,
 			    int nr_heads, const struct ref **to_fetch)
 {
@@ -75,6 +158,8 @@ static int fetch_with_fetch(struct transport *transport,
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
+	standard_options(transport);
+
 	for (i = 0; i < nr_heads; i++) {
 		const struct ref *posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
@@ -178,6 +263,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	data->name = name;
 
 	transport->data = data;
+	transport->set_option = set_helper_option;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
 	transport->disconnect = disconnect_helper;
-- 
1.6.5.52.g0ff2e
