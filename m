From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 07/27] reflog: avoid constructing .lock path with git_path
Date: Sat,  1 Mar 2014 19:12:43 +0700
Message-ID: <1393675983-3232-8-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:21:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJivC-0001uF-HO
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbaCAMVd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:21:33 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:41993 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:21:33 -0500
Received: by mail-pb0-f44.google.com with SMTP id rp16so1892646pbb.17
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ljlvw/HvKpzofrPGUgYANPIiobMWbUyuCLt7TYUdvjU=;
        b=lkKUZOY7WDPHMaqVuczS4qlmsN3jMRxk/0HuWcM5bdnbMWyvqHnrt9b9bnr4jVNl9r
         xmF5x8o7TBCtty+YDiIiiWuQLNFjWK6JanZ3wJkQIDZ1Y8xFwRCl0ulR3JGrM99aKOmk
         L2RusOuPHBdrwfzx5Bzybb+zYhp1jdMmt2M2aKf9QTm3WktPHT0olfVzIQaOo0pZ8KAH
         ZsfhEjAWmFlQd2Sn6lPYM5EJ5cybDd7vHyaQbS5C3yBGGTLU3iVrNTv7kIj/KE1WXUal
         OWo17dnBNxFimL4pHMF6zAuVIr6Od0qabhZSgNeemyXBneKQ+dAY238FlOW756aY6LSa
         aqpQ==
X-Received: by 10.68.231.169 with SMTP id th9mr9093685pbc.113.1393676492650;
        Sat, 01 Mar 2014 04:21:32 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id nv7sm15888413pbc.31.2014.03.01.04.21.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:21:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:21:58 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243072>

git_path() soon understands the path given to it and can transform the
path instead of just prepending $GIT_DIR. So given path "abc",
git_path() may return "$GIT_DIR/abc". But given path "def", git_path()
may return "$GIT_DIR/ghi".

Giving path "def.lock" to git_path() may confuse it and make it
believe "def.lock" should not be transformed because the signature is
"def.lock" not "def". But we want the lock file to have the same base
name with the locked file (e.g. "ghi.lock", not "def.lock"). It's best
to append ".lock" after git_path() has done its conversion.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reflog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 852cff6..ccf2cf6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -372,7 +372,7 @@ static int expire_reflog(const char *ref, const uns=
igned char *sha1, int unused,
 	if (!file_exists(log_file))
 		goto finish;
 	if (!cmd->dry_run) {
-		newlog_path =3D git_pathdup("logs/%s.lock", ref);
+		newlog_path =3D mkpathdup("%s.lock", log_file);
 		cb.newlog =3D fopen(newlog_path, "w");
 	}
=20
--=20
1.9.0.40.gaa8c3ea
