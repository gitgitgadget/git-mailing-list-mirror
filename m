From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/5] fast-import: check return value from unpack_entry()
Date: Thu, 14 Feb 2008 01:34:34 -0500
Message-ID: <20080214063434.GA30678@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:35:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXhB-0005F9-Qo
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbYBNGei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbYBNGei
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:34:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60629 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbYBNGeh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:34:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXg3-0004UU-Ct; Thu, 14 Feb 2008 01:34:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1983820FBAE; Thu, 14 Feb 2008 01:34:34 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73859>

If the tree object we have asked for is deltafied in the packfile and
the delta did not apply correctly or was not able to be decompressed
from the packfile then we can get back NULL instead of the tree data.
This is (part of) the reason why read_sha1_file() can return NULL, so
we need to also handle it the same way.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a523b17..9b71ccc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1204,6 +1204,8 @@ static void load_tree(struct tree_entry *root)
 			die("Not a tree: %s", sha1_to_hex(sha1));
 		t->delta_depth = myoe->depth;
 		buf = gfi_unpack_entry(myoe, &size);
+		if (!buf)
+			die("Can't load tree %s", sha1_to_hex(sha1));
 	} else {
 		enum object_type type;
 		buf = read_sha1_file(sha1, &type, &size);
-- 
1.5.4.1.1309.g833c2
