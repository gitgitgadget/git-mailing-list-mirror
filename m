From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/32] resolve-undo: be specific what part of the index has changed
Date: Fri, 13 Jun 2014 19:19:29 +0700
Message-ID: <1402661991-14977-11-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:21:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQTs-0003FG-GV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbaFMMVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:21:09 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60320 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbaFMMVI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:21:08 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so825265pad.21
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Q0X2hHtVFGI0jsjMgJ2vnPbnO8EtlyK9axt//fafs5U=;
        b=RJG9mPA0iyjycrNfY+13kL4/M5HrzxfUi0F82I49sclb5+QGyTtqgKiq+FTpmkkf65
         j+1DZaBXKyRfI9tX1lTHdxc4QW0Qg+Q6QAmGujl31HYzANu5DwRVKWZ07qkp38DZ0CIM
         vCdk117lx9rj+mz0WiyDonrFWJ1YXbHl5Nq8WXk1SHOZhx5ZP2CuLCtILx+cZIFvSX8Q
         ErFn1yVPo0c7+MLeBqNKAMQWJ3myQvZ6w6vv8JUCcuejHdJfCxf/gaUzMj/s1ajLQBiM
         SbLdzWFdyk1qm4bDRzCJCFTB5m/gkewf057ZWMHAg82skT/IPr9ui5nEViLDWhe3BPgK
         sY3Q==
X-Received: by 10.66.172.229 with SMTP id bf5mr2787447pac.57.1402662067793;
        Fri, 13 Jun 2014 05:21:07 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id kh4sm3385725pbc.64.2014.06.13.05.21.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:21:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:21:07 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251566>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h        | 1 +
 resolve-undo.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 31d4541..976f2e0 100644
--- a/cache.h
+++ b/cache.h
@@ -272,6 +272,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define CE_ENTRY_CHANGED	(1 << 1)
 #define CE_ENTRY_REMOVED	(1 << 2)
 #define CE_ENTRY_ADDED		(1 << 3)
+#define RESOLVE_UNDO_CHANGED	(1 << 4)
=20
 struct index_state {
 	struct cache_entry **cache;
diff --git a/resolve-undo.c b/resolve-undo.c
index e9dff57..468a2eb 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -110,7 +110,7 @@ void resolve_undo_clear_index(struct index_state *i=
state)
 	string_list_clear(resolve_undo, 1);
 	free(resolve_undo);
 	istate->resolve_undo =3D NULL;
-	istate->cache_changed =3D SOMETHING_CHANGED;
+	istate->cache_changed |=3D RESOLVE_UNDO_CHANGED;
 }
=20
 int unmerge_index_entry_at(struct index_state *istate, int pos)
--=20
1.9.1.346.ga2b5940
