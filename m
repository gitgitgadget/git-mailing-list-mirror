From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] branch -v: align even when the first column is in UTF-8
Date: Fri, 24 Aug 2012 21:17:52 +0700
Message-ID: <1345817872-7943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 16:24:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4uny-0003BG-UP
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 16:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab2HXOYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 10:24:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49924 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247Ab2HXOYC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 10:24:02 -0400
Received: by pbbrr13 with SMTP id rr13so3562876pbb.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=LCwIyo1rFEOCZSa4Gz8tBC7nsvN20HZJ6/IyLGmZxLw=;
        b=T+ksuDnDKXquJ50rMi+oEFN4S9bj57sAQRjJxINCrLlDp6x8BbzEcc8onYL/MyO+in
         nHhb3ejyj65zfqr9G82f+2VEq0OxPdV/RwSrGgcr6Qq9x20Fvdj3GLEOr6QlP+zjUJxr
         iNQqikvWRuGcqJZAD3Sm7P5fUDMTQY9ezatgvWc/pXy27ZdQ1sgluHL1OlqZ9xy4/CQe
         L4alpIhIvJ7bCUZuE/eKTxwRs9ZgTNC6Zfn3zCSVcAgXtBc+3O3mng6PE0bCw4tOMGzK
         6V/lCMd00qLndHb3jdaP/1QkDilv/8xLHFv5f0ngG6td8D0vKRSaNUi27B3DovkyV84V
         dkmg==
Received: by 10.68.235.236 with SMTP id up12mr13312004pbc.79.1345818241879;
        Fri, 24 Aug 2012 07:24:01 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id pj8sm8398873pbb.60.2012.08.24.07.23.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Aug 2012 07:23:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Aug 2012 21:17:54 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204211>

Branch names are usually in ASCII so they are not the problem. The
problem most likely comes from "(no branch)" translation, which is in
UTF-8 and makes length calculation just wrong.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 So far all git translations are utf-8 compatible. Branch names may
 use filesystem encoding, but then packed-refs specifies no encoding.
 Anyway branch names should be in utf-8.. at least internally, imo.

 builtin/branch.c | 8 +++++---
 1 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 5 =C4=
=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 3 b=E1=BB=8B x=C3=B3a(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..7c1ffa8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -17,6 +17,7 @@
 #include "revision.h"
 #include "string-list.h"
 #include "column.h"
+#include "utf8.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -490,11 +491,12 @@ static void print_ref_item(struct ref_item *item,=
 int maxwidth, int verbose,
 	}
=20
 	strbuf_addf(&name, "%s%s", prefix, item->name);
-	if (verbose)
+	if (verbose) {
+		int utf8_compensation =3D strlen(name.buf) - utf8_strwidth(name.buf)=
;
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
-			    maxwidth, name.buf,
+			    maxwidth + utf8_compensation, name.buf,
 			    branch_get_color(BRANCH_COLOR_RESET));
-	else
+	} else
 		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
 			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
=20
--=20
1.7.12.rc2.18.g61b472e
