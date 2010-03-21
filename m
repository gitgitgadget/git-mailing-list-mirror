From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/19] Do not read .git/info/attributes if there is no repository
Date: Sun, 21 Mar 2010 17:30:38 +0700
Message-ID: <1269167446-7799-12-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIVT-0003Y8-Kz
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0CUKfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:35:36 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:55586 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0CUKff (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:35:35 -0400
Received: by mail-yw0-f172.google.com with SMTP id 2so1334601ywh.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ESQ6e5oq7BLz5pecp1DZO+vYowZzkLtNsbge//XyznY=;
        b=BYioSWRME682P9xuKJ4vHDohjimehGuDzxzBTYTu035bVIoV2LQJwIP9QzJWYnfFOh
         r5Al3p5Oyj7hf+QJT4ZjucgM5gqmvK2oQLsIfp1pTQI+r3ZRN+Qg7cnoEm8Op00JsgFY
         qrJ23n6ArPn+7Xe6v7h0U0hEDxDPnPogagMYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=doCBiMhqyb5gzmho3B+6gIczp7rXJVC6PrpMfn1/o2bqP8zytB/x8cyH+3GcMTaISx
         5f0fMQAtqWLkd2nD5vDEizQBfLTZIxiVl1p8lMNUvzjAhiDmZhVB5T3kW1DK4huwvLsK
         43fxTkS5eg7ZkMRRq9qqtt2BYz6v5ghoqo4JY=
Received: by 10.101.2.40 with SMTP id e40mr3678656ani.120.1269167734781;
        Sun, 21 Mar 2010 03:35:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 22sm1875697iwn.8.2010.03.21.03.35.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:31:53 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142807>

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
1.7.0.2.425.gb99f1
