From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] fast-import: only store commit objects
Date: Thu,  2 May 2013 23:31:42 -0500
Message-ID: <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 06:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY7gW-0004tz-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 06:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab3ECEdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 00:33:18 -0400
Received: from mail-gh0-f176.google.com ([209.85.160.176]:56481 "EHLO
	mail-gh0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3ECEdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 00:33:16 -0400
Received: by mail-gh0-f176.google.com with SMTP id z17so213129ghb.35
        for <git@vger.kernel.org>; Thu, 02 May 2013 21:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zT4ruzfwjUY68villdLVWWSBxc2w7Y65P4NEot2mykg=;
        b=DUi5g0vaghOuUplpDK/NhKoeTwkQEMOtf+6go3ljzlaoHk4btRa/I+f4DjDuIvsAdC
         SiSimZMpzBqGAS7f+Zn36PU8EGguspZvekfP7GzC2L+vNiAkvkSZR5zKRs+BIKztO7rf
         HrFlXds/ZGA+DBPilUFi4K3eWaMftuzaT5BTboyez+pmefcTzFKFMSEsAjC9sfZeJvTh
         Ea60Dwdf1iNyK94B2Jhuv63sAJwWdKkrsU/t/JIUvO7e6/3VCtLabCIDqe2kBkk0nk5e
         yFmfHAt98/Yvb6XWDzGQN2lK71z+Z4MPVEMzLhKj+3RJkb1WOoTSD4rZv9U6dWORxGac
         Zy8g==
X-Received: by 10.236.21.235 with SMTP id r71mr7332426yhr.193.1367555595865;
        Thu, 02 May 2013 21:33:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id e64sm18249041yhm.4.2013.05.02.21.33.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 21:33:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223279>

There's no point in storing blob, they would increase the time of
loading the marks, and the vast majority of them will never be used
again.

This also makes fast-export and fast-import marks compatible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 fast-import.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index e02f212..c583975 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1743,9 +1743,14 @@ static void dump_marks_helper(FILE *f,
 		}
 	} else {
 		for (k = 0; k < 1024; k++) {
-			if (m->data.marked[k])
+			if (m->data.marked[k]) {
+				struct object_entry *e;
+				e = m->data.marked[k];
+				if (e->type != OBJ_COMMIT)
+					continue;
 				fprintf(f, ":%" PRIuMAX " %s\n", base + k,
-					sha1_to_hex(m->data.marked[k]->idx.sha1));
+					sha1_to_hex(e->idx.sha1));
+			}
 		}
 	}
 }
-- 
1.8.3.rc0.401.g45bba44
