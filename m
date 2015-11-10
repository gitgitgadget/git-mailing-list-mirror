From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 03/12] add_sought_entry_mem: convert to struct object_id
Date: Tue, 10 Nov 2015 02:22:21 +0000
Message-ID: <1447122150-672570-4-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:23:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvyaP-0000rb-U5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbbKJCW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:22:57 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58397 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664AbbKJCWw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:22:52 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DDA8728097;
	Tue, 10 Nov 2015 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122172;
	bh=cugULeTkQ4CdCQHn4Q6tNxJW2Jh1wvrsYFdznKjam6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwEYwDX34QTpc7JcEuLj/E0bamUywGqTBGkzBLrz4L5Bjq8OP+iSMokdEttBw4uyz
	 zBqR2t30dgPmKZKh2/jnCIG+6MK7NFbuAuuP2VWiuefuHpi4DJb+tND0rnHxwq+68N
	 DhQFZ26Yx10tWpfsXhGNKVKUvfI1N0HtIknQMRpqTQ36cvDV7q9L+FgGEnkQDaD+ZW
	 Nwg9LrNZISAR6N5EgMLFgt3C6sRYX4KImXTgF6J9P/wZykRju4d1UQHy5mkUT4ZHTQ
	 L74xUw/ezBtYRBByCheBYYncndFVQlTdq3CmNxYoZwPsyduPT+XmDuOiWMzRx74yML
	 LJSMe3FsQoB5zDFm0dvTsaJ0dNcMHA2jIN71bvJuRYftRO8EpFVc+TC+jz9aimPhZA
	 NNkZKZc9EhNRG0/bJBj9xOJv2Tg5d2OHSGIcb7KisfSTEd8ZPV29N/iEPhEx1BdvKk
	 Scujtlm6mnC98qNJ4WpXEx2aWomT9/E4p24fyoezTDj8kxK8KWu
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281092>

Convert this function to use struct object_id.  Express several
hardcoded constants in terms of GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fetch-pack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 19215b33..cf3019e0 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -14,12 +14,14 @@ static void add_sought_entry_mem(struct ref ***sought, int *nr, int *alloc,
 				 const char *name, int namelen)
 {
 	struct ref *ref = xcalloc(1, sizeof(*ref) + namelen + 1);
-	unsigned char sha1[20];
+	struct object_id oid;
+	const int chunksz = GIT_SHA1_HEXSZ + 1;
 
-	if (namelen > 41 && name[40] == ' ' && !get_sha1_hex(name, sha1)) {
-		hashcpy(ref->old_oid.hash, sha1);
-		name += 41;
-		namelen -= 41;
+	if (namelen > chunksz && name[chunksz - 1] == ' ' &&
+		!get_oid_hex(name, &oid)) {
+		oidcpy(&ref->old_oid, &oid);
+		name += chunksz;
+		namelen -= chunksz;
 	}
 
 	memcpy(ref->name, name, namelen);
-- 
2.6.2.409.gb049f0a
