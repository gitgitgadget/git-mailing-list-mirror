From: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
Subject: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Sat, 13 Jun 2015 00:17:16 +0200
Message-ID: <1434147436-21272-1-git-send-email-johannes@kyriasis.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 00:17:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XGT-0000dw-3h
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927AbbFLWRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2015 18:17:25 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:50671 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbbFLWRY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:17:24 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 08921bbb;
	for <git@vger.kernel.org>;
	Fri, 12 Jun 2015 22:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=theos; bh=mMo69H7kWFo
	i5T3FPLNG3ZwWe7k=; b=KvLmgv652jaI7VGBpMN9UAFuFO+6MJG717pHqYIXEO2
	JUtQrbzIjbH6XTHxgt2CJSOmTFgCPsB9XnUGkqTPNHfPvU+E7SPpb70glHP2dx17
	tGxYwKZ0xQK2lJ97TqaD1C2j5+Hoo/AH9bs9Qys6x8eixBIpzXmJDkpRyIeiXFEs
	=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=theos; b=nwJt+
	GehSFn1RLRrxFfxLX8T479LYQxSgcwxyxgW+4uE0UUxqJI3zFV5nj8FikdhuoX7U
	2RIlqeAZyDywoJBIKI5NVqd0ysi0listXXa/H/N6C2e/Z0DClxlgMrOUPKMupDuK
	ZtQaxOotsDd3GHmbFqLK8CqAs6K3400rpHf6PQ=
Received: from leeloo.kyriasis.com (m77-218-249-155.cust.tele2.se [77.218.249.155]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id f0b1121e;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Fri, 12 Jun 2015 22:17:22 +0000 (UTC)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271536>

Git should fail to clone if trying to clone from an non-existing
ref namespace, since it's the same as a non-existing repository

Signed-off-by: Johannes L=C3=B6thberg <johannes@kyriasis.com>
---

Changes since v1:

* Fixed the namespace check, since I apparently forgot to check with a
  bare repo in my last test. D'oh.

Two other options for this would be to either add a=20
get_git_namespace_len() function and use that, or a is_namespaced()=20
functon. But since it's only used here for now at least it feels simple=
r=20
to not bloat the codabase with another function which has no other use.

 upload-pack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 89e832b..99fb271 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -778,6 +778,10 @@ static void upload_pack(void)
=20
 	head_ref_namespaced(find_symref, &symref);
=20
+	if (strcmp(get_git_namespace(), "") && !symref.items) {
+		die("git upload-pack: tried to clone from empty namespace");
+	}
+
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
 		head_ref_namespaced(send_ref, &symref);
--=20
2.4.2
