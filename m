From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/5] log-tree: rely upon the check in the gpg_interface
Date: Thu, 14 Feb 2013 17:04:43 +0100
Message-ID: <a266fc66b482fa63dd2dd4db4862a073a0c83296.1360857415.git.git@drmicha.warpmail.net>
References: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
Cc: Mariusz Gronczewski <xani666@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 17:05:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61JD-0004kJ-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761178Ab3BNQEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:04:50 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41956 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758047Ab3BNQEs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 11:04:48 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E232620A48;
	Thu, 14 Feb 2013 11:04:47 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 14 Feb 2013 11:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=+P
	BIXTpQP8ezVhcyEqAOvpSLpug=; b=mv7+YDQPW/hKQPwunaMfRt2UEb4yXRCBOq
	EMb1Y5gofqWrVhGm481x5GdJa60lS2hZ2gd0v55Z5M0qcKJqWFKyk/yR3TKJgpgL
	fiL/b2VtG3hnZrjilAZrLa1i5OvokymV98i/dzMSiqUIOi10RLHg2UZB2i/usB5E
	6HXZNyjlk=
X-Sasl-enc: TgR4ak+OCwAdDJdEc2NZq1SyZ/yH/aCmnIGC+syP2Pmj 1360857887
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7FEA8482573;
	Thu, 14 Feb 2013 11:04:47 -0500 (EST)
X-Mailer: git-send-email 1.8.1.3.797.ge0260c7
In-Reply-To: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
In-Reply-To: <cover.1360857415.git.git@drmicha.warpmail.net>
References: <cover.1360857415.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216314>

It's just so much betterer.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 log-tree.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5dc45c4..912fe08 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -508,20 +508,17 @@ static void show_one_mergetag(struct rev_info *opt,
 	gpg_message_offset = verify_message.len;
 
 	payload_size = parse_signature(extra->value, extra->len);
-	if ((extra->len <= payload_size) ||
-	    (verify_signed_buffer(extra->value, payload_size,
-				  extra->value + payload_size,
-				  extra->len - payload_size,
-				  &verify_message) &&
-	     verify_message.len <= gpg_message_offset)) {
-		strbuf_addstr(&verify_message, "No signature\n");
-		status = -1;
-	}
-	else if (strstr(verify_message.buf + gpg_message_offset,
-			": Good signature from "))
-		status = 0;
-	else
-		status = -1;
+	status = -1;
+	if (extra->len > payload_size)
+		if (verify_signed_buffer(extra->value, payload_size,
+					 extra->value + payload_size,
+					 extra->len - payload_size,
+					 &verify_message)) {
+			if (verify_message.len <= gpg_message_offset)
+				strbuf_addstr(&verify_message, "No signature\n");
+			else
+				status = 0;
+		}
 
 	show_sig_lines(opt, status, verify_message.buf);
 	strbuf_release(&verify_message);
-- 
1.8.1.3.797.ge0260c7
