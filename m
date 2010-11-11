From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] setup: save prefix (original cwd relative to toplevel) in startup_info
Date: Thu, 11 Nov 2010 21:08:02 +0700
Message-ID: <1289484484-8632-2-git-send-email-pclouds@gmail.com>
References: <1289484484-8632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
X-From: git-owner@vger.kernel.org Thu Nov 11 15:09:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGXqc-0001Uv-Bg
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab0KKOJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:09:46 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56007 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab0KKOJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:09:45 -0500
Received: by pzk28 with SMTP id 28so395513pzk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1ImAGphvfAouhiN25tLfUfxRlt/263wHFnYVSQvyjio=;
        b=uj1ncTa4/f5MTIkhsoX9niUtMBm+F60yo76b+y7SJjEEpuBgLK+OAQjvz8emy9YHKL
         e3Pv+ialegbfmAa02JXtdS3fMwM4w7jDD/vctOclqu1PAOjuz/Z0Okrek5gAFo4ttkLz
         CQ/Gvp9ze+Q1USPFuhk7YNLHCNnimHOnDnCXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hSbU5nCvRv2RmmZ+LEQRvrjxbqauXBQpdg+kiQrrpqqE0fWKj/Pqi+0Uwu+C7wnDy6
         iWLUVhsgzhbD0kAYoF8eSgBRSXIpG+fTyBKkCZDGLuJxiqnzF0s65pLK80Xk9mio16Av
         /2vujMe7fP/K/v0fLr47PfFLvGkNgbNSUy4OA=
Received: by 10.142.223.7 with SMTP id v7mr529724wfg.358.1289484584796;
        Thu, 11 Nov 2010 06:09:44 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id q13sm2400211wfc.17.2010.11.11.06.09.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:09:43 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:08:23 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289484484-8632-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161251>

Save the path from the original cwd to the cwd at the end of the
setup procedure in the startup_info struct introduced in e37c1329
(2010-08-05).  The value cannot vary from thread to thread anyway,
since the cwd is global.

So now in your builtin command, instead of passing prefix around,
when you want to convert a user-supplied path to a cwd-relative
path, you can use startup_info->prefix directly.

Caveat: As with the return value from setup_git_directory_gently(),
startup_info->prefix would be NULL when the original cwd is not a
subdir of the toplevel.

Longer term, this woiuld allow the prefix to be reused when several
noncooperating functions require access to the same repository (for
example, when accessing configuration before running a builtin).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    1 +
 setup.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..222d9cf 100644
--- a/cache.h
+++ b/cache.h
@@ -1117,6 +1117,7 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	const char *prefix;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/setup.c b/setup.c
index a3b76de..833db12 100644
--- a/setup.c
+++ b/setup.c
@@ -512,8 +512,10 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	const char *prefix;
=20
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
-	if (startup_info)
+	if (startup_info) {
 		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
+		startup_info->prefix =3D prefix;
+	}
 	return prefix;
 }
=20
--=20
1.7.3.2.210.g045198
