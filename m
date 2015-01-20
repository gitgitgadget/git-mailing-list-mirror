From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/24] untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
Date: Tue, 20 Jan 2015 20:03:24 +0700
Message-ID: <1421759013-8494-16-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:05:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYUk-0003rD-1D
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbbATNFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:05:15 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:44585 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbbATNFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:05:14 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so31338970pdj.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nfgMwmpbzx7gXhxcBkCd/dPZYQ8Md8tjSSPwX7lcCTY=;
        b=aKgRItfltg6ltJhW86GyHEX8zsjmuWHg7WBaFy0g1ZtP++HFTMyyXS5azj7dJgecpt
         G2qeyXUuAQnK9sETTqXZ18rdrbHFsvly9lQqQavH6LvOsm66Mn+PxHF6y040U1hcep1N
         5VGwyp1mVLwF0SACooRysUnctdvYSG5LcBVbuDbmIHOjOqWgSfBwKhSulfK8VPCL8qFC
         CFlhf17Rg3LBgTExnuNq8xV9e70JgLVEeAgzwy2xuZUdBzu3Bgdz/mJ5WvcaUGfLIf3l
         pdrR4NOm8fYsGnAZinUKrCjILrqqo4u4mT3xeD+bAhktoxbndNl5023YGuLDJQwqwsll
         yIPg==
X-Received: by 10.68.224.101 with SMTP id rb5mr53256900pbc.67.1421759113983;
        Tue, 20 Jan 2015 05:05:13 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id ig1sm2945402pbc.41.2015.01.20.05.05.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:05:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:05:23 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262667>

This could be used to verify correct behavior in tests

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dir.c b/dir.c
index 439ff22..c5ca5ce 100644
--- a/dir.c
+++ b/dir.c
@@ -1922,6 +1922,18 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const stru
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
+	if (dir->untracked) {
+		static struct trace_key trace_untracked_stats =3D TRACE_KEY_INIT(UNT=
RACKED_STATS);
+		trace_printf_key(&trace_untracked_stats,
+				 "node creation: %u\n"
+				 "gitignore invalidation: %u\n"
+				 "directory invalidation: %u\n"
+				 "opendir: %u\n",
+				 dir->untracked->dir_created,
+				 dir->untracked->gitignore_invalidated,
+				 dir->untracked->dir_invalidated,
+				 dir->untracked->dir_opened);
+	}
 	return dir->nr;
 }
=20
--=20
2.2.0.84.ge9c7a8a
