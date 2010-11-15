From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/10] unpack-trees: optimize full checkout case
Date: Mon, 15 Nov 2010 17:36:45 +0700
Message-ID: <1289817410-32470-6-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:39:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwTL-00026P-1r
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657Ab0KOKjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:39:31 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35059 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab0KOKjb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:39:31 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so922891pva.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lHQe4uAnPeiBX8/owm8FZz9P57OUd6ldzQgAOTbD60M=;
        b=izsCOqIzfQiH5drC7IfpdPEo+jaZKW6FV2Kv0tT5rI7nTD4BluanxzaIMELzze7buX
         wA+NNl4iSOK7aLFi4PmESOnkkAw5xFmme4QnigQohF3fhdUe40QPsMYLndeaqU7MWgcW
         x4ER0sg6vNNtO4YDkJJecxeqpZsPPHtVyDiCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=C7Ic+HQ96ZXfugHTX2mYFN40+ZtpPprfqEnN2FIRuAIhmkXI4X6v7tkiuWxnmec+e5
         mv11Zvscu2tCoaUmlDtFV5RDbOQBZbTpqoJ2OyKeBaCV5n1MtKFxiaxEj4hCLZLOLizx
         kf53vlohvnIgrbHcAjAN+D7krBdxsDXRO27tc=
Received: by 10.142.224.11 with SMTP id w11mr4934183wfg.126.1289817570917;
        Mon, 15 Nov 2010 02:39:30 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id w31sm947270wfd.2.2010.11.15.02.39.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:39:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:38:13 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161482>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f005454..eb5d357 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -996,6 +996,16 @@ int unpack_trees(unsigned len, struct tree_desc *t=
, struct unpack_trees_options
 			o->el =3D &el;
 	}
=20
+	if (!o->skip_sparse_checkout &&
+	    o->el->nr =3D=3D 1 &&
+	    !strcmp(o->el->excludes[0]->pattern, "*")) {
+		for (i =3D 0; i < o->src_index->cache_nr; i++)
+			if (ce_skip_worktree(o->src_index->cache[i]))
+				break;
+		if (i =3D=3D o->src_index->cache_nr)
+			o->skip_sparse_checkout =3D 1;
+	}
+
 	if (!o->skip_sparse_checkout)
 		set_new_skip_worktree_1(o);
=20
--=20
1.7.3.2.210.g045198
