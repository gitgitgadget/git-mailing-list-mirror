From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] http.c: Use timeout suggested by curl instead of
 fixed 50ms timeout
Date: Fri, 04 Nov 2011 10:13:41 -0700
Message-ID: <7vehxndd4q.fsf@alter.siamese.dyndns.org>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-3-git-send-email-mika.fischer@zoopnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, daniel@haxx.se, peff@peff.net
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Fri Nov 04 18:13:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMNKv-0006dx-3I
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 18:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab1KDRNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 13:13:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932394Ab1KDRNn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 13:13:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25DE6600D;
	Fri,  4 Nov 2011 13:13:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I9GNd8A+S+RGLLI80FEuZBoqrc4=; b=giPLmt
	0gce/Iz9DiJSLr3Bp3oFyd8iCsy3DgRPsQjP0PQdZlwScxynAu8U6fhJU3eCQ+Qx
	l5Rtjsfy8DMBGWwGUjOMzB9wDmKdYBQ0p5og6oe5DnlOIrIiaEVlv70ony04bgfL
	O6ap/wRLn0iBxJDrjNiUBJzXqr6bU0+iXwnZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tPaBhQJziwGK6uVwNk7ZezOKN0+1bmjL
	O/2ksAss59Wd+0fYyXHQ0oMD9xLdG9Y8QXn2b8OEwTOwz+LlRhzOVrOzumBNnMh2
	w9xLWNIypT9ACev4dQmLjMhI9pSydG0RtS2NwV9DlJi++JM1TqSRNoF9e00bKTQ3
	alzom8EFazk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BC52600C;
	Fri,  4 Nov 2011 13:13:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A007600B; Fri,  4 Nov 2011
 13:13:42 -0400 (EDT)
In-Reply-To: <1320416367-28843-3-git-send-email-mika.fischer@zoopnet.de>
 (Mika Fischer's message of "Fri, 4 Nov 2011 15:19:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5894D9F6-0708-11E1-B50A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184787>

Mika Fischer <mika.fischer@zoopnet.de> writes:

> Recent versions of curl can suggest a period of time the library user
> should sleep and try again, when curl is blocked on reading or writing
> (or connecting). Use this timeout instead of always sleeping for 50ms.
>
> Signed-off-by: Mika Fischer <mika.fischer@zoopnet.de>

Thanks.

I'm inclined to squash in the following to narrow the scope of
curl_timeout, though.

diff --git a/http.c b/http.c
index 5cb0fb6..924be52 100644
--- a/http.c
+++ b/http.c
@@ -636,9 +636,6 @@ void run_active_slot(struct active_request_slot *slot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
-#if LIBCURL_VERSION_NUM >= 0x070f04
-	long curl_timeout;
-#endif
 	int finished = 0;
 
 	slot->finished = &finished;
@@ -655,6 +652,7 @@ void run_active_slot(struct active_request_slot *slot)
 
 		if (slot->in_use && !data_received) {
 #if LIBCURL_VERSION_NUM >= 0x070f04
+			long curl_timeout;
 			curl_multi_timeout(curlm, &curl_timeout);
 			if (curl_timeout == 0) {
 				continue;
