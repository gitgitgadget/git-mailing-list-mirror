From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: Don't infinite loop during die()
Date: Wed, 24 Mar 2010 14:37:44 -0700
Message-ID: <7veij91jvb.fsf@alter.siamese.dyndns.org>
References: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
 <20100322142204.GB8916@spearce.org> <7vvdclk1y9.fsf@alter.siamese.dyndns.org>
 <20100324200658.GA22505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brady Catherman <brady@catherman.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 22:38:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuYH3-000358-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 22:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab0CXVhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 17:37:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab0CXVhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 17:37:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8EF7A40B3;
	Wed, 24 Mar 2010 17:37:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Dv8zGK1a2/qGPif9EOemHUCkrc=; b=hdpP0S
	UmHBmH1XG1YSXQKJT5IC2DWKZcueAfOICqbzvOcIN8Y7jH6hVDV+3d1b1LlBu23I
	69twAKNiQBfrVTy9dn8T6T0iecNSbLrtE7NpFMPTbsGZb9jIiIJ68qrPCfDnGH0I
	keBe8pxErOaIA7TVfKbfJYlIElSG44TPOUDZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/o9pb3uaQkCzXhR2F/CmsFZKvZJGO6t
	Dh6FxoaVQ5IeWLwN5Q13dGIqu7boHlKHdto1bB7pTNpZV/On0nwqS5R2woVgQfY6
	X0Ii/JA37DWYh0VifjHgv6jXyBb0vvIg7xJekY6fgCqO1RcKum7XBgj5Y3LYIrUn
	lQwPtXBP3q4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE36A40B0;
	Wed, 24 Mar 2010 17:37:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E9DCA40A8; Wed, 24 Mar
 2010 17:37:45 -0400 (EDT)
In-Reply-To: <20100324200658.GA22505@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 24 Mar 2010 13\:06\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7E5892BE-378D-11DF-BD2A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143131>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Just exit(0) if dead is true.

heh, very true.

-- >8 --
Subject: [PATCH] fixup! http-backend.c: Don't infinite loop

Now die_webcgi() actually can return during a recursive call into it,
causing

    http-backend.c:554: error: 'noreturn' function does return

The only reason we would come back to the die handler is because we
failed during it, so we cannot report anything anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-backend.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f4d49b6..5e3f277 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -549,8 +549,8 @@ static NORETURN void die_webcgi(const char *err, va_list params)
 		http_status(500, "Internal Server Error");
 		hdr_nocache();
 		end_headers();
-		exit(0);
 	}
+	exit(0); /* keep apache happy */
 }
 
 static char* getdir(void)
