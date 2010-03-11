From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/16] Do not read .git/info/attributes if there is no repository
Date: Thu, 11 Mar 2010 20:22:29 +0700
Message-ID: <1268313754-28179-12-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMj-0001K7-HF
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456Ab0CKNXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:44 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:40589 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932475Ab0CKNXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:41 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so11276pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=93jlBNhf1eVNtxyV+qGYmlltqMYirJAPTtHk5XeAZYE=;
        b=sVD25eBVGKTI7ucSIQ9YsKJOeYUNnzWcgL8HM5MDKewG3d1Dd51WPCAOyifPSzZuOw
         s8pqfPSMeWV99tRDsJ3hNU8mJiuZJMZrQ9tR60V4qWIbzbJbyTx0MbUdCPCxyXQqRzCS
         rZg3hzLl1cRizSF5+F4bEODedt5giTuRtw0N8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sc4V8Xive6zIszJc0N1e+sbNpvzZ7ytWOOPuY9pLdbaYmj1kBxUmTN1uxxv6HYDZ2B
         IbJX6xPv9YAjkml2d6n+wOvGxGRt8akgkT/1QUBQNqctg6Ihu9NAignBMNqGvYmh5zs9
         fjJaZfEQ01oEQQnajNXE36aHHvZEcXXv6K5Gk=
Received: by 10.115.117.19 with SMTP id u19mr1334555wam.46.1268313820937;
        Thu, 11 Mar 2010 05:23:40 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8863535pzk.14.2010.03.11.05.23.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:36 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141973>

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
1.7.0.1.384.g6abcaa
