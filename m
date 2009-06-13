From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 20:33:23 -0400
Message-ID: <ca433830906121733w7c88dfd4w1025b7b936e48e95@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <7vprdaarka.fsf@alter.siamese.dyndns.org>
	 <ca433830906121613y68e5bdax5778867c41b00339@mail.gmail.com>
	 <7vocst3s8n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 02:33:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFHBd-0001XL-2D
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 02:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbZFMAdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 20:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755331AbZFMAdX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 20:33:23 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55129 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbZFMAdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 20:33:23 -0400
Received: by bwz9 with SMTP id 9so2384036bwz.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TIR4vCgEXbks5HowsXTaNWb1CESXxHjL2iHNRNYgbTo=;
        b=fNOoRBl8GdtMEGBiBaAe0dneyaO23l7JFAkn4dXfuDvuVYXjTbErpbBkBOqyYRvRFK
         SVXH7ID7ueZxLRapplNFi/tvH3F5ANmhTFFvTTsojd79ZceDOCdwnkzf/GbsWXbMfmlK
         KU83cl8iMrHS6PoANsVKPI1d+JdYh8aHUzgkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bfeog7WsE63vQPQvkOFc242svU+RQOK9sL5RquetQpqLFyJv//Wk+0cX/yxoRc25iJ
         5dm+OUPEggFTPpmWtL/DjznCggzfPy+GnipaKpYFpfKBVpnzrCWkJNwGZv/laGMfdNhX
         Vy97vQT5u6c5ChMn2vNOtxi1kr1msRBRA0AxU=
Received: by 10.223.113.199 with SMTP id b7mr3059068faq.82.1244853204029; Fri, 
	12 Jun 2009 17:33:24 -0700 (PDT)
In-Reply-To: <7vocst3s8n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121475>

On Fri, Jun 12, 2009 at 8:14 PM, Junio C Hamano<gitster@pobox.com> wrote:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> If this patch series is accepted, I
>> will make a cleaner version that includes this change.
>
> Sorry, but I do not understand this part of your message.
>

Sorry about that.  I meant that I have cleaned up the code as you
suggested (see diff below), and that if you decide to include the
patch series into git.git (I see now you included it in pu), I can
either submit an additional patch to perform the cleanup, or submit a
new "v2" patch series incorporating these changes.  Is one preferred
over the other?

Also, I wasn't sure where to put the #defines; I chose to put them in
http.h, but should they go in http.c?

Thanks for the feedback!
Mark


diff --git c/http.c i/http.c
index 6ae59b6..7659ef4 100644
--- c/http.c
+++ i/http.c
@@ -213,16 +213,8 @@ static CURL *get_curl_handle(void)
        if (ssl_cert != NULL)
                curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
        if (has_cert_password())
-               curl_easy_setopt(result,
-#if LIBCURL_VERSION_NUM >= 0x071700
-                                CURLOPT_KEYPASSWD,
-#elif LIBCURL_VERSION_NUM >= 0x070903
-                                CURLOPT_SSLKEYPASSWD,
-#else
-                                CURLOPT_SSLCERTPASSWD,
-#endif
-                                ssl_cert_password);
-#if LIBCURL_VERSION_NUM >= 0x070902
+               curl_easy_setopt(result, CURLOPT_KEYPASSWD, ssl_cert_password);
+#ifndef NO_CURLOPT_SSLKEY
        if (ssl_key != NULL)
                curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
 #endif
diff --git c/http.h i/http.h
index 26abebe..b49c280 100644
--- c/http.h
+++ i/http.h
@@ -29,6 +29,12 @@
 #define curl_global_init(a) do { /* nothing */ } while(0)
 #endif

+#if LIBCURL_VERSION_NUM < 0x070903
+#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
+#elif LIBCURL_VERSION_NUM < 0x071700
+#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
+#endif
+
 #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
 #define NO_CURL_EASY_DUPHANDLE
 #endif
