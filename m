From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 27/33] pack_refs(): change to use do_for_each_entry()
Date: Mon, 22 Apr 2013 21:52:35 +0200
Message-ID: <1366660361-21831-28-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMw1-0007GU-7C
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab3DVUBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:45 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:63878 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755174Ab3DVUBo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:44 -0400
X-AuditID: 1207440d-b7fd06d000000905-aa-5175955d3eac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BE.0E.02309.D5595715; Mon, 22 Apr 2013 15:54:06 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOe008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:04 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqBs3tTTQ4FaRRdeVbiaLht4rzBa3
	V8xndmD2+Pv+A5PHxUvKHp83yQUwR3HbJCWWlAVnpufp2yVwZxz4soyx4LNoxYQJ85gaGD8K
	djFyckgImEj86jjJCGGLSVy4t56ti5GLQ0jgMqPE2RlNUM4FJomGf6tZQKrYBHQlFvU0M4HY
	IgJqEhPbDoHFmQUcJDZ/bgSbJCzgIfF0wyP2LkYODhYBVYk5zb4gYV4BV4lnbf0sEMsUJI5v
	3wZWzgkUP91xAiwuJOAiseLgVJYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVm
	luilppRuYoQECu8Oxv/rZA4xCnAwKvHwCriXBgqxJpYVV+YeYpTkYFIS5eWYAhTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwiuaD5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwZoAMFSxKTU+tSMvMKUFIM3FwgggukA08QBsiQQp5iwsSc4sz0yGKTjEqSonzuk0C
	SgiAJDJK8+AGwGL6FaM40D/CvB4g7TzAdADX/QpoMBPQ4MyEEpDBJYkIKakGRisxMdUzj/K+
	Hrk1h8HxiVRV5ryMl+su7d3G+M6NT+Ke1fPw/8cDef8kKKTcWX/9Vcja03+fab8pmns72VXa
	U+310f/lPUXskxinT3l2InTxsr9vtRS3eCvx6Og+/CCw9PXdqPbl/RP8bNfvaj3TKL9BMWVl
	Untjyry/q14WvFfazHLXk5vj/wslluKMREMt5qLiRAARybcSxAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222078>

pack_refs() was not using any of the extra features of for_each_ref(),
so change it to use do_for_each_entry().  This also gives it access to
the ref_entry and in particular its peeled field, which will be taken
advantage of in the next commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 850df8e..88875d1 100644
--- a/refs.c
+++ b/refs.c
@@ -2003,37 +2003,38 @@ static int do_not_prune(int flags)
 	return (flags & (REF_ISSYMREF|REF_ISPACKED));
 }
 
-static int pack_one_ref(const char *refname, const unsigned char *sha1,
-			  int flags, void *cb_data)
+static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
 	struct object *o;
 	int is_tag_ref;
 
-	/* Do not pack the symbolic refs */
-	if ((flags & REF_ISSYMREF))
+	/* Do not pack symbolic or broken refs: */
+	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry))
 		return 0;
-	is_tag_ref = !prefixcmp(refname, "refs/tags/");
+	is_tag_ref = !prefixcmp(entry->name, "refs/tags/");
 
 	/* ALWAYS pack refs that were already packed or are tags */
-	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
+	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref &&
+	    !(entry->flag & REF_ISPACKED))
 		return 0;
 
-	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), refname);
+	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(entry->u.value.sha1),
+		entry->name);
 
-	o = parse_object_or_die(sha1, refname);
+	o = parse_object_or_die(entry->u.value.sha1, entry->name);
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, refname, 0);
+		o = deref_tag(o, entry->name, 0);
 		if (o)
 			fprintf(cb->refs_file, "^%s\n",
 				sha1_to_hex(o->sha1));
 	}
 
-	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
-		int namelen = strlen(refname) + 1;
+	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(entry->flag)) {
+		int namelen = strlen(entry->name) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
-		hashcpy(n->sha1, sha1);
-		strcpy(n->name, refname);
+		hashcpy(n->sha1, entry->u.value.sha1);
+		strcpy(n->name, entry->name);
 		n->next = cb->ref_to_prune;
 		cb->ref_to_prune = n;
 	}
@@ -2110,7 +2111,7 @@ int pack_refs(unsigned int flags)
 	/* perhaps other traits later as well */
 	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
 
-	for_each_ref(pack_one_ref, &cbdata);
+	do_for_each_entry(NULL, "", pack_one_ref, &cbdata);
 	if (ferror(cbdata.refs_file))
 		die("failed to write ref-pack file");
 	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
-- 
1.8.2.1
