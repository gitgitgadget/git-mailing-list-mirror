From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch reminder] Don't verify host name in SSL certs when
 GIT_SSL_NO_VERIFY is set
Date: Sun, 07 Sep 2008 01:35:54 -0700
Message-ID: <7v7i9onyj9.fsf@gitster.siamese.dyndns.org>
References: <20080907082059.GA26705@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 10:37:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcFli-0007uE-AI
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 10:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYIGIgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 04:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbYIGIgF
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 04:36:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYIGIgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 04:36:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4875C5E01F;
	Sun,  7 Sep 2008 04:36:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 770F95E01E; Sun,  7 Sep 2008 04:35:57 -0400 (EDT)
In-Reply-To: <20080907082059.GA26705@glandium.org> (Mike Hommey's message of
 "Sun, 7 Sep 2008 10:20:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FFC38A94-7CB7-11DD-BD4D-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95128>

Subject: Don't verify host name in SSL certs when GIT_SSL_NO_VERIFY is set
Date: Thu, 21 Feb 2008 15:10:37 -0800

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Mike Hommey <mh@glandium.org> writes:

 > While rebasing old branches on master, I saw that I still had this
 > patch[1] ahead, to which you replied with [2]. I might be guilty of not
 > replying back then, but I think your version should be applied.
 >
 > 1. http://marc.info/?l=git&m=120362183916288&w=2
 > 2. http://marc.info/?l=git&m=120363548506950&w=2

 Thanks.

 Just to make sure we are on the same page and to give other people
 comment on and potentially offer better solution, this is the patch in
 question.

 Next time around, please forward/resend "old patches that should not have
 been forgotten" in the way I am doing here.

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
