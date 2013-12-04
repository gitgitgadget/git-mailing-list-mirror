From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 01/11] get_stale_heads(): allow limiting to refname patterns
Date: Wed,  4 Dec 2013 06:44:40 +0100
Message-ID: <1386135890-13954-2-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:52:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5OD-0007zb-0M
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab3LDFwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:52:43 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43888 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754240Ab3LDFwk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:52:40 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-da-529ec17461fc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 66.3D.18966.471CE925; Wed,  4 Dec 2013 00:45:24 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCA6016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:23 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqFtycF6Qwf+XrBZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3xfUs/U8EB+Ypljf1sDYx9
	kl2MnBwSAiYSj86+Y4WwxSQu3FvPBmILCVxmlOiYU9DFyAVkn2eSeP1jETNIgk1AV2JRTzMT
	iC0iIC7x9vhM9i5GDg5mgQiJQ29LQMLCAl4Sz383sIDYLAKqEj8vPQcr5xVwkTgzoZcZYpeC
	ROea/4wgNqeAq0RH7xJmkDFCQDX3zjpNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjX
	SC83s0QvNaV0EyMkTHh3MP5fJ3OIUYCDUYmHN4FzXpAQa2JZcWXuIUZJDiYlUd767UAhvqT8
	lMqMxOKM+KLSnNTiQ4wSHMxKIrw2ZUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC
	1CKYrAwHh5IE78YDQI2CRanpqRVpmTklCGkmDk4QwQWygQdowzqQQt7igsTc4sx0iKJTjIpS
	4ryTQRICIImM0jy4AbCIfsUoDvSPMG8LSBUPMBnAdb8CGswENNj81SyQwSWJCCmpBkbP1acC
	cyauvnQ8Ic0y/2rmgf9R7/6nfavcJsWQeST0lfOiVR5TSjedKq58xLKjYOs2savZwdMYdqR2
	iBl6KaQkbd4Wsl4gY5n93Rvv1z6Z97dl1erVc6/er939hfvdtRl8qzRVZ0yz0i0ObimS3pfL
	9N8oW6f9Zan2jp9pmVq+zVL94porShiVWIozEg21mIuKEwGwk54EwwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238758>

Add a "patterns" argument to get_stale_heads().  If it is non-NULL,
then only refnames matching one of the glob patterns in the string
list will be included in the output.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c  |  3 ++-
 builtin/remote.c |  3 ++-
 remote.c         | 26 ++++++++++++++++++++++++--
 remote.h         |  9 +++++++--
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3d978eb..9a04512 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -711,7 +711,8 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 {
 	int result = 0;
-	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
+	struct ref *stale_refs = get_stale_heads(refs, ref_count, ref_map, NULL);
+	struct ref *ref;
 	const char *dangling_msg = dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
diff --git a/builtin/remote.c b/builtin/remote.c
index f532f35..c08dfa8 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -347,7 +347,8 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
 	stale_refs = get_stale_heads(states->remote->fetch,
-				     states->remote->fetch_refspec_nr, fetch_map);
+				     states->remote->fetch_refspec_nr,
+				     fetch_map, NULL);
 	for (ref = stale_refs; ref; ref = ref->next) {
 		struct string_list_item *item =
 			string_list_append(&states->stale, abbrev_branch(ref->name));
diff --git a/remote.c b/remote.c
index dc56619..075ed71 100644
--- a/remote.c
+++ b/remote.c
@@ -1986,13 +1986,31 @@ struct stale_heads_info {
 	struct ref **stale_refs_tail;
 	struct refspec *refs;
 	int ref_count;
+	struct string_list *patterns;
 };
 
 static int get_stale_heads_cb(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+			      const unsigned char *sha1, int flags,
+			      void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
 	struct refspec query;
+	struct string_list *patterns = info->patterns;
+
+	if (patterns) {
+		int refname_matches = 0;
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, patterns) {
+			if (!fnmatch(item->string, refname, 0)) {
+				refname_matches = 1;
+				break;
+			}
+		}
+		if (!refname_matches)
+			return 0;
+	}
+
 	memset(&query, 0, sizeof(struct refspec));
 	query.dst = (char *)refname;
 
@@ -2014,15 +2032,19 @@ static int get_stale_heads_cb(const char *refname,
 	return 0;
 }
 
-struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fetch_map)
+struct ref *get_stale_heads(struct refspec *refs, int ref_count,
+			    struct ref *fetch_map,
+			    struct string_list *patterns)
 {
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
+
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
 	info.refs = refs;
 	info.ref_count = ref_count;
+	info.patterns = patterns;
 	for (ref = fetch_map; ref; ref = ref->next)
 		string_list_append(&ref_names, ref->name);
 	sort_string_list(&ref_names);
diff --git a/remote.h b/remote.h
index c07eb99..afa3792 100644
--- a/remote.h
+++ b/remote.h
@@ -234,8 +234,13 @@ struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
 			      int all);
 
-/* Return refs which no longer exist on remote */
-struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fetch_map);
+/*
+ * Return refs that no longer exist on remote and that match one of
+ * the patterns.
+ */
+struct ref *get_stale_heads(struct refspec *refs, int ref_count,
+			    struct ref *fetch_map,
+			    struct string_list *patterns);
 
 /*
  * Compare-and-swap
-- 
1.8.4.3
