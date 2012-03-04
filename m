From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/10] fsck: use streaming interface for writing lost-found blobs
Date: Sun,  4 Mar 2012 19:59:56 +0700
Message-ID: <1330865996-2069-11-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:03:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B6C-0003vL-K6
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab2CDNDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:03:36 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:48065 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab2CDNDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:03:35 -0500
Received: by dadp12 with SMTP id p12so3848457dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:03:35 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.191.230 as permitted sender) client-ip=10.68.191.230;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.191.230 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.191.230])
        by 10.68.191.230 with SMTP id hb6mr36350750pbc.87.1330866215562 (num_hops = 1);
        Sun, 04 Mar 2012 05:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0X15X4VjzbtB5ja1b/td8t+tOl22WVvsptXhWQUGQW4=;
        b=GGPQyl3fub04Ev8YkyNLbN3bCTcePFwNksgMH7aPUbaNw8WESCeAyOMGPlUFAZkbi0
         8183Ey11SDPopDH7xGc5XBv7IW81Ra9DNLOhUd9j/7Zso7mJJlFZLowGPFiDIRNHPNut
         7ihipTW2PkDej/extH4xZV24eSOOqPgS9ykP+QFgBje0SFYhCpGPepzmQglcyMisIQaV
         toRK8t5Qr7Bgmq73kVwGylmnQF3w0YDCZcbN00qx/wdVe7KvKQ0hCAm5Ao3Y7CAVDlGk
         +NLrdjpyQ8VPwmGAuHvxkz9gTPPKOYLlzXKGSMgNuThCCNHV2dAkS53knZ2fXc508KT3
         SQ7Q==
Received: by 10.68.191.230 with SMTP id hb6mr30991551pbc.87.1330866215516;
        Sun, 04 Mar 2012 05:03:35 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id z10sm10429263pbq.55.2012.03.04.05.03.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:03:34 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 20:01:28 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192161>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fsck.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8c479a7..7fcb33e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "dir.h"
 #include "progress.h"
+#include "streaming.h"
=20
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -236,13 +237,8 @@ static void check_unreachable_object(struct object=
 *obj)
 			if (!(f =3D fopen(filename, "w")))
 				die_errno("Could not open '%s'", filename);
 			if (obj->type =3D=3D OBJ_BLOB) {
-				enum object_type type;
-				unsigned long size;
-				char *buf =3D read_sha1_file(obj->sha1,
-						&type, &size);
-				if (buf && fwrite(buf, 1, size, f) !=3D size)
+				if (stream_blob_to_fd(fileno(f), obj->sha1, NULL, 1))
 					die_errno("Could not write '%s'", filename);
-				free(buf);
 			} else
 				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
 			if (fclose(f))
--=20
1.7.8.36.g69ee2
