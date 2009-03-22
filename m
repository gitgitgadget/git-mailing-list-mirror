From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 3/4] builtin-fast-export.c: fix crash on tagged trees
Date: Sun, 22 Mar 2009 21:50:19 +0000
Message-ID: <1237758620-6116-3-git-send-email-kusmabite@gmail.com>
References: <1237758620-6116-1-git-send-email-kusmabite@gmail.com>
 <1237758620-6116-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 22:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVah-0008M7-Pu
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 22:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbZCVVu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 17:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756507AbZCVVu0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:50:26 -0400
Received: from mx.getmail.no ([84.208.15.66]:42013 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756164AbZCVVuW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 17:50:22 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGX006J3GNVVID0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 22 Mar 2009 22:50:19 +0100 (MET)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGX00MUHGNPLL60@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 22 Mar 2009 22:50:19 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.22.213422
X-Mailer: git-send-email 1.6.2.GIT
In-reply-to: <1237758620-6116-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114176>

If a tag object points to a tree (or another unhandled type), the commit-
pointer is left uninitialized and later dereferenced. This patch adds a default
case to the switch that issues a warning and skips the object.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-fast-export.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 02bad1f..c3ce320 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -375,6 +375,10 @@ static void get_tags_and_duplicates(struct object_array *pending,
 			case OBJ_BLOB:
 				handle_object(tag->object.sha1);
 				continue;
+			default: /* OBJ_TAG (nested tags) is already handled */
+				warning("Tag points to object of unexpected type %s, skipping.",
+				        typename(tag->object.type));
+				continue;
 			}
 			break;
 		default:
-- 
1.6.2.1.226.gcb2dd
