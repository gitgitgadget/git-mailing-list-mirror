From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] list-objects: reduce one argument in mark_edges_uninteresting
Date: Fri, 16 Aug 2013 16:52:06 +0700
Message-ID: <1376646727-22318-5-git-send-email-pclouds@gmail.com>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
 <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 11:52:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGi6-00085Q-Eq
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab3HPJwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 05:52:41 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35560 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab3HPJwk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:52:40 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so2053902pdj.3
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Xelur6P3KCFW0LED4Tqr6lCfiAy+q/pq+EZmzVUL9sw=;
        b=ABTHzX8afvKnJbNbU0TtsGkXtt93PB6BH4jdpI+3OQDNMDgbOKWJqUWcEBOn1GD5h8
         kFWTFmet4iOAbz0zhfL/clSOt+lubPZ6wXPLoLbCDgbScj1dL0pdxCn4p1fPfzEQGam6
         ddtRhBUEsU9R0OrEXCQBtKKhn6dSERNh6vKXK52xQsFmVOONJW+BW54qmxj9MqmunTaj
         Hi6YBwUqAi3z0tfvkBZaky6fa5rJmSiMNpYLqOLh0qEtVkaPgD+mwcSjsclBgvc+FsPY
         0kialbLowNWiUV/nkj7kpBke3yONWEBojRdFijWW3CD7xxuRTLKtGlYog3HS4aEOCs3M
         TYUw==
X-Received: by 10.66.50.104 with SMTP id b8mr2254651pao.39.1376646759920;
        Fri, 16 Aug 2013 02:52:39 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ss8sm2369141pab.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 02:52:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 16 Aug 2013 16:52:33 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232412>

mark_edges_uninteresting() is always called with this form

  mark_edges_uninteresting(revs->commits, revs, ...);

Remove the first argument and let mark_edges_uninteresting figure that
out by itself. It helps answer the question "are this commit list and
revs related in any way?" when looking at mark_edges_uninteresting
implementation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bisect.c               | 2 +-
 builtin/pack-objects.c | 2 +-
 builtin/rev-list.c     | 2 +-
 http-push.c            | 2 +-
 list-objects.c         | 7 +++----
 list-objects.h         | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index 71c1958..1e46a4f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -624,7 +624,7 @@ static void bisect_common(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
-		mark_edges_uninteresting(revs->commits, revs, NULL);
+		mark_edges_uninteresting(revs, NULL);
 }
=20
 static void exit_if_skipped_commits(struct commit_list *tried,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..dd117b3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2378,7 +2378,7 @@ static void get_object_list(int ac, const char **=
av)
=20
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
-	mark_edges_uninteresting(revs.commits, &revs, show_edge);
+	mark_edges_uninteresting(&revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object, NULL);
=20
 	if (keep_unreachable)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index a5ec30d..4fc1616 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -336,7 +336,7 @@ int cmd_rev_list(int argc, const char **argv, const=
 char *prefix)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	if (revs.tree_objects)
-		mark_edges_uninteresting(revs.commits, &revs, show_edge);
+		mark_edges_uninteresting(&revs, show_edge);
=20
 	if (bisect_list) {
 		int reaches =3D reaches, all =3D all;
diff --git a/http-push.c b/http-push.c
index 6dad188..cde6416 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1976,7 +1976,7 @@ int main(int argc, char **argv)
 		pushing =3D 0;
 		if (prepare_revision_walk(&revs))
 			die("revision walk setup failed");
-		mark_edges_uninteresting(revs.commits, &revs, NULL);
+		mark_edges_uninteresting(&revs, NULL);
 		objects_to_send =3D get_delta(&revs, ref_lock);
 		finish_all_active_slots();
=20
diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..db8ee4f 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -145,11 +145,10 @@ static void mark_edge_parents_uninteresting(struc=
t commit *commit,
 	}
 }
=20
-void mark_edges_uninteresting(struct commit_list *list,
-			      struct rev_info *revs,
-			      show_edge_fn show_edge)
+void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show=
_edge)
 {
-	for ( ; list; list =3D list->next) {
+	struct commit_list *list;
+	for (list =3D revs->commits; list; list =3D list->next) {
 		struct commit *commit =3D list->item;
=20
 		if (commit->object.flags & UNINTERESTING) {
diff --git a/list-objects.h b/list-objects.h
index 3db7bb6..136a1da 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -6,6 +6,6 @@ typedef void (*show_object_fn)(struct object *, const s=
truct name_path *, const
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_obje=
ct_fn, void *);
=20
 typedef void (*show_edge_fn)(struct commit *);
-void mark_edges_uninteresting(struct commit_list *, struct rev_info *,=
 show_edge_fn);
+void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
=20
 #endif
--=20
1.8.2.82.gc24b958
