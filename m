From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v3 1/5] apply: Don't unnecessarily update line lengths in
 the preimage
Date: Sat, 27 Feb 2010 14:51:58 +0100
Message-ID: <4B89237E.4030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 14:52:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlN5W-0006uK-GE
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 14:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968339Ab0B0NwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 08:52:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:34354 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968320Ab0B0NwB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 08:52:01 -0500
Received: by ey-out-2122.google.com with SMTP id 25so68292eya.5
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 05:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=EOCwsH1L+7MZ92PnTl/UmXUPo6RGepbAhjgJJfm50m4=;
        b=PuqJKDlg/1c36NssqtPrrr2FKj6d3fpuYWO2nwUn308HMp5OCu/pyRSeC8ercgIStF
         AGZIVcaOdRJJAPryc/OnypaubF24yh7fks0RKeX4fMHLH+0+0tSb0o0o+LhVSIwLKy/l
         0joUjkKiel670d0a6WnCS1oIouer6JFBkFQpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=vc8FVTtoiMcHfQqsn7OwY/RO03VCasj00A/+SRBRN97b5OMXRfvHpxUR93bCAlmdki
         AyaF6ejtP+TchHCEqPTBf8kTKVKmsFFNpcU3kezcT5kZUUIhs29YMmHKB3nZ9//K1by9
         9XEdfcseUFXtpLwx3ibU5zQVMI+vD2OhSF9lA=
Received: by 10.213.67.141 with SMTP id r13mr1200701ebi.93.1267278720386;
        Sat, 27 Feb 2010 05:52:00 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm5006524eyf.3.2010.02.27.05.51.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 05:51:59 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141207>

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
