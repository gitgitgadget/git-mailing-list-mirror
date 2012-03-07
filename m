From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] fsck: use streaming API for writing lost-found blobs
Date: Wed,  7 Mar 2012 17:54:20 +0700
Message-ID: <1331117661-19378-7-git-send-email-pclouds@gmail.com>
References: <7vty21twqc.fsf@alter.siamese.dyndns.org>
 <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 11:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5EUz-0003DF-H9
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 11:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487Ab2CGKxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 05:53:35 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41429 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab2CGKxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 05:53:34 -0500
Received: by mail-pw0-f46.google.com with SMTP id un15so415256pbc.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 02:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sEnAQO9C9Cfcc5tsVhsLL+4v+8BJ3qHzeqVgQeBQ1pI=;
        b=v66RCEzweiq06O0RZYc7rR9dYjCclv1yHCanlRyDrMNE506avTHn2pH2af/sNIbfOZ
         E4UzMQoql/ML5QBxJNq8L5l0aM5j88ithq49GBwrA3Y34cn+Q9WslPC4SzyNPQ/fiY1p
         GbqxSUPE7QeJrQ2A9WlwvZWaEK3NAiuT0Sj3318QRM0KY0QnWeD52ySV3xDDYusfxqgR
         EB7ajLzOArjV2JTLUVX8K+5WAxn9mI5yhFQZtP4ttyJYAOoy1BtWScfX9li3nb5j81bs
         Z9nMioWLEE+i7FpBbKC7z9SJ8A+//h5Tp/S8IUGrhE+mfMxqIcRfra2BI+nNuAInXEUa
         u8Xw==
Received: by 10.68.224.225 with SMTP id rf1mr3022905pbc.133.1331117613789;
        Wed, 07 Mar 2012 02:53:33 -0800 (PST)
Received: from tre ([115.74.59.10])
        by mx.google.com with ESMTPS id u9sm581095pbj.39.2012.03.07.02.53.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 02:53:32 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 07 Mar 2012 17:55:04 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192441>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fsck.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 67eb553..a710227 100644
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
@@ -238,13 +239,8 @@ static void check_unreachable_object(struct object=
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
