From: Jonathon Mah <me@jonathonmah.com>
Subject: [PATCHv3 2/2] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 10:40:27 -0800
Message-ID: <CA2B8433-E268-49A1-8D75-FBE6B4B8F182@jonathonmah.com>
References: <FF73A39C-2678-40C2-9E2D-58855AEC4E40@jonathonmah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILvQ-0006uv-N5
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbbBBSkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:40:39 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40344 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932707AbbBBSk0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 13:40:26 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 24A9020357
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 13:40:26 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 02 Feb 2015 13:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:content-type:mime-version:subject:from:in-reply-to
	:date:cc:content-transfer-encoding:message-id:references:to; s=
	mesmtp; bh=VKu3borgC0U0by+gY1C77iTeasE=; b=rlaCma/Pg6OTqdTOX1yK2
	xqpDbXXWIlxkGlDb5eWlLGwWdN7M98abRg49Zac5/b3rGch/+4ZizRJq86iOyDl/
	/wTeQh2tiiFqUla+2+cQhO6U2HUugG8DG+GCswB+H0ZVtOAhW48GRIL+Jj/J0iGU
	Aw0J2LL7qCR5DdTlxJjNcY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:content-type:mime-version
	:subject:from:in-reply-to:date:cc:content-transfer-encoding
	:message-id:references:to; s=smtpout; bh=VKu3borgC0U0by+gY1C77iT
	easE=; b=DCfObev2/NbkoRQ/iaSXG3U2TsetVzw985/uqc2mFARexOm3tcr6iI1
	1IWwFOIG4FB5Z7H7aqW0emmz5Pwu4OcGmV5mw0w+olOCi9WRb/bXR7eOa5QXHJz1
	iUtuaOT46wVJvs/uK3ve+nNsmQXQBdGw5myYYmh/2DMm3K1QEaDU=
X-Sasl-enc: XkJh5odDT7sB+0zw61+BcO7+PzWVW24kgaRLMeYmBODt 1422902425
Received: from [172.16.3.162] (unknown [206.169.144.70])
	by mail.messagingengine.com (Postfix) with ESMTPA id 667ACC0029A;
	Mon,  2 Feb 2015 13:40:25 -0500 (EST)
In-Reply-To: <FF73A39C-2678-40C2-9E2D-58855AEC4E40@jonathonmah.com>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263273>

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
