From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] format_sanitized_subject: Don't trim past initial length of strbuf
Date: Tue, 31 Mar 2009 16:24:38 -0700
Message-ID: <1238541878-11025-1-git-send-email-bebarino@gmail.com>
References: <49D2968D.6010108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LonN9-0008Vv-GM
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 01:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762872AbZCaXYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 19:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764604AbZCaXYp
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 19:24:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:3007 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764430AbZCaXYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 19:24:43 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3272527rvb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 16:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Cd2QncXDMBe63pl/rNXYUfIYABJMmvti570mxzQDaxc=;
        b=gjTfzA79Lzr/1kTdaUpPjLXzdn6Ls7VKE85i++Sio2fcYMJwjMbeMhKYgbH9NJAfjh
         6+o1pYvzPRntc4nCzU4GzF7hOwwaa7t/f3wUkppl1gCtCT4tKA8iRytOfiMvs478hp+Q
         Fbxpm/XSldo7d0rziGHRT1kg/SunhVGplV2q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=T34sXW6Q0AbGRGKs7YIpv58hvBv8e9xu7LNZS5M3mZ3mZjcm8RpFAUIHPWedubKKKM
         oH5ErwbDJpSiQprn8j5ZZkZLznMdWw6HxHEaxKbY1EwUGM6gMmq58fk2M9G81ycx1UW0
         +bYo3E/cKRU/KUyYuh+9ewT01IOMFa2DiRpW0=
Received: by 10.114.53.1 with SMTP id b1mr4760811waa.24.1238541881222;
        Tue, 31 Mar 2009 16:24:41 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id m34sm6547344waf.36.2009.03.31.16.24.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 16:24:40 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 31 Mar 2009 16:24:38 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <49D2968D.6010108@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115328>

If the subject line is '...' the strbuf will be accessed before the
first dot is added; potentially changing the strbuf passed into the
function or accessing sb->buf[-1] if it was originally empty.

Reported-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
I was thinking about this today actually. Thanks.

With regards to the isalnum(), I kept the original code because I wasn'=
t sure
if the functionality would be different.

 pretty.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index c57cef4..a0ef356 100644
--- a/pretty.c
+++ b/pretty.c
@@ -502,6 +502,7 @@ static int istitlechar(char c)
 static void format_sanitized_subject(struct strbuf *sb, const char *ms=
g)
 {
 	size_t trimlen;
+	size_t start_len =3D sb->len;
 	int space =3D 2;
=20
 	for (; *msg && *msg !=3D '\n'; msg++) {
@@ -519,8 +520,9 @@ static void format_sanitized_subject(struct strbuf =
*sb, const char *msg)
=20
 	/* trim any trailing '.' or '-' characters */
 	trimlen =3D 0;
-	while (sb->buf[sb->len - 1 - trimlen] =3D=3D '.'
-		|| sb->buf[sb->len - 1 - trimlen] =3D=3D '-')
+	while (sb->len - trimlen > start_len &&
+		(sb->buf[sb->len - 1 - trimlen] =3D=3D '.'
+		|| sb->buf[sb->len - 1 - trimlen] =3D=3D '-'))
 		trimlen++;
 	strbuf_remove(sb, sb->len - trimlen, trimlen);
 }
--=20
1.6.2
