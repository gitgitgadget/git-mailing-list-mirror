From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 12/13] remote.c: refactor get_remote_ref_states()
Date: Mon, 23 Feb 2009 03:31:32 -0500
Message-ID: <1235377892-96089-1-git-send-email-jaysoffian@gmail.com>
References: <76718490902222355v7510d2f9p51ade61d1f257146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 09:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbWFN-0005kf-65
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 09:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbZBWIbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 03:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbZBWIbg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 03:31:36 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:36140 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZBWIbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 03:31:36 -0500
Received: by gxk22 with SMTP id 22so4891112gxk.13
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 00:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TDmcVpUnlzKsqvgjCnOhcHIkusDU8llsP1pBbTSc4S8=;
        b=aLsq6g1TynCeoLRspjHjxGnQIWZ29zPvVKbEA8SOhpXgsbSxX3kvZIIH73vgvwT2W+
         qLjtVr+lO+X0nTlZ0mTECbauhWZoy+PTYgtueJ6qQtCu5Xd0f0zlJtvFrY2JjKGUawiu
         wnZC8AHeTG6qR0V+N3E3lZHqTJEyNC3M42EFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aFlpymVqgiOO6M4yOK6hvEbHhHrNkgm5REjWHyzgFj+gxQtc1kRSEw5wo7usrgvKOt
         nlCv1r77cP8MpeM42PKGx2RBjOoMKL0zJU/27O1SR0dL5MxxtMCsiFNrSgVWmFHZxJAe
         uxrrlfu1z03BIPjmuZTnoUHpB87B1OkwfNDiI=
Received: by 10.100.14.2 with SMTP id 2mr3478642ann.79.1235377894641;
        Mon, 23 Feb 2009 00:31:34 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c28sm12523492anc.45.2009.02.23.00.31.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 00:31:34 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <76718490902222355v7510d2f9p51ade61d1f257146@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111120>

---
So here's the inter-diff doing it the way you suggest. I'm surprised it
didn't add any LOC. If you really think this is better I'll re-do the
end of the series to do it this way.

 builtin-remote.c |   81 ++++++++++++++++++++++++++---------------------------
 1 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index ac49219..5651b41 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -19,10 +19,6 @@ static const char * const builtin_remote_usage[] = {
 	NULL
 };
 
-#define GET_REF_STATES (1<<0)
-#define GET_HEAD_NAMES (1<<1)
-#define GET_PUSH_REF_STATES (1<<2)
-
 static int verbose;
 
 static int show_all(void);
@@ -383,7 +379,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 }
 
 static int get_head_names(const struct ref *remote_refs,
-	const char *remote_name, struct ref_states *states)
+			  struct ref_states *states)
 {
 	struct ref *ref, *matches;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
@@ -785,37 +781,15 @@ static int append_ref_to_tracked_list(const char *refname,
 	return 0;
 }
 
-static int get_remote_ref_states(const char *name,
-				 struct ref_states *states,
-				 int query)
+static const struct ref *get_remote_refs(struct ref_states *states)
 {
 	struct transport *transport;
 	const struct ref *remote_refs;
-
-	states->remote = remote_get(name);
-	if (!states->remote)
-		return error("No such remote: %s", name);
-
-	read_branches();
-
-	if (query) {
-		transport = transport_get(NULL, states->remote->url_nr > 0 ?
-			states->remote->url[0] : NULL);
-		remote_refs = transport_get_remote_refs(transport);
-		transport_disconnect(transport);
-		states->queried = 1;
-		if (query & GET_REF_STATES)
-			get_ref_states(remote_refs, states);
-		if (query & GET_HEAD_NAMES)
-			get_head_names(remote_refs, name, states);
-		if (query & GET_PUSH_REF_STATES)
-			get_push_ref_states(remote_refs, states);
-	} else {
-		for_each_ref(append_ref_to_tracked_list, states);
-		sort_string_list(&states->tracked);
-		get_push_ref_states_noquery(states);
-	}
-	return 0;
+	transport = transport_get(NULL, states->remote->url_nr > 0 ?
+				  states->remote->url[0] : NULL);
+	remote_refs = transport_get_remote_refs(transport);
+	transport_disconnect(transport);
+	return remote_refs;
 }
 
 struct show_info {
@@ -970,7 +944,7 @@ int show_push_info_item(struct string_list_item *item, void *cb_data)
 
 static int show(int argc, const char **argv)
 {
-	int no_query = 0, result = 0, query_flag = 0;
+	int no_query = 0, result = 0;
 	struct option options[] = {
 		OPT_GROUP("show specific options"),
 		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
@@ -985,17 +959,31 @@ static int show(int argc, const char **argv)
 	if (argc < 1)
 		return show_all();
 
-	if (!no_query)
-		query_flag = (GET_REF_STATES | GET_HEAD_NAMES | GET_PUSH_REF_STATES);
-
+	read_branches();
 	memset(&states, 0, sizeof(states));
 	memset(&info, 0, sizeof(info));
+	states.queried = !no_query;
 	info.states = &states;
 	info.list = &info_list;
+
 	for (; argc; argc--, argv++) {
 		int i;
 
-		get_remote_ref_states(*argv, &states, query_flag);
+		if (!(states.remote = remote_get(*argv))) {
+			error("No such remote: %s", *argv);
+			continue;
+		}
+		if (no_query) {
+			for_each_ref(append_ref_to_tracked_list, &states);
+			sort_string_list(&states.tracked);
+			get_push_ref_states_noquery(&states);
+		} else {
+			const struct ref *remote_refs;
+			remote_refs = get_remote_refs(&states);
+			get_ref_states(remote_refs, &states);
+			get_head_names(remote_refs, &states);
+			get_push_ref_states(remote_refs, &states);
+		}
 
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
@@ -1077,8 +1065,13 @@ static int set_head(int argc, const char **argv)
 		head_name = xstrdup(argv[1]);
 	} else if (opt_a && !opt_d && argc == 1) {
 		struct ref_states states;
+		const struct ref *remote_refs;
 		memset(&states, 0, sizeof(states));
-		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
+		read_branches();
+		if (!(states.remote = remote_get(argv[0])))
+			return error("No such remote: %s", argv[0]);
+		remote_refs = get_remote_refs(&states);
+		get_head_names(remote_refs, &states);
 		if (!states.heads.nr)
 			result |= error("Cannot determine remote HEAD");
 		else if (states.heads.nr > 1) {
@@ -1134,11 +1127,17 @@ static int prune(int argc, const char **argv)
 			? " %s will become dangling!\n"
 			: " %s has become dangling!\n");
 
+	read_branches();
 	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
 		int i;
-
-		get_remote_ref_states(*argv, &states, GET_REF_STATES);
+		const struct ref *remote_refs;
+		if (!(states.remote = remote_get(*argv))) {
+			error("No such remote: %s", *argv);
+			continue;
+		}
+		remote_refs = get_remote_refs(&states);
+		get_ref_states(remote_refs, &states);
 
 		if (states.stale.nr) {
 			printf("Pruning %s\n", *argv);
-- 
1.6.2.rc1.223.gfed32
