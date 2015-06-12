From: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
Subject: [PATCH/RFC] upload-pack: Fail if cloning empty namespace
Date: Fri, 12 Jun 2015 22:15:15 +0200
Message-ID: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 22:15:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3VMN-0001bc-J0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 22:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbbFLUPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2015 16:15:23 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:50310 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbFLUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 16:15:22 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 18546e68;
	for <git@vger.kernel.org>;
	Fri, 12 Jun 2015 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=theos; bh=vvFv9MjY1I2cllQYFSa/SDM/
	ZQk=; b=K0WUNcQNehDVUb06E+f9gCv2xNPkhuu4yIl82L8ak6kDT9MnxqoEqy48
	gUz6yZgY9lE8zdUbRcvEyHU5JW+1wkINspW9tknV39xPws49Eqi8xzrQZArilsGV
	tFySf72pNQqTxAJ4DFgZ1HH5svMJegNNi6mq6ciNcJ9PmiIcybA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=theos; b=CQ3KRWvR6Q13wvc8oi
	aoiv6lSuNQ7sqBf8iXlnTTvMyzUKQdXlCOp0py0JoXj73Zg8q4gERF5a3veW4xlw
	QFKQNYMPiBM6IhBvYUmzOcOPooUMS3hYMyXsnqE329Zk7mvD8uvcJajuSaJVihPA
	EBjBaKMAmXkBShSk8K77dBmMQ=
Received: from leeloo.kyriasis.com (m77-218-249-155.cust.tele2.se [77.218.249.155]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id df5f9295;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Fri, 12 Jun 2015 20:15:21 +0000 (UTC)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271517>

Git should fail to clone if trying to clone from an non-existing
ref namespace, since it's the same as a non-existing repository

Signed-off-by: Johannes L=C3=B6thberg <johannes@kyriasis.com>
---

In version 4 of the ArchLinux User Repository, which is a hosting=20
platform for recepies for building Arch packages, we use Git to store=20
the recepies.

To save space we are using ref namespaces, which so far has saved quite=
=20
a bit of space. There is one issue though, when cloning a non-existing=20
repository we don't want the clone to work. This patch fixes this issue=
=20
by failing the clone if a namespace was specified but it doesn't exist.

Making this conditional on a namespace being specified makes sure that=20
cloning regular empty repos still works.

 upload-pack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 89e832b..21f8891 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -778,6 +778,10 @@ static void upload_pack(void)
=20
 	head_ref_namespaced(find_symref, &symref);
=20
+	if (get_git_namespace() && !symref.items) {
+		die("git upload-pack: tried to clone from empty namespace");
+	}
+
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
 		head_ref_namespaced(send_ref, &symref);
--=20
2.4.2
