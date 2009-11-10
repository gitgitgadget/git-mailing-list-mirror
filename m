From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/4] remote: refactor some logic into get_stale_heads()
Date: Tue, 10 Nov 2009 00:03:31 -0500
Message-ID: <1257829414-52316-2-git-send-email-jaysoffian@gmail.com>
References: <1257829414-52316-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 06:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7itS-0006Cg-Eo
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 06:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbZKJFDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 00:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbZKJFDl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 00:03:41 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:6023 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZKJFDj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 00:03:39 -0500
Received: by qw-out-2122.google.com with SMTP id 3so727058qwe.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 21:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/YTcmwlqG4btlrqWcH0/TWRzWPizipWBpUGOnyHQQmc=;
        b=NRTMTHgKmHiw/CrSfML2GsMgD8ZyTPgbTabgoBp1Jj+oNvd9oxFjZlaKKLDL4xyZYK
         kMX7x0fmzZsw/lBhRxLIcVrWOm7uZQEKFNOCMRt70FBxSSKPR/GkHokWqAGHO6J8fS67
         IGabXM4nR8C48d3Y63pICSmCu+M+GB2M+rIkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YESZSkwiZ3nqbUULRWmbiGvgsOwrlR3MhSDemNKxejDikEK31VVe+Zes0GPzyzkwsQ
         6EAk8l1s1CjRaJeDNfGF8/BwbFu8NllyR0LB9jPGOP4uWyoyDBt1/zRZUXgP6vHGibTi
         iGMcICkhUnjmNK2mfQtKdEEgdWlMXeePloCr8=
Received: by 10.224.116.212 with SMTP id n20mr4627801qaq.172.1257829425435;
        Mon, 09 Nov 2009 21:03:45 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 20sm263702qyk.1.2009.11.09.21.03.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 21:03:44 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257829414-52316-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132533>

Move the logic in builtin-remote.c which determines which local heads are stale
to remote.c so it can be used by other builtins.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   32 ++++++++------------------------
 remote.c         |   40 ++++++++++++++++++++++++++++++++++++++++
 remote.h         |    3 +++
 3 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index fd7e0b2..0ea4e60 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -227,32 +227,10 @@ struct ref_states {
 	int queried;
 };
 
-static int handle_one_branch(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct ref_states *states = cb_data;
-	struct refspec refspec;
-
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst = (char *)refname;
-	if (!remote_find_tracking(states->remote, &refspec)) {
-		struct string_list_item *item;
-		const char *name = abbrev_branch(refspec.src);
-		/* symbolic refs pointing nowhere were handled already */
-		if ((flags & REF_ISSYMREF) ||
-		    string_list_has_string(&states->tracked, name) ||
-		    string_list_has_string(&states->new, name))
-			return 0;
-		item = string_list_append(name, &states->stale);
-		item->util = xstrdup(refname);
-	}
-	return 0;
-}
-
 static int get_ref_states(const struct ref *remote_refs, struct ref_states *states)
 {
 	struct ref *fetch_map = NULL, **tail = &fetch_map;
-	struct ref *ref;
+	struct ref *ref, *stale_refs;
 	int i;
 
 	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
@@ -268,11 +246,17 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 		else
 			string_list_append(abbrev_branch(ref->name), &states->tracked);
 	}
+	stale_refs = get_stale_heads(states->remote, fetch_map);
+	for (ref = stale_refs; ref; ref = ref->next) {
+		struct string_list_item *item =
+			string_list_append(abbrev_branch(ref->name), &states->stale);
+		item->util = xstrdup(ref->name);
+	}
+	free_refs(stale_refs);
 	free_refs(fetch_map);
 
 	sort_string_list(&states->new);
 	sort_string_list(&states->tracked);
-	for_each_ref(handle_one_branch, states);
 	sort_string_list(&states->stale);
 
 	return 0;
diff --git a/remote.c b/remote.c
index beaf9fb..eae5866 100644
--- a/remote.c
+++ b/remote.c
@@ -6,6 +6,7 @@
 #include "revision.h"
 #include "dir.h"
 #include "tag.h"
+#include "string-list.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -1587,3 +1588,42 @@ struct ref *guess_remote_head(const struct ref *head,
 
 	return list;
 }
+
+struct stale_heads_info {
+	struct remote *remote;
+	struct string_list *ref_names;
+	struct ref **stale_refs_tail;
+};
+
+static int get_stale_heads_cb(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct stale_heads_info *info = cb_data;
+	struct refspec refspec;
+	memset(&refspec, 0, sizeof(refspec));
+	refspec.dst = (char *)refname;
+	if (!remote_find_tracking(info->remote, &refspec)) {
+		if (!((flags & REF_ISSYMREF) ||
+		    string_list_has_string(info->ref_names, refspec.src))) {
+			struct ref *ref = make_linked_ref(refname, &info->stale_refs_tail);
+			hashcpy(ref->new_sha1, sha1);
+		}
+	}
+	return 0;
+}
+
+struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_map)
+{
+	struct ref *ref, *stale_refs = NULL;
+	struct string_list ref_names = { NULL, 0, 0, 0 };
+	struct stale_heads_info info;
+	info.remote = remote;
+	info.ref_names = &ref_names;
+	info.stale_refs_tail = &stale_refs;
+	for (ref = fetch_map; ref; ref = ref->next)
+		string_list_append(ref->name, &ref_names);
+	sort_string_list(&ref_names);
+	for_each_ref(get_stale_heads_cb, &info);
+	string_list_clear(&ref_names, 0);
+	return stale_refs;
+}
diff --git a/remote.h b/remote.h
index 5db8420..d0aba81 100644
--- a/remote.h
+++ b/remote.h
@@ -154,4 +154,7 @@ struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
 			      int all);
 
+/* Return refs which no longer exist on remote */
+struct ref *get_stale_heads(struct remote *remote, struct ref *fetch_map);
+
 #endif
-- 
1.6.4.2
