From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] cache.h: eliminate SHA-1 deprecation warnings on
 OS X 10.8
Date: Sun, 12 May 2013 21:22:41 -0400
Message-ID: <CAPig+cSvz+gb8_yAkeUH7P3uK14ynro54LvsiR4biNbTw4vkrg@mail.gmail.com>
References: <1368260548-52612-1-git-send-email-davvid@gmail.com>
	<1368260548-52612-2-git-send-email-davvid@gmail.com>
	<1368260548-52612-3-git-send-email-davvid@gmail.com>
	<CAPig+cSw5-S7MDhG+5WdnLd+7PDUrSJcZJ-caXGM8JmYU6YWHw@mail.gmail.com>
	<CAJDDKr5QbrY6dFLbdZc2P5fTdLx+MPrSE+r1AAJMU4g=nrV9BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 03:22:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbhTa-0002cv-2W
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 03:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab3EMBWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 21:22:46 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:37871 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab3EMBWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 21:22:43 -0400
Received: by mail-la0-f50.google.com with SMTP id dz20so1740035lab.37
        for <git@vger.kernel.org>; Sun, 12 May 2013 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=sZac3GR0hRUPwIAv5zCeEFjC8VTVbXhA3p48YBOkZ9s=;
        b=fy6ZTz/0keUYAViKpO2efXamYgliqwQ7i07UTlQf4n5feGzzyV/GbG2n243xWxRJby
         t0+2Vxg7sUzzGXOrRy/L0l51AcZiQb6m7562aZjmtRVP7FAaHWbD6DQGg7gt5HKHS8bt
         Tgo60OkhTLqpjPHQUODVRK4E3qJTbIzL0qy2fq8F/rLUog73m1KjQNHmUH/Y6Vm+2cCI
         Vog3RAHoXABJHEeEfYpxasDZfnlQytgiMlb8BUfzJxW1GgTjQB6AHlZvCPSXrWUFQE1v
         6O43Vz1e0N8zX6SCA/EZI33+CqQjurEjIUa0vxA2AhVN5qLLUQCq64i5yxOFJz+uoMEc
         HbVw==
X-Received: by 10.112.72.163 with SMTP id e3mr11817813lbv.28.1368408161582;
 Sun, 12 May 2013 18:22:41 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Sun, 12 May 2013 18:22:41 -0700 (PDT)
In-Reply-To: <CAJDDKr5QbrY6dFLbdZc2P5fTdLx+MPrSE+r1AAJMU4g=nrV9BA@mail.gmail.com>
X-Google-Sender-Auth: zOyyqrClDX8uWqo7tdIvXr-G8Jg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224073>

On Sat, May 11, 2013 at 4:22 AM, David Aguilar <davvid@gmail.com> wrote:
> Mac OS X Mountain Lion prints warnings when building git:
>
>         warning: 'SHA1_Init' is deprecated
>         (declared at /usr/include/openssl/sha.h:121)
>
> Silence the warnings by using the Common Digest SHA-1
> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>
> Add a COMMON_DIGEST_SHA1 knob to the Makefile to allow
> choosing this implementation and define it by default on Darwin.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Unchanged since last time; rebased to 3/3.
>
> diff --git a/cache.h b/cache.h
> index 94ca1ac..e2b24c6 100644
> --- a/cache.h
> +++ b/cache.h
>  @@ -10,11 +10,18 @@
>
>  #include SHA1_HEADER
>  #ifndef git_SHA_CTX
> +#ifdef COMMON_DIGEST_FOR_SHA1
> +#define git_SHA_CTX CC_SHA1_CTX
> +#define git_SHA1_Init CC_SHA1_Init
> +#define git_SHA1_Update CC_SHA1_Update
> +#define git_SHA1_Final CC_SHA1_Final
> +#else
>  #define git_SHA_CTX SHA_CTX
>  #define git_SHA1_Init SHA1_Init
>  #define git_SHA1_Update SHA1_Update
>  #define git_SHA1_Final SHA1_Final
>  #endif
> +#endif

Reading [*1*], it appears that you can get these defines for free by
#defining COMMON_DIGEST_FOR_OPENSSL before including
<CommonCrypto/CommonDigest.h>, so this patch hunk can be eliminated,
which is nice since you don't have to pollute cache.h with any
Apple-specific ugliness. Also, according to [*1*], you need only link
against libSystem (or System.framework), so you can drop the
$(LIB_4_CRYPTO) reference too. The entire patch therefore reduces to
(excuse whitespace corruption):

-->8--
diff --git a/Makefile b/Makefile
index 25282b4..a080d20 100644
--- a/Makefile
+++ b/Makefile
@@ -1055,6 +1055,7 @@ ifeq ($(uname_S),Darwin)
                endif
        endif
        COMMON_DIGEST_HMAC = YesPlease
+       COMMON_DIGEST_SHA1 = YesPlease
        NO_REGEX = YesPlease
        PTHREAD_LIBS =
 endif
@@ -1390,10 +1391,15 @@ ifdef PPC_SHA1
        LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
        LIB_H += ppc/sha1.h
 else
+ifdef COMMON_DIGEST_SHA1
+       BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
+       SHA1_HEADER = <CommonCrypto/CommonDigest.h>
+else
        SHA1_HEADER = <openssl/sha.h>
        EXTLIBS += $(LIB_4_CRYPTO)
 endif
 endif
+endif

 ifdef COMMON_DIGEST_HMAC
        BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC=1
-->8--

[*1*] /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.8.sdk/usr/include/CommonCrypto/CommonDigest.h
