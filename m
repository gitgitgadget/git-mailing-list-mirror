From: Sergey Vlasov <vsu@altlinux.ru>
Subject: pack-objects: Fix segfault when object count is less than thread count
Date: Mon, 21 Jan 2008 17:35:45 +0300
Message-ID: <1200926145-14625-1-git-send-email-vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 15:55:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGy3V-0000mY-J9
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 15:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbYAUOyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 09:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbYAUOyu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 09:54:50 -0500
Received: from master.altlinux.org ([62.118.250.235]:3897 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbYAUOyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 09:54:49 -0500
X-Greylist: delayed 1142 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2008 09:54:49 EST
Received: by master.altlinux.org (Postfix, from userid 584)
	id 0C4F9E3368; Mon, 21 Jan 2008 17:35:46 +0300 (MSK)
X-Mailer: git-send-email 1.5.4.rc4.14.gd50a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71284>

When partitioning the work amongst threads, dividing the number of
objects by the number of threads may return 0 when there are less
objects than threads; this will cause the subsequent code to segfault
when accessing list[sub_size-1].  Fix this by ensuring that sub_size
is not zero if there is at least one object to process.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 builtin-pack-objects.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ec10238..cdf8aae 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1665,6 +1665,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	for (i = 0; i < delta_search_threads; i++) {
 		unsigned sub_size = list_size / (delta_search_threads - i);
 
+		if (sub_size == 0 && list_size >= 1)
+			sub_size = 1;
+
 		p[i].window = window;
 		p[i].depth = depth;
 		p[i].processed = processed;
-- 
1.5.4.rc4.14.gd50a3
