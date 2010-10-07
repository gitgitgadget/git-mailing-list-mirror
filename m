From: pclouds@gmail.com
Subject: [PATCH 1/2] setup.c: add enter_work_tree()
Date: Thu,  7 Oct 2010 11:46:52 +0700
Message-ID: <4cad50cc.0626730a.5616.673d@mx.google.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens.Lehmann@web.de, Junio C Hamano <gitster@pobox.com>,
	jrnieder@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, judge.packham@gmail.co
X-From: git-owner@vger.kernel.org Thu Oct 07 06:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3iNw-0001mG-UC
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 06:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab0JGErL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 00:47:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34222 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0JGErK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 00:47:10 -0400
Received: by pzk34 with SMTP id 34so60408pzk.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 21:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vRKaMd6c7OuJ540Lqrx3Ig2BkSTOYAuQtD8pAwsKX1A=;
        b=oS5hVQ68tCiiL95ny1nKGqT7DA8n/yTXJxZZWOMWjTXpi7un9gysxT86rorzoSsrGf
         /1SA8WniPAIqKgYhWepKCAC4Y3tgYKs+knIisNsMesXcLNVSdEgJb7IgIKzwpJnDChnN
         eijUZuZ0gnGPrvtqG6a/XRjcTPLFl0GGM4Bz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KcbK+rcZ1zEThG3cZv4FRhe/qSpCNAQDwOyLV8d/gL+R6JfYNtDIjKXFbDws85WpF6
         5z6/eDxVsCEG0LQTxczvgpAwTDj6iyZOhnfFwwDqDDeMS285ngMu697uL2HRz+15ktjE
         rUmzvlRsmsMn0QKpLsCxmhk39x7IvzFLVO9MI=
Received: by 10.114.88.15 with SMTP id l15mr242958wab.191.1286426829903;
        Wed, 06 Oct 2010 21:47:09 -0700 (PDT)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id q6sm2646858waj.22.2010.10.06.21.47.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 21:47:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Oct 2010 11:46:55 +0700
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158368>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This function, apart from chdir() to worktree topdir, also invalidates
inside_work_tree so is_inside_work_tree() should reflect the new
situation correctly.

This function may be used when cwd is outside worktree and the running
command supports this case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 To be used by builtin/grep.c when cwd is outside worktree.
 More explanation in the next patch.

 cache.h |    1 +
 setup.c |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 2ef2fa3..e71db23 100644
--- a/cache.h
+++ b/cache.h
@@ -414,6 +414,7 @@ extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
 extern void set_git_work_tree(const char *tree);
+extern void enter_work_tree();
=20
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
diff --git a/setup.c b/setup.c
index a3b76de..3fbe928 100644
--- a/setup.c
+++ b/setup.c
@@ -208,6 +208,13 @@ int is_inside_work_tree(void)
 	return inside_work_tree;
 }
=20
+void enter_work_tree(void)
+{
+	if (chdir(get_git_work_tree()))
+		die("Could not chdir to %s", get_git_work_tree());
+	inside_work_tree =3D -1;
+}
+
 /*
  * set_work_tree() is only ever called if you set GIT_DIR explicitly.
  * The old behaviour (which we retain here) is to set the work tree ro=
ot
--=20
1.7.1.rc1.70.g788ca
