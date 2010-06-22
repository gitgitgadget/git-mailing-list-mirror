From: Pascal Obry <pascal.obry@gmail.com>
Subject: [PATCH v4] Do not decode url protocol.
Date: Tue, 22 Jun 2010 22:16:57 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C211A39.2080207@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 22 22:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR9sy-0003QZ-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 22:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab0FVUPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 16:15:51 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:59957 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab0FVUPu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 16:15:50 -0400
Received: by wwc33 with SMTP id 33so439757wwc.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:subject:x-enigmail-version
         :content-type:content-transfer-encoding;
        bh=E4LkadK9n4pIt7ijC5ciUujliDczzmG+c56LHQwFcRU=;
        b=e/Oy7G/5nMHg1jo3YuW1i0lNlNnPYYjwDK7aPJm07rN1716vtDQF5fp+1Fh+Gzi2xB
         ZzzANKDG7NMRvoz+JIJCmmsI8LEuqh9J1KCcQlo5Ml7sCBlet3GT2YfG2lzSghxqJigg
         Y6o7JLn7/h+yKtuYGiHt/0BXUFRpF1x7jejk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=yDKP2eSFdBA8kKDAQtMvstNUWZtHRipsJ1XcCLeCTJnHCVG3Zt+ilezQSygH4d68wq
         5wOh3kiCIUzdBki5XKcFj1pNJaAB7g9thTr3tFG5ckN08teM40GJXZ2vBoYjoxLFrT0N
         TEl93/KpUHbzJrJo+mowMHOBWKE9veWtxSggY=
Received: by 10.227.147.132 with SMTP id l4mr6747789wbv.155.1277237748804;
        Tue, 22 Jun 2010 13:15:48 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-11-160.w82-124.abo.wanadoo.fr [82.124.73.160])
        by mx.google.com with ESMTPS id b17sm45628313wbd.1.2010.06.22.13.15.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 13:15:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149491>


When using the protocol git+ssh:// for example we do not want to
decode the '+' as a space. The url decoding must take place only
for the server name and parameters.

This fixes a regression introduced in 9d2e942.
---
 url.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

Ok, so this is the fourth version of this patch. Thanks again Matthieu
for the review. I think this time I got the place for the message right :)

Anyway, I think this time we properly skip the protocol decoding when
needed.

diff --git a/url.c b/url.c
index cd32b92..0eb7fb3 100644
--- a/url.c
+++ b/url.c
@@ -67,12 +67,23 @@ static int url_decode_char(const char *q)
        return val;
 }

-static char *url_decode_internal(const char **query, const char *stop_at)
+static char *url_decode_internal(const char **query, const char *stop_at,
+               int with_protocol)
 {
        const char *q = *query;
+       const char *first_slash;
        struct strbuf out;

        strbuf_init(&out, 16);
+
+       /* Skip protocol if present. */
+       if (with_protocol) {
+         first_slash = strchr(*query, '/');
+
+         while (q < first_slash)
+               strbuf_addch(&out, *q++);
+       }
+
        do {
                unsigned char c = *q;

@@ -104,15 +115,15 @@ static char *url_decode_internal(const char
**query, const char *stop_at)

 char *url_decode(const char *url)
 {
-       return url_decode_internal(&url, NULL);
+       return url_decode_internal(&url, NULL, 1);
 }

 char *url_decode_parameter_name(const char **query)
 {
-       return url_decode_internal(query, "&=");
+       return url_decode_internal(query, "&=", 0);
 }

 char *url_decode_parameter_value(const char **query)
 {
-       return url_decode_internal(query, "&");
+       return url_decode_internal(query, "&", 0);
 }
-- 
1.7.1.426.gb436.dirty

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
