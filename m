From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 14/21] builtin-remote: rename variables and eliminate redundant function call
Date: Wed, 25 Feb 2009 03:32:21 -0500
Message-ID: <a21a51f2e43118267f515e8947915cf8c5c512e4.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFFA-0000Xo-1O
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760031AbZBYIdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759862AbZBYIdS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:18 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:53734 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759854AbZBYIdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:33:04 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1285105yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Xc9XbLSJ6+9w6kTd3nSEhIyUcIShelr6VQewFQJbI/U=;
        b=SoQGXLOmmOI7YclX+jmcy1nc2nn+sEci5fupS1f8A/3EkmRpHcFfqwDB/Wr81LtMFu
         7nFBv54vD7HjSeEhsB30h+79GVAne3dcEZj7t7jfm338oR2h3CLPyWa5FqycMmQTHwcn
         J4LPNV+0WYRcDx5+DUojH+2kUtnqPHUieEDiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pyywwMWft2Dm0EZhxjid/Zlw5B35oeZvzgQ3PajLw5J13qpLS/WxRhNr3VU3Vq3GIN
         ZRmONlSc0GUQ1x+MxCRQSgfjA2vmR5JXTc/bTLfJnny4HmpmdoOCipWOQdYYJQPH4cPe
         Ax4mWklknp/xfgTmwYaDC91ZdEdpjLsWsIIRM=
Received: by 10.100.190.14 with SMTP id n14mr848038anf.19.1235550782718;
        Wed, 25 Feb 2009 00:33:02 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b37sm7713323ana.17.2009.02.25.00.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:33:02 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111409>

- The variable name "remote" is used as both a "char *" and as a "struct
  remote *"; this is confusing, so rename the former to remote_name.

- Consistently refer to the refs returned by transport_get_remote_refs()
  as remote_refs.

- There is no need to call "sort_string_list(&branch_list)" as
  branch_list is populated via string_list_insert(), which maintains its
  order.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
In the original series this is two commits, but after re-ordering it
made sense to squash the two together as they were both very minimal.

 builtin-remote.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 3e6dee4..fc02e5f 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -143,7 +143,7 @@ static int add(int argc, const char **argv)
 }
 
 struct branch_info {
-	char *remote;
+	char *remote_name;
 	struct string_list merge;
 };
 
@@ -182,9 +182,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			item->util = xcalloc(sizeof(struct branch_info), 1);
 		info = item->util;
 		if (type == REMOTE) {
-			if (info->remote)
+			if (info->remote_name)
 				warning("more than one branch.%s", key);
-			info->remote = xstrdup(value);
+			info->remote_name = xstrdup(value);
 		} else {
 			char *space = strchr(value, ' ');
 			value = abbrev_branch(value);
@@ -206,7 +206,6 @@ static void read_branches(void)
 	if (branch_list.nr)
 		return;
 	git_config(config_read_branches, NULL);
-	sort_string_list(&branch_list);
 }
 
 struct ref_states {
@@ -238,13 +237,14 @@ static int handle_one_branch(const char *refname,
 	return 0;
 }
 
-static int get_ref_states(const struct ref *ref, struct ref_states *states)
+static int get_ref_states(const struct ref *remote_refs, struct ref_states *states)
 {
 	struct ref *fetch_map = NULL, **tail = &fetch_map;
+	struct ref *ref;
 	int i;
 
 	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
-		if (get_fetch_map(ref, states->remote->fetch + i, &tail, 1))
+		if (get_fetch_map(remote_refs, states->remote->fetch + i, &tail, 1))
 			die("Could not get fetch map for refspec %s",
 				states->remote->fetch_refspec[i]);
 
@@ -459,7 +459,7 @@ static int mv(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote && !strcmp(info->remote, rename.old)) {
+		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
 			if (git_config_set(buf.buf, rename.new)) {
@@ -569,7 +569,7 @@ static int rm(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote && !strcmp(info->remote, remote->name)) {
+		if (info->remote_name && !strcmp(info->remote_name, remote->name)) {
 			const char *keys[] = { "remote", "merge", NULL }, **k;
 			for (k = keys; *k; k++) {
 				strbuf_reset(&buf);
@@ -637,7 +637,7 @@ static int get_remote_ref_states(const char *name,
 				 int query)
 {
 	struct transport *transport;
-	const struct ref *ref;
+	const struct ref *remote_refs;
 
 	states->remote = remote_get(name);
 	if (!states->remote)
@@ -648,10 +648,10 @@ static int get_remote_ref_states(const char *name,
 	if (query) {
 		transport = transport_get(NULL, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
-		ref = transport_get_remote_refs(transport);
+		remote_refs = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
 
-		get_ref_states(ref, states);
+		get_ref_states(remote_refs, states);
 	}
 
 	return 0;
@@ -701,7 +701,7 @@ static int show(int argc, const char **argv)
 			struct branch_info *info = branch->util;
 			int j;
 
-			if (!info->merge.nr || strcmp(*argv, info->remote))
+			if (!info->merge.nr || strcmp(*argv, info->remote_name))
 				continue;
 			printf("  Remote branch%s merged with 'git pull' "
 				"while on branch %s\n   ",
-- 
1.6.2.rc1.291.g83eb
