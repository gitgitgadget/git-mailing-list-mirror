From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Wishlist] could git tell which password it is asking when
 asking a password.
Date: Fri, 01 Jul 2011 10:16:02 -0700
Message-ID: <7v1uy9q5v1.fsf@alter.siamese.dyndns.org>
References: <877h82nlua.dlv@debian.org>
 <7v62nmos0k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Fri Jul 01 19:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QchK9-0006hp-6Z
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 19:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab1GARQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 13:16:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab1GARQF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 13:16:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFE574CD6;
	Fri,  1 Jul 2011 13:18:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1tFsTYkLcG8cz6ekZM9sdg7RXHc=; b=n098J5
	wR4Jan0w7NP3dZG+/M6wSNCrwiqZomJ/4jSR8S0pf4k13UNba6heTzCE/Ybmn7NJ
	uWEXZoqUfXZvclzQq3SY2dBevzAVgx2fbqTC0wji164V+LDT7Um4Y3DIMjzvFEYu
	aXmA8EPefbKS9pv632zTJDdWz3mHtpohSEhuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vNj1t/0OMKlG80EPR7hoe/CnDx3/f5fi
	fStYRfcG48X20ShTCT8HCjzbHAjLinP7SBuNaWdLZat2oN2FyGyaPwl0OiesgE81
	KWdub8iTB/Ce3qicLEHW9OE7sKAe6JkUTS192l60LV1dZiRGo3nQyka8WvxYSmHH
	eJqtpyUABrk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E92654CD4;
	Fri,  1 Jul 2011 13:18:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 42E4C4CD3; Fri,  1 Jul 2011
 13:18:18 -0400 (EDT)
In-Reply-To: <7v62nmos0k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 01 Jul 2011 10:00:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CE7B564-A406-11E0-BE38-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176525>

Junio C Hamano <gitster@pobox.com> writes:

> ... So an alternative route
> may be to keep git_getpass() as-is, and update the init_curl_http_auth()
> callsite to include the username (but imap-send assumes that user and host
> are relatively short without verifying that assumption, and should not be
> used as a model of good existing code).

And here is such a lazy patch, completely untested, of course ;-).

 http.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index b2ae8de..44948a7 100644
--- a/http.c
+++ b/http.c
@@ -209,8 +209,11 @@ static void init_curl_http_auth(CURL *result)
 {
 	if (user_name) {
 		struct strbuf up = STRBUF_INIT;
-		if (!user_pass)
-			user_pass = xstrdup(git_getpass("Password: "));
+		if (!user_pass) {
+			strbuf_addf(&up, "Password for %s: ", user_name);
+			user_pass = xstrdup(git_getpass(up.buf));
+			strbuf_reset(&up);
+		}
 		strbuf_addf(&up, "%s:%s", user_name, user_pass);
 		curl_easy_setopt(result, CURLOPT_USERPWD,
 				 strbuf_detach(&up, NULL));
