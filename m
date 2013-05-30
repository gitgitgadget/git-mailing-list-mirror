From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] unpack-trees: plug a memory leak
Date: Thu, 30 May 2013 06:58:55 -0500
Message-ID: <1369915136-4248-4-git-send-email-felipe.contreras@gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 14:01:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1XY-0001Vv-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab3E3MBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:01:04 -0400
Received: from mail-gg0-f176.google.com ([209.85.161.176]:60586 "EHLO
	mail-gg0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3E3MAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:00:49 -0400
Received: by mail-gg0-f176.google.com with SMTP id b1so22941ggm.7
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ju/PSs2IuTO3UBthuwQ5hwDPYAcW6bfM3d2mDN4wWWY=;
        b=KRdl+jlSsG7UbxR/j64qS6TFLaxASNejXlSFygyMbif5tSwFPfpksmxgGXld0/0LMe
         BDjnpoB9XWRtI/RBtvxNaonNguxeFT5E0/PVqCTYQINqCNav5FFF+csGCoGk+GQEkoSW
         03UsHq7sSI8pJUQn0WwUp4S9v03fy7eI1jlGEpv7eCkZeF0E0vvWgdFpiCbQPItaTLyO
         MYRWTI2eCeuJMDM7FjyPz9oZb8EHyNCTS/u/NObfi4LXdQO82HOtSWfs+0WNKcXNhMas
         R05BCPWdma6OVB6bI+czh0EbV8WFD9T06F9Loa+zZqGj8I2KWyI7oGQ0uLeVh6PHnHYJ
         LEUQ==
X-Received: by 10.236.113.33 with SMTP id z21mr3466484yhg.143.1369915248303;
        Thu, 30 May 2013 05:00:48 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id f71sm59424186yha.8.2013.05.30.05.00.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 05:00:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225971>

Before overwriting the destination index, first let's discard it's
contents.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 unpack-trees.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index ede4299..eff2944 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1146,8 +1146,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
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
1.8.3.rc3.312.g47657de
