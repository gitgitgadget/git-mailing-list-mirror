From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] diff: turn off skip_stat_unmatch on "diff --cached"
Date: Sat, 25 Jan 2014 13:46:51 +0700
Message-ID: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
References: <20140123024525.B726248918@mail.valinux.co.jp>
 <1390632411-3596-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: iwamoto@valinux.co.jp, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 07:41:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6wwD-0000HS-0i
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 07:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbaAYGlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jan 2014 01:41:47 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:61047 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbaAYGla (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 01:41:30 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so4092445pab.9
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 22:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=b/gvRy+tpg7myagrSTXskCoN+KP7DsixKY3ojhTerCw=;
        b=W67ByQ6SdZJyGegnv/HcwqcaNw8phi0kemNvKiMZYypQsJJIN9Y8eAusvOMolaT935
         j6qhxyokKLmbPhUEHasR0mwDlLmcsjzB/xKPQr5sdfw79H2zocKOCwAL3Xg8bc+0bZqC
         uxuoU2hTSYGAOJaXylj9ZbklerhO+PPvcEiE/NS/tQ6C8jjZNicsNkd2Lgn240lH01xA
         Pe4LWoAcdknsLL7YnHu7XKDtuDV5jFaFdxEbDjwnK0XRDYQHRQW3IIO68ZlXSp/OpPhf
         qdI8hiQBBN2Ib6B/0dsi4yEfH+XLrPu/9xPq2KQ5R3Q7Axa9SBALdbQGEj+F05tZM50R
         sYTA==
X-Received: by 10.68.195.4 with SMTP id ia4mr18438096pbc.142.1390632089907;
        Fri, 24 Jan 2014 22:41:29 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id tu3sm25753185pab.1.2014.01.24.22.41.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 22:41:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 25 Jan 2014 13:47:04 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390632411-3596-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241064>

skip_stat_unmatch flag is added in fb13227 (git-diff: squelch "empty"
diffs - 2007-08-03) to ignore empty diffs caused by stat-only
dirtiness. In "diff --cached" case, stat is not invovled at all. While
the code is written in a way that no expensive I/O is done, we still
need to move all file pairs from the old queue to the new queue in
diffcore_skip_stat_unmatch(). Avoid it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0f247d2..85f97d7 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -150,9 +150,10 @@ static int builtin_diff_index(struct rev_info *rev=
s,
 			perror("read_cache_preload");
 			return -1;
 		}
-	} else if (read_cache() < 0) {
-		perror("read_cache");
-		return -1;
+	} else {
+		if (read_cache() < 0)
+			return error("read_cache: %s", strerror(errno));
+		revs->diffopt.skip_stat_unmatch =3D 0;
 	}
 	return run_diff_index(revs, cached);
 }
--=20
1.8.5.2.240.g8478abd
