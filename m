From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] fetch-pack: factor out hardcoded handshake window size
Date: Fri, 18 Mar 2011 15:26:58 -0700
Message-ID: <7v7hbwt68d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 23:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0i8Y-0006yt-IW
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975Ab1CRW1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 18:27:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932917Ab1CRW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 18:27:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E01E74C72;
	Fri, 18 Mar 2011 18:28:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=M
	P3DRX35XmTQeUCfE/cB9DiwPxQ=; b=VKhQYwgTeXG64KunHd0lqmTcEPNvTWV4A
	7oO7G0zpKbkY9yoQ16XuyPp6lM+SEpyxgjVScPJZzWeMwe11QGYauJKYLNm8HhVF
	yGaOJ66SSO7MesY/b9GobYEkmxPNvrtxhtSIPeJeOYp4DsBArc+FkPVhOLFaHThD
	vKqAamdWnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=HnzLH41XikrA1Dkti9zQKLJnDwTbAFRTNLonkXX+ZTRFHMBHPs7pIjtR
	Xa1QMv4hvftrxtW34arSKbBi7W76yka0g6kZaRo13hs6B+S2e4H9oQV2zJt+d8C3
	CEsCRyxLWAQ8xOF4XuAhOVcG60Ymg4VVl43uQH5N8/rinrzjG7g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE4164C71;
	Fri, 18 Mar 2011 18:28:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C62EA4C6F; Fri, 18 Mar 2011
 18:28:34 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 119197E2-51AF-11E0-9A6E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169370>

The "git fetch" client presents the most recent 32 commits it has to the
server and gives a chance to the server to say "ok, we heard enough", and
continues reporting what it has in chunks of 32 commits, digging its
history down to older commits.

Move the hardcoded size of the handshake window outside the code, so that
we can tweak it more easily.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I don't want to be stepping on your toes, but the first step was very
   trivial.  Goes on top of the sp/maint-fetch-pack-stop-early topic.

 builtin/fetch-pack.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 59fbda5..20e30f5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -218,11 +218,18 @@ static void send_request(int fd, struct strbuf *buf)
 		safe_write(fd, buf->buf, buf->len);
 }
 
+#define INITIAL_FLUSH 32
+
+static int next_flush(int count)
+{
+	return INITIAL_FLUSH + count;
+}
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
 	int fetching;
-	int count = 0, flushes = 0, retval;
+	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
 	const unsigned char *sha1;
 	unsigned in_vain = 0;
 	int got_continue = 0;
@@ -335,19 +342,20 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		if (args.verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
 		in_vain++;
-		if (!(31 & ++count)) {
+		if (flush_at <= ++count) {
 			int ack;
 
 			packet_buf_flush(&req_buf);
 			send_request(fd[1], &req_buf);
 			strbuf_setlen(&req_buf, state_len);
 			flushes++;
+			flush_at = next_flush(count);
 
 			/*
 			 * We keep one window "ahead" of the other side, and
 			 * will wait for an ACK only on the next one
 			 */
-			if (!args.stateless_rpc && count == 32)
+			if (!args.stateless_rpc && count == INITIAL_FLUSH)
 				continue;
 
 			consume_shallow_list(fd[0]);
-- 
1.7.4.1.496.ga3201
