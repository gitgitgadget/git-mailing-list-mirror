From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't verify host name in SSL certs when
 GIT_SSL_NO_VERIFY is set
Date: Thu, 21 Feb 2008 15:10:37 -0800
Message-ID: <7vd4qpsy6q.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0802212003140.14691@yvahk3.pbagnpgbe.fr>
 <1203621790-1415-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:11:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSKZe-0008LY-An
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 00:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbYBUXKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 18:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755154AbYBUXKy
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 18:10:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbYBUXKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 18:10:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 226CF1464;
	Thu, 21 Feb 2008 18:10:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 16DC51463; Thu, 21 Feb 2008 18:10:45 -0500 (EST)
In-Reply-To: <1203621790-1415-1-git-send-email-mh@glandium.org> (Mike
 Hommey's message of "Thu, 21 Feb 2008 20:23:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74676>

Mike Hommey <mh@glandium.org> writes:

> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  http.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/http.c b/http.c
> index 5925d07..519621a 100644
> --- a/http.c
> +++ b/http.c
> @@ -177,6 +177,7 @@ static CURL* get_curl_handle(void)
>  	CURL* result = curl_easy_init();
>  
>  	curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
> +	curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, curl_ssl_verify * 2);
>  #if LIBCURL_VERSION_NUM >= 0x070907
>  	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
>  #endif

Is it just me who finds that "* 2" is extremely magical?

diff --git a/http.c b/http.c
index 5925d07..8dce820 100644
--- a/http.c
+++ b/http.c
@@ -176,7 +176,16 @@ static CURL* get_curl_handle(void)
 {
 	CURL* result = curl_easy_init();
 
-	curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+	if (!curl_ssl_verify) {
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
+	} else {
+		/* Verify authenticity of the peer's certificate */
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
+		/* The name in the cert must match whom we tried to connect */
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
+	}
+
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
