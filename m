From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/22] receive-pack: do not reuse old_sha1[] for other things
Date: Fri,  5 Sep 2014 13:54:51 -0700
Message-ID: <1409950510-10209-4-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xk-0005bR-TP
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbaIEUzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51958 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbaIEUzW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4330436636;
	Fri,  5 Sep 2014 16:55:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/7+2
	B18K/epfguSnsG5ScOBe3XM=; b=YnN0z3aTfzGNkrhfcQR8If3cnueVO5QvjzS2
	U+MVzIywfKq4a8F1iLpo0RptqBPGlg166TTG/2DfeYlfZ5W8z+OxZqDykpgjCqWd
	7xWIPoDoIpT294JEvGX1nl/qlfdqTu9JLASyeYLQw1KYqC7py/Oi74oLz0J+qUSf
	eW9KV5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bMjDim
	EVoqcHo5p1xwJxgwXOADhE+FHLMiGnV8AxUreE8Iq+V7GcY5xMg3KruTBT8aHZx9
	L8XlXYTFjZKk/Mczgg6O0Lmt//GnQw/vfKlYY990zD5Z++SLwGGi+YFODKU5DM0M
	ldv/fPsRnP6p66fhbYsj+bgGvkDqfoCgHhTNg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6E0736633;
	Fri,  5 Sep 2014 16:55:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A65BB36630;
	Fri,  5 Sep 2014 16:55:19 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F2461602-353E-11E4-A378-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256523>

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
2.1.0-399-g2df620b
