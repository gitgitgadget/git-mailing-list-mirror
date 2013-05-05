From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Sun,  5 May 2013 17:38:53 -0500
Message-ID: <1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 06 00:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ7bd-0006pc-Kp
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 00:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab3EEWkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 18:40:25 -0400
Received: from mail-gg0-f181.google.com ([209.85.161.181]:60240 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab3EEWkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 18:40:24 -0400
Received: by mail-gg0-f181.google.com with SMTP id q1so552661ggm.40
        for <git@vger.kernel.org>; Sun, 05 May 2013 15:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2coHU4qLN0I9x/JLq6zxmeN9QR5kwmJ0ARUAG+U4R8A=;
        b=0ctpQbm4DjM88GT+rrOFiv42YjxEvAwfJzKnZ3xHDG2Vxsro0tUmG2JYaDBw4cpgFU
         h9GMS9pWjYtGj/IDmRGHoq76zhMcCGHg3+l1/tchyIOo1TnzP+17JPuK0N0z9CYrLXrV
         E9APmuFGXUTGSLGAudYSy0jSf+OPE/VVDqaPMBuC/+6Omrk8uIYKqb/Z7CRvvUMnK+vP
         EZSeD2KcVPUGIe+qhIg+adaV/JiXF9NCrsPrr+AU2ZBiNPb52GSEMwqqRsdkTFm0yZcF
         Q7a7gEDlZeDl81/hEAr2Gx2HTHySKnhy/FTxnoPs7d2toIKAsaCJKaoaKQdR1RWBINSo
         rh7w==
X-Received: by 10.236.112.73 with SMTP id x49mr16219215yhg.145.1367793624268;
        Sun, 05 May 2013 15:40:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id a24sm4636361yho.24.2013.05.05.15.40.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 05 May 2013 15:40:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223423>

We don't care about blobs, or any object other than commits, but in
order to find the type of object, we are parsing the whole thing, which
is slow, specially in big repositories with lots of big files.

There's no need for that, we can query the object information with
sha1_object_info();

Before this, loading the objects of a fresh emacs import, with 260598
blobs took 14 minutes, after this patch, it takes 3 seconds.

This is the way fast-import does it. Also die if the object is not
found (like fast-import).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a4dee14..a5b8da8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -613,6 +613,7 @@ static void import_marks(char *input_file)
 		char *line_end, *mark_end;
 		unsigned char sha1[20];
 		struct object *object;
+		enum object_type type;
 
 		line_end = strchr(line, '\n');
 		if (line[0] != ':' || !line_end)
@@ -627,17 +628,19 @@ static void import_marks(char *input_file)
 		if (last_idnum < mark)
 			last_idnum = mark;
 
-		object = parse_object(sha1);
-		if (!object)
+		type = sha1_object_info(sha1, NULL);
+		if (type < 0)
+			die("object not found: %s", sha1_to_hex(sha1));
+
+		if (type != OBJ_COMMIT)
+			/* only commits */
 			continue;
 
+		object = parse_object(sha1);
+
 		if (object->flags & SHOWN)
 			error("Object %s already has a mark", sha1_to_hex(sha1));
 
-		if (object->type != OBJ_COMMIT)
-			/* only commits */
-			continue;
-
 		mark_object(object, mark);
 
 		object->flags |= SHOWN;
-- 
1.8.3.rc0.401.g45bba44
