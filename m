From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 01/16] list-objects: mark tree as unparsed when we free its buffer
Date: Tue, 25 Jun 2013 01:22:58 +0200
Message-ID: <1372116193-32762-2-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:23:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG6r-00031D-FW
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab3FXXXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:23:42 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34598 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3FXXXl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:41 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so8795887wgh.27
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2ehA3+720A91LrT4/kEd98xbRtPAalr+ZzO9qtDGjao=;
        b=olVcWrMUXzTu/r/A5maZs9tGUgfadp0Br1V9xmCWypy1dH0ujbibxXX3INww9sb7oD
         9q4ZpbzmUra92Qac/29Mu7ZuuKv5rovJ5nEGvJn54Bdfz7wyXhfY5GQgVzRVk9CYuxpT
         NvXaKoV++pJvfVxLC8XZ2kCOKioi+AsbBJMtNj1D8LPMyIcmooyAa6OM9U615M2QL+FE
         7aPVCp42/7sIrbCS4Frukm7NM+KGlibbEjEr0ll9aZCrzwMyeNxeDsS29OcLZ1qjanB5
         ecCNvGM/p3r0QRQqKPAb5SROKZW975IMoB3NHeyuHFhoZTWVm6++ZkpOrgdDlcz6EeLt
         wAVA==
X-Received: by 10.180.182.229 with SMTP id eh5mr7346176wic.63.1372116219914;
        Mon, 24 Jun 2013 16:23:39 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228919>

From: Jeff King <peff@peff.net>

We free the tree buffer during traversal to save memory.
However, we do not reset the "parsed" flag, which leaves a
landmine for the next person to use the tree. When they call
parse_tree it will do nothing, and they will segfault when
they try to access the buffer.

This hasn't mattered until now because most rev-list
traversals would exit the program immediately afterwards,
but the bitmap writer wants to access the trees twice.
---
 list-objects.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..1251180 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -125,6 +125,7 @@ static void process_tree(struct rev_info *revs,
 	strbuf_setlen(base, baselen);
 	free(tree->buffer);
 	tree->buffer = NULL;
+	tree->object.parsed = 0;
 }
 
 static void mark_edge_parents_uninteresting(struct commit *commit,
-- 
1.7.9.5
