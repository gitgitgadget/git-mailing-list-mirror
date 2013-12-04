From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 03/11] fetch: use the new functions for handling --prune options
Date: Wed,  4 Dec 2013 06:44:42 +0100
Message-ID: <1386135890-13954-4-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5Ny-0007pN-QW
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab3LDFwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:52:30 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53412 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752158Ab3LDFw2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:52:28 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2013 00:52:28 EST
X-AuditID: 12074412-b7fc96d0000023d5-3d-529ec176fd94
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.80.09173.671CE925; Wed,  4 Dec 2013 00:45:26 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCA8016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:25 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqFt2cF6QwfQeWYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M74e0mr4JRUxc/W+ewNjOtF
	uxg5OSQETCS+Hp/ADGGLSVy4t56ti5GLQ0jgMqNEw4K7LBDOeSaJNZ1XmUCq2AR0JRb1NIPZ
	IgLiEm+Pz2TvYuTgYBaIkDj0tgTEFBbwk1gymROkgkVAVaL/wi2wCl4BF4kvK9ggVilIdK75
	zwhicwq4SnT0LmEGKRECKrl31mkCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZ
	JXqpKaWbGCEhIrSDcf1JuUOMAhyMSjy8CZzzgoRYE8uKK3MPMUpyMCmJ8tZvBwrxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4bUpA8rxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwWh0AahQsSk1PrUjLzClBSDNxcIIILpANPEAbTEEKeYsLEnOLM9Mhik4xKkqJ84aB
	JARAEhmleXADYNH8ilEc6B9hXk+QKh5gIoDrfgU0mAlosPmrWSCDSxIRUlINjCG89w0O111/
	dWHCyXihrQzz169O3zab2Yj13Y9/m4Ifz5zUvJDvytxtGW7hj/xu3eKPOBq5XPjd1GnhXG9E
	dhlE5LbvubjgEa9f5rGGh6GPHH70ud+KyT7op/Rv5tzzT9oqI7sePfp0xie+S9tg3vpr1125
	5kcfdNkyVWXJjGYP0cTtK6SO915SYinOSDTUYi4qTgQA7ceEgsECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238757>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9a04512..fcc06a4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -30,8 +30,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int fetch_prune_config = -1; /* unspecified */
-static int prune = -1; /* unspecified */
+static struct prune_option prune_option = PRUNE_OPTION_INIT;
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
@@ -59,15 +58,6 @@ static int option_parse_recurse_submodules(const struct option *opt,
 	return 0;
 }
 
-static int git_fetch_config(const char *k, const char *v, void *cb)
-{
-	if (!strcmp(k, "fetch.prune")) {
-		fetch_prune_config = git_config_bool(k, v);
-		return 0;
-	}
-	return 0;
-}
-
 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "all", &all,
@@ -83,8 +73,9 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
-	OPT_BOOL('p', "prune", &prune,
-		 N_("prune remote-tracking branches no longer on remote")),
+	{ OPTION_CALLBACK, 'p', "prune", &prune_option, N_("pattern"),
+		    N_("prune remote-tracking branches no longer on remote"),
+		    PARSE_OPT_NOARG, prune_option_parse },
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
@@ -848,7 +839,7 @@ static int do_fetch(struct transport *transport,
 		retcode = 1;
 		goto cleanup;
 	}
-	if (prune) {
+	if (prune_option.prune) {
 		/*
 		 * We only prune based on refspecs specified
 		 * explicitly (via command line or configuration); we
@@ -935,8 +926,7 @@ static void add_options_to_argv(struct argv_array *argv)
 {
 	if (dry_run)
 		argv_array_push(argv, "--dry-run");
-	if (prune != -1)
-		argv_array_push(argv, prune ? "--prune" : "--no-prune");
+	argv_push_prune_option(argv, &prune_option);
 	if (update_head_ok)
 		argv_array_push(argv, "--update-head-ok");
 	if (force)
@@ -1002,17 +992,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		die(_("No remote repository specified.  Please, specify either a URL or a\n"
 		    "remote name from which new revisions should be fetched."));
 
-	gtransport = prepare_transport(remote);
+	prune_option_fill(remote, &prune_option, PRUNE_BY_DEFAULT);
 
-	if (prune < 0) {
-		/* no command line request */
-		if (0 <= gtransport->remote->prune)
-			prune = gtransport->remote->prune;
-		else if (0 <= fetch_prune_config)
-			prune = fetch_prune_config;
-		else
-			prune = PRUNE_BY_DEFAULT;
-	}
+	gtransport = prepare_transport(remote);
 
 	if (argc > 0) {
 		int j = 0;
@@ -1063,8 +1045,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
-	git_config(git_fetch_config, NULL);
-
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
-- 
1.8.4.3
