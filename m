Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94EEC1F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756164AbdLPMMc (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:12:32 -0500
Received: from mout.web.de ([212.227.15.14]:64905 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752535AbdLPMMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:12:30 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGzFy-1eDaOx1vgg-00DpTX; Sat, 16
 Dec 2017 13:12:17 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] revision: introduce prepare_revision_walk_extended()
Message-ID: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
Date:   Sat, 16 Dec 2017 13:12:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:5M+luyVUjjwzXkP1F0b+Jzj7JSLxWxxtPMnTU2tJOpQ1kZcUhUG
 M4O8+e/MBP/qnsCT4Qzg4jxvYsAiqJNiRDeleBrHVEbs0NDOCfZSHGLIOKAJMsZ909CtF8h
 BGpuX23pfNVKyk/h08U6Cs2ThohlVMcW+fDXqv7K1japX5lkcueQhl/xKNDsHF23Jn9Bt1t
 K75xKzGnQPnc1hIRd4jfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZuyOPvM1TJ4=:72UUUvwsen+UwerGAFA5YE
 KQHco9mqJAsnBPDgcCUQyRnzOmB6KStnD8vXvD4tGQH2YbfaQ5/W0mi79zoJ0unihgCzUKjGe
 OOE+vBSapQKUElegtKjGrb4m5FC9MLHWVGR214SyupNd9yVBODzXT5vUnxBdf+v1Etj8upjso
 mqc0bAfqj/Y56WYZ1S10KlIDw+wG+kEIbvxxPMncpjs0gjObwD3VzWwxi6qcdAHIpWvu9hHy7
 3wWz06jAG+uD6M/JmhIE9yjmQ8V7vB44rx638rXi7JPksKdLjeMJdbewG0To5awc37DtubIuc
 VAca+NhKEzqe9xzFtI7duhgxRDOtPnHOVx71WiAS1Vk7SIrRTWv24WymhFS0b3gINtArEvZoI
 OIdXZwR3X0hE4EXFKhGZ3n1n0GS1GZzrIhiCIgxhGncCZVw9P5atmENwViacOn48CLgmjKwCB
 VRT/zAwMPyljtJFyxh1VCfCBaPC2qZmEekq7RCPnYrYhwPE7q/8Hspg5p71wHkM8mEEmwTgX+
 Z+x0RyR/ra/i6qNPWUi0Ggha/eVnDzdkC7vO27FQmbgm4nkJBv19J84B/Qgqtnr2ZbQX6PG9p
 MBS0UfMu8EJA9+IWkbb7jZNYdB30PqLaA9KoLCPz5ZYJ2jAO9gcfiR5yynanKX8eM8RBLQyGd
 hF+qPvDg86n5JAg506Gzi9QRUD/gb5lZ3v9Y6XLymlZwoh1rPUab/jiP1Nm92xeEecnnFaoQl
 X5BZn0Em5GJzA3m1KAkWcAX++H5EIF9q+WWv/TgXblEgcLqqwqzM4BItIpanL+B2AeFg6cMAR
 HepmnVdVDvCxdlhSOhYlCi46q61FVPYi7Jp88SJSRrZQ7f4PdQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prepare_revision_walk() allows callers to take ownership of the array of
pending objects by setting the rev_info flag "leak_pending" and copying
the object_array "pending".  They use it to clear commit marks after
setup is done.  This interface is brittle enough that it requires
extensive comments.

Provide an easier way by adding a function that can hand over the array
to a caller-supplied output parameter and converting all users of the
flag "leak_pending" to call prepare_revision_walk_extended() instead.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-revision-walking.txt |  6 ++++++
 bisect.c                                         | 17 +++++------------
 builtin/checkout.c                               |  9 +--------
 bundle.c                                         |  9 +--------
 revision.c                                       | 10 +++++++++-
 revision.h                                       | 14 ++------------
 6 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
index 55b878ade8..9dc573d2ec 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -50,6 +50,12 @@ function.
 	returns any error (non-zero return code) and if it does not, you can
 	start using get_revision() to do the iteration.
 
+`prepare_revision_walk_extended`::
+
+	Like prepare_revision_walk(), but allows callers to take ownership
+	of the array of pending objects by passing an object_array pointer
+	as the second parameter; passing NULL clears the array.
+
 `get_revision`::
 
 	Takes a pointer to a `rev_info` structure and iterates over it,
diff --git a/bisect.c b/bisect.c
index 0fca17c02b..a2af405d28 100644
--- a/bisect.c
+++ b/bisect.c
@@ -641,9 +641,10 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	/* XXX leak rev_argv, as "revs" may still be pointing to it */
 }
 
-static void bisect_common(struct rev_info *revs)
+static void bisect_common(struct rev_info *revs,
+			  struct object_array *old_pending_ptr)
 {
-	if (prepare_revision_walk(revs))
+	if (prepare_revision_walk_extended(revs, old_pending_ptr))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
 		mark_edges_uninteresting(revs, NULL);
@@ -825,15 +826,7 @@ static int check_ancestors(const char *prefix)
 	bisect_rev_setup(&revs, prefix, "^%s", "%s", 0);
 
 	/* Save pending objects, so they can be cleaned up later. */
-	pending_copy = revs.pending;
-	revs.leak_pending = 1;
-
-	/*
-	 * bisect_common calls prepare_revision_walk right away, which
-	 * (together with .leak_pending = 1) makes us the sole owner of
-	 * the list of pending objects.
-	 */
-	bisect_common(&revs);
+	bisect_common(&revs, &pending_copy);
 	res = (revs.commits != NULL);
 
 	/* Clean up objects used, as they will be reused. */
@@ -964,7 +957,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
 
-	bisect_common(&revs);
+	bisect_common(&revs, NULL);
 
 	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
 	revs.commits = managed_skipped(revs.commits, &tried);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e1e157d205..1f04f5d5e5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -796,14 +796,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);
 
 	/* Save pending objects, so they can be cleaned up later. */
-	refs = revs.pending;
-	revs.leak_pending = 1;
-
-	/*
-	 * prepare_revision_walk (together with .leak_pending = 1) makes us
-	 * the sole owner of the list of pending objects.
-	 */
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk_extended(&revs, &refs))
 		die(_("internal error in revision walk"));
 	if (!(old->object.flags & UNINTERESTING))
 		suggest_reattach(old, &revs);
diff --git a/bundle.c b/bundle.c
index 93290962c9..6af6e38c40 100644
--- a/bundle.c
+++ b/bundle.c
@@ -158,14 +158,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	setup_revisions(2, argv, &revs, NULL);
 
 	/* Save pending objects, so they can be cleaned up later. */
-	refs = revs.pending;
-	revs.leak_pending = 1;
-
-	/*
-	 * prepare_revision_walk (together with .leak_pending = 1) makes us
-	 * the sole owner of the list of pending objects.
-	 */
-	if (prepare_revision_walk(&revs))
+	if (prepare_revision_walk_extended(&revs, &refs))
 		die(_("revision walk setup failed"));
 
 	i = req_nr;
diff --git a/revision.c b/revision.c
index f6a3da5cd9..3a231451a4 100644
--- a/revision.c
+++ b/revision.c
@@ -2841,6 +2841,12 @@ void reset_revision_walk(void)
 }
 
 int prepare_revision_walk(struct rev_info *revs)
+{
+	return prepare_revision_walk_extended(revs, NULL);
+}
+
+int prepare_revision_walk_extended(struct rev_info *revs,
+				   struct object_array *old_pending_ptr)
 {
 	int i;
 	struct object_array old_pending;
@@ -2860,7 +2866,9 @@ int prepare_revision_walk(struct rev_info *revs)
 			}
 		}
 	}
-	if (!revs->leak_pending)
+	if (old_pending_ptr)
+		*old_pending_ptr = old_pending;
+	else
 		object_array_clear(&old_pending);
 
 	/* Signal whether we need per-parent treesame decoration */
diff --git a/revision.h b/revision.h
index 54761200ad..5d4b475334 100644
--- a/revision.h
+++ b/revision.h
@@ -150,18 +150,6 @@ struct rev_info {
 			date_mode_explicit:1,
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
-	/*
-	 * Set `leak_pending` to prevent `prepare_revision_walk()` from clearing
-	 * the array of pending objects (`pending`). It will still forget about
-	 * the array and its entries, so they really are leaked. This can be
-	 * useful if the `struct object_array` `pending` is copied before
-	 * calling `prepare_revision_walk()`. By setting `leak_pending`, you
-	 * effectively claim ownership of the old array, so you should most
-	 * likely call `object_array_clear(&pending_copy)` once you are done.
-	 * Observe that this is about ownership of the array and its entries,
-	 * not the commits referenced by those entries.
-	 */
-	unsigned int	leak_pending:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
 			track_first_time:1,
@@ -270,6 +258,8 @@ extern int handle_revision_arg(const char *arg, struct rev_info *revs,
 
 extern void reset_revision_walk(void);
 extern int prepare_revision_walk(struct rev_info *revs);
+extern int prepare_revision_walk_extended(struct rev_info *revs,
+					  struct object_array *old_pending_ptr);
 extern struct commit *get_revision(struct rev_info *revs);
 extern char *get_revision_mark(const struct rev_info *revs,
 			       const struct commit *commit);
-- 
2.15.1
