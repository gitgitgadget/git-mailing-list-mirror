From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pack-objects: use free()+xcalloc() instead of xrealloc()+memset()
Date: Sun, 01 Jun 2014 13:07:21 +0200
Message-ID: <538B0969.9080409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Vicent Marti <tanoku@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 01 13:07:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr3cA-0005F1-0d
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 13:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbaFALHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 07:07:37 -0400
Received: from mout.web.de ([212.227.15.4]:64232 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbaFALHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 07:07:36 -0400
Received: from [192.168.178.27] ([79.253.133.25]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LaCmk-1WPBAh3Chi-00lzYd; Sun, 01 Jun 2014 13:07:33
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Provags-ID: V03:K0:SkMGdl++C2MN8qi7qydkfn+diOI50HocEy7reF8BqFYBVI5MnTS
 HxZzHLxEwt9rT3P+oZIZW2SKGy7m7Xeriq9zhJx0bFMtWJd0R/XoNmqzi3h2lfaMYVJm8L5
 xQ8Sf7rTKgUFgry/gsXEIqN/Gf7NfGwBG12595KFFIaff+FEkgWBogm02dr8xZ0hfJGUgzs
 yISwQqQPdx8wv1HHPnT1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250525>

Whenever the hash table becomes too small then its size is increased,
the original part (and the added space) is zerod out using memset(),
and the table is rebuilt from scratch.

Simplify this proceess by returning the old memory using free() and
allocating the new buffer using xcalloc(), which already clears the
buffer for us.  That way we avoid copying the old hash table contents
needlessly inside xrealloc().

While at it, use the first array member with sizeof instead of a
specific type.  The old code used uint32_t and int, while index is
actually an array of int32_t.  Their sizes are the same basically
everywhere, so it's not actually a problem, but the new code is
cleaner and doesn't have to be touched should the type be changed.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-objects.c b/pack-objects.c
index d01d851..4f36c32 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -47,8 +47,8 @@ static void rehash_objects(struct packing_data *pdata)
 	if (pdata->index_size < 1024)
 		pdata->index_size = 1024;
 
-	pdata->index = xrealloc(pdata->index, sizeof(uint32_t) * pdata->index_size);
-	memset(pdata->index, 0, sizeof(int) * pdata->index_size);
+	free(pdata->index);
+	pdata->index = xcalloc(pdata->index_size, sizeof(*pdata->index));
 
 	entry = pdata->objects;
 
-- 
2.0.0
