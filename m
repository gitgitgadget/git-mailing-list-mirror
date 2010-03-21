From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/19] rev-parse --git-dir: print relative gitdir correctly
Date: Sun, 21 Mar 2010 17:30:30 +0700
Message-ID: <1269167446-7799-4-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIUg-0003AR-6N
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887Ab0CUKer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:34:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54002 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab0CUKeq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:34:46 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so509917gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ne9P39zRYKo0Xh4idH7mPMbEL5jrcPsW/xSEA4nIqjw=;
        b=K6zSkLGpaaur/Ic4Sf6HSC74auA7Qbmx97MzxUtNmaO7LdSaTBrMwXvoD3qygXMnsn
         ZUgyDmfUZ3WoGi6d6ZelJYNnd6TBGLoWev6ygYwjl7ga/s2e2ggb4N3r086BooBojBsP
         rX+x2Hbn5V+QmyFBOv/gE6WcMY0SSMUvCcyoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZXa1fio9n4ZIS43CR6kAJyGYXPESfpiMETWGlGvNYxlpnCSinuVUUM/ZuvxEQGdNes
         frZgqJn80eIHg4oQuDXxFLHnS8G6Ga5Ce6IJ+93FGeBkibuiv0FGJeMqhkhp2tHPsFGP
         Jlr0Ai9RXsWXh1NjtqtxdOabKEFWYWxeLGhjk=
Received: by 10.101.186.30 with SMTP id n30mr3777970anp.180.1269167686198;
        Sun, 21 Mar 2010 03:34:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 20sm1549402iwn.9.2010.03.21.03.34.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:34:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:31:03 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142799>

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
1.7.0.2.425.gb99f1
