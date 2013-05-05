From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/3] fast-export: don't parse all the commits
Date: Sun,  5 May 2013 17:38:54 -0500
Message-ID: <1367793534-8401-4-git-send-email-felipe.contreras@gmail.com>
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
	id 1UZ7be-0006pc-4V
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 00:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab3EEWk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 18:40:29 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:53509 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab3EEWk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 18:40:28 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so622406yho.30
        for <git@vger.kernel.org>; Sun, 05 May 2013 15:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9fVohOwb/Jsu7s7fhuxipEeOXYcqmmaXo4NaNtu4ZZU=;
        b=aqAycdIYziuahzweibAXuZmzrF07eLyRFLy0Nw24Z8c8XwgG1A1fGughisu4G+2wPo
         Ra/2DMcOCt4sl+f9R5RaogPxv/odwtfbbaVTkFus3m/0CXspUBsNPRRKtv6+rvwGN/XO
         F3sMY1Xwi8Qb2a3yNuIikiglFcpQCHafSjhJKcgsv9DOJO91FA8g5aGJ47zdE89JDG2Y
         D2J5Ms5e09BrWfnFVTBrLfV0eMgLNGOEFDtPVFo5JOEdx/dPrFMpw8sYkwTbE0tRKMI5
         xlRvb1yku89t62xih3M9E9fPxPjZ1DwH6J2XVxVXEpY8KlRdaD2j2Tn+LR27y++9umL4
         4mdA==
X-Received: by 10.236.16.13 with SMTP id g13mr15991280yhg.103.1367793627663;
        Sun, 05 May 2013 15:40:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id l70sm42456770yha.1.2013.05.05.15.40.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 05 May 2013 15:40:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223424>

We don't need the parsed objects at this point, merely the information
that they have marks.

Seems to be three times faster in my setup with lots of objects.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a5b8da8..d1d68e9 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -613,6 +613,7 @@ static void import_marks(char *input_file)
 		char *line_end, *mark_end;
 		unsigned char sha1[20];
 		struct object *object;
+		struct commit *commit;
 		enum object_type type;
 
 		line_end = strchr(line, '\n');
@@ -636,7 +637,11 @@ static void import_marks(char *input_file)
 			/* only commits */
 			continue;
 
-		object = parse_object(sha1);
+		commit = lookup_commit(sha1);
+		if (!commit)
+			die("not a commit? can't happen: %s", sha1_to_hex(sha1));
+
+		object = &commit->object;
 
 		if (object->flags & SHOWN)
 			error("Object %s already has a mark", sha1_to_hex(sha1));
-- 
1.8.3.rc0.401.g45bba44
