From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3]  use alloc_ref_from_str() everywhere
Date: Sat, 18 Oct 2008 10:41:33 +0200
Message-ID: <48F9A13D.3090401@lsrfire.ath.cx>
References: <48F9A054.4010703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 18 10:42:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr7Oc-0001Bd-Az
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 10:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbYJRIli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 04:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbYJRIli
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 04:41:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:37961 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYJRIlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 04:41:37 -0400
Received: from [10.0.1.101] (p57B7E475.dip.t-dialin.net [87.183.228.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 180992F8058;
	Sat, 18 Oct 2008 10:41:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48F9A054.4010703@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98528>

Replace pairs of alloc_ref() and strcpy() with alloc_ref_from_str(),
simplifying the code.

In connect.c, also a pair of alloc_ref() and memcpy() is replaced --
the additional cost of a strlen() call should not have too much of an
impact.  Consistency and simplicity are more important.

In remote.c, the code was allocating 11 bytes more than needed for
the name part, but I couldn't see them being used for anything.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 connect.c   |    3 +--
 remote.c    |    3 +--
 transport.c |    6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index 67d2cd8..b69060b 100644
--- a/connect.c
+++ b/connect.c
@@ -90,9 +90,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			continue;
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
-		ref = alloc_ref(name_len + 1);
+		ref = alloc_ref_from_str(buffer + 41);
 		hashcpy(ref->old_sha1, old_sha1);
-		memcpy(ref->name, buffer + 41, name_len + 1);
 		*list = ref;
 		list = &ref->next;
 	}
diff --git a/remote.c b/remote.c
index 98cbcf9..44d681d 100644
--- a/remote.c
+++ b/remote.c
@@ -878,8 +878,7 @@ static struct ref *try_explicit_object_name(const char *name)
 	struct ref *ref;
 
 	if (!*name) {
-		ref = alloc_ref(20);
-		strcpy(ref->name, "(delete)");
+		ref = alloc_ref_from_str("(delete)");
 		hashclr(ref->new_sha1);
 		return ref;
 	}
diff --git a/transport.c b/transport.c
index 5110c56..3d03475 100644
--- a/transport.c
+++ b/transport.c
@@ -75,15 +75,14 @@ static int read_loose_refs(struct strbuf *path, int name_offset,
 
 			if (fd < 0)
 				continue;
-			next = alloc_ref(path->len - name_offset + 1);
+			next = alloc_ref_from_str(path->buf + name_offset);
 			if (read_in_full(fd, buffer, 40) != 40 ||
 					get_sha1_hex(buffer, next->old_sha1)) {
 				close(fd);
 				free(next);
 				continue;
 			}
 			close(fd);
-			strcpy(next->name, path->buf + name_offset);
 			(*tail)->next = next;
 			*tail = next;
 		}
@@ -127,14 +126,13 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 				      (*list)->next->name)) > 0)
 			list = &(*list)->next;
 		if (!(*list)->next || cmp < 0) {
-			struct ref *next = alloc_ref(len - 40);
+			struct ref *next = alloc_ref_from_str(buffer + 41);
 			buffer[40] = '\0';
 			if (get_sha1_hex(buffer, next->old_sha1)) {
 				warning ("invalid SHA-1: %s", buffer);
 				free(next);
 				continue;
 			}
-			strcpy(next->name, buffer + 41);
 			next->next = (*list)->next;
 			(*list)->next = next;
 			list = &(*list)->next;
-- 
1.6.0.2.542.gde55
