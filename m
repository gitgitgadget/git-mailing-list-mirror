From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 04/13] add_sought_entry_mem: convert to struct object_id
Date: Fri,  9 Oct 2015 01:43:50 +0000
Message-ID: <1444355039-186351-5-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:46:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMku-0001vC-RI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbbJIBpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:50 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58062 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755625AbbJIBpL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0AA262809A;
	Fri,  9 Oct 2015 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355110;
	bh=Sb3gPXQe7UC6ijwwtgshjgySJQXnrokffVukyaKjx0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wtBfbxT49eMuzo9Ffv0MtYdnAOZxX5ILV4xe2HJ+UjgGOQ2iIPbRpw3cm05RuoEan
	 EWVaxljGynlvPe/T2LeBkaVOzuZNfG78JL1Bf+p4ZLBJwKYO5TxB++dBBfh0vK7vXm
	 y7MBI+TcOeGMa9aDjbmTGDvflY0X/0NqH/1wfNIwQMyDhSmesVEUHkEtFsjQKYlP3B
	 MKkG5DPk/clXuSGotmmKuIIgftxo++Ndk9TtJ6a5GZD9Oyjh+6Cq9YgEe9innihFi6
	 0VznJ0wmqxwjTQEWGezZu1mHW4WSaKbO6+CE9AS2mZDZyQBxPavdbDdVSAvkhuP16e
	 g2gyuIAW9fdilc1Y7kyEKqwkcNPfOjRzRfYLMJLn9amcnMoNy5Abldr2yS3llsv0IB
	 CwrM4fm26ly41pRrqxvBSohpTwU4AYyCTv3y4ngt1hyy6Lirg7CfnOMEkByS3eBvbm
	 rVJI0W+sQ1mXGX/EW+AKAadaCfC7UZKFT10VkogO4bm2bCg8Wbo
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279298>

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
2.6.1
