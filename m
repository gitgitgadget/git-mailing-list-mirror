From: Jeff King <peff@peff.net>
Subject: Re: Tag peeling peculiarities
Date: Thu, 14 Mar 2013 01:32:37 -0400
Message-ID: <20130314053237.GA3552@sigill.intra.peff.net>
References: <51409439.5090001@alum.mit.edu>
 <7vwqtb2ood.fsf@alter.siamese.dyndns.org>
 <20130313215800.GA23838@sigill.intra.peff.net>
 <51415516.2070702@alum.mit.edu>
 <20130314052448.GA2300@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 14 06:33:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG0mo-0004bQ-UQ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 06:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab3CNFck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 01:32:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51381 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab3CNFck (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 01:32:40 -0400
Received: (qmail 11632 invoked by uid 107); 14 Mar 2013 05:34:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Mar 2013 01:34:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2013 01:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20130314052448.GA2300@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218114>

On Thu, Mar 14, 2013 at 01:24:48AM -0400, Jeff King wrote:

> So the only question is how much work we want to put into making sure
> the new reader handles the old writer correctly. Doing 2c is obviously
> more rigorous, and it is not that much work to add the fully-packed
> flag, but I kind of wonder if anybody even cares. We can just say "it's
> a bug fix; run `git pack-refs` again if you care" and call it a day
> (i.e., 1b).

Urgh, for some reason I kept writing "fully-packed" but obviously I
meant "fully-peeled". Hopefully you figured it out.

Just as a quick sketch of how much work is in involved in 2c, I think
the complete solution would look like this (but note I haven't tested
this at all):

diff --git a/pack-refs.c b/pack-refs.c
index f09a054..261a6a6 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -27,6 +27,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 			  int flags, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
+	struct object *o;
 	int is_tag_ref;
 
 	/* Do not pack the symbolic refs */
@@ -39,14 +40,12 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 		return 0;
 
 	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
-	if (is_tag_ref) {
-		struct object *o = parse_object(sha1);
-		if (o->type == OBJ_TAG) {
-			o = deref_tag(o, path, 0);
-			if (o)
-				fprintf(cb->refs_file, "^%s\n",
-					sha1_to_hex(o->sha1));
-		}
+	o = parse_object(sha1);
+	if (o->type == OBJ_TAG) {
+		o = deref_tag(o, path, 0);
+		if (o)
+			fprintf(cb->refs_file, "^%s\n",
+				sha1_to_hex(o->sha1));
 	}
 
 	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
@@ -128,7 +127,7 @@ int pack_refs(unsigned int flags)
 		die_errno("unable to create ref-pack file structure");
 
 	/* perhaps other traits later as well */
-	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
+	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
 
 	for_each_ref(handle_one_ref, &cbdata);
 	if (ferror(cbdata.refs_file))
diff --git a/refs.c b/refs.c
index 175b9fc..770abf4 100644
--- a/refs.c
+++ b/refs.c
@@ -808,6 +808,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	struct ref_entry *last = NULL;
 	char refline[PATH_MAX];
 	int flag = REF_ISPACKED;
+	int fully_peeled = 0;
 
 	while (fgets(refline, sizeof(refline), f)) {
 		unsigned char sha1[20];
@@ -818,13 +819,18 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			const char *traits = refline + sizeof(header) - 1;
 			if (strstr(traits, " peeled "))
 				flag |= REF_KNOWS_PEELED;
+			if (strstr(traits, " fully-peeled "))
+				fully_peeled = 1;
 			/* perhaps other traits later as well */
 			continue;
 		}
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			last = create_ref_entry(refname, sha1, flag, 1);
+			int this_flag = flag;
+			if (!fully_peeled && prefixcmp(refname, "refs/tags/"))
+				this_flag &= ~REF_KNOWS_PEELED;
+			last = create_ref_entry(refname, sha1, this_flag, 1);
 			add_ref(dir, last);
 			continue;
 		}

So it's really not that much code. The bigger question is whether we
want to have to carry the "fully-peeled" tag forever, and how other
implementations would treat it.

-Peff
