From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] apply: do not read from the filesystem under --index
Date: Mon,  2 Feb 2015 15:27:28 -0800
Message-ID: <1422919650-13346-3-git-send-email-gitster@pobox.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 00:27:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIQPC-00034P-9K
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 00:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbbBBX1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 18:27:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752461AbbBBX1g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 18:27:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CE3035A8D;
	Mon,  2 Feb 2015 18:27:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=r56g
	EB6CEPZ8BDLmK9moWgHQHco=; b=K1gqTujzjh0EqMAnXGyfParfmK+4AY1mBcOv
	r2RphoR0+hdwtSPKfB4Z97d6i+HxlOvVnY2KH6b8OBGmlnFH6BX1X2w78ZbXbNKO
	ik63bTS00rPAl7R199d0GmYel6tYnmiNVg2qnErtOzL/08NU2qkb3O8us4h4js0X
	Q+K+STo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eA8Uga
	zVihl/K23ppkBAvNuCQLDJb2Im4yIPfZaZqmp0mhs+mA3gkSr0mMhxm6VMPOq5QD
	XML62gs8R/V4hRKhQxx8kE6+OAix0M/al+9pwf5O0qiSJy8mYrN3055MWcgwkILb
	eckuG1lKHzoB/48htM5clrSOkMnBBt82qcf3Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94FA435A8C;
	Mon,  2 Feb 2015 18:27:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B74F35A8B;
	Mon,  2 Feb 2015 18:27:35 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-166-g7339d96
In-Reply-To: <1422919650-13346-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 116133C2-AB33-11E4-AE59-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263293>

We currently read the preimage to apply a patch from the index only
when the --cached option is given.  Do so also when the command is
running under the --index option.  With --index, the index entry and
the working tree file for a path that is involved in a patch must be
identical, so this should not affect the result, but by reading from
the index, we will get the protection to avoid reading an unintended
path beyond a symbolic link automatically.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c751ddf..05eaf54 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3136,7 +3136,7 @@ static int load_patch_target(struct strbuf *buf,
 			     const char *name,
 			     unsigned expected_mode)
 {
-	if (cached) {
+	if (cached || check_index) {
 		if (read_file_or_gitlink(ce, buf))
 			return error(_("read of %s failed"), name);
 	} else if (name) {
-- 
2.3.0-rc2-164-g799cdce
