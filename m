From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/3] unpack-trees: plug a memory leak
Date: Thu, 30 May 2013 08:34:20 -0500
Message-ID: <1369920861-30030-3-git-send-email-felipe.contreras@gmail.com>
References: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui31r-0006yY-Pd
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278Ab3E3Ng2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:36:28 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:33917 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756390Ab3E3NgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:36:11 -0400
Received: by mail-yh0-f53.google.com with SMTP id f64so51746yha.40
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ju/PSs2IuTO3UBthuwQ5hwDPYAcW6bfM3d2mDN4wWWY=;
        b=tVsg1lgo5ekBQGwyosvzRmJz12kK3V2Mc3nRZm/foBpDs1pPYFQVSFZF+qTTjtuOis
         YyYQ7RoKFjA9sPkXYNtOwKvX51+g83ASPXLHQf/fGBbFTBEFKcqNHfaPcf0CzX5Jrl30
         BWSg+kE3dLN4iUoa5M2orrfIxaX+CuzkgIxo2+zpMS8QwWeWIWzwvj9Tp2h2DVDk9ULW
         jolE0dUc755ug19xuISvvXrJbSwr9Ce+LIWqYggjoa0mIr2zvRwiKtASvI3ePkUDsKeU
         llhj/8MT33FA64wTaZEd0zGT8ryT9aZjwMT+VggLSMCYpYPtW1GlAYr1RgdiFVmY3tPn
         3IfA==
X-Received: by 10.236.120.52 with SMTP id o40mr3750302yhh.58.1369920971033;
        Thu, 30 May 2013 06:36:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z65sm59987020yhc.9.2013.05.30.06.36.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:36:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225988>

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
