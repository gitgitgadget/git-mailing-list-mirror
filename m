From: Phil Hord <hordp@cisco.com>
Subject: [RFC/PATCH] Fix path prefixing in grep_object
Date: Sat, 24 Aug 2013 21:35:58 -0400
Message-ID: <1377394558-371-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 25 03:39:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDPIJ-0005US-Ig
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 03:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab3HYBgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 21:36:10 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:27396 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab3HYBgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 21:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1158; q=dns/txt; s=iport;
  t=1377394569; x=1378604169;
  h=from:to:cc:subject:date:message-id;
  bh=lqlfTbKNkTPQ8aGT2TNK5ku/WHTcywzxoVHWKGpJfYw=;
  b=YP/1Y8zFOrFHzHoPHhZPHAO9OrUcvPVjwys1J9Yc+FiJpt+cIbid1oEW
   kgsb//fxvIkuRoCcwLyw9GHEPQzKN1lB5nnlOkIqTgFGCcgUbKklraIBL
   Dfj0VA3fAKbhUdO2KMdqvQCCIFYp7wB+ZfSMMmIohcxIjOM8Y3dmQqab2
   A=;
X-IronPort-AV: E=Sophos;i="4.89,949,1367971200"; 
   d="scan'208";a="251358945"
Received: from rcdn-core2-2.cisco.com ([173.37.113.189])
  by rcdn-iport-6.cisco.com with ESMTP; 25 Aug 2013 01:36:09 +0000
Received: from ipsn-lnx-hordp.cisco.com (rtp-hordp-8914.cisco.com [10.117.80.101])
	by rcdn-core2-2.cisco.com (8.14.5/8.14.5) with ESMTP id r7P1a80x006739;
	Sun, 25 Aug 2013 01:36:08 GMT
X-Mailer: git-send-email 1.8.4.557.g34b3a2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232892>

When the pathspec given to grep includes a tree name, the full
name of matched files is assembled using colon as a separator.
If the pathspec includes a tree name, it should use a slash
instead.

Check if the pathspec already names a tree and ref (including
a colon) and use a slash if so.
---

I'm not sure about the detection I used here.  It works, but it is
not terribly robust.  Is there a better way to handle this?  Maybe
something like 'prefix_pathspec(name,"");'.

 builtin/grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 03bc442..d0deae4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -480,8 +480,9 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		len = name ? strlen(name) : 0;
 		strbuf_init(&base, PATH_MAX + len + 1);
 		if (len) {
+			int has_colon = !!strchr(name,':');
 			strbuf_add(&base, name, len);
-			strbuf_addch(&base, ':');
+			strbuf_addch(&base, has_colon?'/':':');
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-- 
1.8.4.557.g34b3a2e
