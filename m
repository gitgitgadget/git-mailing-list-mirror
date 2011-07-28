From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/WIP 4/7] fast-import: fix data corruption in store_tree
Date: Thu, 28 Jul 2011 10:46:07 +0600
Message-ID: <1311828370-30477-5-git-send-email-divanorama@gmail.com>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 06:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIRm-0004W6-3w
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab1G1Eni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:43:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33373 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1G1Enb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:43:31 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so881739fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 21:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Jcnz2eJa08Vx665C4AfHKBjGkIAp/3jhzEo+mEuJ7ig=;
        b=eh5VnI0pfb++kzFSk6N2DY/mlrbUqUYm+ki8wtVNTTuWwXuffdzgE+MXkZQyc9kzXT
         5P5Ackhn+1ARRRiEQP5UJap79UQXyEt/2FLGzJMGYwClelAJWGxE+uwqym91+ch0jlBV
         dkTOSY37xuSekvsK0ns0l+3xNTHASh+ZjdXQc=
Received: by 10.204.166.129 with SMTP id m1mr174824bky.350.1311828211263;
        Wed, 27 Jul 2011 21:43:31 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id r24sm146189bkr.26.2011.07.27.21.43.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 21:43:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178014>

store_tree didn't check for S_ISDIR(versions[1].mode), but it did check
for tree != NULL.

It's possible that tree == NULL && S_ISDIR(versions[1].mode) in which
case we need to load_tree and then to store_tree, and not to drop that
entry. Calling load_tree requires S_ISDIR check to be present, that's
why it is added..

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d5915b8..d917ea6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1474,8 +1474,11 @@ static void store_tree(struct tree_entry *root)
 		return;
 
 	for (i = 0; i < t->entry_count; i++) {
-		if (t->entries[i]->tree)
-			store_tree(t->entries[i]);
+		if (!S_ISDIR(t->entries[i]->versions[1].mode))
+			continue;
+		if (!t->entries[i]->tree)
+			load_tree(t->entries[i]);
+		store_tree(t->entries[i]);
 	}
 
 	le = find_object(root->versions[0].sha1);
-- 
1.7.3.4
