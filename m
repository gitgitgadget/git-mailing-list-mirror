From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 3/4] Add the configure variable skipFetchAll
Date: Sun, 08 Nov 2009 16:47:54 +0100
Message-ID: <4AF6E82A.4040404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 16:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N79zm-0002sw-6E
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 16:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbZKHPrv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 10:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbZKHPrv
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 10:47:51 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:56773 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbZKHPrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 10:47:51 -0500
Received: by ewy3 with SMTP id 3so2430591ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=F3RiEhDi6wJpI+ed4qSAZz24GQ8LiFj0TiwepmMztK0=;
        b=gYeLsGlCy7+hAARiWVr+2O7FtJZ9hP5nmp8Lk2jT28Mx/MCyf/+ghzYHifTkcSkHQh
         sBdMv9al3P027TqtqRXltSFL8ciV8s4VMvDXzSWpEem0rFhe9hMbFhlq6McL1He8gVc4
         Tu3L4srHz2gEJMWG/KddHnkvXedfWUZoRmv08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=F+tt1yPsavXwhCvgjgfbxQ5zwAfGIJyZeyZXrj+s8sIsnhY+mNmZm/UnuX/6kD0NCJ
         1AJiFTWaF/OE3pq12zUKpdZyDrxKP4cCWszR/hP4uXlnpf43NWUcqWMobHlHO2tDYSPb
         sa5GNWtkaKXyY2bSdb6SNQkEX2lxvEIyMd4rw=
Received: by 10.213.95.200 with SMTP id e8mr7343405ebn.18.1257695275405;
        Sun, 08 Nov 2009 07:47:55 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm3716955eyz.27.2009.11.08.07.47.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 07:47:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132406>

Implement the configure skipFetchAll variable to allow
certain remotes to be skipped when doing 'git fetch --all' and
'git remote update'. The existing skipDefaultUpdate variable
is still honored (by 'git fetch --all' and 'git remote update').
(If both are set in the configuration file with different values,
the value of the last occurrence will be used.)

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-fetch.c |    3 ++-
 remote.c        |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 7926658..651e9c3 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -688,7 +688,8 @@ static void set_option(const char *name, const char=
 *value)
 static int get_one_remote_for_fetch(struct remote *remote, void *priv)
 {
 	struct string_list *list =3D priv;
-	string_list_append(remote->name, list);
+	if (!remote->skip_default_update)
+		string_list_append(remote->name, list);
 	return 0;
 }
=20
diff --git a/remote.c b/remote.c
index 73d33f2..beaf9fb 100644
--- a/remote.c
+++ b/remote.c
@@ -396,7 +396,8 @@ static int handle_config(const char *key, const cha=
r *value, void *cb)
 		remote->mirror =3D git_config_bool(key, value);
 	else if (!strcmp(subkey, ".skipdefaultupdate"))
 		remote->skip_default_update =3D git_config_bool(key, value);
-
+	else if (!strcmp(subkey, ".skipfetchall"))
+		remote->skip_default_update =3D git_config_bool(key, value);
 	else if (!strcmp(subkey, ".url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
--=20
1.6.5.1.69.g36942
