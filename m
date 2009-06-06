From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 14/23] http: create function end_url_with_slash
Date: Sat, 6 Jun 2009 16:43:43 +0800
Message-ID: <20090606164343.57ed98e4.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:51:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrcH-0004Mp-25
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbZFFIuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbZFFIt6
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:49:58 -0400
Received: from mail-px0-f181.google.com ([209.85.216.181]:33895 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbZFFIt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:49:58 -0400
Received: by mail-px0-f181.google.com with SMTP id 11so21643pxi.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=aRDsInRzA4aSqpU2Eb6KwriKBXgz9NymwxPt4DotNa8=;
        b=P4lTSot/58DKvPd1DQgUijPe8XY5bONXiGIqiq3tZKjgKsgGO7yOs1DRO4qDCQ0LvN
         SVFxV6zEK4DN81SVDAym7adFNxFdLxLdUOaM1R8NiwiuI7Ea4I39uN8CZzWz6xgUoMDB
         UXslol/1S4HniFGjY0apjpPHeEyLCJ+GTYE3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=BGqkja169dhlT0buMIw4o5k3CTwbk0snHEbfPcJGpQLsc8rO3GwEdYfa9z+XdaXdp/
         UDCkMK3a3hZxgL77gPdlsCUWpJPCaEFkdI1fQ3sF1mlV35paR9ecTV/jdXa8yf+ergk9
         DwW5WCGzgcNgEqqPvi8nivqL0RQbRE8F2IebM=
Received: by 10.142.214.12 with SMTP id m12mr1621999wfg.45.1244278200539;
        Sat, 06 Jun 2009 01:50:00 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 32sm2741468wfc.14.2009.06.06.01.49.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:50:00 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120895>

The logic to append a slash to the url if necessary in quote_ref_url
(added in 113106e "http.c: use strbuf API in quote_ref_url") has been
moved to a new function, end_url_with_slash.

The method takes a strbuf, the URL, and the path to be appended to the
URL. It first adds the URL to the strbuf. It then appends a slash
if the URL does not end with a slash.

The check on ref in quote_ref_url for a slash at the beginning has been
removed as a result of using end_url_with_slash. This check is not
needed, because slashes will be quoted anyway.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 3ca60bb..75fce9e 100644
--- a/http.c
+++ b/http.c
@@ -620,6 +620,7 @@ void finish_all_active_slots(void)
 		}
 }

+/* Helpers for modifying and creating URLs */
 static inline int needs_quote(int ch)
 {
 	if (((ch >= 'A') && (ch <= 'Z'))
@@ -640,15 +641,20 @@ static inline int hex(int v)
 		return 'A' + v - 10;
 }

+static void end_url_with_slash(struct strbuf *buf, const char *url)
+{
+	strbuf_addstr(buf, url);
+	if (buf->len && buf->buf[buf->len - 1] != '/')
+		strbuf_addstr(buf, "/");
+}
+
 static char *quote_ref_url(const char *base, const char *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *cp;
 	int ch;

-	strbuf_addstr(&buf, base);
-	if (buf.len && buf.buf[buf.len - 1] != '/' && *ref != '/')
-		strbuf_addstr(&buf, "/");
+	end_url_with_slash(&buf, base);

 	for (cp = ref; (ch = *cp) != 0; cp++)
 		if (needs_quote(ch))
--
1.6.3.1
