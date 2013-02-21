From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] imap-send: support SNI (RFC4366)
Date: Wed, 20 Feb 2013 21:35:16 -0800
Message-ID: <7vr4kaw7or.fsf@alter.siamese.dyndns.org>
References: <7vbobey0xv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 06:36:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Ooz-0001f2-16
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 06:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241Ab3BUFfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 00:35:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab3BUFfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 00:35:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87E0CB861;
	Thu, 21 Feb 2013 00:35:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3d5cZT4v1KP+IRq1D+eYSPnnRzk=; b=FceTxF
	V1Se8wOkVlKeQYnt4WKc8aPtIu9Mc9UaloRBJpgETWMMg9tyXCIzZ2PEtE7ntfs5
	5LuYVpOhzn4LqvAM2tmC6PUAKoMrQ4fhHpHdkVNmCU/AybMOdjyRJLE3ItSafBYf
	XvOoEHKJK0doVAq290NEVoGpI/ioLqEtQzxkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hG7ivJFs0foxkGr9/cD1KjfofnLqIk6P
	r5+fCxQ7yKzssGK20HSj5KPEZlKHuuic4y9iPbmbgWCstYiJp+dE8O7whjQu57b8
	h8tptHvmbKSK0sRH7xTUDS2IR11xgcUqN8UP51jepII/xYCST+Te8eMQFtL8eMTZ
	CAvn1og63uA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BFF6B860;
	Thu, 21 Feb 2013 00:35:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB769B85F; Thu, 21 Feb 2013
 00:35:17 -0500 (EST)
In-Reply-To: <7vbobey0xv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 20 Feb 2013 16:18:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79AACDC0-7BE8-11E2-A425-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216753>

Junio C Hamano <gitster@pobox.com> writes:

> To talk to a site that serves multiple names on a single IP address,
> the client needs to ask for the specific hostname it wants to talk
> to. Otherwise, the default certificate returned from the IP address
> may not match that of the host we wanted to talk to.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * I need help from people on this patch in two areas:
>
>  (1) I only tested this patch by connecting to https://googlemail.com/ 
>      with
> ...
>      I would appreciate it if somebody knows an imap server that
>      needs SNI and runs an end-to-end test against that server.
> 
>  (2) I do not know if everybody has SSL_set_tslext_host_name() macro
>      defined, so this patch may be breaking build for people with
>      different versions of OpenSSL.

What I queued for tonight replaces the posted patch with this
version in order to address (2) above.

-- >8 --
Subject: [PATCH] imap-send: support SNI (RFC4366)

To talk with some sites that serve multiple names on a single IP
address, the client needs to ask for the specific host it wants to
talk to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 imap-send.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index 171c887..ab2098a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -370,6 +370,17 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 		return -1;
 	}
 
+#ifdef SSL_CTRL_SET_TLSEXT_HOSTNAME
+	/*
+	 * SNI (RFC4366)
+	 * OpenSSL does not document this function, but the implementation
+	 * returns 1 on success, 0 on failure after calling SSLerr().
+	 */
+	ret = SSL_set_tlsext_host_name(sock->ssl, server.host);
+	if (ret != 1)
+		warning("SSL_set_tslext_host_name(%s) failed.\n", server.host);
+#endif
+
 	ret = SSL_connect(sock->ssl);
 	if (ret <= 0) {
 		socket_perror("SSL_connect", sock, ret);
-- 
1.8.2.rc0.127.g4d5d7da
