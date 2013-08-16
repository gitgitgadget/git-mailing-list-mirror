From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] list-objects: mark more commits as edges in mark_edges_uninteresting
Date: Fri, 16 Aug 2013 16:52:07 +0700
Message-ID: <1376646727-22318-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Aug 16 11:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGiG-0008Eq-QR
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab3HPJwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 05:52:50 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33587 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446Ab3HPJwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:52:46 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so2035687pde.38
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DYNIqDAAesCvLZ7ToELKPWJ32NBjUAEUU0OcM31sy1c=;
        b=wqcRq2r+MHwZsHYjxW17flNnmoiGA57CXAmqG9KTvhGJKnFiomjvUCZSv/h73ZswuA
         q72kxF54YP3UjbN07Mef9nt6t3rXvHyHpC3I6UrqXLoHnTs7SpiMD5UVHodG7zCRWMm5
         o023gcGfZyc6AGEAg28HkiaBbwHMLwTOnc3oSL5/1O+vpHIpgjlerw3/afGo9fTacGBy
         xEN39HdVMqbAQ/9GHo2QGr/Am/MIzu260CHvYUv/QRzcbD0hg64Us96Pm63//MjSKjNJ
         0tg3P6FebH+GY4W4xVumCp81eTCDhJl6ldBecJMf33u4KXpLd77KHOeQkMpKNJ8zbgK6
         3Lbw==
X-Received: by 10.66.234.232 with SMTP id uh8mr2115761pac.155.1376646766356;
        Fri, 16 Aug 2013 02:52:46 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id sz6sm2373050pab.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 02:52:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 16 Aug 2013 16:52:40 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232413>

The purpose of edge commits is to let pack-objects know what objects
it can use as base, but does not need to include in the thin pack
because the other side is supposed to already have them. So far we
mark uninteresting parents of interesting commits as edges. But even
an unrelated uninteresting commit (that the other side has) may become
a good base for pack-objects and help produce more efficient packs.

This is especially true for shallow clone, when the client issues a
fetch with a depth smaller or equal to the number of commits the
server is ahead of the client. For example, in this commit history the
client has up to "A" and the server has up to "B":

    -------A---B
     have--^   ^
              /
       want--+

If depth 1 is requested, the commit list to send to the client
includes only B. The way m_e_u is working, it checks if parent commits
of B are uninteresting, if so mark them as edges. Due to shallow
effect, commit B is grafted to have no parents and the revision walker
never sees A as the parent of B. In fact it marks no edges at all in
this simple case and sends everything B has to the client even if it
could have excluded what A and also the client already have. In a
slightly different case where A is not a direct parent of B (iow there
are commits in between A and B), marking A as an edge can still save
some because B may still have stuff from the far ancestor A.

There is another case from the previous patch, when we deepen a ref
from C->E to A->E:

    ---A---B   C---D---E
     want--^   ^       ^
       shallow-+      /
          have-------+

In this case we need to send A and B to the client, and C (i.e. the
current shallow point that the client informs the server) is a very
good base because it's closet to A and B. Normal m_e_u won't recognize
C as an edge because it only looks back to parents (i.e. A<-B) not the
opposite way B->C even if C is already marked as uninteresting commit
by the previous patch.

This patch includes all uninteresting commits from command line as
edges and lets pack-objects decide what's best to do. The upside is we
have better chance of producing better packs in certain cases. The
downside is we may need to process some extra objects on the server
side.

=46or the shallow case on git.git, when the client is 5 commits behind
and does "fetch --depth=3D3", the result pack is 99.26 KiB instead of
4.92 MiB.

Reported-and-analyzed-by: Matthijs Kooijman <matthijs@stdin.nl>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 list-objects.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/list-objects.c b/list-objects.c
index db8ee4f..05c8c5c 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -148,15 +148,32 @@ static void mark_edge_parents_uninteresting(struc=
t commit *commit,
 void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show=
_edge)
 {
 	struct commit_list *list;
+	int i;
+
 	for (list =3D revs->commits; list; list =3D list->next) {
 		struct commit *commit =3D list->item;
=20
 		if (commit->object.flags & UNINTERESTING) {
 			mark_tree_uninteresting(commit->tree);
+			if (revs->edge_hint && !(commit->object.flags & SHOWN)) {
+				commit->object.flags |=3D SHOWN;
+				show_edge(commit);
+			}
 			continue;
 		}
 		mark_edge_parents_uninteresting(commit, revs, show_edge);
 	}
+	for (i =3D 0; i < revs->cmdline.nr; i++) {
+		struct object *obj =3D revs->cmdline.rev[i].item;
+		struct commit *commit =3D (struct commit *)obj;
+		if (obj->type !=3D OBJ_COMMIT || !(obj->flags & UNINTERESTING))
+			continue;
+		mark_tree_uninteresting(commit->tree);
+		if (revs->edge_hint && !(obj->flags & SHOWN)) {
+			obj->flags |=3D SHOWN;
+			show_edge(commit);
+		}
+	}
 }
=20
 static void add_pending_tree(struct rev_info *revs, struct tree *tree)
--=20
1.8.2.82.gc24b958
