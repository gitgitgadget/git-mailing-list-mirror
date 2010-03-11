From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/16] rev-parse --git-dir: print relative gitdir correctly
Date: Thu, 11 Mar 2010 20:22:21 +0700
Message-ID: <1268313754-28179-4-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMe-0001K7-AJ
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414Ab0CKNW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:22:59 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57809 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0CKNW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:22:57 -0500
Received: by pvb32 with SMTP id 32so5497pvb.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3mRPGqNBRDzqm8PL8NnSgpredVl9kPjfs+inGFNlTQA=;
        b=PVTWXbqkd0s+cY0yuA0lPQmH53tkzSiVuw2+8pINfCs7m0XM7cJXK6/Fo3DXj55012
         eBkRDcj1x5SWvp44gLJiHHL5FTyj8q0ooz0ZaTCGLV5xojM1+eLIE/tsBfjTUlWi+Tsk
         7/x52Ma/cLE1ffegWJexrd3Wr5QRkQlsWn8Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KMaHO7DUAikZe+hhUY+WkViDpv7av8nCyYTo11jpsCcsxcol9gN4+MZKNAFu9itaiu
         LYDR/BlnCN8Vm3lU+YiJtyDLsGT/ahIkdUWrH6Yhq3aCW9IuNR5egoTRSjhaX3Q23uv3
         vKMihr8L62RPAsH5ScWgSanmgx4hngu/LpSKg=
Received: by 10.142.121.12 with SMTP id t12mr1340670wfc.286.1268313776503;
        Thu, 11 Mar 2010 05:22:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 20sm2786031pzk.7.2010.03.11.05.22.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:22:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:22:51 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141965>

When git_dir is relative, it is relative to Git's current working
directory, which is worktree top directory. "git rev-parse --git-dir"
is expected to output relative to user's current working directory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rev-parse.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8fbf9d0..8819e8a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -646,6 +646,14 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				static char cwd[PATH_MAX];
 				int len;
 				if (gitdir) {
+					if (prefix && !is_absolute_path(gitdir)) {
+						int len;
+						if (!getcwd(cwd, PATH_MAX))
+							die_errno("unable to get current working directory");
+						len =3D strlen(cwd);
+						printf("%s%s%s\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "", g=
itdir);
+						continue;
+					}
 					puts(gitdir);
 					continue;
 				}
--=20
1.7.0.1.384.g6abcaa
