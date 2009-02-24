From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 16/23] builtin-remote: refactor get_remote_ref_states()
Date: Tue, 24 Feb 2009 04:51:04 -0500
Message-ID: <29438718de2df87754786279cd138b0d1fe0ca0e.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu01-0002Ej-Gz
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbZBXJwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755990AbZBXJv5
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:57 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:15777 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947AbZBXJv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:56 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005621yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=58NsK17mAsimpJeEF9inplOtK6RgWPmkUNTUKrkM/PY=;
        b=GiT6EzolIYejF06OacCAC/CTcnwWQR5lD8OyyNDiwIvycF5Dgp23/PgDsJeTI3NJEq
         RWZPmAJXl+/+hqSwX3PDIVj42wlY2CpMoy9r3sgjHcvyykExQ1pxZlFcfebbkMvCjizl
         aUDbIXgJOd50JASuFWIm5mB+hx4h40DoSyTWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pEQk6OxYuBbq/wHLFmWTCrmOva2m2sA/uEUe3xJdH01+/rxkMIhHPKKJ6A5Rzfo9c/
         vJgIz3XFrQTzmgOA8ZWWsdQtqznt6YFIXE6WZX1/bPDHgX2b+c/Bl/eQQ1HJaBTUmMjs
         TWBniDGYm9+2AwqbUae8bMpOAUOrGCrInc7Qg=
Received: by 10.100.58.19 with SMTP id g19mr5461800ana.82.1235469114575;
        Tue, 24 Feb 2009 01:51:54 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c37sm7604205ana.2.2009.02.24.01.51.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:54 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111275>

get_remote_ref_states() has three callers, but each is interested in
slightly different information. Give it a bit-field flag so that callers
can specify which pieces of information they need.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 5ef8163..a822bd5 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -19,6 +19,9 @@ static const char * const builtin_remote_usage[] = {
 	NULL
 };
 
+#define GET_REF_STATES (1<<0)
+#define GET_HEAD_NAMES (1<<1)
+
 static int verbose;
 
 static int show_all(void);
@@ -691,9 +694,10 @@ static int get_remote_ref_states(const char *name,
 			states->remote->url[0] : NULL);
 		remote_refs = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
-
-		get_head_names(remote_refs, name, states);
-		get_ref_states(remote_refs, states);
+		if (query & GET_REF_STATES)
+			get_ref_states(remote_refs, states);
+		if (query & GET_HEAD_NAMES)
+			get_head_names(remote_refs, name, states);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
 		sort_string_list(&states->tracked);
@@ -704,7 +708,7 @@ static int get_remote_ref_states(const char *name,
 
 static int show(int argc, const char **argv)
 {
-	int no_query = 0, result = 0;
+	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
 		OPT_GROUP("show specific options"),
 		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
@@ -717,11 +721,14 @@ static int show(int argc, const char **argv)
 	if (argc < 1)
 		return show_all();
 
+	if (!no_query)
+		query_flag = (GET_REF_STATES | GET_HEAD_NAMES);
+
 	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
 		int i;
 
-		get_remote_ref_states(*argv, &states, !no_query);
+		get_remote_ref_states(*argv, &states, query_flag);
 
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
@@ -805,7 +812,7 @@ static int set_head(int argc, const char **argv)
 	} else if (opt_a && !opt_d && argc == 1) {
 		struct ref_states states;
 		memset(&states, 0, sizeof(states));
-		get_remote_ref_states(argv[0], &states, 1);
+		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
 		if (!states.heads.nr)
 			result |= error("Cannot determine remote HEAD");
 		else if (states.heads.nr > 1) {
@@ -865,7 +872,7 @@ static int prune(int argc, const char **argv)
 	for (; argc; argc--, argv++) {
 		int i;
 
-		get_remote_ref_states(*argv, &states, 1);
+		get_remote_ref_states(*argv, &states, GET_REF_STATES);
 
 		if (states.stale.nr) {
 			printf("Pruning %s\n", *argv);
-- 
1.6.2.rc1.291.g83eb
