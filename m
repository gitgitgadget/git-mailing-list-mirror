From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC][PATCH] for_each_ref() returning heads in wrong order
Date: Sat, 23 Sep 2006 10:12:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609231004210.4388@g5.osdl.org>
References: <20060923160712.5890.73139.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 19:13:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRB3i-000720-BD
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 19:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWIWRMu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 13:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWIWRMu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 13:12:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751330AbWIWRMu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 13:12:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8NHCenW021982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Sep 2006 10:12:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8NHCeTS020017;
	Sat, 23 Sep 2006 10:12:40 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923160712.5890.73139.stgit@machine.or.cz>
X-Spam-Status: No, hits=-2.476 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.152 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27603>



On Sat, 23 Sep 2006, Petr Baudis wrote:
>
> Using the #next branch I've now hit a problem with git-fetch-pack
> master choosing refs/bases/master (I geuss created by StGIT) instead
> of refs/heads/master. The old upload-pack returned the refs in the order
> heads-tags-everything_else but the new one just goes for whatever order
> readdir() returns them in (modulo merging with packed refs). I actually
> can't see the difference that caused this right now, though.

Actually, I think it's exactly the other way around.

The _old_ "for_each_refs()" returned things in a totally random order, 
depending on the readdir(). On many (but not all) filesystems, that ends 
up being somewhat decided by the order the entries were created in, so for 
example, you'd generally get "refs/heads/" and "refs/tags/" early 
(discounting HEAD, which is always a special case and comes first).

The _new_ thing is totally reliable. It returns things sorted 
alphabetically according to "strcmp". It doesn't matter what ordering 
readdir() gives.

Now, we could change the sorting order artificially, but I think your 
patch is actually incorrect. Because you no longer sort the list 
appropriately, the merge-sort done by "do_show_each_ref()" is no longer 
guaranteed to work, I think.

Ugly.

The proper way to fix it (if you want to do this at all) is to just define 
the sort-order to be something else than a plain "strcmp()", and change 
the things that compare ordering to just use the new ordering instead.

In other words, start from something like THIS, and just change 
"ref_name_compare()" to taste. Make sure it's a complete ordering, though.

		Linus

---
diff --git a/refs.c b/refs.c
index 2cef2b4..05b7006 100644
--- a/refs.c
+++ b/refs.c
@@ -37,6 +37,17 @@ static const char *parse_ref_line(char *
 	return line;
 }
 
+/*
+ * This is the ordering function for refnames. It has the
+ * same semantics as "strcmp()", but you can define it to
+ * order "refs/heads/" and "refs/tags/" before other names,
+ * for example.
+ */
+static int ref_name_compare(const char *a, const char *b)
+{
+	return strcmp(a,b);
+}
+
 static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
 				int flag, struct ref_list *list)
 {
@@ -45,7 +56,7 @@ static struct ref_list *add_ref(const ch
 
 	/* Find the place to insert the ref into.. */
 	while ((entry = *p) != NULL) {
-		int cmp = strcmp(entry->name, name);
+		int cmp = ref_name_compare(entry->name, name);
 		if (cmp > 0)
 			break;
 
@@ -179,7 +190,7 @@ const char *resolve_ref(const char *ref,
 		if (lstat(path, &st) < 0) {
 			struct ref_list *list = get_packed_refs();
 			while (list) {
-				if (!strcmp(ref, list->name)) {
+				if (!ref_name_compare(ref, list->name)) {
 					hashcpy(sha1, list->sha1);
 					if (flag)
 						*flag |= REF_ISPACKED;
@@ -297,7 +308,7 @@ static int do_for_each_ref(const char *b
 
 	while (packed && loose) {
 		struct ref_list *entry;
-		int cmp = strcmp(packed->name, loose->name);
+		int cmp = ref_name_compare(packed->name, loose->name);
 		if (!cmp) {
 			packed = packed->next;
 			continue;
