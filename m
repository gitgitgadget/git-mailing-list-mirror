From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 12/23] send-pack: clarify that cmds_sent is a boolean
Date: Mon, 15 Sep 2014 15:24:13 -0700
Message-ID: <1410819864-22967-13-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:25:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeiT-0006iF-K2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbaIOWZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:25:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60320 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758708AbaIOWYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C8623B1B8;
	Mon, 15 Sep 2014 18:24:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FZiZ
	J155ukJpx8cQnXYA51crX2k=; b=E3UpZuZ2NJ3ZoQy5oHHTWWhJxdNEUsrsL1Q+
	62O1mRf5rha0Y+eD/O5Dl+5B+EEWl/Ij9oamgAkIubMUn+1dgqrxgzjD6jilYTGF
	wMqS1NYunn8lg0SIQfpmrRiy9KtUg0T7VcgCC86Pa2d2LO7l0uCtybzxwMXRLKih
	Sp2ozQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=P5wjHW
	NbYffnhA06IF2uDuxhIONAPw4jmQEjEemd8oaLPQe6rBcPQNzoEcSL0TvfOIcKoq
	F0DI5w3IehA9IO2Ni+q2EZ1/nJ+TXWUh5Xp5yaIMLgbWyK6TetRtAgctd9cziS2F
	uRRbbD5MPtC8SpI27ACGE7yDkhurjWtip94zQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4471E3B1B7;
	Mon, 15 Sep 2014 18:24:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BD5E03B1B6;
	Mon, 15 Sep 2014 18:24:49 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1B3B6450-3D27-11E4-BB23-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257108>

We use it to make sure that the feature request is sent only once on
the very first request packet (ignoring the "shallow " line, which
was an unfortunate mistake we cannot retroactively fix with existing
receive-pack already deployed in the field) and we set it to "true"
with cmds_sent++, not because we care about the actual number of
updates sent but because it is merely an idiomatic way.

Set it explicitly to one to clarify that the code that uses this
variable only cares about its zero-ness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6dc8a46..bb13599 100644
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
2.1.0-410-gd72dacd
