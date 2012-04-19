From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH nd/threaded-index-pack] index-pack: disable threading if NO_PREAD is defined
Date: Thu, 19 Apr 2012 21:05:29 +0700
Message-ID: <1334844329-24557-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 16:08:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKs2Z-0002mC-MI
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 16:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab2DSOIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 10:08:51 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:36118 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab2DSOIv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 10:08:51 -0400
Received: by dake40 with SMTP id e40so11428274dak.11
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=/mWYffq97asfg1iymWKN8uMoUs99atrXkEA0edywL7o=;
        b=bERwbaKNvkGChESa0iwJdM7rCY2fPCrgushgbburtWkNx9vb5WAdeTO8P8x+/x9wtJ
         jz45PKDuF5RJM8sPOR8umDnCgXyzG992jOMHl8pr7aPnK7ZkKCzDnYY7kbbZBtAovUX7
         ByAM3+n6zmoKMrGX18pNKu5zaLbUAF7xcJLESrhLp3EdExb43IDlEXa4lpMpTwjxJhyr
         zsxpNwITvxQK3tT8GnctP8OcxLD9+vFUGi3wYQcPkVfn3axCQieiG5mPPrME0Cd/B6MC
         izyB0ZjrdbcvD2EwJ0Ux7Ij5OadwV39t8l8bD9/+eX6gs6hJ2RKz300Fhfu0np7GGG8h
         mzmw==
Received: by 10.68.201.73 with SMTP id jy9mr5025862pbc.35.1334844530635;
        Thu, 19 Apr 2012 07:08:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.39.247])
        by mx.google.com with ESMTPS id i5sm2358288pbf.19.2012.04.19.07.08.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 07:08:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 19 Apr 2012 21:05:36 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195947>

NO_PREAD simulates pread() as a sequence of seek, read, seek in
compat/pread.c. The simulation is not thread-safe because another
thread could move the file offset away in the middle of pread
operation. Do not allow threading in that case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 847dbb3..c1c3c81 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -39,6 +39,11 @@ struct base_data {
 	int ofs_first, ofs_last;
 };
=20
+#if !defined(NO_PTHREADS) && defined(NO_PREAD)
+/* NO_PREAD uses compat/pread.c, which is not thread-safe. Disable thr=
eading. */
+#define NO_PTHREADS
+#endif
+
 struct thread_local {
 #ifndef NO_PTHREADS
 	pthread_t thread;
--=20
1.7.8.36.g69ee2
