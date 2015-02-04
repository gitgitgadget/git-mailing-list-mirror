From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] apply: do not read from the filesystem under --index
Date: Tue,  3 Feb 2015 16:44:20 -0800
Message-ID: <1423010662-26497-3-git-send-email-gitster@pobox.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1423010662-26497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 01:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIo57-0004Wn-UI
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 01:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966830AbbBDAob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 19:44:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754651AbbBDAo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 19:44:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D8F2F365D9;
	Tue,  3 Feb 2015 19:44:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/+UY
	2KjVSZsIowvUzi6KtFbLrrw=; b=jFu+8D1Apjzp7DwKN/GU61lqcI+aqkQJyHxg
	4tZWjyZAugbaNOHyAkkzOtcVoM2mmNM3DlyuhuQ6F72r+xWiA+t9yAI+IGIVEnXI
	5UTbhCtmvZeQM1XKt383IaPXQ+waZ4m0z8uKRKKxXzO6NW4hs0pHjdaAoMuJG3KA
	qE6448k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Me5CJH
	4sCPFYSl20VLy2+wQlRqo2nHaeIh5d8GirKkjqZC0EyM4HNnncyZupdjutzhX9iu
	0QW8fjU3/4Sol3iAt7zJF24hWzMc7CHmC1sTyemaLgaiDmdFMpajiJ50FAxoaxg4
	J9KSSoF89+aqpB+p6odw8NUh0z3V+JtBJ7nSs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D017E365D8;
	Tue,  3 Feb 2015 19:44:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53BDF365D7;
	Tue,  3 Feb 2015 19:44:26 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-168-g106c876
In-Reply-To: <1423010662-26497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F84CA13A-AC06-11E4-83B2-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263342>

We currently read the preimage to apply a patch from the index only
when the --cached option is given.  Do so also when the command is
running under the --index option.  With --index, the index entry and
the working tree file for a path that is involved in a patch must be
identical, so this should not affect the result, but by reading from
the index, we will get the protection to avoid reading an unintended
path beyond a symbolic link automatically.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Same as v2

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
2.3.0-rc2-168-g106c876
