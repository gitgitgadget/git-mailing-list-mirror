From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 3/3] fetch-pack: use smaller handshake window for initial
 request
Date: Fri, 18 Mar 2011 15:27:55 -0700
Message-ID: <7vsjukrrmc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:28:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0i9T-0007Ro-AT
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027Ab1CRW2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 18:28:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933022Ab1CRW2D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 18:28:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02F9E4C85;
	Fri, 18 Mar 2011 18:29:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=1
	mJ0xQXylYYLKnrzZ9fxn5HjBjs=; b=sJSw5g46HJOu4h2l0S6iVoagzHxz+ng1q
	rR5XhjxQuXt4Ukqof7MClTFsJgJWC4iMHsRvTYl5E+3THMa9cmQ+873WsfBZSyBf
	tFs/cJ4unzmOjkZWzsyjHdGvh7QBzx5LKvO6WjGnIfPd9w6dLIDab1Pfjcuik8d/
	FOYKi8Dyxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=jpeUH5XyQl0LMI+qH3wwzermDuyYBEvSDPA8t7yzzSRyrO1ioyz2qZVW
	5clzi3OwKPv3mtZLfyEWm3CgdHe6Ntyn4pvWrUrvKD+r8MdXWbKaCLA8Js2J5MWq
	k0xgMAKlMdFxuT6pjyuehG1Dv5N5zfn7QuoCcO/wbDpGD4rn6YM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4A954C84;
	Fri, 18 Mar 2011 18:29:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E33E64C83; Fri, 18 Mar 2011
 18:29:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33985452-51AF-11E0-9A6E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169372>

Start the initial request small by halving the INITIAL_FLUSH (we will try
to stay one window ahead of the server, so we would end up giving twice as
many "have" in flight at the very beginning).  We may want to tweak these
values even more, taking MTU into account.

Signed-off-by: Junio C Hamano <junio@pobox.com>
---
 builtin/fetch-pack.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index b4f34a2..3c2c940 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -218,12 +218,14 @@ static void send_request(int fd, struct strbuf *buf)
 		safe_write(fd, buf->buf, buf->len);
 }
 
-#define INITIAL_FLUSH 32
+#define INITIAL_FLUSH 16
 #define LARGE_FLUSH 1024
 
 static int next_flush(int count)
 {
-	if (count < LARGE_FLUSH)
+	if (count < INITIAL_FLUSH * 2)
+		count += INITIAL_FLUSH;
+	else if (count < LARGE_FLUSH)
 		count <<= 1;
 	else
 		count += LARGE_FLUSH;
