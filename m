From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/32] clone: support --narrow option
Date: Wed, 25 Aug 2010 08:20:09 +1000
Message-ID: <1282688422-7738-20-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:23:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uM-00030j-1N
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab0HXWXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49555 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab0HXWXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:01 -0400
Received: by pxi10 with SMTP id 10so2813335pxi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wfXkh4AzryVIVlq+V//JQk6vXuTHy2WggdgzTUuLqmg=;
        b=KVZi3oz/AMWk+4ArSF3fCnJvRF5R2YyhzGRR6dawMukwBmzdPmf2s6ltZTjXKXr1Qo
         fm4hf5L1jE93zRZbrk60xtELfpceTjrbRa6qaRCEtbl5o+/11AcZo6TTpO/2Z/a5apOq
         v4QEP08swDeZbYzi/O9L6Z3kGMbFBRlEnuFEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=euI2zys5v1f2Ti7uFsnIOmqn2ATx61ubgBiAJGmedG0MaobisUSvUtEi4Diq+WXHIf
         i/8q/KJXp324j9gKtUHiiKTdEgtTvE50Mu9ocBNKb2LIYUcXoZTwdCn/3yLkQ+Si+tnL
         2HljgKms+2RYHLKHcj+eBOk67tekdaY458De4=
Received: by 10.142.229.13 with SMTP id b13mr6254160wfh.61.1282688580799;
        Tue, 24 Aug 2010 15:23:00 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id z1sm644434wfd.3.2010.08.24.15.22.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:22:59 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:22:54 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154357>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efb1e6f..65c4cee 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "narrow-tree.h"
=20
 /*
  * Overall FIXMEs:
@@ -39,7 +40,7 @@ static const char * const builtin_clone_usage[] =3D {
=20
 static int option_no_checkout, option_bare, option_mirror;
 static int option_local, option_no_hardlinks, option_shared, option_re=
cursive;
-static char *option_template, *option_reference, *option_depth;
+static char *option_template, *option_reference, *option_depth, *optio=
n_narrow;
 static char *option_origin =3D NULL;
 static char *option_branch =3D NULL;
 static char *option_upload_pack =3D "git-upload-pack";
@@ -78,6 +79,8 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
+	OPT_STRING(0, "narrow", &option_narrow, "tree",
+		   "narrow clone"),
=20
 	OPT_END()
 };
@@ -515,6 +518,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	strbuf_reset(&value);
=20
 	if (path && !is_bundle) {
+		if (option_narrow)
+			die("--narrow is not really for local clone. Please consider --shar=
ed");
 		refs =3D clone_local(path, git_dir);
 		mapped_refs =3D wanted_peer_refs(refs, refspec);
 	} else {
@@ -530,6 +535,14 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			transport_set_option(transport, TRANS_OPT_DEPTH,
 					     option_depth);
=20
+		/* Do this early in order to set get_narrow_prefix() !=3D NULL */
+		if (option_narrow) {
+			int fd =3D open(git_path("narrow"), O_RDWR | O_CREAT, 0644);
+			write(fd, option_narrow, strlen(option_narrow));
+			close(fd);
+			check_narrow_prefix();
+		}
+
 		transport_set_verbosity(transport, option_verbosity, option_progress=
);
=20
 		if (option_upload_pack)
--=20
1.7.1.rc1.69.g24c2f7
