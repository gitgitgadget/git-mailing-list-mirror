From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 07/36] unpack-trees: plug a memory leak
Date: Sun,  9 Jun 2013 14:24:21 -0500
Message-ID: <1370805890-3453-8-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllGq-0003Pb-QN
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab3FIT1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:11 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54340 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab3FIT1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:04 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so8941302obc.24
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1Cb0JfJlFAmY+YA3pVltyBcamT4PzZ6kfREbtSsjqVM=;
        b=rUz+3s/mx1hhw2AKGo14r9vliHsG+ilhO01Th7D+0q4Zgf/Sh1xMVpO5sucip8Ta5o
         u75uWq/aXdxI4wzxjPLFVSWtpbsR3rqfVP/8BPbx64fsx1BqwJwBliBm4Bi0EZPn7Xjt
         VhKTRpTQTQwhtULuXgviOjMmDukIELNrBkwmWRvdVBkABLRyBaorSphKGk17LRz7D3Ox
         TBmMmhYCGFuXZPa2nVdVWgM8OJ/8yfiWQV1Bl890KCjZ4Sg/iYjE/LK/YO92E5yVe7IJ
         k0Uan39CkbJV9E7/gDBRuwGO1qdYTE1VLCwss+Bs5FC0XJt8Jia/J7erM0bSX50K8+AQ
         daLw==
X-Received: by 10.182.129.129 with SMTP id nw1mr5581922obb.100.1370806023680;
        Sun, 09 Jun 2013 12:27:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ei16sm16240770oeb.7.2013.06.09.12.27.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227117>

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
