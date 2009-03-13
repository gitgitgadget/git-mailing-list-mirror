From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line 
 lengths)
Date: Thu, 12 Mar 2009 22:53:29 -0700
Message-ID: <7vsklihsti.fsf@gitster.siamese.dyndns.org>
References: <49B5AF67.6050508@gmail.com>
 <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <49B5F0BA.3070806@gmail.com>
 <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
 <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 06:55:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li0MP-0004P6-LN
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 06:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbZCMFxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 01:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbZCMFxl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 01:53:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbZCMFxk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 01:53:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1ABBFA1CCE;
	Fri, 13 Mar 2009 01:53:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C21EEA1CCC; Fri,
 13 Mar 2009 01:53:31 -0400 (EDT)
In-Reply-To: <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
 (Mike Ralphson's message of "Thu, 12 Mar 2009 08:53:20 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B042824-0F93-11DE-9C39-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113145>

Mike Ralphson <mike.ralphson@gmail.com> writes:

> Elsewhere we seem to protect use of CURL_NETRC_OPTIONAL by checking
> for LIBCURL_VERSION_NUM >= 0x070907. I have an ancient curl here
> (curl-7.9.3-2ssl) which doesn't seem to have this option, so building
> next is broken on AIX for me from this morning (c33976cb).

Yeah, I did this as "How about doing it this way without adding a band-aid
configuration options" demonstration, and meant to clean it up (rather,
meant to wait for the original submitter to clean-up) before moving it
forward, but I forgot.  Sorry about that.

How does this look?

http://curl.haxx.se/libcurl/c/curl_easy_setopt.html seems to say "added in
7.X.Y" for some options but does say when CURLOPT_USERPWD was added, so I
am assuming it was available even in very early versions...

-- >8 --
From 750d9305009a0f3fd14c0b5c5e62ae1eb2b18fda Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 12 Mar 2009 22:34:43 -0700
Subject: [PATCH] http.c: CURLOPT_NETRC_OPTIONAL is not available in ancient versions of cURL

Besides, we have already called easy_setopt with the option before coming
to this function if it was available, so there is no need to repeat it
here.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index b8f947e..2fc55d6 100644
--- a/http.c
+++ b/http.c
@@ -138,9 +138,7 @@ static int http_options(const char *var, const char *value, void *cb)
 
 static void init_curl_http_auth(CURL *result)
 {
-	if (!user_name)
-		curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
-	else {
+	if (user_name) {
 		struct strbuf up = STRBUF_INIT;
 		if (!user_pass)
 			user_pass = xstrdup(getpass("Password: "));
-- 
1.6.2.249.g770a0
