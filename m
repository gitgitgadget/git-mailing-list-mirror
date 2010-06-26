From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/8] bundle: reuse setup_revisions result
Date: Sat, 26 Jun 2010 01:22:12 -0500
Message-ID: <20100626062212.GF15881@burratino>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 554682@bugs.debian.org,
	Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 08:22:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOmb-0007Zz-AR
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 08:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab0FZGWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 02:22:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60728 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0FZGWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 02:22:24 -0400
Received: by iwn41 with SMTP id 41so2712135iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xm5EdQh32MzZgifn8FkUz50zmRQs+8G0mtTx/d4D0Cg=;
        b=ERtuT4Cp9EN0ICb/zp2PFdLIdIXd6m1YNYWZxbl5VmTgNom8I2t+M71DBqhbOpjfL/
         xBd4oUXcb6y8qPVT0Err6hMkGBNTWzxBBcz7fAFbqr3mFA3UFIfW95hRA7zpD8goURFn
         2v2HqXsYgcNB+21Jm8A51dtvulOqW8m61mrHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fMfSHbxPQkojDQm8tlKrP/UOWTLwCVGgTxEg5LOC6R963Ys59HMvphhAQl3pRDzgbv
         7Ix9hob/Iidks799n3J2Khx4oQETzHkyW4TGT7/0n2zJKRuSPkHLLnS5zuNq/AR3QEIC
         mpE4a32dmORMZnewNMBLAS85+pqaWvXgushmg=
Received: by 10.231.14.201 with SMTP id h9mr1809790iba.118.1277533343874;
        Fri, 25 Jun 2010 23:22:23 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm2739801ibh.14.2010.06.25.23.22.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 23:22:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626061735.GA15881@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149733>

Avoid reading stdin twice for bundle --stdin.

Reported-by: Joey Hess <joey@kitenet.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 bundle.c |   57 +++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/bundle.c b/bundle.c
index 8ba6479..311c554 100644
--- a/bundle.c
+++ b/bundle.c
@@ -193,7 +193,17 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 		(revs->min_age == -1 || revs->min_age > date);
 }
 
-static void list_prerequisite(int bundle_fd, struct rev_info *revs,
+static void object_array_copy(struct object_array *dest, const struct object_array *src)
+{
+	int i;
+
+	for (i = 0; i < src->nr; i++) {
+		struct object_array_entry *e = src->objects + i;
+		add_object_array_with_mode(e->item, e->name, dest, e->mode);
+	}
+}
+
+static void list_prerequisite(int bundle_fd, struct object_array *pending,
 		struct commit *rev)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -216,45 +226,52 @@ static void list_prerequisite(int bundle_fd, struct rev_info *revs,
 	write_or_die(bundle_fd, buf.buf, buf.len);
 
 	rev->object.flags |= UNINTERESTING;
-	add_pending_object(revs, &rev->object, buf.buf);
+	add_object_array(&rev->object, buf.buf, pending);
 	strbuf_release(&buf);
 }
 
 static int list_prerequisites(int bundle_fd, struct rev_info *revs,
-		int argc, const char * const *argv)
+		int argc, const char **argv)
 {
-	const char **argv_boundary = xmalloc((argc + 1) * sizeof(const char *));
-	struct rev_info boundary_revs;
 	struct commit *rev;
+	struct object_array pending_copy = { 0, 0, NULL };
 
-	memcpy(argv_boundary, argv, (argc + 1) * sizeof(const char *));
+	revs->simplify_history = 0;
+	argc = setup_revisions(argc, argv, revs, NULL);
+	if (argc > 1)
+		return error("unrecognized argument: %s", argv[1]);
 
-	init_revisions(&boundary_revs, NULL);
-	boundary_revs.boundary = 1;
-	if (setup_revisions(argc, argv_boundary, &boundary_revs, NULL) > 1)
-		return error("unrecognized argument: %s", argv_boundary[1]);
-	if (prepare_revision_walk(&boundary_revs))
+	if (revs->reflog_info)
+		return error("bundle does not support --walk-reflogs");
+	if (revs->no_walk)
+		return error("bundle does not support --no-walk");
+	if (revs->simplify_history)
+		return error("bundle and history simplification do not mix");
+
+	object_array_copy(&pending_copy, &revs->pending);
+
+	revs->boundary = 1;
+	if (prepare_revision_walk(revs))
 		return error("revision walk setup failed");
 
 	while ((rev = get_revision(revs))) {
 		if (rev->object.flags & BOUNDARY)
-			list_prerequisite(bundle_fd, revs, rev);
+			list_prerequisite(bundle_fd, &pending_copy, rev);
 		else
 			rev->object.flags |= SHOWN;
 	}
+
+	if (revs->pending.objects != NULL)
+		return error("%u revisions pending after boundary walk",
+						revs->pending.nr);
+	revs->pending = pending_copy;
 	return 0;
 }
 
-static int bundle_list_refs(int bundle_fd,
-		int argc, const char **argv, struct rev_info *revs)
+static int bundle_list_refs(int bundle_fd, struct rev_info *revs)
 {
 	int i, ref_count = 0;
 
-	argc = setup_revisions(argc, argv, revs, NULL);
-
-	if (argc > 1)
-		return error("unrecognized argument: %s'", argv[1]);
-
 	object_array_remove_duplicates(&revs->pending);
 
 	for (i = 0; i < revs->pending.nr; i++) {
@@ -367,7 +384,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 		return -1;
 
 	/* write references */
-	if (bundle_list_refs(bundle_fd, argc, argv, &revs))
+	if (bundle_list_refs(bundle_fd, &revs))
 		return -1;
 
 	/* end header */
-- 
1.7.1.198.g8d802
