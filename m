From: Jonathon Mah <me@jonathonmah.com>
Subject: [PATCH 2/2] sha1_file: fix iterating loose alternate objects
Date: Sun, 1 Feb 2015 13:55:33 -0800
Message-ID: <50251CB8-0885-40FF-A7C9-9C9460266E14@jonathonmah.com>
References: <BF4AA771-DEB5-4DED-9C74-768036C1E2DD@jonathonmah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 22:55:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI2UW-0000Oo-7G
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 22:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbbBAVzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 16:55:35 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47821 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753635AbbBAVzf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 Feb 2015 16:55:35 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9FF71208C5
	for <git@vger.kernel.org>; Sun,  1 Feb 2015 16:55:34 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Sun, 01 Feb 2015 16:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:content-type:mime-version:subject:from:in-reply-to
	:date:cc:content-transfer-encoding:message-id:references:to; s=
	mesmtp; bh=VKu3borgC0U0by+gY1C77iTeasE=; b=k14Go5YiuMs84cPuBjVWO
	qFj+v4DnzYFNAcaIVBI4gPCjSxc2hiqrq5f6gqh6idasqFELhbb3p7c3y6DYUWHu
	ijhfsp0EG80HhEEQeF5xC7vPoRna9/u7uY6mUJSdutsJ5vTTw2xgl5QfKxfoEgvo
	893j4B3avQILzOqS+xkS8E=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:content-type:mime-version
	:subject:from:in-reply-to:date:cc:content-transfer-encoding
	:message-id:references:to; s=smtpout; bh=VKu3borgC0U0by+gY1C77iT
	easE=; b=Ra58c+2EEXt8gsDvsCwitfKbJ5DI2o7a6R0Uypk0QyoCMZwkh+3I16S
	HL76DB+FHTXOqYe0mi4km54T8eMHXmcIJQB1mlWwIdc9S5ea0Tr+Z+jPdSI7yTG4
	hdILzwyslYeXY6s84KngwxC72eP7Y5lFkT1pUZ35u/0m1E48mdv0=
X-Sasl-enc: +85+c3BV6jRYsmrJ+/7RBwRZqKLTFBTzyhQYNR8j+d1J 1422827734
Received: from [172.16.60.11] (unknown [24.5.84.102])
	by mail.messagingengine.com (Postfix) with ESMTPA id E2766680085;
	Sun,  1 Feb 2015 16:55:33 -0500 (EST)
In-Reply-To: <BF4AA771-DEB5-4DED-9C74-768036C1E2DD@jonathonmah.com>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263240>

The string in 'base' contains a path suffix to a specific object; when
its value is used, the suffix must either be filled (as in
stat_sha1_file, open_sha1_file, check_and_freshen_nonlocal) or cleared
(as in prepare_packed_git) to avoid junk at the end.  loose_from_alt_odb
(introduced in 660c889e46d185dc98ba78963528826728b0a55d) did neither and
treated 'base' as a complete path to the "base" object directory,
instead of a pointer to the "base" of the full path string.

The trailing path after 'base' is still initialized to NUL, hiding the
bug in some common cases.  Additionally the descendent
for_each_file_in_obj_subdir function swallows ENOENT, so an error only
shows if the alternate's path was last filled with a valid object
(where statting /path/to/existing/00/0bjectfile/00 fails).

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
 sha1_file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 30995e6..fcb1c4b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3396,9 +3396,13 @@ static int loose_from_alt_odb(struct alternate_object_database *alt,
 			      void *vdata)
 {
 	struct loose_alt_odb_data *data = vdata;
-	return for_each_loose_file_in_objdir(alt->base,
-					     data->cb, NULL, NULL,
-					     data->data);
+	int r;
+	alt->name[-1] = 0;
+	r = for_each_loose_file_in_objdir(alt->base,
+					  data->cb, NULL, NULL,
+					  data->data);
+	alt->name[-1] = '/';
+	return r;
 }
 
 int for_each_loose_object(each_loose_object_fn cb, void *data)
-- 
2.3.0.rc2.2.g184f7a0
