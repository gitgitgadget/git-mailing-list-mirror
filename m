From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 08/17] http: create function end_url_with_slash
Date: Sat, 30 May 2009 01:59:12 +0800
Message-ID: <20090530015912.cc078265.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6P6-0000Xl-37
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759542AbZE2SBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759418AbZE2SBF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:01:05 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24455 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759243AbZE2SBD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:01:03 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1285295wah.21
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=aRDsInRzA4aSqpU2Eb6KwriKBXgz9NymwxPt4DotNa8=;
        b=MBt333qBv6CraVNnpZWivH8pf4g+SxIYhfChAOF6VYmsNLAh+tmy9Yy/kTLKKrM1WM
         ZmYOuo06f0ultqTHaQrQSvW8PoAMKc4HZQPxUU3bYUBoNqbfroddBRQ9QAQMoQuzaFRf
         degtRESS+uKZDBLOTZ0BZXgvbMIGW/RhhEJoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=FIDG/Mk+T3tFqvyWoeR4cRA+GcDT6HxIMMx+QI0dTEAH7aOa+vdIcSwD4u1d3M5LoZ
         UN3TsWk0srLUcHkxSJogTOUhPAuRy+Ewhj31uZylgR8TWguxQQ7+mki07G09UZLKsB3v
         RNOhS3YdLoXGQSQkmbIwAnnkI40TAa7sc7Q1I=
Received: by 10.114.158.1 with SMTP id g1mr4529620wae.126.1243620064799;
        Fri, 29 May 2009 11:01:04 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id l30sm2548492waf.35.2009.05.29.11.01.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:01:04 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120296>

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
