From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] notes: Use get_sha1_committish instead of read_ref in init_notes()
Date: Wed, 17 Jun 2015 10:15:31 +0900
Message-ID: <1434503731-26414-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 03:15:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z51xI-0007Zu-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 03:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbbFQBPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 21:15:43 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:60006 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772AbbFQBPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 21:15:41 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Z51wx-0006sh-Vi; Wed, 17 Jun 2015 10:15:31 +0900
X-Mailer: git-send-email 2.4.3.2.gf0a024e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271806>

init_notes() is essentially the only point of entry to the notes API.
It is an arbitrary restriction that all it allows as input is a strict
ref name, when callers may want to give an arbitrary committish.

This has the side effect of enabling the use of committish as notes refs
in commands allowing them, e.g. git log --notes=foo@{1}, although
I haven't checked whether that's the case for all of them.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

My motivation for this change is to allow to use init_notes from a
third-party helper that links to libgit.a with a commit that is not
pointed at directly by a ref. The side effect of making git log
--notes=foo@{1} work is nice IMHO. As noted, though, I haven't checked if
all code paths using init_notes don't prefilter the ref, but I assume
they don't. 

 notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index df08209..402e4ce 100644
--- a/notes.c
+++ b/notes.c
@@ -1012,7 +1012,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
-	    read_ref(notes_ref, object_sha1))
+	    get_sha1_committish(notes_ref, object_sha1))
 		return;
 	if (get_tree_entry(object_sha1, "", sha1, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
-- 
2.4.3.2.gf0a024e.dirty
