From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 01/26] rev-parse --git-dir: print relative gitdir correctly
Date: Tue, 16 Feb 2010 23:04:52 +0700
Message-ID: <1266336317-607-2-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:08:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPyD-00065B-4n
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883Ab0BPQIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:08:11 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684Ab0BPQII (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:08:08 -0500
Received: by yxe38 with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=54se3fvRuB4VRBlTM7GhOhqX/w5e6X13dmr4rAwL+os=;
        b=nEtAAFrp955yYT9Rj/h1okrBMHQLR0lMmc+uS9TQUO43JQWh6Kd31lUUHhuFsU3v2A
         ZiR2zRvStfcndFrmtcgJbMSJRw8LtK+/WyuhtyG9QETVkPkchwNSQehOxfsYevrRCpHC
         GkYQzOF1EqxXotpeQOMOpgHbCY/N/JZc9KwFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wv7vIeqWnfxUrf4f8m1MiNtRWJzWGaXQk83QigAeIyk0/GrXCfGccQ3i++vnRKoMtp
         S2tRcFW3gSH+pGL6TTH7dXODpzqaJwWzs7VEnDgZnqXz2hyxkxVm/RC19bogcbQTnpZ4
         rtwFF8GrPC60n/3QZN6GtTRVu53xmdcHI+9Tc=
Received: by 10.101.132.14 with SMTP id j14mr4648744ann.58.1266336487531;
        Tue, 16 Feb 2010 08:08:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 21sm2872442ywh.1.2010.02.16.08.08.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:05:25 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140103>

When git_dir is relative, it is relative to Git's current working
directory, which is worktree top directory. "git rev-parse --git-dir"
is expected to output relative to user's current working directory.

Catch this case and make gitdir absolute (the easy way).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This one is probably not needed for now. In my later patches, set_git_=
dir()
 is used more, and this becomes necessary.

 builtin-rev-parse.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a8c5043..a054256 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -638,6 +638,14 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				const char *gitdir =3D getenv(GIT_DIR_ENVIRONMENT);
 				static char cwd[PATH_MAX];
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
1.7.0.195.g637a2
