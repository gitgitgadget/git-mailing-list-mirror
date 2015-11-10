From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 04/12] parse_fetch: convert to use struct object_id
Date: Tue, 10 Nov 2015 02:22:22 +0000
Message-ID: <1447122150-672570-5-git-send-email-sandals@crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 03:23:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvyau-0001RF-J2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 03:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbbKJCW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 21:22:56 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58402 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752229AbbKJCWx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 21:22:53 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4AF1828098;
	Tue, 10 Nov 2015 02:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1447122172;
	bh=ktoq+LUOt6UftBfKVmZMdo6nLeDa/VN7LHzfrSbemk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P19Ry56FDojKq9b+DCC/a312TbJszVr1SzK5QqJbmpGvJNZKIGPHSTmXe4hSWtYqA
	 3dlOEXVYRMVXFHBL1NaHk8ALl161/MLd4Lv7YA79mbXGw4dDusLhDyBZLvUCkH50Aw
	 mkipYPtBubL925b9TjZC7C3A3/yc1hrPjjfhwCTsk+zIi4hIh45YViolpgLfkhpPlT
	 5nuQtGfuHdN2qRr91X1jQ+6pGNceDmAtNujISyM3bBrTk3zoNSf07nVW7m/hN/JkJU
	 kpsD990buE8ik8jE/anZxl/ivELO5I7EfAYdFGKQ9IcEWmYTxjwbe1T3rieq9OSv5d
	 4jr/MBSCnETV3jtjE007FbPXfZnlbagmkS5DcvrtWjmW62N/5dstJCo2YJorsB/ZiT
	 TtL1LMr7mSTV4tCIcpf/fTJ9C7TMpRSeGIzfd46uhpiCO4IU8HUyVGEfFQmFxTj9bb
	 P2mav031tZSd2PgdKRsYcG6FeurnH+LvzkvtTrO1gL92Oq1+GGV
X-Mailer: git-send-email 2.6.2.409.gb049f0a
In-Reply-To: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281099>

Convert the parse_fetch function to use struct object_id.  Remove the
strlen check as get_oid_hex will fail safely on receiving a too-short
NUL-terminated string.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index bc3af79e..f404faf0 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -803,19 +803,19 @@ static void parse_fetch(struct strbuf *buf)
 		if (skip_prefix(buf->buf, "fetch ", &p)) {
 			const char *name;
 			struct ref *ref;
-			unsigned char old_sha1[20];
+			struct object_id old_oid;
 
-			if (strlen(p) < 40 || get_sha1_hex(p, old_sha1))
+			if (get_oid_hex(p, &old_oid))
 				die("protocol error: expected sha/ref, got %s'", p);
-			if (p[40] == ' ')
-				name = p + 41;
-			else if (!p[40])
+			if (p[GIT_SHA1_HEXSZ] == ' ')
+				name = p + GIT_SHA1_HEXSZ + 1;
+			else if (!p[GIT_SHA1_HEXSZ])
 				name = "";
 			else
 				die("protocol error: expected sha/ref, got %s'", p);
 
 			ref = alloc_ref(name);
-			hashcpy(ref->old_oid.hash, old_sha1);
+			oidcpy(&ref->old_oid, &old_oid);
 
 			*list = ref;
 			list = &ref->next;
-- 
2.6.2.409.gb049f0a
