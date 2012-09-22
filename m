From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] graph: avoid infinite loop in graph_show_commit()
Date: Sat, 22 Sep 2012 21:24:40 +0700
Message-ID: <1348323880-3751-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 16:24:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFQdV-0002Dn-6Q
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 16:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab2IVOYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 10:24:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33075 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab2IVOYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 10:24:36 -0400
Received: by pbbrr4 with SMTP id rr4so4527013pbb.19
        for <git@vger.kernel.org>; Sat, 22 Sep 2012 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=HfII4bcM7CDh/0jvbpc2wjDBk9TWm+2gtRm7Aj6zbxw=;
        b=B0r1i6AZlgax/aLbWrZSlbLHeP70W4Oii+VDdsExxWd/XdMbHEsk6oRWjwByK7UjbC
         Hs1CxAPIL4STE1Xg6SMRYwZB2B3KpW2H11L+XuBE8SgndJpXV7C+RK2TTES4qJtbxD1+
         V9aSBSSllq3meGKMB9i8JnAAwG2SmELeW1FiR3vslNvIn0HIXMFfidyCd8CardutzVqE
         y+bJB70V8T5YZcqAJP+pOMlpFCPQ+jRiQrPIw6Nk+0k6xbnkbZoQ8dCm2O+YmScrK+IG
         cCfmNl8wv34UYZiGG+6G6qISTbvsf1uyi2Nn8TZlqHcdPU+Vm+COAVDLvECWKy3HbVR7
         pXmg==
Received: by 10.66.76.231 with SMTP id n7mr20378882paw.68.1348323875954;
        Sat, 22 Sep 2012 07:24:35 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id m9sm5771513paw.16.2012.09.22.07.24.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Sep 2012 07:24:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 21:24:46 +0700
X-Mailer: git-send-email 1.7.12.1.389.gc2218b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206205>

The loop can be triggered with "git diff-tree --graph commit" where
the commit is a non-merge. It goes like this

 - graph_show_commit
 - graph_next_line
 - graph_output_padding_line

The last function quits because graph->commit is NULL, but
graph_next_line() does not return "shown", so the loop in
graph_show_commit keeps going.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Corner case. Nobody sane would do that. But still worth plugging.

 graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index e864fe2..1735b26 100644
--- a/graph.c
+++ b/graph.c
@@ -1224,7 +1224,7 @@ void graph_show_commit(struct git_graph *graph)
 	struct strbuf msgbuf =3D STRBUF_INIT;
 	int shown_commit_line =3D 0;
=20
-	if (!graph)
+	if (!graph || !graph->commit)
 		return;
=20
 	while (!shown_commit_line) {
--=20
1.7.12.1.389.gc2218b5
