From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] unpack_trees(): keep track of unmerged entries
Date: Wed, 29 Jul 2009 16:49:13 +1000
Message-ID: <1248850154-5469-5-git-send-email-pclouds@gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
 <1248850154-5469-2-git-send-email-pclouds@gmail.com>
 <1248850154-5469-3-git-send-email-pclouds@gmail.com>
 <1248850154-5469-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 08:49:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW2yz-0003qW-88
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 08:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbZG2Gtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 02:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZG2Gtp
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 02:49:45 -0400
Received: from mail-px0-f184.google.com ([209.85.216.184]:40415 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbZG2Gto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 02:49:44 -0400
Received: by mail-px0-f184.google.com with SMTP id 14so404542pxi.33
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zkXZm/ri8pb8QadZbUCiJvMSobgm6kIQpzGqrvRhnCU=;
        b=yGjYd70EE5G2QKw/oF/8KX6b0hFfpUEN8hC6nXO1xr7oOVHYMFCQswcsyVB7N0oLwo
         2X39DbFBYm/w1AAXZAR+qk2u0Kv5Le9ok/P/qKXaxOlLAucNwNJ4zvMrz2Fx1G3/ESao
         Iqt0iQWYT0M0zYcTlpopIB7gjOEgBvYAgdykM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=c63R7l7ipJes9lKS2AWsu2dAl6xD0WCGPgNuWFqGWpf4XNhKkwcROMnWH+WZaecWpq
         DT3t2KjtrdAvwJvrrvU3Qu/BhYMjYgzmXW6mKUx0gnuy86rBW/sfBGTxcsyFxyfkD5EI
         El9cRFMN578u0y4RIprHRDVT+iqdArom/juiQ=
Received: by 10.114.112.14 with SMTP id k14mr13256728wac.139.1248850184920;
        Tue, 28 Jul 2009 23:49:44 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id k35sm853739waf.29.2009.07.28.23.49.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 23:49:43 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 29 Jul 2009 16:49:38 +1000
X-Mailer: git-send-email 1.6.3.2.448.gdf8b6
In-Reply-To: <1248850154-5469-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124313>

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
 builtin-read-tree.c |    6 +++++-
 unpack-trees.c      |    7 +++++++
 unpack-trees.h      |    2 ++
 3 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9c2d634..17ca265 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -113,7 +113,11 @@ int cmd_read_tree(int argc, const char **argv, con=
st char *unused_prefix)
 	argc =3D parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
=20
-	if (read_cache_unmerged() && (opts.prefix || opts.merge))
+	if (opts.reset) {
+		opts.prune_unmerged =3D 1;
+		read_cache();
+	}
+	else if (read_cache_unmerged() && (opts.prefix || opts.merge))
 		die("You need to resolve your current index first");
=20
 	prefix_set =3D opts.prefix ? 1 : 0;
diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..c67eed8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -289,6 +289,7 @@ static int unpack_callback(int n, unsigned long mas=
k, unsigned long dirmask, str
=20
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
+		o->has_unmerged =3D 0;
 		while (o->pos < o->src_index->cache_nr) {
 			struct cache_entry *ce =3D o->src_index->cache[o->pos];
 			int cmp =3D compare_entry(ce, info, p);
@@ -308,6 +309,12 @@ static int unpack_callback(int n, unsigned long ma=
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
index d19df44..aa3ac17 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -26,6 +26,8 @@ struct unpack_trees_options {
 		     verbose_update,
 		     aggressive,
 		     skip_unmerged,
+		     prune_unmerged,
+		     has_unmerged,
 		     initial_checkout,
 		     diff_index_cached,
 		     gently;
--=20
1.6.3.2.448.gdf8b6
