From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/34] mailinfo: fix an off-by-one error in the boundary stack
Date: Mon, 19 Oct 2015 00:28:20 -0700
Message-ID: <1445239731-10677-4-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4sV-0002V5-A3
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbbJSH3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:00 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35488 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbJSH25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:28:57 -0400
Received: by pasz6 with SMTP id z6so22254926pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=EISGXDavxFPBOroSfJqefnzOPNF4cV8fPFldpD/1xh8=;
        b=Hg9vOcHUV72fS0alTWJdShSMphlrJWugr0muiNT3EVyLtfnI4buGEp81swbE5t+bqa
         vR6X+H8aulndhcbOsUdc2uvm+ApNPu79inQH/AZpByGIofEp6wlubq6ivCIEjXuKsIpT
         LVDnuTL7d9DfR288GcX/5Q3g6CTMY0DEkcaFS93NTlfm2RXjjK8FQPKNVJggFtpjqEEW
         L5mMzphD3CxU8wRYcYe6lZhgFiig9ck8PuDmwwzGVF5UY8L0oSqrorFsFUyzuVJXLztz
         1rgYCeCTI3fdq/iNRa9qzIbfy92kaKGDUVDicQuLesU6tKNlj39xw+FQ49JMsCLcnWvt
         EruA==
X-Received: by 10.66.235.194 with SMTP id uo2mr32722981pac.41.1445239737570;
        Mon, 19 Oct 2015 00:28:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id pq4sm34481668pbc.53.2015.10.19.00.28.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:28:57 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279834>

We pre-increment the pointer that we will use to store something at,
so the pointer is already beyond the end of the array if it points
at content[MAX_BOUNDARIES].

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index addc0e0..1566c19 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -185,7 +185,7 @@ static void handle_content_type(struct strbuf *line)
 
 	if (slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
-		if (++content_top > &content[MAX_BOUNDARIES]) {
+		if (++content_top >= &content[MAX_BOUNDARIES]) {
 			fprintf(stderr, "Too many boundaries to handle\n");
 			exit(1);
 		}
-- 
2.6.2-383-g144b2e6
