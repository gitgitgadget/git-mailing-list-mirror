From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-reset.c: Extend hard reset error message when
	using paths.
Date: Tue, 14 Apr 2009 01:35:29 -0400
Message-ID: <20090414053529.GB19027@coredump.intra.peff.net>
References: <1239646444-11653-1-git-send-email-tim@retout.co.uk> <7vr5zwe3ie.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tim Retout <tim@retout.co.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 07:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtbKT-0004c5-IP
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 07:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbZDNFfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 01:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbZDNFfc
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 01:35:32 -0400
Received: from peff.net ([208.65.91.99]:49784 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbZDNFfb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 01:35:31 -0400
Received: (qmail 7103 invoked by uid 107); 14 Apr 2009 05:35:34 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 14 Apr 2009 01:35:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Apr 2009 01:35:29 -0400
Content-Disposition: inline
In-Reply-To: <7vr5zwe3ie.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116513>

On Mon, Apr 13, 2009 at 12:51:21PM -0700, Junio C Hamano wrote:

> That is one possibility.  Another is:
> 
>     git reset --hard mester
> 
> (and you have ./mester file in the work tree) and in that case the user
> definitely didn't want to do any checkout.
> 
> I wonder if you can tell these cases apart, and also if this (not just
> telling these apart, but what your patch adds) is worth additional

You could always guess based on the existing refs:

---
diff --git a/builtin-reset.c b/builtin-reset.c
index c0cb915..803957d 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -243,8 +243,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (get_sha1(rev, sha1))
-		die("Failed to resolve '%s' as a valid ref.", rev);
+	if (get_sha1(rev, sha1)) {
+		error("Failed to resolve '%s' as a valid ref.", rev);
+		probable_refs_print(rev);
+		return 1;
+	}
 
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
@@ -257,6 +260,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (i < argc) {
 		if (reset_type == MIXED)
 			warning("--mixed option is deprecated with paths.");
+		else if (reset_type == HARD) {
+			error("Cannot do hard reset with paths.");
+			probable_refs_print(argv[i]);
+			return 1;
+		}
 		else if (reset_type != NONE)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
diff --git a/refs.c b/refs.c
index 82afb87..bad7e2f 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,8 @@
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
+#include "levenshtein.h"
+#include "string-list.h"
 
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
@@ -750,9 +752,8 @@ int check_ref_format(const char *ref)
 	}
 }
 
-const char *prettify_ref(const struct ref *ref)
+static const char *prettify_refname(const char *name)
 {
-	const char *name = ref->name;
 	return name + (
 		!prefixcmp(name, "refs/heads/") ? 11 :
 		!prefixcmp(name, "refs/tags/") ? 10 :
@@ -760,6 +761,11 @@ const char *prettify_ref(const struct ref *ref)
 		0);
 }
 
+const char *prettify_ref(const struct ref *ref)
+{
+	return prettify_refname(ref->name);
+}
+
 const char *ref_rev_parse_rules[] = {
 	"%.*s",
 	"refs/%.*s",
@@ -1756,3 +1762,74 @@ char *shorten_unambiguous_ref(const char *ref)
 	free(short_name);
 	return xstrdup(ref);
 }
+
+struct probable_refs_data {
+	const char *s;
+	struct string_list *out;
+};
+
+static void probable_refs_append(struct probable_refs_data *d, const char *s)
+{
+	struct string_list_item *i = string_list_append(s, d->out);
+	i->util = (void *)levenshtein(d->s, s, 0, 2, 1, 4);
+}
+
+static int probable_refs_cb(const char *refname, const unsigned char *sha1,
+		int flag, void *data)
+{
+	const char *p = prettify_refname(refname);
+	probable_refs_append(data, refname);
+	if (p != refname)
+		probable_refs_append(data, p);
+	return 1;
+}
+
+static int util_compare(const void *va, const void *vb)
+{
+	const struct string_list_item *a = va, *b = vb;
+	return a->util - b->util;
+}
+
+void probable_refs(const char *s, struct string_list *out)
+{
+	struct probable_refs_data d;
+	int i, j;
+
+	memset(out, 0, sizeof(*out));
+	out->strdup_strings = 1;
+	d.s = s;
+	d.out = out;
+	for_each_ref(probable_refs_cb, &d);
+
+	if (!out->nr)
+		return;
+
+	qsort(out->items, out->nr, sizeof(*out->items), util_compare);
+	/* Arbitrary cutoff at distance '5'. The first is the best match, but
+	 * there may be others which are equally good */
+	for (i = 0; i < out->nr; i++)
+		if ((int)out->items[i].util > 5 ||
+		    out->items[i].util > out->items[0].util)
+			break;
+	/* truncate the list to i items */
+	for (j = i; j < out->nr; j++)
+		free(out->items[j].string);
+	out->nr = i;
+}
+
+void probable_refs_print(const char *name)
+{
+	struct string_list s;
+	int i;
+
+	probable_refs(name, &s);
+	if (!s.nr)
+		return;
+
+	fprintf(stderr, "\nDid you mean %s?\n",
+		s.nr < 2 ? "this" : "one of these");
+	for (i = 0; i < s.nr; i++)
+		fprintf(stderr, "\t%s\n", s.items[i].string);
+
+	string_list_clear(&s, 0);
+}
diff --git a/refs.h b/refs.h
index 50abbbb..586bfab 100644
--- a/refs.h
+++ b/refs.h
@@ -95,4 +95,6 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
+void probable_refs_print(const char *name);
+
 #endif /* REFS_H */



And yes, I am joking.

-Peff
