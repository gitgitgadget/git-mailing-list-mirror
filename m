From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] unpack_trees(): keep track of unmerged entries
Date: Sun, 30 Nov 2008 17:54:33 +0700
Message-ID: <1228042478-1886-4-git-send-email-pclouds@gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
 <1228042478-1886-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jyv-0005ev-B7
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbYK3Kz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2008 05:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbYK3KzZ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:55:25 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:31243 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbYK3KzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:55:23 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2162618wfd.4
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uKRRcgNJoUSByyzK7jPvPUsDKrvJ6Lj6daER2KhWxX4=;
        b=PnIvhVv/QrRhe8FNnJI14EuXumrqdFe/2FCelQbcpilSRH4plq52GaPVQFZI2ncHfR
         WBa2Ua9XzTJPA6A3HFH4Zh3poiyoMERWaj1cGyo22GvGT54WCZPoI1oPIBWihzrnKYTH
         kvCyGwn1bsIpf1gViljEihINsN3Nz+baJSLa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GaVBdG4whY7dfhR9ojFNzkNSvwbWnvtBwVAqPiUacIMBYIK9oinKn3mHc7Hkz5xSJg
         jmi6tv0c/kKOCu8aW/bU31bD4MdmX+Ep2MCcKeVvKvX3lQjZLyd1XjSOk7nLo2Yx99/0
         O7G3sn+aekhBRDKrGI0fXo3FaE1ZAuNcsaivY=
Received: by 10.142.187.8 with SMTP id k8mr4058908wff.106.1228042522919;
        Sun, 30 Nov 2008 02:55:22 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id 30sm5138839wfg.45.2008.11.30.02.55.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:55:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:55:02 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
In-Reply-To: <1228042478-1886-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101964>

"git read-tree --reset" will currently remove all unmerged entries in
index before feeding the index to unpack_trees(). Because the lack of
unmerged entries, these entries, when read from tree, will be seen as
"new entries" by {one,two,three}way_merge().

This is fine for now. But for sparse checkout, it needs to know
whether an entry is new entry, because it will handle it different way
than already-in entry.

So the patch moves "unmerged entries removal" part into
unpack_trees(), actually unpack_callback(). The function then can turn
on o->has_unmerged flag, which can be utilized by sparse checkout.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-read-tree.c |    3 ++-
 unpack-trees.c      |    7 +++++++
 unpack-trees.h      |    2 ++
 3 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 38fef34..528134c 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -136,9 +136,10 @@ int cmd_read_tree(int argc, const char **argv, con=
st char *unused_prefix)
 			if (stage || opts.merge || opts.prefix)
 				usage(read_tree_usage);
 			opts.reset =3D 1;
+			opts.prune_unmerged =3D 1;
 			opts.merge =3D 1;
 			stage =3D 1;
-			read_cache_unmerged();
+			read_cache();
 			continue;
 		}
=20
diff --git a/unpack-trees.c b/unpack-trees.c
index 83888ae..7d99051 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -301,6 +301,7 @@ static int unpack_callback(int n, unsigned long mas=
k, unsigned long dirmask, str
=20
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
+		o->has_unmerged =3D 0;
 		while (o->pos < o->src_index->cache_nr) {
 			struct cache_entry *ce =3D o->src_index->cache[o->pos];
 			int cmp =3D compare_entry(ce, info, p);
@@ -320,6 +321,12 @@ static int unpack_callback(int n, unsigned long ma=
sk, unsigned long dirmask, str
 						add_entry(o, ce, 0, 0);
 						return mask;
 					}
+
+					if (o->prune_unmerged) {
+						o->has_unmerged =3D 1;
+						/* leave src[0] as NULL and go over all other staged entries */
+						continue;
+					}
 				}
 				src[0] =3D ce;
 			}
diff --git a/unpack-trees.h b/unpack-trees.h
index 93ec3c6..86f0989 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -43,6 +43,8 @@ struct unpack_trees_options {
 		     verbose_update:1,
 		     aggressive:1,
 		     skip_unmerged:1,
+		     prune_unmerged:1,
+		     has_unmerged:1,
 		     initial_checkout:1,
 		     gently:1;
 	const char *prefix;
--=20
1.6.0.3.890.g95457
