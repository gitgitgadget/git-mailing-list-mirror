From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/45] unpack-trees: plug a memory leak
Date: Sun,  9 Jun 2013 11:40:19 -0500
Message-ID: <1370796057-25312-8-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulii7-0006RE-N7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab3FIQnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:14 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:53154 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FIQnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:11 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so8795585obc.40
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1Cb0JfJlFAmY+YA3pVltyBcamT4PzZ6kfREbtSsjqVM=;
        b=U/fE5DiK9nYuNm3IMVYlm+TZHuld3Z0SrAUBRgyvdspTS4veH0y5SOsBoF/9A1CX+Y
         eVu/R0NxXrPopocq4lcC0FzoSEqAP2Xe3hekU+gU394E1QKMvjJuR5utJirutmYCls7x
         RYfHnAHU5wHBkIfZ/xo5tEaAfGNq91USxsXmADSRu++BgJjyrPGlSI9hgZz7ojCwQHGt
         F8N1j2kgGNDTLczgk9UDtNbvThFi92uWO275zC/9fwSLzvBxAAMSiPIeloOV/lEqBcqj
         V6VX5H97Gkuftk7VJ0pCcowFett/BFMMwAGc4ZdpCH1X1hiD9msgPF5qVBLMOjOmq53z
         ZqGA==
X-Received: by 10.182.84.193 with SMTP id b1mr5247092obz.68.1370796190883;
        Sun, 09 Jun 2013 09:43:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm15170627oez.4.2013.06.09.09.43.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226977>

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
