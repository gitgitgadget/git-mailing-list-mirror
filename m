From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/5] Ensure builtin-fetch honors {fetch,transfer}.unpackLimit
Date: Wed, 19 Sep 2007 00:49:39 -0400
Message-ID: <20070919044939.GD17107@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 06:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXrVg-00072u-QM
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 06:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbXISEto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 00:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXISEtn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 00:49:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38748 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbXISEtm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 00:49:42 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXrVK-0006xW-OW; Wed, 19 Sep 2007 00:49:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B432920FBAE; Wed, 19 Sep 2007 00:49:39 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58677>

The only way to configure the unpacking limit is currently through
the .git/config (or ~/.gitconfig) mechanism as we have no existing
command line option interface to control this threshold on a per
invocation basis.  This was intentional by design as the storage
policy of the repository should be a repository-wide decision and
should not be subject to variations made on individual command
executions.

Earlier builtin-fetch was bypassing the unpacking limit chosen by
the user through the configuration file as it did not reread the
configuration options through fetch_pack_config if we called the
internal fetch_pack() API directly.  We now ensure we always run the
config file through fetch_pack_config at least once in this process,
thereby setting our unpackLimit properly.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch-pack.c |   19 +++++++++++++------
 transport.c          |    9 ---------
 transport.h          |    3 ---
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 77eb181..d128915 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -670,18 +670,24 @@ static int fetch_pack_config(const char *var, const char *value)
 
 static struct lock_file lock;
 
-int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
+static void fetch_pack_setup()
 {
-	int i, ret, nr_heads;
-	struct ref *ref;
-	char *dest = NULL, **heads;
-
+	static int did_setup;
+	if (did_setup)
+		return;
 	git_config(fetch_pack_config);
-
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
 	else if (0 <= fetch_unpack_limit)
 		unpack_limit = fetch_unpack_limit;
+	did_setup = 1;
+}
+
+int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
+{
+	int i, ret, nr_heads;
+	struct ref *ref;
+	char *dest = NULL, **heads;
 
 	nr_heads = 0;
 	heads = NULL;
@@ -760,6 +766,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 	struct ref *ref;
 	struct stat st;
 
+	fetch_pack_setup();
 	memcpy(&args, my_args, sizeof(args));
 	if (args.depth > 0) {
 		if (stat(git_path("shallow"), &st))
diff --git a/transport.c b/transport.c
index 85f5b1e..a1d0a3c 100644
--- a/transport.c
+++ b/transport.c
@@ -242,11 +242,7 @@ static int close_bundle(struct transport *transport)
 struct git_transport_data {
 	unsigned thin : 1;
 	unsigned keep : 1;
-
-	int unpacklimit;
-
 	int depth;
-
 	const char *uploadpack;
 	const char *receivepack;
 };
@@ -267,9 +263,6 @@ static int set_git_option(struct transport *connection,
 	} else if (!strcmp(name, TRANS_OPT_KEEP)) {
 		data->keep = !!value;
 		return 0;
-	} else if (!strcmp(name, TRANS_OPT_UNPACKLIMIT)) {
-		data->unpacklimit = atoi(value);
-		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
 			data->depth = 0;
@@ -318,7 +311,6 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.uploadpack = data->uploadpack;
 	args.keep_pack = data->keep;
 	args.lock_pack = 1;
-	args.unpacklimit = data->unpacklimit;
 	args.use_thin_pack = data->thin;
 	args.verbose = transport->verbose;
 	args.depth = data->depth;
@@ -435,7 +427,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		data->receivepack = "git-receive-pack";
 		if (remote && remote->receivepack)
 			data->receivepack = remote->receivepack;
-		data->unpacklimit = -1;
 	}
 
 	return ret;
diff --git a/transport.h b/transport.h
index 3e332ff..6e318e4 100644
--- a/transport.h
+++ b/transport.h
@@ -47,9 +47,6 @@ struct transport *transport_get(struct remote *, const char *);
 /* Keep the pack that was transferred if not null */
 #define TRANS_OPT_KEEP "keep"
 
-/* Unpack the objects if fewer than this number of objects are fetched */
-#define TRANS_OPT_UNPACKLIMIT "unpacklimit"
-
 /* Limit the depth of the fetch if not null */
 #define TRANS_OPT_DEPTH "depth"
 
-- 
1.5.3.1.195.gadd6
