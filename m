From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jk/strbuf-vaddf] compat: fall back on __va_copy if available
Date: Tue, 8 Mar 2011 02:33:44 -0600
Message-ID: <20110308083344.GD26516@elie>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142647.GA15477@sigill.intra.peff.net>
 <AANLkTin7NBx5NVRkHpgymcZfnaZaJehMMpPv=zD+cKtV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 09:33:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsMe-0001n3-7r
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674Ab1CHIdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 03:33:50 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62011 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab1CHIdt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 03:33:49 -0500
Received: by gyh20 with SMTP id 20so1954763gyh.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 00:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1xlvKxrdqSUY8yNO+IR/zXZmtzr/bewd8cYptjQwmfA=;
        b=xdz5R+cqn1knSeLRL9EL6ayT/z0QSDxSEC/v27+T86nogC+wApKFcMtC0v1zXOAN6U
         upKhypxMQGcB2xjSfS0Ex+LMMnJWJKnd7DvCbU1nWvZzPZt3ZrkFT65Jii1XjptzGJr3
         Zh/yIUJIcPKmNFvWTV/xTc9SRfGFK34b9KFy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=o4KuMd/ZRrnYvA8a+Hn9VbT4wnAwZgkgSyIP98TmKkqo5KmwCFqVzXUGDFhO6c7n5N
         yTQpZLzjIhbk8JK4QEpJgRv6xo7buOtDMa65O6bNPLDySWkEJskA+S6RCQALr3z3GEUt
         l/WEYFOQXpOXy8xUgQGmzsag8f1RMEsxheY7Y=
Received: by 10.90.8.38 with SMTP id 38mr6382088agh.48.1299573229049;
        Tue, 08 Mar 2011 00:33:49 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.ameritech.net [69.209.61.99])
        by mx.google.com with ESMTPS id w6sm708943anf.26.2011.03.08.00.33.46
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 00:33:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTin7NBx5NVRkHpgymcZfnaZaJehMMpPv=zD+cKtV@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168641>

Since an obvious implementation of va_list is to make it a pointer
into the stack frame, implementing va_copy as "dst =3D src" will work o=
n
many systems.  Platforms that use something different (e.g., a size-1
array of structs, to be assigned with *(dst) =3D *(src)) will need some
other compatibility macro, though.

Luckily, as the glibc manual hints, such systems tend to provide the
__va_copy macro (introduced in GCC in March, 1997).  By using that if
it is available, we can cover our bases pretty well.

Discovered by building with CC=3D"gcc -std=3Dc89" on an amd64 machine:

 $ make CC=3Dc89 strbuf.o
 [...]
 strbuf.c: In function =E2=80=98strbuf_vaddf=E2=80=99:
 strbuf.c:211:2: error: incompatible types when assigning to type =E2=80=
=98va_list=E2=80=99 from type =E2=80=98struct __va_list_tag *=E2=80=99
 make: *** [strbuf.o] Error 1

Explained-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Erik Faye-Lund wrote:

> Wouldn't it be even more portable to fall back on use __va_copy (if
> present), as suggested by Junio in
> <7vbpip86q5.fsf@alter.siamese.dyndns.org>?

Yes, it seems so.

 git-compat-util.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 00d41e4..f4cb0a9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -536,7 +536,16 @@ void git_qsort(void *base, size_t nmemb, size_t si=
ze,
 #endif
=20
 #ifndef va_copy
-#define va_copy(dst,src) (dst) =3D (src)
+/*
+ * Since an obvious implementation of va_list would be to make it a
+ * pointer into the stack frame, a simple assignment will work on
+ * many systems.  But let's try to be more portable.
+ */
+#ifdef __va_copy
+#define va_copy(dst, src) __va_copy(dst, src)
+#else
+#define va_copy(dst, src) ((dst) =3D (src))
+#endif
 #endif
=20
 /*
--=20
1.7.4.1
