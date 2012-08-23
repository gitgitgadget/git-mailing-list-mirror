From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Thu, 23 Aug 2012 16:31:53 -0400
Message-ID: <20120823203152.GA1810@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <20120823092624.GG6963@sigill.intra.peff.net>
 <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley>
 <20120823195648.GB15268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mhagger@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:32:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4e4R-0006Ig-4m
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 22:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098Ab2HWUb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 16:31:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46524 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073Ab2HWUb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 16:31:56 -0400
Received: (qmail 24529 invoked by uid 107); 23 Aug 2012 20:32:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 16:32:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 16:31:53 -0400
Content-Disposition: inline
In-Reply-To: <20120823195648.GB15268@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204168>

On Thu, Aug 23, 2012 at 03:56:48PM -0400, Jeff King wrote:

> This code blames back to:
> 
>  commit 4bcb310c2539b66d535e87508d1b7a90fe29c083
>  Author: Alexandre Julliard <julliard@winehq.org>
>  Date:   Fri Nov 24 16:00:13 2006 +0100
> 
>     fetch-pack: Do not fetch tags for shallow clones.
> 
>     A better fix may be to only fetch tags that point to commits that we
>     are downloading, but git-clone doesn't have support for following
>     tags. This will happen automatically on the next git-fetch though.
> 
> So it is about making sure that "git clone --depth=1" does not
> accidentally pull a single commit from v1.0, v1.1, v1.2, and so forth,
> losing the purpose of using --depth in the first place. These days it is
> largely irrelevant, since this code path is not followed by clone, and
> clone will automatically restrict its list of fetched refs to a single
> branch if --depth is used.

I think part of the confusion of this code is that inside the loop over
the refs it is sometimes checking aspects of the ref, and sometimes
checking invariants of the loop (like args.fetch_all). Splitting it into
separate loops makes it easier to see what is going on, like the patch
below (on top of Michael's series).

I'm not sure if it ends up being more readable, since the generic "cut
down this linked list" function has to operate through callbacks with a
void pointer. On the other hand, that function could also be used
elsewhere.

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 90683ca..877cf38 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -521,51 +521,80 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 	}
 }
 
-static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
+static void filter_refs_callback(struct ref **refs,
+				 int (*want)(struct ref *, void *),
+				 void *data)
 {
-	struct ref *newlist = NULL;
-	struct ref **newtail = &newlist;
+	struct ref **tail = refs;
 	struct ref *ref, *next;
-	int match_pos = 0, unmatched = 0;
 
 	for (ref = *refs; ref; ref = next) {
-		int keep_ref = 0;
 		next = ref->next;
-		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_refname_format(ref->name, 0))
-			; /* trash */
-		else if (args.fetch_all &&
-			   (!args.depth || prefixcmp(ref->name, "refs/tags/")))
-			keep_ref = 1;
-		else
-			while (match_pos < *nr_heads) {
-				int cmp = strcmp(ref->name, heads[match_pos]);
-				if (cmp < 0) { /* definitely do not have it */
-					break;
-				} else if (cmp == 0) { /* definitely have it */
-					free(heads[match_pos++]);
-					keep_ref = 1;
-					break;
-				} else { /* might have it; keep looking */
-					heads[unmatched++] = heads[match_pos++];
-				}
-			}
-
-		if (keep_ref) {
-			*newtail = ref;
-			ref->next = NULL;
-			newtail = &ref->next;
-		} else {
+		if (want(ref, data))
+			tail = &ref->next;
+		else {
 			free(ref);
+			*tail = next;
 		}
 	}
+}
 
-	/* copy any remaining unmatched heads: */
-	while (match_pos < *nr_heads)
-		heads[unmatched++] = heads[match_pos++];
-	*nr_heads = unmatched;
+static int ref_name_is_ok(struct ref *ref, void *data)
+{
+	return memcmp(ref->name, "refs/", 5) ||
+		!check_refname_format(ref->name, 0);
+}
+
+static int ref_ok_for_shallow(struct ref *ref, void *data)
+{
+	return prefixcmp(ref->name, "refs/tags/");
+}
 
-	*refs = newlist;
+struct filter_by_name_data {
+	char **heads;
+	int nr_heads;
+	int match_pos;
+	int unmatched;
+};
+
+static int want_ref_name(struct ref *ref, void *data)
+{
+	struct filter_by_name_data *f = data;
+
+	while (f->match_pos < f->nr_heads) {
+		int cmp = strcmp(ref->name, f->heads[f->match_pos]);
+		if (cmp < 0) /* definitely do not have it */
+			return 0;
+		else if (cmp == 0) { /* definitely have it */
+			free(f->heads[f->match_pos++]);
+			return 1;
+		} else /* might have it; keep looking */
+			f->heads[f->unmatched++] = f->heads[f->match_pos++];
+	}
+	return 0;
+}
+
+static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
+{
+	struct filter_by_name_data f;
+
+	filter_refs_callback(refs, ref_name_is_ok, NULL);
+
+	if (args.fetch_all) {
+		if (args.depth)
+			filter_refs_callback(refs, ref_ok_for_shallow, NULL);
+		return;
+	}
+
+	memset(&f, 0, sizeof(f));
+	f.heads = heads;
+	f.nr_heads = *nr_heads;
+	filter_refs_callback(refs, want_ref_name, &f);
+
+	/* copy any remaining unmatched heads: */
+	while (f.match_pos < f.nr_heads)
+		heads[f.unmatched++] = heads[f.match_pos++];
+	*nr_heads = f.unmatched;
 }
 
 static void mark_alternate_complete(const struct ref *ref, void *unused)
