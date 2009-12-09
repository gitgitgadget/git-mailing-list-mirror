From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH v2 4/8] Refactor git transport options parsing
Date: Wed,  9 Dec 2009 17:26:30 +0200
Message-ID: <1260372394-16427-5-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 16:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIORf-0002on-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbZLIP0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbZLIP0k
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:26:40 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:51273 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbZLIP0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:26:36 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id D5E538C249
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:41 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A06E29D2791; Wed, 09 Dec 2009 17:26:41 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id A722C1C638C
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:40 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134987>

Refactor the transport options parsing so that protocols that aren't
directly smart transports (file://, git://, ssh:// & co) can record
the smart transport options for the case if it turns that transport
can actually be smart.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport.c |   78 +++++++++++++++++++++++++++++++++++-----------------------
 transport.h |   15 +++++++++++
 2 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/transport.c b/transport.c
index dea37d0..e6eb20e 100644
--- a/transport.c
+++ b/transport.c
@@ -395,41 +395,35 @@ static int close_bundle(struct transport *transport)
 }
 
 struct git_transport_data {
-	unsigned thin : 1;
-	unsigned keep : 1;
-	unsigned followtags : 1;
-	int depth;
+	struct git_transport_options options;
 	struct child_process *conn;
 	int fd[2];
-	const char *uploadpack;
-	const char *receivepack;
 	struct extra_have_objects extra_have;
 };
 
-static int set_git_option(struct transport *connection,
+static int set_git_option(struct git_transport_options *opts,
 			  const char *name, const char *value)
 {
-	struct git_transport_data *data = connection->data;
 	if (!strcmp(name, TRANS_OPT_UPLOADPACK)) {
-		data->uploadpack = value;
+		opts->uploadpack = value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_RECEIVEPACK)) {
-		data->receivepack = value;
+		opts->receivepack = value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_THIN)) {
-		data->thin = !!value;
+		opts->thin = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_FOLLOWTAGS)) {
-		data->followtags = !!value;
+		opts->followtags = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_KEEP)) {
-		data->keep = !!value;
+		opts->keep = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
-			data->depth = 0;
+			opts->depth = 0;
 		else
-			data->depth = atoi(value);
+			opts->depth = atoi(value);
 		return 0;
 	}
 	return 1;
@@ -439,7 +433,8 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
 {
 	struct git_transport_data *data = transport->data;
 	data->conn = git_connect(data->fd, transport->url,
-				 for_push ? data->receivepack : data->uploadpack,
+				 for_push ? data->options.receivepack :
+				 data->options.uploadpack,
 				 verbose ? CONNECT_VERBOSE : 0);
 	return 0;
 }
@@ -469,15 +464,15 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct ref *refs_tmp = NULL;
 
 	memset(&args, 0, sizeof(args));
-	args.uploadpack = data->uploadpack;
-	args.keep_pack = data->keep;
+	args.uploadpack = data->options.uploadpack;
+	args.keep_pack = data->options.keep;
 	args.lock_pack = 1;
-	args.use_thin_pack = data->thin;
-	args.include_tag = data->followtags;
+	args.use_thin_pack = data->options.thin;
+	args.include_tag = data->options.followtags;
 	args.verbose = (transport->verbose > 0);
 	args.quiet = (transport->verbose < 0);
 	args.no_progress = args.quiet || (!transport->progress && !isatty(1));
-	args.depth = data->depth;
+	args.depth = data->options.depth;
 
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
@@ -734,7 +729,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	memset(&args, 0, sizeof(args));
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
 	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
-	args.use_thin_pack = data->thin;
+	args.use_thin_pack = data->options.thin;
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
 	args.quiet = !!(flags & TRANSPORT_PUSH_QUIET);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
@@ -847,12 +842,14 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
+		ret->smart_options = NULL;
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->get_refs_list = get_refs_from_bundle;
 		ret->fetch = fetch_refs_from_bundle;
 		ret->disconnect = close_bundle;
+		ret->smart_options = NULL;
 	} else if (!is_url(url)
 		|| !prefixcmp(url, "file://")
 		|| !prefixcmp(url, "git://")
@@ -862,20 +859,14 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		/* These are builtin smart transports. */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
-		ret->set_option = set_git_option;
+		ret->set_option = NULL;
 		ret->get_refs_list = get_refs_via_connect;
 		ret->fetch = fetch_refs_via_pack;
 		ret->push_refs = git_transport_push;
 		ret->disconnect = disconnect_git;
+		ret->smart_options = &(data->options);
 
-		data->thin = 1;
 		data->conn = NULL;
-		data->uploadpack = "git-upload-pack";
-		if (remote->uploadpack)
-			data->uploadpack = remote->uploadpack;
-		data->receivepack = "git-receive-pack";
-		if (remote->receivepack)
-			data->receivepack = remote->receivepack;
 	} else if (!prefixcmp(url, "http://")
 		|| !prefixcmp(url, "https://")
 		|| !prefixcmp(url, "ftp://")) {
@@ -893,14 +884,39 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		transport_helper_init(ret, handler);
 	}
 
+	if (ret->smart_options) {
+		ret->smart_options->thin = 1;
+		ret->smart_options->uploadpack = "git-upload-pack";
+		if (remote->uploadpack)
+			ret->smart_options->uploadpack = remote->uploadpack;
+		ret->smart_options->receivepack = "git-receive-pack";
+		if (remote->receivepack)
+			ret->smart_options->receivepack = remote->receivepack;
+	}
+
 	return ret;
 }
 
 int transport_set_option(struct transport *transport,
 			 const char *name, const char *value)
 {
+	int git_reports = 1, protocol_reports = 1;
+
+	if (transport->smart_options)
+		git_reports = set_git_option(transport->smart_options,
+					     name, value);
+
 	if (transport->set_option)
-		return transport->set_option(transport, name, value);
+		protocol_reports = transport->set_option(transport, name,
+							value);
+
+	/* If either report is 0, report 0 (success). */
+	if (!git_reports || !protocol_reports)
+		return 0;
+	/* If either reports -1 (invalid value), report -1. */
+	if ((git_reports == -1) || (protocol_reports == -1))
+		return -1;
+	/* Otherwise if both report unknown, report unknown. */
 	return 1;
 }
 
diff --git a/transport.h b/transport.h
index 9e74406..e90c285 100644
--- a/transport.h
+++ b/transport.h
@@ -4,6 +4,15 @@
 #include "cache.h"
 #include "remote.h"
 
+struct git_transport_options {
+	unsigned thin : 1;
+	unsigned keep : 1;
+	unsigned followtags : 1;
+	int depth;
+	const char *uploadpack;
+	const char *receivepack;
+};
+
 struct transport {
 	struct remote *remote;
 	const char *url;
@@ -65,6 +74,12 @@ struct transport {
 	signed verbose : 3;
 	/* Force progress even if the output is not a tty */
 	unsigned progress : 1;
+	/*
+	 * If transport is at least potentially smart, this points to
+	 * git_transport_options structure to use in case transport
+	 * actually turns out to be smart.
+	 */
+	struct git_transport_options *smart_options;
 };
 
 #define TRANSPORT_PUSH_ALL 1
-- 
1.6.6.rc1.300.gfbc27
