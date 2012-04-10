From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] Teach traverse_commit_list callsites about new parameter, nr_threads
Date: Tue, 10 Apr 2012 21:39:30 +0700
Message-ID: <1334068771-32725-5-git-send-email-pclouds@gmail.com>
References: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 16:43:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcHs-0007JE-5t
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758926Ab2DJOnK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 10:43:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52722 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913Ab2DJOnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:43:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so45834pbc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZMron0LaU2HjidzRG4JbM4P3X7Ge9fbdNkyCo7r6s+k=;
        b=TAVK8SzY2bpXiyavf7zw9GXoTXEI2/8YlSHeBY2Fp9UVL0jX0rVuAp5Rmii5a5Vd1J
         wb+PKpKqwaLpBG1AqgMytcE49jHAhGzFJ/fLLKdOr47oI3ggydvCX5odFlW8yuOUFzCN
         nOCOjlI1uthmRBxNNIiAFUrmgD69/awCTs39ZP6bnt25tSiEGsOMoXPnqljPG4r2GkKL
         Hbz4YzJ48j4PTnpMmEHih4vNZUG8ryAMPs/0TDpAZipZW0oPUGCBCQ/fHN0lIhEidon0
         OWslsKLf9Q7HOIarz05d+ecTMdNb7W7b6wG+bNKi/cETwmuti+ihWl/Vt5ZJbeFbaxFc
         EKNg==
Received: by 10.68.135.40 with SMTP id pp8mr29497482pbb.13.1334068989175;
        Tue, 10 Apr 2012 07:43:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.33.136])
        by mx.google.com with ESMTPS id r10sm59297pbf.22.2012.04.10.07.43.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 07:43:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Apr 2012 21:40:09 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195088>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c |    2 +-
 builtin/rev-list.c     |    4 ++--
 list-objects.c         |    2 +-
 list-objects.h         |    2 +-
 upload-pack.c          |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2f242c4..0702cd1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2292,7 +2292,7 @@ static void get_object_list(int ac, const char **=
av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+	traverse_commit_list(&revs, show_commit, show_object, NULL, 0);
=20
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4c4d404..e720561 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -290,7 +290,7 @@ static int show_bisect_vars(struct rev_list_info *i=
nfo, int reaches, int all)
 		strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
=20
 	if (flags & BISECT_SHOW_ALL) {
-		traverse_commit_list(revs, show_commit, show_object, info);
+		traverse_commit_list(revs, show_commit, show_object, info, 0);
 		printf("------\n");
 	}
=20
@@ -395,7 +395,7 @@ int cmd_rev_list(int argc, const char **argv, const=
 char *prefix)
 			return show_bisect_vars(&info, reaches, all);
 	}
=20
-	traverse_commit_list(&revs, show_commit, show_object, &info);
+	traverse_commit_list(&revs, show_commit, show_object, &info, 0);
=20
 	if (revs.count) {
 		if (revs.left_right && revs.cherry_mark)
diff --git a/list-objects.c b/list-objects.c
index 2605b63..4f365e8 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -170,7 +170,7 @@ static void add_pending_tree(struct rev_info *revs,=
 struct tree *tree)
 void traverse_commit_list(struct rev_info *revs,
 			  show_commit_fn show_commit,
 			  show_object_fn show_object,
-			  void *data)
+			  void *data, int nr_threads_)
 {
 	int i;
 	struct commit *commit;
diff --git a/list-objects.h b/list-objects.h
index 3db7bb6..aa604ba 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -3,7 +3,7 @@
=20
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const struct name_path=
 *, const char *, void *);
-void traverse_commit_list(struct rev_info *, show_commit_fn, show_obje=
ct_fn, void *);
+void traverse_commit_list(struct rev_info *, show_commit_fn, show_obje=
ct_fn, void *, int);
=20
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct commit_list *, struct rev_info *,=
 show_edge_fn);
diff --git a/upload-pack.c b/upload-pack.c
index bb08e2e..698f966 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -128,7 +128,7 @@ static int do_rev_list(int in, int out, void *user_=
data)
 		for (i =3D 0; i < extra_edge_obj.nr; i++)
 			fprintf(pack_pipe, "-%s\n", sha1_to_hex(
 					extra_edge_obj.objects[i].item->sha1));
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
+	traverse_commit_list(&revs, show_commit, show_object, NULL, 0);
 	fflush(pack_pipe);
 	fclose(pack_pipe);
 	return 0;
--=20
1.7.8.36.g69ee2
