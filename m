From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send.c: fix pointer to be const
Date: Wed, 28 Oct 2009 10:56:35 -0700
Message-ID: <7vhbtjo10s.fsf@alter.siamese.dyndns.org>
References: <1256706591-2763-1-git-send-email-vietor@vxwo.org>
 <7vk4ygxce6.fsf@alter.siamese.dyndns.org>
 <1256713526.3333.0.camel@localhost.localdomain>
 <4AE8482F.7020807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vietor Liu <vietor@vxwo.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Clz-0003nH-3D
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 18:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbZJ1R4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 13:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbZJ1R4o
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 13:56:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbZJ1R4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 13:56:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05EEB6A366;
	Wed, 28 Oct 2009 13:56:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Sr7H3pMfqGRT3qhRkrBrJGo1Jok=; b=atlW16PJdbACvsTkJhXZqt+
	W3+6TAEcyKnCjz2CyIvTtITIfjUSzorzYF0YC+1MotYl7MXJ837TFJy5Z9rxw94Y
	Y+VLDejsp7JjPRpa719RYEraQ2zNaAVUMoQrC8IYRFNGLDKfpa28BuwCl6ZCAZlw
	ELbbcf0MCW2wkXtuJmnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WKn0fSgXXDGxX9ScVIn+MWjkV6aDVVKqjiTnMke+2ed7fKIGm
	gF4LgAGGUtpsnIaoP8fdpz7XHlcLDomYvC3NK5RGPCJE1qu26E8mQVGzmk4jTSQD
	+iURM2Obcren5mGoLj9B7a+cYPg2Nvbz9yhJCd4a5PePM6+lH1QaCjCLuY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE6C56A365;
	Wed, 28 Oct 2009 13:56:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B7DB6A364; Wed, 28 Oct
 2009 13:56:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3EEC67EC-C3EB-11DE-8D08-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131484>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Since this is only about warnings, maybe git 1.7.0 is the right time
> frame to adjust this to the upcoming standard?

This does not look like "one group wants this way, but the others want
differently.  We have to pick one and sacrifice the other because it is
impossible to have it both ways"; there is no excuse to bring up 1.7.0 for
something like this.

Doesn't inclusing "ssl.h" give us some indication whether "const" is
needed to allow us to use #if/#else/#endif in order to compile with
headers from either versions?  I.e. something like...

diff --git a/imap-send.c b/imap-send.c
index 3847fd1..a199db8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -273,7 +273,11 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
 	return -1;
 #else
+#if (OPENSSL_VERSION_NUMBER >= 0x1000000fL)
+	const SSL_METHOD *meth;
+#else
 	SSL_METHOD *meth;
+#endif
 	SSL_CTX *ctx;
 	int ret;
 
