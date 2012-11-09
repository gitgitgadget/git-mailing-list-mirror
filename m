From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] cache-tree: invalidate i-t-a paths after writing trees
Date: Fri,  9 Nov 2012 18:04:00 +0700
Message-ID: <1352459040-14452-1-git-send-email-pclouds@gmail.com>
References: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathon Mah <me@JonathonMah.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 12:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWmNr-00020O-5k
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 12:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab2KILEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 06:04:10 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57501 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab2KILEH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 06:04:07 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2709802pad.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 03:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W3rA/QuR+sRrwJEZUBVi/U4sqOpum86STqwjPRa9VHE=;
        b=hI7+kMXHH7naNlx6mbjsr5GBbjZvN6iewm1bUZ8cppdXCK2PM65QSEcM4q6ILUqj/X
         sbbbG74SJpDJmhp/GjKVfqM2PmIZ7ryVfbbXL0ns8BtU5+StcT8YSRalw8hRgKo1XlpU
         P/uehoj4LJXFDFfXMIN1GaO+uQw9ZH9PhQMl3mf0d/6/1QNJLwB0aDK7UspW0tCMagZY
         TBDAtjgjHaed28LkwMHn8IaXGwefQwyTQ+9Xwnz6VaU/+SnJ/798pB/R8rz9W0DzLdOP
         KbMNBsDpKV3mAMmVKwFPAHmEfiLV2Le+YxdsBUpHG+NJSMBidmfQHCwwhFzxkftViYNa
         gJzQ==
Received: by 10.68.193.136 with SMTP id ho8mr32189927pbc.98.1352459047276;
        Fri, 09 Nov 2012 03:04:07 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id nd6sm17580082pbc.68.2012.11.09.03.04.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Nov 2012 03:04:06 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 09 Nov 2012 18:04:05 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <3E62F933-76CD-4578-8684-21444EAA454F@JonathonMah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209213>

Intent-to-add entries used to forbid writing trees so it was not a
problem. After commit 3f6d56d (commit: ignore intent-to-add entries
instead of refusing - 2012-02-07), an index with i-t-a entries can
write trees. However, the commit forgets to invalidate all paths
leading to i-t-a entries. With fully valid cache-tree (e.g. after
commit or write-tree), diff operations may prefer cache-tree to index
and not see i-t-a entries in the index, because cache-tree does not
have them.

The invalidation is done after calling update_one() in
cache_tree_update() for simplicity because it's probably not worth the
complexity of changing a recursive function and the performance
bottleneck won't likely fall to this new loop, rather in
write_sha1_file or hash_sha1_file. But this means that if update_one()
has new call sites, they must re-do the same what this commit does to
avoid the same fault.

Reported-by: Jonathon Mah <me@JonathonMah.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c          |  3 +++
 t/t2203-add-intent.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 28ed657..30a8018 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -381,6 +381,9 @@ int cache_tree_update(struct cache_tree *it,
 	i =3D update_one(it, cache, entries, "", 0, flags);
 	if (i < 0)
 		return i;
+	for (i =3D 0; i < entries; i++)
+		if (cache[i]->ce_flags & CE_INTENT_TO_ADD)
+			cache_tree_invalidate_path(it, cache[i]->name);
 	return 0;
 }
=20
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index ec35409..2a4a749 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -62,5 +62,25 @@ test_expect_success 'can "commit -a" with an i-t-a e=
ntry' '
 	git commit -a -m all
 '
=20
+test_expect_success 'cache-tree invalidates i-t-a paths' '
+	git reset --hard &&
+	mkdir dir &&
+	: >dir/foo &&
+	git add dir/foo &&
+	git commit -m foo &&
+
+	: >dir/bar &&
+	git add -N dir/bar &&
+	git diff --cached --name-only >actual &&
+	echo dir/bar >expect &&
+	test_cmp expect actual &&
+
+	git write-tree >/dev/null &&
+
+	git diff --cached --name-only >actual &&
+	echo dir/bar >expect &&
+	test_cmp expect actual
+'
+
 test_done
=20
--=20
1.8.0.rc2.23.g1fb49df
