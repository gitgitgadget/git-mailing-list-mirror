From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3] unpack-trees: fix accidentally quadratic behavior
Date: Fri, 22 Jan 2016 14:58:43 -0500
Message-ID: <1453492723-4907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Fri Jan 22 20:58:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMhrG-0005wD-TY
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 20:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbcAVT6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 14:58:55 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:32886 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbcAVT6y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 14:58:54 -0500
Received: by mail-qg0-f45.google.com with SMTP id b35so65776798qge.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 11:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RPleMGnigUgITaJ4oiUO3Z1mEpuM8PzeGpXEiDzte8M=;
        b=GPzqW3PVFW8CIyGBWplLknK7P97MfiuPSwnEZ/oukzH3oxrXii9QulUs3Ln9MPzX42
         JRZs5Eonhk+0PHwpDKhDWsp6sdx/Vt0etTlKmzlU0HMfmAn2ohIqGbRUdfbmbH4ZvUN5
         gAVdxwjVtHVSjK+JLK8KR5fBEutBVttQzhLU0aGjrQFMIOlDfg5tGA7PsIMD6pxkOaOg
         zczchtGTn58LSotmGOrOQ11sCwYhTnYzDigIvsLDPZN8LpvOBACqw8Yt5gOogy9ULPic
         RkvOxsCQfSSUhnXo1RC0qN9fMkVfZqf4FEnE5UyqLmyB/Kf/AYx7vfjOS5gjJ66uv2EK
         3hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RPleMGnigUgITaJ4oiUO3Z1mEpuM8PzeGpXEiDzte8M=;
        b=JAlhdzibTX+VmL2ELOm3CP6LPOjJyYrpmzhjhBvZHXMmtHVKf8wbhJU9M6ZlEmuTJq
         y9xbdpOF3YylnIOWiekPpdmxYq8/DFY/LqA6JrDcAo4KUEKyhhK9KSiZo75tDXr962A6
         VPihrid0ovegtyk835H8iKDSD+TS/8HGn+If5S2ANkwRlvXjzrAWMaVLb//Z9UNXuwxG
         BiOZyNnifHO5MhUViWAeY1Pj9YiGxxFIJxExOMSiJUo0nVmdOon3hiwqSzfrNQ+pfOR/
         g5iZB6HfmnQbP0+xdcFfDmYT27sYURt4vhvdsnifvmmIYzrsvLGIdG2q0hNRXMM8C2xl
         2Nxg==
X-Gm-Message-State: AG10YOQf3mSpw1w2xRI/JaRwyFtbFd2ZrYcfQQMv2BD+dA5m5PjfO8y/B5rDKgvwE0Y5GQ==
X-Received: by 10.140.86.85 with SMTP id o79mr5977936qgd.3.1453492733617;
        Fri, 22 Jan 2016 11:58:53 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h99sm3415644qge.7.2016.01.22.11.58.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jan 2016 11:58:52 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284589>

While unpacking trees (e.g. during git checkout), when we hit a cache
entry that's past and outside our path, we cut off iteration.

This provides about a 45% speedup on git checkout between master and
master^20000 on Twitter's monorepo.  Speedup in general will depend on
repostitory structure, number of changes, and packfile packing
decisions.

Signed-off-by: David Turner <dturner@twopensource.com>
---
A colleague pointed out that the info->prev test was unnecessary as
ce_in_traverse_path already does that.
---
 unpack-trees.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5f541c2..9f55cc2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -695,8 +695,19 @@ static int find_cache_pos(struct traverse_info *info,
 				++o->cache_bottom;
 			continue;
 		}
-		if (!ce_in_traverse_path(ce, info))
+		if (!ce_in_traverse_path(ce, info)) {
+			/*
+			 * Check if we can skip future cache checks
+			 * (because we're already past all possible
+			 * entries in the traverse path).
+			 */
+			if (info->traverse_path) {
+				if (strncmp(ce->name, info->traverse_path,
+					    info->pathlen) > 0)
+					break;
+			}
 			continue;
+		}
 		ce_name = ce->name + pfxlen;
 		ce_slash = strchr(ce_name, '/');
 		if (ce_slash)
-- 
2.4.2.749.g730654d-twtrsrc
