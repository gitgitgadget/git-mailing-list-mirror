From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] Disallow NULL in struct commit_list
Date: Wed, 17 Aug 2011 09:01:18 +0700
Message-ID: <1313546478-8833-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 04:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtVSF-0004rs-An
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 04:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab1HQCB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 22:01:27 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57430 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab1HQCB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 22:01:26 -0400
Received: by pzk37 with SMTP id 37so213623pzk.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=NU6BtWE5rR7RDcHPB+JPjcn7skTJerX+4sVnkG6CgtI=;
        b=bGMpoyikGvup00n7DmsrvkX4hE0m7jMaV21mcPjj7Jw//yH659B4JR7KNTTngUn7qP
         Y2qjq7BOwcc5FQYNYAcizLzO7uveEm8rsDFcuDmM5u6FJCwf9f37mSItgc5OGiLIja5Y
         AJeIqGoTsfYIBRdD+FCqVYOREH0fozIor2Hlw=
Received: by 10.142.179.6 with SMTP id b6mr185878wff.238.1313546486206;
        Tue, 16 Aug 2011 19:01:26 -0700 (PDT)
Received: from tre ([115.73.228.117])
        by mx.google.com with ESMTPS id g4sm219391pbj.41.2011.08.16.19.01.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 19:01:24 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Wed, 17 Aug 2011 09:01:19 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179495>

It seems to me that in most cases commit_list is supposed to contain
real commits. If someone puts a NULL there by accident, it'd be hard to
track down because sigsegv would happen later when the the commit is
used, not when added.

So perhaps we could safeguard commit_list_insert(). If a bug tries to
put NULL in, it'd be caught earlier.

There is code that add NULL commit on purpose, "make test" only catches
one in revert.c, but I may miss other cases and crash system unnecessar=
ily.

Not sure if this patch is worth the trouble. Maybe make it permanent
resident of next and never graduate to master?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c  |    2 +-
 builtin/revert.c |    2 +-
 commit.c         |    3 +++
 commit.h         |    2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 325891e..158008d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -611,7 +611,7 @@ static void write_tree_trivial(unsigned char *sha1)
=20
 static const char *merge_argument(struct commit *commit)
 {
-	if (commit)
+	if (commit && commit !=3D &null_commit)
 		return sha1_to_hex(commit->object.sha1);
 	else
 		return EMPTY_TREE_SHA1_HEX;
diff --git a/builtin/revert.c b/builtin/revert.c
index 1f27c63..7d5005e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -471,7 +471,7 @@ static int do_pick_commit(void)
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
-		base =3D parent;
+		base =3D parent ? parent : &null_commit;
 		base_label =3D msg.parent_label;
 		next =3D commit;
 		next_label =3D msg.label;
diff --git a/commit.c b/commit.c
index dc22695..604d2f1 100644
--- a/commit.c
+++ b/commit.c
@@ -11,6 +11,8 @@ int save_commit_buffer =3D 1;
=20
 const char *commit_type =3D "commit";
=20
+struct commit null_commit;
+
 static struct commit *check_commit(struct object *obj,
 				   const unsigned char *sha1,
 				   int quiet)
@@ -363,6 +365,7 @@ int find_commit_subject(const char *commit_buffer, =
const char **subject)
 struct commit_list *commit_list_insert(struct commit *item, struct com=
mit_list **list_p)
 {
 	struct commit_list *new_list =3D xmalloc(sizeof(struct commit_list));
+	assert(item !=3D NULL);
 	new_list->item =3D item;
 	new_list->next =3D *list_p;
 	*list_p =3D new_list;
diff --git a/commit.h b/commit.h
index 0e36fd0..c9f0743 100644
--- a/commit.h
+++ b/commit.h
@@ -21,6 +21,8 @@ struct commit {
 	char *buffer;
 };
=20
+extern struct commit null_commit;
+
 extern int save_commit_buffer;
 extern const char *commit_type;
=20
--=20
1.7.4.74.g639db
