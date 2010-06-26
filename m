From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/8] bundle: split table of contents output into its own
 function
Date: Sat, 26 Jun 2010 01:21:16 -0500
Message-ID: <20100626062116.GE15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOli-0007JP-7N
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab0FZGVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 02:21:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37683 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZGV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:21:29 -0400
Received: by mail-iw0-f174.google.com with SMTP id 41so2711526iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JTe2nnaRoaEzQ/rFp3aqRuvcLCqThVza7qO8+/qoz8c=;
        b=NsCjkzPogGjtSzYoUUFczQuXwtpcVBa/uX2ZpNs1Gx5SA/EBSGNAriuAeFLg1fdV3q
         i08GW/8SH7Yk6oqafU0RIqPShvnA20i0WdjdAeoAF86sOQ9ikBjxkCw46asqfDm867yI
         mMZS9uySdyTZfeHaTYusPR/PJN00yAbKTGpZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e3giabchcp9KVtm3mxzKndCrxs/on5QeAY2O2NPpJyOzjzjUctU7oGyBU5b3or0mlR
         XVfEUrbMccvJzfz4RnPwko6S7MvYkKx5h/QfozqI7r/iFZGs9mAaQnH0aA+ZEeaPb7MX
         jgf5b/9uUyuBZtDfbz7/dcHqcsFwdt0JL7mVs=
Received: by 10.231.207.225 with SMTP id fz33mr1821267ibb.173.1277533287681;
        Fri, 25 Jun 2010 23:21:27 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm2736380ibh.2.2010.06.25.23.21.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:21:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626061735.GA15881@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149732>

Isolate another piece of create_bundle() to work on.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 bundle.c |   78 +++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/bundle.c b/bundle.c
index e90b5c5..8ba6479 100644
--- a/bundle.c
+++ b/bundle.c
@@ -245,45 +245,20 @@ static int list_prerequisites(int bundle_fd, struct rev_info *revs,
 	return 0;
 }
 
-int create_bundle(struct bundle_header *header, const char *path,
-		int argc, const char **argv)
+static int bundle_list_refs(int bundle_fd,
+		int argc, const char **argv, struct rev_info *revs)
 {
-	static struct lock_file lock;
-	int bundle_fd = -1;
-	int bundle_to_stdout;
-	const char **argv_pack = xmalloc(5 * sizeof(const char *));
 	int i, ref_count = 0;
-	struct rev_info revs;
-	struct child_process rls;
 
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
-	if (list_prerequisites(bundle_fd, &revs, argc, argv))
-		return -1;
-
-	/* write references */
-	argc = setup_revisions(argc, argv, &revs, NULL);
+	argc = setup_revisions(argc, argv, revs, NULL);
 
 	if (argc > 1)
 		return error("unrecognized argument: %s'", argv[1]);
 
-	object_array_remove_duplicates(&revs.pending);
+	object_array_remove_duplicates(&revs->pending);
 
-	for (i = 0; i < revs.pending.nr; i++) {
-		struct object_array_entry *e = revs.pending.objects + i;
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object_array_entry *e = revs->pending.objects + i;
 		unsigned char sha1[20];
 		char *ref;
 		const char *display_ref;
@@ -298,7 +273,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
 		if (e->item->type == OBJ_TAG &&
-				!is_tag_in_date_range(e->item, &revs)) {
+				!is_tag_in_date_range(e->item, revs)) {
 			e->item->flags |= UNINTERESTING;
 			continue;
 		}
@@ -344,7 +319,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 				 */
 				obj = parse_object(sha1);
 				obj->flags |= SHOWN;
-				add_pending_object(&revs, obj, e->name);
+				add_pending_object(revs, obj, e->name);
 			}
 			free(ref);
 			continue;
@@ -358,7 +333,42 @@ int create_bundle(struct bundle_header *header, const char *path,
 		free(ref);
 	}
 	if (!ref_count)
-		die ("Refusing to create empty bundle.");
+		die("Refusing to create empty bundle.");
+	return 0;
+}
+
+int create_bundle(struct bundle_header *header, const char *path,
+		int argc, const char **argv)
+{
+	static struct lock_file lock;
+	int bundle_fd = -1;
+	int bundle_to_stdout;
+	const char **argv_pack = xmalloc(5 * sizeof(const char *));
+	struct rev_info revs;
+	struct child_process rls;
+	int i;
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
+	if (list_prerequisites(bundle_fd, &revs, argc, argv))
+		return -1;
+
+	/* write references */
+	if (bundle_list_refs(bundle_fd, argc, argv, &revs))
+		return -1;
 
 	/* end header */
 	write_or_die(bundle_fd, "\n", 1);
-- 
1.7.1.198.g8d802
