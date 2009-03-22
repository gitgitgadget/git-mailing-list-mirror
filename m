From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 4/4] builtin-fast-export.c: handle nested tags
Date: Sun, 22 Mar 2009 21:50:20 +0000
Message-ID: <1237758620-6116-4-git-send-email-kusmabite@gmail.com>
References: <1237758620-6116-1-git-send-email-kusmabite@gmail.com>
 <1237758620-6116-2-git-send-email-kusmabite@gmail.com>
 <1237758620-6116-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 22:52:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVai-0008M7-FM
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 22:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286AbZCVVua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 17:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756575AbZCVVu3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:50:29 -0400
Received: from mx.getmail.no ([84.208.15.66]:36601 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756367AbZCVVuX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 17:50:23 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGX004S1GNXFW30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 22 Mar 2009 22:50:21 +0100 (MET)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGX00MUHGNPLL60@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 22 Mar 2009 22:50:20 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.22.213422
X-Mailer: git-send-email 1.6.2.GIT
In-reply-to: <1237758620-6116-3-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114175>

When tags that points to tags are passed to fast-export, an error saying
"Tag [TAGNAME] points nowhere?". This fix calls parse_object() on the object
before referencing it's tag, to ensure the tag-info is fully initialized. In
addition, it inserts a comment to point out where nested tags are handled. This
is consistent with the comment for signed tags.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-fast-export.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index c3ce320..8083c5f 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -362,7 +362,10 @@ static void get_tags_and_duplicates(struct object_array *pending,
 			break;
 		case OBJ_TAG:
 			tag = (struct tag *)e->item;
+
+			/* handle nested tags */
 			while (tag && tag->object.type == OBJ_TAG) {
+				parse_object(tag->object.sha1);
 				string_list_append(full_name, extra_refs)->util = tag;
 				tag = (struct tag *)tag->tagged;
 			}
-- 
1.6.2.1.226.gcb2dd
