From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] shallow: only add shallow graft points to new shallow file
Date: Fri, 16 Aug 2013 16:52:03 +0700
Message-ID: <1376646727-22318-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
 <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 11:52:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGhm-0007oW-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab3HPJwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 05:52:22 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:51452 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab3HPJwV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:52:21 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so2054268pdi.14
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D1cvtXtUiSiItmjrNZlqdvZu+tMaInqA6ZOiUoGcx6g=;
        b=KsJqHegvwklVt97bwnjZVAeRR+NdTzSBlYM6TRK576X7BDjxF377bm7A7tYsUbmh3f
         hyUy32wOTAFvOpCZL5dAK6bFNinQG+IplCRRkenCMNmT9KMmfSuRDnUrKXWPz2gTUzwy
         STdhtJ4TzjQoAeRcQ07RigH88HYEuJGAHP08RSC6VMc04AThpQDZpx24P53u+AuMRKBr
         02amh82ZwWbMsTTpeRUvfXg1V1GvqdxNnGnWRg/WqNvzKLZeDryFo+1bNCru4JHNHsXt
         TVzOm2Xb8hyUk71HYj+HhdWSJwKwVMsLiMga1/BPLaDBYwxvdZn/3Prgkk4BZ4qR7Lk2
         6BLA==
X-Received: by 10.68.2.69 with SMTP id 5mr677662pbs.124.1376646741490;
        Fri, 16 Aug 2013 02:52:21 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id fk4sm2327396pab.23.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 02:52:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 16 Aug 2013 16:52:15 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232409>

for_each_commit_graft() goes through all graft points and shallow
boudaries are just one special kind of grafting. If $GIT_DIR/shallow
and $GIT_DIR/info/grafts are both present, write_shallow_commits may
catch both sets, accidentally turning some graft points to shallow
boundaries. Don't do that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 shallow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/shallow.c b/shallow.c
index 68dd106..5f626c0 100644
--- a/shallow.c
+++ b/shallow.c
@@ -153,6 +153,8 @@ static int write_one_shallow(const struct commit_gr=
aft *graft, void *cb_data)
 {
 	struct write_shallow_data *data =3D cb_data;
 	const char *hex =3D sha1_to_hex(graft->sha1);
+	if (graft->nr_parent !=3D -1)
+		return 0;
 	data->count++;
 	if (data->use_pack_protocol)
 		packet_buf_write(data->out, "shallow %s", hex);
--=20
1.8.2.82.gc24b958
