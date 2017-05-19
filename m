Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33918201CF
	for <e@80x24.org>; Fri, 19 May 2017 06:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755407AbdESGMR (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 02:12:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:54690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755065AbdESGMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 02:12:17 -0400
Received: (qmail 7510 invoked by uid 109); 19 May 2017 06:12:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 06:12:15 +0000
Received: (qmail 26098 invoked by uid 111); 19 May 2017 06:12:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 02:12:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 02:12:12 -0400
Date:   Fri, 19 May 2017 02:12:12 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        git discussion list <git@vger.kernel.org>
Subject: [PATCH] ref-filter: resolve HEAD when parsing %(HEAD) atom
Message-ID: <20170519061212.5xrkqydzl32l24ck@sigill.intra.peff.net>
References: <dfc3a334-8047-26b0-1142-81c703010507@alum.mit.edu>
 <20170517140417.kwzznw4su36k6pxv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170517140417.kwzznw4su36k6pxv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user asks to display (or sort by) the %(HEAD) atom,
ref-filter has to compare each refname to the value of HEAD.
We do so by resolving HEAD fresh when calling populate_value()
on each ref. If there are a large number of refs, this can
have a measurable impact on runtime.

Instead, let's resolve HEAD once when we realize we need the
%(HEAD) atom, allowing us to do a simple string comparison
for each ref. On a repository with 3000 branches (high, but
an actual example found in the wild) this drops the
best-of-five time to run "git branch >/dev/null" from 59ms
to 48ms (~20% savings).

Signed-off-by: Jeff King <peff@peff.net>
---
The "something like this" patch I sent earlier just cached the value of
HEAD in a global for the length of the program. This is a bit nicer, in
that it ties the cache to the atom we are filling in. But since that's
also stored in a program global, the end effect is the same. :) I think
it's still worth doing it this way, though, as we might one day push the
used_atom stuff into some kind of ref_filter_context struct, and then
this would Just Work.

I did take a look at de-globalifying used_atom and friends, but it gets
pretty nasty pushing it all through the callstack. Since there's no
immediate benefit, I don't think it's really worth pursuing for now.

 ref-filter.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1fc5e9970..82ca411d0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -93,6 +93,7 @@ static struct used_atom {
 			unsigned int length;
 		} objectname;
 		struct refname_atom refname;
+		char *head;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -287,6 +288,12 @@ static void if_atom_parser(struct used_atom *atom, const char *arg)
 	}
 }
 
+static void head_atom_parser(struct used_atom *atom, const char *arg)
+{
+	unsigned char unused[GIT_SHA1_RAWSZ];
+
+	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, unused, NULL);
+}
 
 static struct {
 	const char *name;
@@ -325,7 +332,7 @@ static struct {
 	{ "push", FIELD_STR, remote_ref_atom_parser },
 	{ "symref", FIELD_STR, refname_atom_parser },
 	{ "flag" },
-	{ "HEAD" },
+	{ "HEAD", FIELD_STR, head_atom_parser },
 	{ "color", FIELD_STR, color_atom_parser },
 	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
@@ -1369,12 +1376,7 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
-			const char *head;
-			unsigned char sha1[20];
-
-			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-						  sha1, NULL);
-			if (head && !strcmp(ref->refname, head))
+			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = "*";
 			else
 				v->s = " ";
-- 
2.13.0.219.g63f6bc368

