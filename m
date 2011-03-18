From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 2/3] fetch-pack: progressively use larger handshake windows
Date: Fri, 18 Mar 2011 15:27:39 -0700
Message-ID: <7vzkosrrms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:27:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0i9B-0007IP-68
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025Ab1CRW1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 18:27:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933022Ab1CRW1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 18:27:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB7E14C82;
	Fri, 18 Mar 2011 18:29:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	2xSxlcEIOgEFqDbfmLyWkgw5gg=; b=GIGTkSjl3d4NDOz3vSzUWyJihvgUv6+Se
	AyKghBTQHWcvOgBdW9aKalENU2X1XEbLixhYTtEOyc4DPlN16jzD1PMOKIb6EQ2x
	RFmjCl6kVEgqpYOPmaBmaDWG1CmEe120prtPMjX0pIbVkCUnujuMxhkyrH2KApsg
	rxmzTdq1aM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=hCf1f7cwBUNEHDLuCMV3Zy5PgfSyx8kwrfp5HzRvjocoChYHQ3pyF2sT
	m0T70dV7IpbnYv0egoOTd5DrrGM1divUj0sbEfqxXFOZtCd9nAy8o/TWPhDgHWsx
	AXiivp3bAQUJdsw1d4ShOWOkDpjoxFH1A69bKXHtBN6H7YCDtTw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 869954C7C;
	Fri, 18 Mar 2011 18:29:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 941C44C79; Fri, 18 Mar 2011
 18:29:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29DEE41C-51AF-11E0-8567-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169371>

The client has to dig the history deeper when more recent parts of its
history do not have any overlap with the server it is fetching from. Make
the handshake window exponentially larger as we dig deeper, with a
reasonable upper cap.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This uses rather simpleminded "double up to the limit".

 builtin/fetch-pack.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 20e30f5..b4f34a2 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -219,10 +219,15 @@ static void send_request(int fd, struct strbuf *buf)
 }
 
 #define INITIAL_FLUSH 32
+#define LARGE_FLUSH 1024
 
 static int next_flush(int count)
 {
-	return INITIAL_FLUSH + count;
+	if (count < LARGE_FLUSH)
+		count <<= 1;
+	else
+		count += LARGE_FLUSH;
+	return count;
 }
 
 static int find_common(int fd[2], unsigned char *result_sha1,
