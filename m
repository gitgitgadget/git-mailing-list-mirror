Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0C31F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405582AbfBNF4E (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:56:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:43788 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731876AbfBNF4E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:56:04 -0500
Received: (qmail 904 invoked by uid 109); 14 Feb 2019 05:51:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:51:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6967 invoked by uid 111); 14 Feb 2019 05:51:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:51:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:51:03 -0500
Date:   Thu, 14 Feb 2019 00:51:03 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/10] ref-filter: drop unused "sz" parameters
Message-ID: <20190214055103.GJ20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many of our grab_* functions, which parse the object content, take a
buf/sz pair of the object bytes. However, the functions which actually
parse the buffers (like find_wholine() and find_subpos()) never look at
"sz", and instead use functions like strchr() and strchrnul() that
assume the result is NUL-terminated.

This is OK in practice (and common for Git's parsing code), since we
always allocate an extra NUL when loading an object into memory (and
likewise, we are OK with stopping parsing if a commit or tag contains an
embedded NUL).

Let's drop these extra "sz" parameters, as they are misleading about how
the functions intend to access the buffer. We can drop from both the
functions mentioned above, which in turn lets us drop from their
callers, cascading all the way up to the top-level grab_values().

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9ba18b220c..09b5fb439f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -968,7 +968,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 	}
 }
 
-static const char *find_wholine(const char *who, int wholen, const char *buf, unsigned long sz)
+static const char *find_wholine(const char *who, int wholen, const char *buf)
 {
 	const char *eol;
 	while (*buf) {
@@ -1064,7 +1064,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 }
 
 /* See grab_values */
-static void grab_person(const char *who, struct atom_value *val, int deref, void *buf, unsigned long sz)
+static void grab_person(const char *who, struct atom_value *val, int deref, void *buf)
 {
 	int i;
 	int wholen = strlen(who);
@@ -1085,7 +1085,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 		    !starts_with(name + wholen, "date"))
 			continue;
 		if (!wholine)
-			wholine = find_wholine(who, wholen, buf, sz);
+			wholine = find_wholine(who, wholen, buf);
 		if (!wholine)
 			return; /* no point looking for it */
 		if (name[wholen] == 0)
@@ -1105,7 +1105,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 	if (strcmp(who, "tagger") && strcmp(who, "committer"))
 		return; /* "author" for commit object is not wanted */
 	if (!wholine)
-		wholine = find_wholine(who, wholen, buf, sz);
+		wholine = find_wholine(who, wholen, buf);
 	if (!wholine)
 		return;
 	for (i = 0; i < used_atom_cnt; i++) {
@@ -1123,7 +1123,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 	}
 }
 
-static void find_subpos(const char *buf, unsigned long sz,
+static void find_subpos(const char *buf,
 			const char **sub, unsigned long *sublen,
 			const char **body, unsigned long *bodylen,
 			unsigned long *nonsiglen,
@@ -1192,7 +1192,7 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf, unsigned long sz)
+static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
@@ -1212,7 +1212,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf,
 		    !starts_with(name, "contents"))
 			continue;
 		if (!subpos)
-			find_subpos(buf, sz,
+			find_subpos(buf,
 				    &subpos, &sublen,
 				    &bodypos, &bodylen, &nonsiglen,
 				    &sigpos, &siglen);
@@ -1265,19 +1265,19 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
 {
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf, sz);
-		grab_person("tagger", val, deref, buf, sz);
+		grab_sub_body_contents(val, deref, buf);
+		grab_person("tagger", val, deref, buf);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, buf, sz);
-		grab_person("author", val, deref, buf, sz);
-		grab_person("committer", val, deref, buf, sz);
+		grab_sub_body_contents(val, deref, buf);
+		grab_person("author", val, deref, buf);
+		grab_person("committer", val, deref, buf);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
@@ -1516,7 +1516,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
 					       oid_to_hex(&oi->oid), ref->refname);
 		}
-		grab_values(ref->value, deref, *obj, oi->content, oi->size);
+		grab_values(ref->value, deref, *obj, oi->content);
 	}
 
 	grab_common_values(ref->value, deref, oi);
-- 
2.21.0.rc1.567.g648f076c3f
