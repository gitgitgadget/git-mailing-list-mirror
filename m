From: "Paolo G. Giarrusso" <p.giarrusso@gmail.com>
Subject: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Wed,  9 Oct 2013 05:57:25 +0200
Message-ID: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
Cc: "Paolo G. Giarrusso" <p.giarrusso@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 09 05:57:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTkuC-0000IF-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 05:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab3JID5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 23:57:35 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:51079 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3JID5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 23:57:35 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so87750eaj.34
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 20:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=s9+VMZxnz++XwVFQPiemLyLOIUzEemkQX+300gLa+kc=;
        b=gPQcJRmvMTkdOIN5hlUFvSlA53RQB3p48otwtv0cZ1CWaZgHy150LChgPWEb9S80Xk
         1JRmSonf3qZbprdYMkkVOvcdQUOkIXZhDysdyb+B1gcgRI+OdSwFZh+7SlsbuNJEt4mn
         wUUhn7QCg/hULWc/x0OTbWfPc2JTXiIc5u25HZNZPOaq4ISv+KxwLE+LjmOBvpbFQ+mB
         07pqjocg4IjT4snWYkUvK7j+1Q4mto7Ult4DYhEY8MWHNzZXA3V1YC5LqXYI8I2+R0Pu
         F/cb/n3Gp2VznP+rUiGgf3mTmxE4VJIPB23L/ztBaHNmugluYyf5AqvXp+29RK2mo8Xm
         bfXQ==
X-Received: by 10.14.37.4 with SMTP id x4mr8121347eea.16.1381291053726;
        Tue, 08 Oct 2013 20:57:33 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-097-072-161.pools.arcor-ip.net. [188.97.72.161])
        by mx.google.com with ESMTPSA id x47sm83509267eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 20:57:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235800>

Since say uses echo, this uses echo -n, which is not portable - see
19c3c5fdcb35b66b792534c5dc4e8d87a3952d2a.

Without this commit, the output looks like:

...
-n 1891/    1936 (1883)
-n 1892/    1936 (1884)
-n 1893/    1936 (1885)
...

Signed-off-by: Paolo G. Giarrusso <p.giarrusso@gmail.com>
---

Please CC me on replies, as I am not subscribed to this mailing list.
I am tracking this submission via https://github.com/git/git/pull/61, which I'll
duly close myself when the discussion is resolved.

 contrib/subtree/git-subtree.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7d7af03..ebfb78f 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -592,7 +592,9 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
"
+		if [ -z "$quiet" ]; then
+			printf "%s" "$revcount/$revmax ($createcount)
" >&2
+		fi
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
 		if [ -n "$exists" ]; then
-- 
1.8.4
