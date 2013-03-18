From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] read-cache: avoid memcpy in expand_name_field in index v4
Date: Mon, 18 Mar 2013 19:58:02 +0700
Message-ID: <1363611482-1015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 18 13:58:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHZeA-0008Lt-CX
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 13:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab3CRM6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 08:58:11 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:36967 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab3CRM6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 08:58:10 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so4048dan.33
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=oWfCvP1kGnvpvp/RGhaFeb5HJD49r54ORiohSeuN7DU=;
        b=oV4rmq8iHvEGo6TBN/diN6JOCx5hsI2AlOtfkavjGTyKKGYrhOpJils5Rz9CbqwLkt
         /5dAmz4iT1a3jSHVJTUZqQUmzS2a32/AAjBfie4P7lEJJ3oKePJWf8D88PxK6peshkFS
         NQW1u3kDXivrD/FIeg8Qj/1qE5h0pdI0gtRih6ZrhRsYLvV4mYkZJ1szlNQHAIOTQC00
         OyUz8gFOADOfHZA2sdWpvGSCnaemLsxuUA+cVIniART2m3maU1Jd+y0ggJj968X/ZJOt
         R6Ss6CxiJeZ2ZCIj8JBtamhM5PRuyE5t5MGaVfBX+LaIWiPCZKtfKbWPiFnFkbA0I4a3
         uhag==
X-Received: by 10.68.204.164 with SMTP id kz4mr32704441pbc.158.1363611489802;
        Mon, 18 Mar 2013 05:58:09 -0700 (PDT)
Received: from lanh ([115.74.61.42])
        by mx.google.com with ESMTPS id yr10sm8161837pab.6.2013.03.18.05.58.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 05:58:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 18 Mar 2013 19:58:03 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218409>

perf reports memcpy at the the 6th position [1] in "git status -uno"
using index v4, and strbuf_remove() in expand_name_field() accounts
for 25% of that. What we need here is a simple string cut and a
cheaper strbuf_setlen() should be enough. After this change, memcpy
drops down to the 13th position [2] and is dominated by
read_index_from.

[1] before
+     15.74%   git  git                [.] blk_SHA1_Block
+     13.22%   git  [kernel.kallsyms]  [k] link_path_walk
+     10.91%   git  [kernel.kallsyms]  [k] __d_lookup
+      8.17%   git  [kernel.kallsyms]  [k] strncpy_from_user
+      4.75%   git  [kernel.kallsyms]  [k] memcmp
+      2.42%   git  libc-2.11.2.so     [.] memcpy

[2] after
+     16.30%   git  git                [.] blk_SHA1_Block
+     13.43%   git  [kernel.kallsyms]  [k] link_path_walk
+     11.45%   git  [kernel.kallsyms]  [k] __d_lookup
+      8.73%   git  [kernel.kallsyms]  [k] strncpy_from_user
+      5.14%   git  [kernel.kallsyms]  [k] memcmp
+      2.29%   git  [kernel.kallsyms]  [k] do_lookup
+      2.21%   git  libc-2.11.2.so     [.] 0x6daf6
+      1.98%   git  [kernel.kallsyms]  [k] _atomic_dec_and_lock
+      1.98%   git  [kernel.kallsyms]  [k] _raw_spin_lock
+      1.86%   git  [kernel.kallsyms]  [k] acl_permission_check
+      1.61%   git  [kernel.kallsyms]  [k] kmem_cache_free
+      1.59%   git  git                [.] unpack_trees
+      1.47%   git  libc-2.11.2.so     [.] memcpy

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I was after something else when I noticed this. Seems like a simple
 and safe change.

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 827ae55..8c443aa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1354,7 +1354,7 @@ static unsigned long expand_name_field(struct str=
buf *name, const char *cp_)
=20
 	if (name->len < len)
 		die("malformed name field in the index");
-	strbuf_remove(name, name->len - len, len);
+	strbuf_setlen(name, name->len - len);
 	for (ep =3D cp; *ep; ep++)
 		; /* find the end */
 	strbuf_add(name, cp, ep - cp);
--=20
1.8.2.83.gc99314b
