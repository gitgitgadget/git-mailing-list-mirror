From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 12/13] remote.c: refactor get_remote_ref_states()
Date: Mon, 23 Feb 2009 01:29:00 -0500
Message-ID: <885507eaf920f6b60727db7e712da3560a7fd4c5.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULQ-00072Y-FR
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbZBWG3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbZBWG3j
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:39 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:12887 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZBWG3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:32 -0500
Received: by yx-out-2324.google.com with SMTP id 8so746768yxm.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=52kfDagXX2B7mgaJnel8zXSfULkIUgx1HtOJige10Kk=;
        b=R8v/uodV99G2azIsIjo5/tLoR5M7+Fqk6wigcCCIqTUiHLsvXfb6QAEMkp0NjDIAQO
         5nJkBqrgyL70aF5mB/0bvWWI0lbdz3vqc+GHTOFVZ8oYrrBMV6fAhqQLTz92DRzfkvGk
         zGeURrgc7Jj004BjU80SZYHyJUykObyOWT040=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Vr5ir/cGiNIecjqAnRtlDDCMwKrfxTzGaw0bkITAttyVk4Jb88ryXEepUr/d0yFGax
         2C3SH7jYJTK9bkj7s3cY0wGo1IJERRBUItLmgvpzycx9mByrFWorYe45in1/I6LXUbi5
         zPj8N47whJ6tBg6/hNUe8qsRJAmiWEejsvJy8=
Received: by 10.100.111.5 with SMTP id j5mr3569978anc.54.1235370572262;
        Sun, 22 Feb 2009 22:29:32 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d38sm6979606and.9.2009.02.22.22.29.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:31 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111097>

get_remote_ref_states() has three callers, but each is interested in
slightly different information. Give it a bit-field flag so that callers
can specify which pieces of information they need.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 4975a0e..327667a 100644
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
@@ -685,14 +688,15 @@ static int get_remote_ref_states(const char *name,
 			states->remote->url[0] : NULL);
 		remote_refs = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
-		get_head_names(remote_refs, name, states);
-		get_ref_states(remote_refs, states);
+		states->queried = 1;
+		if (query & GET_REF_STATES)
+			get_ref_states(remote_refs, states);
+		if (query & GET_HEAD_NAMES)
+			get_head_names(remote_refs, name, states);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
 		sort_string_list(&states->tracked);
 	}
-	states->queried = query;
-
 	return 0;
 }
 
@@ -796,7 +800,7 @@ int show_local_info_item(struct string_list_item *item, void *cb_data)
 
 static int show(int argc, const char **argv)
 {
-	int no_query = 0, result = 0;
+	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
 		OPT_GROUP("show specific options"),
 		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
@@ -811,6 +815,9 @@ static int show(int argc, const char **argv)
 	if (argc < 1)
 		return show_all();
 
+	if (!no_query)
+		query_flag = (GET_REF_STATES | GET_HEAD_NAMES);
+
 	memset(&states, 0, sizeof(states));
 	memset(&info, 0, sizeof(info));
 	info.states = &states;
@@ -818,7 +825,7 @@ static int show(int argc, const char **argv)
 	for (; argc; argc--, argv++) {
 		int i;
 
-		get_remote_ref_states(*argv, &states, !no_query);
+		get_remote_ref_states(*argv, &states, query_flag);
 
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
@@ -902,7 +909,7 @@ static int set_head(int argc, const char **argv)
 	} else if (opt_a && !opt_d && argc == 1) {
 		struct ref_states states;
 		memset(&states, 0, sizeof(states));
-		get_remote_ref_states(argv[0], &states, 1);
+		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
 		if (!states.heads.nr)
 			result |= error("Cannot determine remote HEAD");
 		else if (states.heads.nr > 1) {
@@ -962,7 +969,7 @@ static int prune(int argc, const char **argv)
 	for (; argc; argc--, argv++) {
 		int i;
 
-		get_remote_ref_states(*argv, &states, 1);
+		get_remote_ref_states(*argv, &states, GET_REF_STATES);
 
 		if (states.stale.nr) {
 			printf("Pruning %s\n", *argv);
-- 
1.6.2.rc1.223.gfed32
