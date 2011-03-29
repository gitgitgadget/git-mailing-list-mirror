From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix potential local deadlock during fetch-pack
Date: Tue, 29 Mar 2011 10:06:19 -0700
Message-ID: <7vtyelsvp0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 19:06:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cNI-0000rQ-LP
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1C2RGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 13:06:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1C2RGb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 13:06:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0B5E467A;
	Tue, 29 Mar 2011 13:08:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	y5+jeU8lUYZobO0da/aoggb1c4=; b=uGQ0joJ/fvyV/henMg/cTP5J8iOK5do/A
	VAIHmiQYIys8KPzeS7Pz1ILdCBU0UdHF4gqvvncNvrDw2bjx4xzlAi5cywdSXH2d
	VUSrePwyQTq+qGYAz2n1cp5ZnmSe1lQW62gNN2WfzWmWWp8Ny5KgvFA2C3rKQftD
	uZNoFXp9uU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=AIVsvKoqQmI3JvD6StF6hdu8meQF0HqkRvIJ58fWYH4UhbQKIVnmiQiH
	URRilBGAtajaWZQy+ILnh93SXQuEkUKLSE8kE3tIK8DhN5I2VahXyOZ2GyeO1z2K
	uHi6RH/zoR4nna0h3Ad9Hf3eR9BNwIlsNG7Hxo02azCBO9c+PAE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEB964676;
	Tue, 29 Mar 2011 13:08:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A8A5E4675; Tue, 29 Mar 2011
 13:08:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FF5763E-5A27-11E0-A267-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170281>

The fetch-pack/upload-pack protocol relies on the underlying transport
(local pipe or TCP socket) to have enough slack to allow one window worth
of data in flight without blocking the writer.  Traditionally we always
relied on being able to have a batch of 32 "have"s in flight (roughly 1.5k
bytes) to stream.

The recent "progressive-stride" change allows "fetch-pack" to send up to
1024 "have"s without reading any response from "upload-pack".  The
outgoing pipe of "upload-pack" can be clogged with many ACK and NAK that
are unread, while "fetch-pack" is still stuffing its outgoing pike with
more "have"s, leading to a deadlock.

Revert the change unless we are in stateless rpc (aka smart-http) mode, as
using a large window full of "have"s is still a good way to help reduce
the number of back-and-forth, and there is no buffering issue there (it is
strictly "ping-pong" without an overlap).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch-pack.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 1724b76..e5fdacd 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -229,16 +229,17 @@ static void insert_alternate_refs(void)
 }
 
 #define INITIAL_FLUSH 16
+#define PIPESAFE_FLUSH 32
 #define LARGE_FLUSH 1024
 
 static int next_flush(int count)
 {
-	if (count < INITIAL_FLUSH * 2)
-		count += INITIAL_FLUSH;
-	else if (count < LARGE_FLUSH)
+	int flush_limit = args.stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUSH;
+
+	if (count < flush_limit)
 		count <<= 1;
 	else
-		count += LARGE_FLUSH;
+		count += flush_limit;
 	return count;
 }
 
