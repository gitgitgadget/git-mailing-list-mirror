From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v4 1/5] apply: Don't unnecessarily update line lengths in
 the preimage
Date: Sat, 06 Mar 2010 15:30:21 +0100
Message-ID: <4B9266FD.1060103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 21:59:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No1Zu-0006gY-Ti
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0CFOa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 09:30:26 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:64796 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0CFOaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 09:30:25 -0500
Received: by wwa36 with SMTP id 36so2555903wwa.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 06:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=EOCwsH1L+7MZ92PnTl/UmXUPo6RGepbAhjgJJfm50m4=;
        b=Rksm7IeJVzdfpnxyMEcGjVUx7/77ovqrlE8EPH4+BSa32BUNKk3H2Y+Z+qPVYX8nl8
         fEXyzVOCfHLKBrXweDqrHqgfYnGNJcRUK+bX3ctLIH1u22fIwAaXdGIJhVHOc+Ynx6j5
         hwnHY+Cg41tLcU5D0Uy70TL4ig3KuKjMHClCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=jVhFNHk69L+24RNHg7EgEHdiYDCNtRrD/qQA9Ry2bhV0erdohy4+rYQkVxJjOB2Luv
         UT1RU/Mfc4B0FS6+yUibhIJG1amRHRk3MabYhC4NRVWbPGO/9kOp9foDhUeDbxgx1c1F
         vOz22Rp6DqRGAjiJ2YgM3WX0wG50PNDqaGctY=
Received: by 10.216.87.146 with SMTP id y18mr1115183wee.127.1267885822837;
        Sat, 06 Mar 2010 06:30:22 -0800 (PST)
Received: from [10.0.1.10] (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 24sm986052eyx.10.2010.03.06.06.30.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 06:30:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141614>

In match_fragment(), the line lengths in the preimage are updated
just before calling update_pre_post_images(). That is not
necessary, since update_pre_post_images() itself will
update the line lengths based on the buffer passed to it.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-apply.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2a1004d..fc6c708 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1905,20 +1905,15 @@ static int match_fragment(struct image *img,
 		}
=20
 		/*
-		 * Ok, the preimage matches with whitespace fuzz. Update it and
-		 * the common postimage lines to use the same whitespace as the
-		 * target. imgoff now holds the true length of the target that
-		 * matches the preimage, and we need to update the line lengths
-		 * of the preimage to match the target ones.
+		 * Ok, the preimage matches with whitespace fuzz.
+		 *
+		 * imgoff now holds the true length of the target that
+		 * matches the preimage.  Update the preimage and
+		 * the common postimage context lines to use the same
+		 * whitespace as the target.
 		 */
 		fixed_buf =3D xmalloc(imgoff);
 		memcpy(fixed_buf, img->buf + try, imgoff);
-		for (i =3D 0; i < preimage->nr; i++)
-			preimage->line[i].len =3D img->line[try_lno+i].len;
-
-		/*
-		 * Update the preimage buffer and the postimage context lines.
-		 */
 		update_pre_post_images(preimage, postimage,
 				fixed_buf, imgoff, postlen);
 		return 1;
--=20
1.7.0
