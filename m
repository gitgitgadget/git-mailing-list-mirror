From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/2] fast-import: be saner with temporary trees
Date: Tue, 16 Aug 2011 16:08:56 +0600
Message-ID: <1313489337-2523-2-git-send-email-divanorama@gmail.com>
References: <1313489337-2523-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 12:08:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGZ2-0006vP-JQ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 12:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab1HPKIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 06:08:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62745 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab1HPKH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 06:07:58 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3592725bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dhMPeU3U+3oI+h812a914o89g4o1AZoKzqbGoHBnbm8=;
        b=n6GaCJDD41WTE+kMPi3aIzmR3ETo2xplMHtWz4ht3MSRW2LzHCCd7hjdh3+TPkOrn/
         If0XsfIR4qxKR8lexDddij/1VEE+/2AmYmL8R6O3iUshjcvwfxg5cZqtSFJopBjVFMJK
         guVuNmhiMBcF+ComhGE/k2fOPBi1M35A8cWAA=
Received: by 10.204.168.193 with SMTP id v1mr1338010bky.90.1313489277581;
        Tue, 16 Aug 2011 03:07:57 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id y8sm1836823bks.54.2011.08.16.03.07.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 03:07:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313489337-2523-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179425>

new_tree_entry/release_tree_entry manage a stack of tree_entry structs
to use as temporaries. Initializing them is the responsibility of the
caller, both after allocation with xmalloc() when existing temporaries
are exhausted and after used entries are pushed with release_tree_entry.

parse_ls doesn't set root->versions[0] fields, making root an invalid
entry. The problem could arise if store_tree(root) is called. parse_ls
calls store_tree on the node corresponding to the path it is called on.

Do initialize entry->versions[0]. As of now, ls command can not list
the topmost tree so this change is just to avoid surprises in case
things will change around ls or tree_content_get.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7cc2262..3a0aaad 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2951,6 +2951,9 @@ static void parse_ls(struct branch *b)
 	} else {
 		struct object_entry *e = parse_treeish_dataref(&p);
 		root = new_tree_entry();
+		hashclr(root->versions[0].sha1);
+		root->versions[0].mode = 0;
+		root->versions[1].mode = S_IFDIR;
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
 		load_tree(root);
 		if (*p++ != ' ')
-- 
1.7.3.4
