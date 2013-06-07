From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/2] unpack-trees: plug a memory leak
Date: Fri,  7 Jun 2013 17:29:27 -0500
Message-ID: <1370644168-4745-2-git-send-email-felipe.contreras@gmail.com>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5By-0006R0-KX
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab3FGWbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:31:22 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:61898 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762Ab3FGWbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:31:21 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so3921454oag.14
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1Cb0JfJlFAmY+YA3pVltyBcamT4PzZ6kfREbtSsjqVM=;
        b=fN6nC7tT09DgITLBGIzyrzaGI20nOhsB/j+dX1pjkJl7NuLW5/d0zGXQNxPDke3wad
         hM2eOtM/yuuRNueX54w9qwsF17lVUOPR3mpdWBE8s7rnQSDhiYavxQcpFBhwetTI+NI5
         mpitYaUQ6rACIB0HEE3TU8VO0rN1iMTgsvhLUZbU9SWuBPaGKkOlQMUzd+s0Cf/XK3ii
         k2hC2gOR4u+/ScOMnYA8hz3/aqHTKKSjTDc/uAdborIiUYxf7Wvo2tenIotUzJtTBclQ
         hJqAX1Ia0+EXDBUIDXmQIQw9RZ83Bb0U7zUWIbhVSnq4wQhLTXlG42yW/8l1acUoKhm0
         Ew3Q==
X-Received: by 10.182.65.100 with SMTP id w4mr492003obs.70.1370644281268;
        Fri, 07 Jun 2013 15:31:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm965187oby.12.2013.06.07.15.31.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:31:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226757>

Before overwriting the destination index, first let's discard its
contents.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 unpack-trees.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 57b4074..abe2576 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1166,8 +1166,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	o->src_index = NULL;
 	ret = check_updates(o) ? (-2) : 0;
-	if (o->dst_index)
+	if (o->dst_index) {
+		discard_index(o->dst_index);
 		*o->dst_index = o->result;
+	}
 
 done:
 	clear_exclude_list(&el);
-- 
1.8.3.698.g079b096
