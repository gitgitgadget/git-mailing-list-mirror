From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/WIP 2/7] fast-import: be saner with temporary trees
Date: Thu, 28 Jul 2011 10:46:05 +0600
Message-ID: <1311828370-30477-3-git-send-email-divanorama@gmail.com>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 06:43:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIRk-0004W6-J1
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab1G1Ena (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:43:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33373 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1G1En1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:43:27 -0400
Received: by fxh19 with SMTP id 19so881739fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 21:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+q6GlSV0bJOkBPLKULYP5dBRWpk7omVL3IzwEGefdGo=;
        b=EjvwXSoRzxuSk4wxS/YWNbZavc3vpS5/pQmQ3GUKjX74kpu60sark+bXJOQpBMmRlj
         xRP1WGQx+fKl8c1dIDqx5b5hsep39tIMmhNJd1ZERwn94eoO6hIV5bRR8JHfrWB5Aoer
         U+wcR2yuILMu6Cml/lPn+Xt3ZZ0IX2e/UVQp8=
Received: by 10.204.142.69 with SMTP id p5mr156866bku.362.1311828205891;
        Wed, 27 Jul 2011 21:43:25 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id r24sm146189bkr.26.2011.07.27.21.43.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 21:43:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178009>

new_tree_entry() doesn't zero or otherwise initialize the returned
entry, neither does release_tree_entry(). So it is quite possible
to get previously released data in a new entry.

parse_ls doesn't set entry->versions[0] fields, but it does call
store_tree(entry) which looks for this base sha1 and tries to do
delta compression with that random object.

Reset entry->versions[0] fields to make things more predictable
and to avoid surprises here.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 05cc55e..da9cb62 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2968,6 +2968,9 @@ static void parse_ls(struct branch *b)
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
