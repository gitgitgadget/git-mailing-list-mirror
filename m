From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/21] receive-pack: do not reuse old_sha1[] for other things
Date: Thu,  4 Sep 2014 13:04:39 -0700
Message-ID: <1409861097-19151-4-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHr-0000jh-8x
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbaIDUFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62119 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbaIDUFR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B879538162;
	Thu,  4 Sep 2014 16:05:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=quG/
	EwwmkfzkZjUoiwkzdBNvLQs=; b=kCi1sT58WAf6mXLvUvVdDMkmXeCWn6AB1yfb
	ZdCJp5luYBkBeEuDY/GaqgDPow5R69YBBfLXeb5txtBYD6xToPt1asSHgApx0iYL
	sLf8stYZkqUYvQ2FPF+RvdjUNhkal1g+a60MMbV0E79ZcVitTgGCYZy8P30Jci0t
	V3MG9Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dibTgE
	ibKZYvjXCjvREssbFJ2kLNzttjc+GYHwWJFZTfIw7hjYIeZ22ogVgkz3G292OSf0
	f4j18N5vVJFMhZNdCkFmo0VdRLLF5aoqVhSuxBRP8fw9LJr2gxNkEOIVmfJlWhO1
	GKgb2JOmdh2EDWdqRDfyI0+tRVbF/ti45JWxE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74BD938161;
	Thu,  4 Sep 2014 16:05:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 44BEE38150;
	Thu,  4 Sep 2014 16:05:10 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C61EBEC4-346E-11E4-99AA-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256461>

This piece of code reads object names of shallow boundaries, not
old_sha1[], i.e. the current value the ref points at, which is to be
replaced by what is in new_sha1[].

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a91eec8..c9b92bf 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -847,9 +847,11 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			break;
 
 		if (len == 48 && starts_with(line, "shallow ")) {
-			if (get_sha1_hex(line + 8, old_sha1))
-				die("protocol error: expected shallow sha, got '%s'", line + 8);
-			sha1_array_append(shallow, old_sha1);
+			unsigned char sha1[20];
+			if (get_sha1_hex(line + 8, sha1))
+				die("protocol error: expected shallow sha, got '%s'",
+				    line + 8);
+			sha1_array_append(shallow, sha1);
 			continue;
 		}
 
-- 
2.1.0-399-g1364b4d
