From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] fast-export: improve speed by skipping blobs
Date: Thu,  2 May 2013 23:31:40 -0500
Message-ID: <1367555502-4706-3-git-send-email-felipe.contreras@gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 06:33:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY7gL-0004gt-DH
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 06:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab3ECEdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 00:33:11 -0400
Received: from mail-gg0-f176.google.com ([209.85.161.176]:58185 "EHLO
	mail-gg0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab3ECEdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 00:33:09 -0400
Received: by mail-gg0-f176.google.com with SMTP id o5so212689ggn.7
        for <git@vger.kernel.org>; Thu, 02 May 2013 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2coHU4qLN0I9x/JLq6zxmeN9QR5kwmJ0ARUAG+U4R8A=;
        b=ylG4DSRCc0aTD11YpnXspyeAUEPUekPzlrAUaRNNv/lYyQ/qpsMylhUhaoywFRW0u0
         zvMdQKxd15AaTeNfuHkiryMHcOXaCwSI/TQOpyowfJpEUl2HmBiZEdMtn2YjKeEL94Gi
         qVEw7lwqBj5xQU9AqXygN9JkO1sk/TyRjUxJ6aXLQUY5gUh7veKIQlBgNWkfIvd5lV7c
         cT38NAjiUVEYzJYq6dqeYLE73QbYRYAczSRY9t35uVxODBXoduxeb3fCdxxq8xvf8a1o
         vqFIlkvqkfl2q7y+g7EfiVIojy1AxE9TWojm+gRHl4mAMcK0WUvfSPyMDesEXW7WKYg2
         YMqA==
X-Received: by 10.236.28.38 with SMTP id f26mr7699268yha.32.1367555588929;
        Thu, 02 May 2013 21:33:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id y24sm13557666yhn.20.2013.05.02.21.33.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 21:33:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223277>

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
