From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/3] diff/apply: cast variable in call to free()
Date: Sun,  6 Nov 2011 13:06:23 +0100
Message-ID: <1320581184-4557-3-git-send-email-avarab@gmail.com>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 13:06:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN1V4-00074r-F8
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 13:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab1KFMGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 07:06:53 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49619 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab1KFMGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 07:06:53 -0500
Received: by mail-fx0-f46.google.com with SMTP id o14so4247439faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 04:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aMbqT9gM28tC/gI3YRvlWdHrk7keS7VUhoC+HNIRamM=;
        b=cdnr9oTPW29Y/xvJKRbbV4iI+flcKTpDOom1Pxh6LDAGYOXTrq8O1+MlcdNBy2STHi
         TfQxIKEAfWLwkwgc+VF6Ydl/BYg+tdKlqyBSq5jPywnBv5o73tcnaE2DHMelmt1TRQ2z
         6Z9pXWnCjmfMxUWFpxF1yTKtPJlnUnuLhhaiY=
Received: by 10.223.76.217 with SMTP id d25mr38715785fak.31.1320581212395;
        Sun, 06 Nov 2011 04:06:52 -0800 (PST)
Received: from snth.ams7.corp.booking.com ([62.140.137.119])
        by mx.google.com with ESMTPS id f14sm3038218fah.6.2011.11.06.04.06.50
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 04:06:51 -0800 (PST)
X-Mailer: git-send-email 1.7.6.3
In-Reply-To: <1320581184-4557-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184909>

Both of these free() calls are freeing a "const unsigned char (*)[20]"
type while free() expects a "void *". This results in the following
warning under clang 2.9:

    builtin/diff.c:185:7: warning: passing 'const unsigned char (*)[20]=
' to parameter of type 'void *' discards qualifiers
            free(parent);
                 ^~~~~~

    submodule.c:394:7: warning: passing 'const unsigned char (*)[20]' t=
o parameter of type 'void *' discards qualifiers
            free(parents);
                 ^~~~~~~

This free()-ing without a cast was added by Jim Meyering to
builtin/diff.c in v1.7.6-rc3~4 and later by Fredrik Gustafsson in
submodule.c in v1.7.7-rc1~25^2.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/diff.c |    2 +-
 submodule.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 1118689..0fe638f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -182,7 +182,7 @@ static int builtin_diff_combined(struct rev_info *r=
evs,
 		hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
 			   revs->dense_combined_merges, revs);
-	free(parent);
+	free((void *)parent);
 	return 0;
 }
=20
diff --git a/submodule.c b/submodule.c
index 0fd10a0..52cdcc6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -391,7 +391,7 @@ static void commit_need_pushing(struct commit *comm=
it, struct commit_list *paren
 	rev.diffopt.format_callback_data =3D needs_pushing;
 	diff_tree_combined(commit->object.sha1, parents, n, 1, &rev);
=20
-	free(parents);
+	free((void *)parents);
 }
=20
 int check_submodule_needs_pushing(unsigned char new_sha1[20], const ch=
ar *remotes_name)
--=20
1.7.6.3
