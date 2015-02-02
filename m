From: Jonathon Mah <me@jonathonmah.com>
Subject: [PATCHv2 2/2] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 10:34:07 -0800
Message-ID: <D37068A8-F7D3-4BF6-986C-09528EF443C6@jonathonmah.com>
References: <0BD44E44-686B-44B2-A4C0-9E14A99BA96B@jonathonmah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:34:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILp8-0002bb-9y
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbbBBSeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:34:10 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53474 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753015AbbBBSeI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 13:34:08 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 1970420A3E
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 13:34:08 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 02 Feb 2015 13:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:content-type:mime-version:subject:from:in-reply-to
	:date:cc:content-transfer-encoding:message-id:references:to; s=
	mesmtp; bh=VKu3borgC0U0by+gY1C77iTeasE=; b=MMv8F++Pp2p8R0lCNtAux
	SYS7XxXqFusPeti3zq0pH/tXxjnTQC6TN05Jc2PN59jlSg7RYzaCzaVIGM7l30Wk
	tCW4GxhBSGRJVXfFkarAm0F8gzPujsqdop4oGQ/a+OnfI5JZMMxk6ozkBbgkTODR
	CJXN2szX0+TeB2ECodZRTA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:content-type:mime-version
	:subject:from:in-reply-to:date:cc:content-transfer-encoding
	:message-id:references:to; s=smtpout; bh=VKu3borgC0U0by+gY1C77iT
	easE=; b=YqdwoJCoXY8I9boOcT8qazSKSag6efgPWlibP3O81Q4IgIujVPQ6GU9
	hhEuIy/vcOq6ltBU27H1QF3q1brUYKHo7BPYtAjLJWv+rtT8X8yaUXwnRNrZ2Zbw
	hxIcPk/uAPltLdPHq4t8sp+dsCs0u6k1/tF/r3/ZLKGEQonSvWis=
X-Sasl-enc: zIkcoABK5Rv+Atkqxs4yUzAM+1PGnCZD+LdKUZwL1566 1422902047
Received: from [172.16.3.162] (unknown [206.169.144.70])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5E873C0028B;
	Mon,  2 Feb 2015 13:34:07 -0500 (EST)
In-Reply-To: <0BD44E44-686B-44B2-A4C0-9E14A99BA96B@jonathonmah.com>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263269>

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
