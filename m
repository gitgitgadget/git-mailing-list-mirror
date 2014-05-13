From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] read-cache--daemon: do not read index from shared memory
Date: Tue, 13 May 2014 18:15:35 +0700
Message-ID: <1399979737-8577-9-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:16:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAhK-0000jn-0b
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760989AbaEMLQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:16:28 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:56975 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbaEMLQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:16:27 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so165962pbb.28
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HbhSnp+t0ObB/JV/ih0096pSx9rI2ESc24JmTs0kOGE=;
        b=RcIqJc/smm3LRF/e5KaQF3SypqSDtBsiwO/I3it1WZOtnuXcNVr25aRmM38Bv3xH7K
         vTBQGWe4pPqidJ6d0s94MYYpWgKikLQoWrbYTnlkRmdL7nPG5eJ0i+X8UaAp+e6a0zWz
         mUsMppvtTEoTcGv6xDF674CUn6NMd0a3m5iXh07pxE37qkk2vPCgLFPmnIs+Ajz7DlRz
         uDXUwlzFR9AIyv2lYfmNLijvXU/Lj7U1kL1nXcxlBSp/MnowuiXDHWUPd0IIY/xh1jd2
         NuO+dGQpSfl24KBSrQHY4Eb8Dp5iBCFOOjgRJf5ovTgGIbd924DEuK0IArxBjAzuudOQ
         qrfg==
X-Received: by 10.68.143.231 with SMTP id sh7mr4423477pbb.7.1399979786597;
        Tue, 13 May 2014 04:16:26 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id hk5sm27685467pbb.86.2014.05.13.04.16.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:16:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:16:32 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248768>

It does not hurt doing that. But it does not help anybody either.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache--daemon.c | 1 +
 read-cache.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache--daemon.c b/read-cache--daemon.c
index 4531978..bd6d84f 100644
--- a/read-cache--daemon.c
+++ b/read-cache--daemon.c
@@ -145,6 +145,7 @@ static void serve_cache(const char *socket_path, in=
t detach)
 	if (fd < 0)
 		die_errno("unable to bind to '%s'", socket_path);
=20
+	use_read_cache_daemon =3D -1;
 	refresh();
 	if (detach && daemonize(&daemonized))
 		die_errno("unable to detach");
diff --git a/read-cache.c b/read-cache.c
index 0e46523..4041485 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1470,7 +1470,7 @@ static void *try_shm(void *mmap, size_t *mmap_siz=
e)
 	struct stat st;
 	int fd;
=20
-	if (old_size <=3D 20 || !use_read_cache_daemon)
+	if (old_size <=3D 20 || use_read_cache_daemon <=3D 0)
 		return mmap;
=20
 	strbuf_addf(&sb, "/git-index-%s.lock",
--=20
1.9.1.346.ga2b5940
