From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 4/4] builtin-fast-export.c: handle nested tags
Date: Mon, 30 Mar 2009 11:08:57 +0200
Message-ID: <1238404137-6693-4-git-send-email-kusmabite@gmail.com>
References: <1238404137-6693-1-git-send-email-kusmabite@gmail.com>
 <1238404137-6693-2-git-send-email-kusmabite@gmail.com>
 <1238404137-6693-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:10:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDVw-0001sG-1S
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758081AbZC3JJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757752AbZC3JJM
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:09:12 -0400
Received: from mx.getmail.no ([84.208.15.66]:35517 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757622AbZC3JJF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 05:09:05 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KHB00J65AR1J440@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Mar 2009 11:09:01 +0200 (MEST)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KHB000Q8AQYPG60@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Mar 2009 11:09:01 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.30.84610
X-Mailer: git-send-email 1.6.2.1
In-reply-to: <1238404137-6693-3-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115113>

When tags that points to tags are passed to fast-export, an error saying
"Tag [TAGNAME] points nowhere?". This fix calls parse_object() on the object
before referencing it's tag, to ensure the tag-info is fully initialized. In
addition, it inserts a comment to point out where nested tags are handled. This
is consistent with the comment for signed tags.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-fast-export.c  |    5 ++++-
 t/t9301-fast-export.sh |    4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 2070288..b23a502 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -363,7 +363,10 @@ static void get_tags_and_duplicates(struct object_array *pending,
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
@@ -376,7 +379,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 			case OBJ_BLOB:
 				handle_object(tag->object.sha1);
 				continue;
-			default:
+			default: /* OBJ_TAG (nested tags) is already handled */
 				warning("Tag points to object of unexpected type %s, skipping.",
 				        typename(tag->object.type));
 				continue;
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index b587feb..495c051 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -276,7 +276,7 @@ test_expect_success 'set-up a few more tags for tag export tests' '
 # NEEDSWORK: not just check return status, but validate the output
 test_expect_success 'tree_tag'        'git fast-export tree_tag'
 test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
-test_expect_failure 'tag-obj_tag'     'git fast-export tag-obj_tag'
-test_expect_failure 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
+test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
+test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
 test_done
-- 
1.6.2.1
