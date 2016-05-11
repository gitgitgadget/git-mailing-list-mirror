From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] am: plug FILE * leak in split_mail_conv()
Date: Wed, 11 May 2016 16:35:46 -0700
Message-ID: <20160511233546.13090-2-gitster@pobox.com>
References: <20160511233546.13090-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:36:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0dfc-0002C7-23
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 01:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbcEKXfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 19:35:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932113AbcEKXfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 19:35:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DECA81A598;
	Wed, 11 May 2016 19:35:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tPRm
	VXPU8LJ8tiNOJB5QpGwxjP8=; b=irs7I10Kej9b9dHxXSmRCjNrKCx1kw4kA704
	2Zryc5g17nc6zxzRD3JJFTGrBkqqlcGNK3vgJOson7JU5yiNECxANAjgcUQMgrWq
	jhyolGrj7NXnxCU7SlfBiwH5DH8if5tsD4ONHsrorgXIom00pKo9LhVmLWvtDgoG
	ytJEKyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=UofBsK
	zITam00TXSbV0/E8v0L/uy84JlRyTdZEzAphNqNkPZETlja20EwaHWW4/pdBSf7R
	RdovP9zGdV8GZLNokG1cpK800g1U83uJAzwucdTYuWfiPcWLRyhIXkIkD24dKxCv
	WLHSrwumz/+eTsiFcYBlQmBfObIwNRwtiIn08=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D64291A597;
	Wed, 11 May 2016 19:35:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 586801A596;
	Wed, 11 May 2016 19:35:50 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-679-g91c6421
In-Reply-To: <20160511233546.13090-1-gitster@pobox.com>
X-Pobox-Relay-ID: 183EC23E-17D1-11E6-9C02-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294377>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index f1a84c6..a373928 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -761,9 +761,11 @@ static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
 		mail = mkpath("%s/%0*d", state->dir, state->prec, i + 1);
 
 		out = fopen(mail, "w");
-		if (!out)
+		if (!out) {
+			fclose(in);
 			return error(_("could not open '%s' for writing: %s"),
 					mail, strerror(errno));
+		}
 
 		ret = fn(out, in, keep_cr);
 
-- 
2.8.2-679-g91c6421
