From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/4] remote: refactor some logic into get_stale_heads()
Date: Mon,  9 Nov 2009 23:58:30 -0500
Message-ID: <1257829113-52168-2-git-send-email-jaysoffian@gmail.com>
References: <1257829113-52168-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 05:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7ip2-0004pk-KG
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 05:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbZKJE6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 23:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755618AbZKJE6s
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 23:58:48 -0500
Received: from mail-qy0-f194.google.com ([209.85.221.194]:57263 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbZKJE6q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 23:58:46 -0500
Received: by qyk32 with SMTP id 32so1481613qyk.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 20:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IuIjNPDcsGPBjJ5iRSYsd0J8bCHFgNV7CSY8HCiLzNw=;
        b=MulGvUkPcr3gf7fQRa0WdA3kG5Unl7sJMidalG5c6yaujElJNcEsPl3aAV+j/tjoFi
         Da2iYKIF8/SvLVf3s5K/GA2DxGlJJ3pdB6QX3x3roN8T4n2yyy3WNI/Eewz56Sig5G4F
         SKal/Up3Nb31Fl63eqoCjESXzVcPaeftBu/5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p1JQ7OccugaTl0hgjY3zdE2SUBshri3IS+hC0elC7svS1GHrMboylkWw4r4ghTfL+A
         OK8HjRt9fFMgzT1FiILS2ghjsRwlUZUBVohWJh6CTqmTziZBe2aeoXSO0uxJlZqRvZ0i
         BAA9mBiXx0sVjtyK/Tk/LS4iNE6+2RVugtpuw=
Received: by 10.224.96.88 with SMTP id g24mr4572308qan.361.1257829131669;
        Mon, 09 Nov 2009 20:58:51 -0800 (PST)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 21sm260449qyk.0.2009.11.09.20.58.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 20:58:51 -0800 (PST)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1257829113-52168-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132528>

Move the logic in builtin-remote.c which determines which local heads are stale
to remote.c so it can be used by other builtins.
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
