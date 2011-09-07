From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Wed, 07 Sep 2011 15:21:12 -0700
Message-ID: <7vpqjc0zaf.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <CAJo=hJtz6fa4XfC-4ghryP_nfg3sbcrE2bKauj+F7w2Z_8Ckvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 00:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1QUj-00084X-Hw
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 00:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343Ab1IGWVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 18:21:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757294Ab1IGWVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 18:21:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 310A35F7F;
	Wed,  7 Sep 2011 18:21:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F532E8kERsKdZbcTbZmwYV7pUtI=; b=KQKLFK
	sRL874ZevV5iHHtwDdqEKxjTOav9HyR4PevxlCGOTGboJ9reR22h3x4LptC+5dGI
	z5V4LZI1Gwms8LE3DAenucYHVzWMRZla5XfZFvh1te1nkUyRTPm4G6XwftBn3ojB
	E6dTqah/MrkgP56R5OOv77nAe70OpH+sDzPBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e9vfPaGzHXuW4jUHXDO++ln4OYTxuKJm
	gJawMZXE6WdanJc8muTinDhd9PoNKoHXuEV82dnuY72RmLwPXvNscc3J4pWfx+C6
	LA4pg5uQzEAsN/3+VK5ika+P4RWoOImNlOQNrcBkxvD2NkEop78SPhm5MIeYyTM3
	ZvtJc9bf5y8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 264EA5F7E;
	Wed,  7 Sep 2011 18:21:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC7E25F7C; Wed,  7 Sep 2011
 18:21:14 -0400 (EDT)
In-Reply-To: <CAJo=hJtz6fa4XfC-4ghryP_nfg3sbcrE2bKauj+F7w2Z_8Ckvw@mail.gmail.com> (Shawn
 Pearce's message of "Wed, 7 Sep 2011 14:18:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2FECB0E-D99F-11E0-B8B3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180922>

Shawn Pearce <spearce@spearce.org> writes:

> Yes. Above we flushed the req_buf and send that in an HTTP request.
> You need to hoist this block above the "if (args->stateless_rpc)"
> segment.

What do you mean by "hoist"? For the req advertisement, it seems that you
are not hoisting anything but duplicating the code, turning safe_write()
followed by flush into packet-buf-flush and sending the result over the
sideband. Shouldn't this new data be sent over the sideband-to-http the
same way?

Unless you do not want signed push over http, that is...

 builtin/send-pack.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 3193f34..37e0313 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -379,9 +379,13 @@ int send_pack(struct send_pack_args *args,
 			packet_buf_write(&req_buf, "%.*s",
 					 (int)(ep - cp), cp);
 		}
-		/* Do we need anything funky for stateless rpc? */
-		safe_write(out, req_buf.buf, req_buf.len);
-		packet_flush(out);
+		if (args->stateless_rpc) {
+			packet_buf_flush(&req_buf);
+			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
+		} else {
+			safe_write(out, req_buf.buf, req_buf.len);
+			packet_flush(out);
+		}
 	}
 	strbuf_release(&req_buf);
 
