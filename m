From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] wincred: port to generic credential helper (UNTESTED)
Date: Thu, 30 Aug 2012 20:27:02 +0200
Message-ID: <CABPQNSZsXnf2kjcN+Qma8pApjGRF6SD5iJjB2Ow6GuGts0Z=Kg@mail.gmail.com>
References: <503A680C.3090406@qo.cx> <1346018649-3002-1-git-send-email-pah@qo.cx>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: "Philipp A. Hartmann" <pah@qo.cx>
X-From: git-owner@vger.kernel.org Thu Aug 30 20:28:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T79TN-0000j9-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 20:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab2H3S2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 14:28:01 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62277 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2H3S2A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 14:28:00 -0400
Received: by vcbfk26 with SMTP id fk26so2318084vcb.19
        for <git@vger.kernel.org>; Thu, 30 Aug 2012 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Gbdb/ft0kWRHGudL3aVuwP9mCjw+zzUT0EzuzM+DYgs=;
        b=IHJiWhBr8nWp909RaAUxtgdH522MPLcx3scti8rc938u3e8cQzc2f6i1eKlO0yRpPP
         cIQM9DLrFwiYZx+Esr3/0zv3jssNJ/JWUYgJ1NHhOPNwRybgHuF9RsOLwQ0A/ZRIf1BG
         wPCX+LX/aNtYOxXvRkyLmjSippe3HhvuhiZ9q+ko9H6VP0Cz16nC6sxjjdYBpgJ5rbSc
         KwPjazl9N9zruEGZdoE9Le2IthXzSbEBY1h9hYyA+9qPiXLui78oUANF1/JWJtVd+6Ku
         Eo1K3lGxI6MQRE6APS+DjObfHOccwi2rCklF0mmM2EY1785Esmt/gc48gUQgibbHq0Wj
         xkzg==
Received: by 10.52.94.97 with SMTP id db1mr3135729vdb.71.1346351279281; Thu,
 30 Aug 2012 11:27:59 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Thu, 30 Aug 2012 11:27:02 -0700 (PDT)
In-Reply-To: <1346018649-3002-1-git-send-email-pah@qo.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204561>

On Mon, Aug 27, 2012 at 12:04 AM, Philipp A. Hartmann <pah@qo.cx> wrote:
> From: "Philipp A. Hartmann" <pah@qo.cx>
>
> This patch is an experiment to port the wincred helper
> to the generic implementation.  As of know, it is
> completely untested.
>
> In addition to porting the helper to the generic API,
> this patch clears up all passwords from memory, which
> reduces the total amount to saved lines.
>
> Signed-off-by: Philipp A. Hartmann <pah@qo.cx>
> ---
>
> The porting was fairly easy, but due to the lack of a testing
> platform, it is completely untested.
>
> Erik: Can you try to have look?

Sorry for the late reply, I'm currently in bed with pneumonia.

But I gave it a quick go, but as-is it's a NACK; a wall of warnings and errors.

But with this patch on top, it seems to at least compile OK:

---8<---
diff --git a/contrib/credential/helper/credential_helper.h
b/contrib/credential/helper/credential_helper.h
index 7e73fc6..13b611e 100644
--- a/contrib/credential/helper/credential_helper.h
+++ b/contrib/credential/helper/credential_helper.h
@@ -125,6 +125,7 @@ static inline char *xstrdup(const char *str)
 	return ret;
 }

+#ifndef NO_STRNDUP
 static inline char *xstrndup(const char *str, size_t len)
 {
 	char *ret = strndup(str,len);
@@ -133,5 +134,6 @@ static inline char *xstrndup(const char *str, size_t len)

 	return ret;
 }
+#endif

 #endif /* CREDENTIAL_HELPER_H_INCLUDED_ */
diff --git a/contrib/credential/wincred/Makefile
b/contrib/credential/wincred/Makefile
index ee7a8ef..3900322 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -1,9 +1,10 @@
 MAIN:=git-credential-wincred
-all:: $(MAIN)
+all:: $(MAIN).exe

 CC = gcc
 RM = rm -f
 CFLAGS = -O2 -Wall
+CPPFLAGS = -DNO_STRNDUP

 -include ../../../config.mak.autogen
 -include ../../../config.mak
diff --git a/contrib/credential/wincred/git-credential-wincred.c
b/contrib/credential/wincred/git-credential-wincred.c
index 721e59f..e26ba47 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <io.h>
 #include <fcntl.h>
+#include <credential_helper.h>

 /* MinGW doesn't have wincred.h, so we need to define stuff */

@@ -124,9 +125,8 @@ static int prepare_credential(struct credential *c)
 		wusername = utf8_to_utf16_dup(c->username);
 	if (c->password)
 		wpassword = utf8_to_utf16_dup(c->password);
-	if (c->port) {
-		snprintf(port_buf,"%hd",c->port);
-	}
+	if (c->port)
+		snprintf(port_buf, sizeof(port_buf), "%hd", c->port);
 	return EXIT_SUCCESS;
 }

@@ -170,7 +170,7 @@ static int get_credential(struct credential *c)

 	/* search for the first credential that matches username */
 	for (i = 0; i < num_creds; ++i)
-		if (match_cred(creds[i])) {
+		if (match_cred(creds[i], c)) {
 			cred = creds[i];
 			break;
 		}
---8<---

However, I haven't been able to successfully run the tests on the
result. When I did, I got this error:

---8<---
rm: cannot remove `t/trash directory.t0303-credential-external/stderr': Permissi
on denied
rm: cannot remove `t/trash directory.t0303-credential-external/stdout': Permissi
on denied
rm: cannot remove directory `t/trash directory.t0303-credential-external': Direc
tory not empty
---8<---

And I'm not currently feeling up to debugging stuck processes or whatever it is.
