From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/21] send-pack: clarify that cmds_sent is a boolean
Date: Thu,  4 Sep 2014 13:04:48 -0700
Message-ID: <1409861097-19151-13-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:07:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ1-0001FP-4Y
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbaIDUFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58241 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329AbaIDUFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFF83381D4;
	Thu,  4 Sep 2014 16:05:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kgWn
	D7qqTkgCClrGKIbZPtZ6c/U=; b=cum9Pd0aiLupwpeRgbvOKKHFNaApEhRaSRkl
	893iCcbnPdK81rG876rmhTv92sp8SnI8joBtMQ/DuKC11SWtfKgyWiBEykETe3s9
	0zp5lBIrO3jlm29E/GRcpeFv5K6i3Bfbh2uU/GYzmKnh9iN7KYtqMWTWKKvytOGj
	ea8f/08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Xfe62k
	aeijhR0qcS7l/97Nk2KiK4L6W6W0ZFNcX7L/MuXbkhhezQ16lwkubZE+h4l7ghsj
	nqku8Vn3mfg1V0FKT2MWhWvHkxAgtdVfo2jdty0ntxp4U9mhXzNfPrkY3sl+cmwX
	89ExXGvjCK2dbTTS+fxIkhTle7lvuj1CeWwqU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F61C381D2;
	Thu,  4 Sep 2014 16:05:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BECFC381BE;
	Thu,  4 Sep 2014 16:05:40 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D84C9F26-346E-11E4-A780-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256480>

We use it to make sure that the feature request is sent only once on
the very first request packet (ignoring the "shallow " line, which
was an unfortunate mistake we cannot retroactively fix with existing
receive-pack already deployed in the field) and we set it to "true"
with cmds_sent++, not because we care about the actual number of
updates sent but because it is merely an old idiomatic way.

Set it explicitly to one to clarify that the code that uses this
variable only cares about its zero-ness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index f3262f2..05926d2 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -304,15 +304,16 @@ int send_pack(struct send_pack_args *args,
 
 		old_hex = sha1_to_hex(ref->old_sha1);
 		new_hex = sha1_to_hex(ref->new_sha1);
-		if (!cmds_sent)
+		if (!cmds_sent) {
 			packet_buf_write(&req_buf,
 					 "%s %s %s%c%s",
 					 old_hex, new_hex, ref->name, 0,
 					 cap_buf.buf);
-		else
+			cmds_sent = 1;
+		} else {
 			packet_buf_write(&req_buf, "%s %s %s",
 					 old_hex, new_hex, ref->name);
-		cmds_sent++;
+		}
 	}
 
 	if (args->stateless_rpc) {
-- 
2.1.0-399-g1364b4d
