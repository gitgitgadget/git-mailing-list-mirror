From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/9] pack-objects: equal objects in size should delta against
 newer objects
Date: Mon, 16 Apr 2007 12:14:51 -0400 (EDT)
Message-ID: <S1030820AbXDPQOy/20070416161454Z+1495@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 16 18:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTrR-0002jZ-JR
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030824AbXDPQOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbXDPQOy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:14:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39242 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030812AbXDPQOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:14:52 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL0004DMGROKS0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:14:51 -0400 (EDT)
Date-warning: Date header was inserted by VL-MH-MR001.ip.videotron.ca
Apparently-To: <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44660>

Before finding best delta combinations, we sort objects by name hash,
then by size, then by their position in memory.  Then we walk the list
backwards to test delta candidates.

We hope that a bigger size usually means a newer objects.  But a bigger
address in memory does not mean a newer object.  So the last comparison
must be reversed.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 62a011e..869ca1a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1276,7 +1276,7 @@ static int type_size_sort(const struct object_entry *a, const struct object_entr
 		return -1;
 	if (a->size > b->size)
 		return 1;
-	return a < b ? -1 : (a > b);
+	return a > b ? -1 : (a < b);  /* newest last */
 }
 
 struct unpacked {
-- 
1.5.1.1.781.g65e8
