From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/43] Do not read .git/info/attributes if there is no repository
Date: Mon,  5 Apr 2010 20:41:17 +0200
Message-ID: <1270492888-26589-33-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:48:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrLr-00052I-8V
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab0DESsn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:48:43 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:1279 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab0DESsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:48:41 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1461970qwh.37
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=P5mkejS2mRek3e+JvlUSvD+xdbRjfmm0yHThwJry1io=;
        b=J5tG4qlR8f1QkOPXos/vXnEZc2ETGLUlOogeX2KTU/dEZ+TAs0brmTfWyyJVYXlzic
         rU+t6xr0oJHn7aeDE1T3EVa+xFjDDJTqyr6nJOazI/kJOascRhepkPQiCpsSvCI07rhj
         ixR8OFBkWyLFX3fUEdT44ZBQ1fywkallzSWLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ap1XIndkUAi3a75ItQfxwuJM8subIEPLgoBx/+8lZTWHlJndEh9cvRS/EUbpopPPXJ
         UhwlNyelYOaOhOyuq+aT3nQ2neSHR5LTPebHfKzefadwDXn5tEoni4RV9vbtthSji7Kf
         TD8vA87OSSyr475ldm2RmN7AtCnIx+JeEPrN0=
Received: by 10.229.211.210 with SMTP id gp18mr8878490qcb.31.1270493015277;
        Mon, 05 Apr 2010 11:43:35 -0700 (PDT)
Received: from dektop ([72.14.241.37])
        by mx.google.com with ESMTPS id 20sm7215364qyk.0.2010.04.05.11.43.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:34 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:29 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144043>

This one is difficult to demonstrate by tests. So I'll describe the
call flow instead.

Say we do "git grep --no-index --show-function foo -- bar" in no
repository. The call flow would be:
 - ...
 - cmd_grep
 - grep_directory
 - grep_file
 - grep_buffer
 - grep_buffer_1
 - userdiff_find_by_path
 - git_checkattr("diff")
 - bootstrap_attr_stack
 - git_path("info/attributes")

Because no repository is found, git_dir in environment.c would be
NULL. When it reaches git_path("info/attributes"), it will
automatically set git_dir to ".git". If we have $(cwd)/.git/info/attrib=
utes
then that file will be read, no matter $(cwd)/.git is a valid
repository.

This bug is hard to be exposed, because after git_checkattr("diff")
finds something (wrong). It will look up for diff drivers from
=2Egit/config. If we do thing correctly, .git/config will not be read,
thus no diff drivers, no visible impact. If .git/config is read,
git_dir must be set already, all this would not happen.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index f5346ed..f1362de 100644
--- a/attr.c
+++ b/attr.c
@@ -480,7 +480,10 @@ static void bootstrap_attr_stack(void)
 			debug_push(elem);
 		}
=20
-		elem =3D read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
+		if (!startup_info || startup_info->have_repository)
+			elem =3D read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
+		else
+			elem =3D NULL;
 		if (!elem)
 			elem =3D xcalloc(1, sizeof(*elem));
 		elem->origin =3D NULL;
--=20
1.7.0.rc1.541.g2da82.dirty
