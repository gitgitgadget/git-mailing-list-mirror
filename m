From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] ls-files: support -o --max-depth (more of a hack as fill_directory should support this)
Date: Fri,  8 Jan 2010 00:07:55 +0700
Message-ID: <1262884076-12293-3-git-send-email-pclouds@gmail.com>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 18:09:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvrJ-0003TN-OO
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0AGRJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 12:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393Ab0AGRJP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:09:15 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:53624 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab0AGRJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:09:13 -0500
Received: by mail-yx0-f188.google.com with SMTP id 26so17848817yxe.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 09:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=m10z74jcZ/rad/Y9olURwIXAlMOi3AFAQRAKg9O/OMc=;
        b=nEkG7ZMr3Wot2erjT3Eu8yUE6qr7KD6Mu8iBDStu37DlhVq5WWdnPC/rZCHMFtDlbz
         MYl8YVKUs7+LAy+ii1O+sanZq3zWBDJ7ago3e23eqtIHLvbxmT6uofTULt6N2MNgAPIs
         6um4l+y1CTL3NzhEZgBvrXQaZyP5cn7uZg4z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AEDg2XAvTsUKcsfC9qgWfPbNNueVV5v1i7OF26qAqlbbiKrU8BdJp7LwAM+pz6S1EF
         eFC0GcclT064D0O+Fequtg2ShfyPPMe2PCYubJPlnZGW0M4uwBDXMQzqvoOKgm2cJlWB
         SHnPgpbmlf/VL8QUziAMLHs7khDnALT0DSICM=
Received: by 10.90.16.31 with SMTP id 31mr1119236agp.42.1262884153472;
        Thu, 07 Jan 2010 09:09:13 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 14sm10773034gxk.14.2010.01.07.09.09.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 09:09:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri,  8 Jan 2010 00:08:25 +0700
X-Mailer: git-send-email 1.6.6.315.g1a406
In-Reply-To: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136362>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 2bb851a..e16638e 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -51,6 +51,17 @@ static void show_dir_entry(const char *tag, struct d=
ir_entry *ent)
 	if (!match_pathspec(pathspec, ent->name, ent->len, len, ps_matched))
 		return;
=20
+	if (max_depth) {
+		int slashes =3D 0;
+		const char *entry =3D ent->name + prefix_offset;
+		while ((entry =3D strchr(entry, '/')) !=3D NULL) {
+			slashes++;
+			if (slashes >=3D max_depth)
+				return;
+			entry++;
+		}
+	}
+
 	fputs(tag, stdout);
 	write_name_quoted(ent->name + offset, stdout, line_terminator);
 }
--=20
1.6.6.315.g1a406
