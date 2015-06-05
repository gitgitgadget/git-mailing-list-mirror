From: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
Subject: [PATCH v2 1/2] receive-pack: Create a HEAD ref for ref namespace
Date: Fri,  5 Jun 2015 16:12:10 +0200
Message-ID: <1433513531-13423-2-git-send-email-johannes@kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433513531-13423-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 16:12:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0sMF-0005J6-K6
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 16:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423111AbbFEOMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 10:12:22 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52532 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422683AbbFEOMT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 10:12:19 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 4c36ade6;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=theos; bh=Ixfq1tEgUff
	gUwDDj4OwlPG9jVc=; b=q9hd8s7eQh46kDgybUYyGXMbuJEQqT6Je8LjNW7VvnQ
	gxJ8g0P4XWYoO9E6WBLtpoJecoy247F4gN7JoNZoDh+4SzpGgkm7jbn2jRf9i9Wg
	WTCyCQX+fUjYrbg5u+5NMVCLnUqRVQw1e/OfFLwn+D7YPyxOqCHcDYX8jvMOSTFU
	=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=theos; b=Aeli7
	8WOoWdRwLEjJuiphwbvqIjUkkNuEwau1lo0Md/MPLub8vlkgv6tufPwAqfgSoFz7
	QSWaZMv/ZXydgQU2kaksuL58McVG49vHY6xTbgj3EwTKf0n/Ruh8EriJJsdVEuVo
	L7SKpmSs7LfHNQmC28HsEUI3jl1/pNGglo3V6o=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 22370a56;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Fri, 5 Jun 2015 14:12:17 +0000 (UTC)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433513531-13423-1-git-send-email-johannes@kyriasis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270836>

Each ref namespace have their own separate branches, tags, and HEAD, so
when pushing to a namespace we need to make sure that there exists a
HEAD ref for the namespace, otherwise you will not be able to check out
the repo after cloning from a namespace

Signed-off-by: Johannes L=C3=B6thberg <johannes@kyriasis.com>
---
 builtin/receive-pack.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5292bb5..c189838 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -864,7 +864,9 @@ static const char *update(struct command *cmd, stru=
ct shallow_info *si)
 {
 	const char *name =3D cmd->ref_name;
 	struct strbuf namespaced_name_buf =3D STRBUF_INIT;
-	const char *namespaced_name, *ret;
+	struct strbuf namespaced_head_buf =3D STRBUF_INIT;
+	const char *namespaced_name, *ret, *namespace;
+	const char *namespaced_head_path;
 	unsigned char *old_sha1 =3D cmd->old_sha1;
 	unsigned char *new_sha1 =3D cmd->new_sha1;
=20
@@ -981,6 +983,14 @@ static const char *update(struct command *cmd, str=
uct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		namespace =3D get_git_namespace();
+		if (strcmp(namespace, "refs/namespaces/")) {
+			strbuf_addf(&namespaced_head_buf, "%s%s", namespace, "HEAD");
+			namespaced_head_path =3D strbuf_detach(&namespaced_head_buf, NULL);
+
+			create_symref(namespaced_head_path, namespaced_name, NULL);
+		}
+
 		struct strbuf err =3D STRBUF_INIT;
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
--=20
2.4.2
