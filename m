From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct
 child_process variables
Date: Thu, 30 Oct 2014 17:35:24 -0400
Message-ID: <20141030213523.GA21017@peff.net>
References: <54500212.7040603@web.de>
 <20141029172109.GA32234@peff.net>
 <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:35:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjxNS-0003Jd-JD
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 22:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbaJ3Vf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 17:35:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:35288 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933386AbaJ3Vf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 17:35:26 -0400
Received: (qmail 2796 invoked by uid 102); 30 Oct 2014 21:35:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Oct 2014 16:35:26 -0500
Received: (qmail 9128 invoked by uid 107); 30 Oct 2014 21:35:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Oct 2014 17:35:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Oct 2014 17:35:24 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 12:16:05PM -0700, Junio C Hamano wrote:

> Probably three helper functions:
> 
>  - The first is to find tops and bottoms (this translates fuzzy
>    specifications such as "--since 30.days" into a more concrete
>    revision range "^A ^B ... Z" to establish bundle prerequisites),
>    which is done by running a "rev-list --boundary".
> 
>  - The second is to show refs, while paying attention to things like
>    "--10 maint master" which may result in the tip of 'maint' not
>    being shown at all.  I am not sure if this part can/should take
>    advantage of revs.cmdline, though.
> 
>  - The last is to create the actual pack data.
> 
> I agree with your analysis on the change in column.c and trailer.c

I was not planning to work on this, but since you did the first and
third bullet points, I think it makes sense to start the second one with
this cleanup:

-- >8 --
Subject: bundle: split out ref writing from bundle_create

The bundle_create() function has a number of logical steps:
process the input, write the refs, and write the packfile.
Recent commits split the first and third into separate
sub-functions. It's worth splitting the middle step out,
too, if only because it makes the progression of the steps
more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously this should be dropped if somebody is actively working on the
revs.cmdline thing you mentioned, as it would conflict horribly. But I
think it is a nice step for somebody working on it later, because the
revs.cmdline changes should be isolated to write_bundle_refs.

 bundle.c | 97 ++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 39 deletions(-)

diff --git a/bundle.c b/bundle.c
index 0ca8737..ca4803b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -310,43 +310,22 @@ static int compute_and_write_prerequistes(int bundle_fd,
 	return 0;
 }
 
-int create_bundle(struct bundle_header *header, const char *path,
-		  int argc, const char **argv)
+/*
+ * Write out bundle refs based on the tips already
+ * parsed into revs.pending. As a side effect, may
+ * manipulate revs.pending to include additional
+ * necessary objects (like tags).
+ *
+ * Returns the number of refs written, or negative
+ * on error.
+ */
+static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 {
-	static struct lock_file lock;
-	int bundle_fd = -1;
-	int bundle_to_stdout;
-	int i, ref_count = 0;
-	struct rev_info revs;
-
-	bundle_to_stdout = !strcmp(path, "-");
-	if (bundle_to_stdout)
-		bundle_fd = 1;
-	else
-		bundle_fd = hold_lock_file_for_update(&lock, path,
-						      LOCK_DIE_ON_ERROR);
-
-	/* write signature */
-	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
-
-	/* init revs to list objects for pack-objects later */
-	save_commit_buffer = 0;
-	init_revisions(&revs, NULL);
-
-	/* write prerequisites */
-	if (compute_and_write_prerequistes(bundle_fd, &revs, argc, argv))
-		return -1;
-
-	/* write references */
-	argc = setup_revisions(argc, argv, &revs, NULL);
-
-	if (argc > 1)
-		return error(_("unrecognized argument: %s"), argv[1]);
-
-	object_array_remove_duplicates(&revs.pending);
+	int i;
+	int ref_count = 0;
 
-	for (i = 0; i < revs.pending.nr; i++) {
-		struct object_array_entry *e = revs.pending.objects + i;
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object_array_entry *e = revs->pending.objects + i;
 		unsigned char sha1[20];
 		char *ref;
 		const char *display_ref;
@@ -361,7 +340,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
 		if (e->item->type == OBJ_TAG &&
-				!is_tag_in_date_range(e->item, &revs)) {
+				!is_tag_in_date_range(e->item, revs)) {
 			e->item->flags |= UNINTERESTING;
 			continue;
 		}
@@ -407,7 +386,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 				 */
 				obj = parse_object_or_die(sha1, e->name);
 				obj->flags |= SHOWN;
-				add_pending_object(&revs, obj, e->name);
+				add_pending_object(revs, obj, e->name);
 			}
 			free(ref);
 			continue;
@@ -420,11 +399,51 @@ int create_bundle(struct bundle_header *header, const char *path,
 		write_or_die(bundle_fd, "\n", 1);
 		free(ref);
 	}
-	if (!ref_count)
-		die(_("Refusing to create empty bundle."));
 
 	/* end header */
 	write_or_die(bundle_fd, "\n", 1);
+	return ref_count;
+}
+
+int create_bundle(struct bundle_header *header, const char *path,
+		  int argc, const char **argv)
+{
+	static struct lock_file lock;
+	int bundle_fd = -1;
+	int bundle_to_stdout;
+	int ref_count = 0;
+	struct rev_info revs;
+
+	bundle_to_stdout = !strcmp(path, "-");
+	if (bundle_to_stdout)
+		bundle_fd = 1;
+	else
+		bundle_fd = hold_lock_file_for_update(&lock, path,
+						      LOCK_DIE_ON_ERROR);
+
+	/* write signature */
+	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
+
+	/* init revs to list objects for pack-objects later */
+	save_commit_buffer = 0;
+	init_revisions(&revs, NULL);
+
+	/* write prerequisites */
+	if (compute_and_write_prerequistes(bundle_fd, &revs, argc, argv))
+		return -1;
+
+	argc = setup_revisions(argc, argv, &revs, NULL);
+
+	if (argc > 1)
+		return error(_("unrecognized argument: %s"), argv[1]);
+
+	object_array_remove_duplicates(&revs.pending);
+
+	ref_count = write_bundle_refs(bundle_fd, &revs);
+	if (!ref_count)
+		die(_("Refusing to create empty bundle."));
+	else if (ref_count < 0)
+		return -1;
 
 	/* write pack */
 	if (write_pack_data(bundle_fd, &lock, &revs))
-- 
2.1.2.596.g7379948
