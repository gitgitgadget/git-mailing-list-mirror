From: =?UTF-8?q?T=C3=B6r=C3=B6k=20Edwin?= <edwintorok@gmail.com>
Subject: [PATCH] Fix 'git clean' failure on NFS.
Date: Fri, 18 Jun 2010 14:07:15 +0300
Message-ID: <1276859235-13534-1-git-send-email-edwintorok@gmail.com>
References: <loom.20100618T122039-876@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?T=C3=B6r=C3=B6k=20Edwin?= <edwintorok@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 18 13:07:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPZQA-0000rh-FE
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 13:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760938Ab0FRLHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 07:07:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41843 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489Ab0FRLHc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 07:07:32 -0400
Received: by fxm10 with SMTP id 10so526452fxm.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 04:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=t6F1dogQOEd8vBWGH2ekxYwKqwLKgUFPp0/67AtWfPo=;
        b=S8PJBBA8p7RJezYL+UB0JJr5w+nDo4c1v3wj2a46sNNnLjeld2cBxLDm7WcpPutQZ8
         vMRtEyQOC+1oT89Dbp5DRnNM7RuYxlD4NLpcsKM+3prIOay+sp9Cei2CSKg+tpTzkGLQ
         ytl9ckgBGwVtTHXjmo/zLudKOq4qayzrvfz8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bQ0BdCw5TakbJ9xT80bJTJmpyMUMHbKB4H+01YB+dv4O+FVFgBcjOdSiGcr8dys6Ro
         V7bUkRiy35WVR0DJ5qr5+lwxhiZMVvehE+gH8VngKOfOmUB5IC9eASn2cOj9i4eII6Mr
         W3MAbmaz8zUFBQkMMcSU+lCykBDTA1W1+gdRo=
Received: by 10.223.143.20 with SMTP id s20mr720340fau.38.1276859250829;
        Fri, 18 Jun 2010 04:07:30 -0700 (PDT)
Received: from debian ([79.114.67.113])
        by mx.google.com with ESMTPS id o19sm17119751fal.47.2010.06.18.04.07.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 04:07:29 -0700 (PDT)
Received: by debian (Postfix, from userid 1000)
	id 9496039702; Fri, 18 Jun 2010 14:07:28 +0300 (EEST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <loom.20100618T122039-876@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149341>

readdir() used to do a single pass, which is not always enough.
If you unlink some files/rmdir some subdirs then there might be some
files you haven't seen yet *before* the readdir cursor (files get rearr=
anged
in the directory, etc.).

The fix is to do an additional readdir() pass if we unlinked/rmdired so=
mething.
This is easily accomplished by using rewinddir.

Signed-off-by: T=C3=B6r=C3=B6k Edwin <edwintorok@gmail.com>
---
 dir.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 5615f33..7260907 100644
--- a/dir.c
+++ b/dir.c
@@ -999,6 +999,7 @@ int remove_dir_recursively(struct strbuf *path, int=
 flag)
 	struct dirent *e;
 	int ret =3D 0, original_len =3D path->len, len;
 	int only_empty =3D (flag & REMOVE_DIR_EMPTY_ONLY);
+	int did_rm;
 	unsigned char submodule_head[20];
=20
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
@@ -1013,6 +1014,8 @@ int remove_dir_recursively(struct strbuf *path, i=
nt flag)
 		strbuf_addch(path, '/');
=20
 	len =3D path->len;
+	do {
+	did_rm =3D 0;
 	while ((e =3D readdir(dir)) !=3D NULL) {
 		struct stat st;
 		if (is_dot_or_dotdot(e->d_name))
@@ -1023,15 +1026,24 @@ int remove_dir_recursively(struct strbuf *path,=
 int flag)
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (!remove_dir_recursively(path, only_empty))
+			if (!remove_dir_recursively(path, only_empty)) {
+				did_rm =3D 1;
 				continue; /* happy */
-		} else if (!only_empty && !unlink(path->buf))
+			}
+		} else if (!only_empty && !unlink(path->buf)) {
+			did_rm =3D 1;
 			continue; /* happy, too */
+		}
=20
 		/* path too long, stat fails, or non-directory still exists */
 		ret =3D -1;
 		break;
 	}
+	/* if we unlinked/rmdir-ed anything there might be files we haven't s=
een
+	 * yet before the readdir() cursor, rewind and walk directory again
+	 * until we can't unlink any more. */
+	rewinddir(dir);
+	} while (did_rm && !ret);
 	closedir(dir);
=20
 	strbuf_setlen(path, original_len);
--=20
1.7.0
