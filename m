From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] parse_object: pass on the original sha1, not the replaced one
Date: Thu, 02 Sep 2010 23:13:20 +0200
Message-ID: <20100902211321.18003.34601.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 23:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrHCI-0006FV-Vp
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 23:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319Ab0IBVPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 17:15:00 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:35860 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755254Ab0IBVO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 17:14:57 -0400
Received: from style.boubyland (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A3C27818159;
	Thu,  2 Sep 2010 23:14:51 +0200 (CEST)
X-git-sha1: 2f52c4a8e339b9adf1dcc1836e0de8049ac935c4 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155208>

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>

Commit 0e87c36 (object: call "check_sha1_signature" with the
replacement sha1) changed the first argument passed to
parse_object_buffer() from "sha1" to "repl". With that change,
the returned obj pointer has the replacement SHA1 in obj->sha1,
not the original one.

But when using lookup_commit() and then parse_commit() on a
commit, we get an object pointer with the original sha1, but
the commit content comes from the replacement commit.

So the result we get from using parse_object() is different
from the we get from using lookup_commit() followed by
parse_commit().

It looks much simpler and safer to fix this inconsistency by
passing "sha1" to parse_object_bufer() instead of "repl".

The commit comment should be used to tell the the replacement
commit is replacing another commit and why. So it should be
easy to see that we have a replacement commit instead of an
original one.

And it is not a problem if the content of the commit is not
consistent with the sha1 as cat-file piped to hash-object can
be used to see the difference.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Since no one resent the original patch with an improved commit
message, here is my try.

 object.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/object.c b/object.c
index 277b3dd..7adfda7 100644
--- a/object.c
+++ b/object.c
@@ -199,7 +199,7 @@ struct object *parse_object(const unsigned char *sha1)
 			return NULL;
 		}
 
-		obj = parse_object_buffer(repl, type, size, buffer, &eaten);
+		obj = parse_object_buffer(sha1, type, size, buffer, &eaten);
 		if (!eaten)
 			free(buffer);
 		return obj;
-- 
1.7.2.2.417.g10a17
