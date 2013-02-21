From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH/PATCH] imap-send: support SNI (RFC4366)
Date: Wed, 20 Feb 2013 16:18:04 -0800
Message-ID: <7vbobey0xv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 01:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Jru-0005Mg-8R
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 01:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab3BUASJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 19:18:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab3BUASH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 19:18:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8BD7B522;
	Wed, 20 Feb 2013 19:18:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=a
	SQmQXcW6aqXjdJYVsimTMOc1wE=; b=aWiRXZG1CCgTMi/b7VCgjW8FpAif/+iG2
	s/gvriZve7v0f0mBZsOP5rzW9z3ocxfD6wZpcMt1387MwwZc1lj54zuJ+6flEaER
	Ssn2RKHZD1QNXUed+Um2luNYdr5KYErXDufbUH7BnSmDw8kw8b8qmzY756VcCut0
	afMnHdTtCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=MPk
	/OiQzKgNZ3HNyL3/NuEQ9xHFNOXJcgA8oHelwknC1nXhqjCmLjTX+ivI/PY2lPCZ
	Qg33bOZCnK3rdUgzbHRFptZ8jG6yuM1EBMtrMcqFbqIs4VO4WE0Q/EPFayOHbExa
	ot2vejE1eFEgsklNPt5gO53AxRwHWiEIL62uH0bA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B40FEB521;
	Wed, 20 Feb 2013 19:18:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20643B51F; Wed, 20 Feb 2013
 19:18:06 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29E3DA06-7BBC-11E2-8BD2-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216745>

To talk to a site that serves multiple names on a single IP address,
the client needs to ask for the specific hostname it wants to talk
to. Otherwise, the default certificate returned from the IP address
may not match that of the host we wanted to talk to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I need help from people on this patch in two areas:

 (1) I only tested this patch by connecting to https://googlemail.com/ 
     with

     $ git -c imap.host=imaps://googlemail.com -c imap.port=443 imap-send <this-patch.txt

     as it is the only site I knew clients needs to talk SNI to get
     the right certificate to verify; of course the port does not
     talk imap, and the only thing that is tested by that approach is
     we successfully establish an SSL/TLS connection.  Without the
     patch, we fail to verify the certificate (we get a cert that is
     for another hostname that is hosted at the same IP address), and
     with the patch, we successfully get the right one.

     I would appreciate it if somebody knows an imap server that
     needs SNI and runs an end-to-end test against that server.

 (2) I do not know if everybody has SSL_set_tslext_host_name() macro
     defined, so this patch may be breaking build for people with
     different versions of OpenSSL.

 imap-send.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index 171c887..d9abd8b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -370,6 +370,15 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 		return -1;
 	}
 
+	/*
+	 * SNI (RFC4366)
+	 * OpenSSL does not document this function, but the implementation
+	 * returns 1 on success, 0 on failure after calling SSLerr().
+	 */
+	ret = SSL_set_tlsext_host_name(sock->ssl, server.host);
+	if (ret != 1)
+		warning("SSL_set_tslext_host_name(%s) failed.\n", server.host);
+
 	ret = SSL_connect(sock->ssl);
 	if (ret <= 0) {
 		socket_perror("SSL_connect", sock, ret);
-- 
1.8.2.rc0.106.ga6e4a61
