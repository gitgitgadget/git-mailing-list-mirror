Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 7109 invoked by uid 107); 24 Aug 2009 09:45:33 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 05:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbZHXJpO (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 05:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZHXJpO
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 05:45:14 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:35718 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbZHXJpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 05:45:12 -0400
Received: by ewy3 with SMTP id 3so2202540ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 02:45:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J27+nSY+dCpaUKzeqT7C4FOerAdps5170sokPtWWZVg=;
        b=d6jLC9ZIe9M1KJCY6d8mjOYHxPEtPTFNWV3Z1P3xjsD4SllBiQvmUTLZD6LGo8ecE0
         2ubL0MiLJ2vzsBGX/fMfqvPJXabp/kGZIUAk2UxFt6WN5auhkpeBmU+F7H3DPvNEZ7Ze
         bmYjzb7vyS05nAjuEH0gjPIJ7P72xUGAhPTR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y7oUgSu5T9NFtPfIYrhcu/o1RWbvhZUpLPZucWbo9jrZiZm87WjvBWGM6UKJ/ae2O7
         e+2uyAkX8qkw02a69XFTeBZZXoxs+UHjm1Nu9+JTn8Modby4v31WIdJFBgjiJPW2G5nK
         PsD+Y8JGoYaaAVtiHw9L7RT6X36vTXeMg83Us=
MIME-Version: 1.0
Received: by 10.210.62.4 with SMTP id k4mr4629780eba.25.1251107113562; Mon, 24 
	Aug 2009 02:45:13 -0700 (PDT)
In-Reply-To: <1250354813-81349-1-git-send-email-brian@gernhardtsoftware.com>
References: <1250354813-81349-1-git-send-email-brian@gernhardtsoftware.com>
Date:	Mon, 24 Aug 2009 11:45:13 +0200
Message-ID: <81b0412b0908240245l33b04322l923084362197406a@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add NEEDS_CRYPTO_WITH_SSL
From:	Alex Riesen <raa.lkml@gmail.com>
To:	Brian Gernhardt <brian@gernhardtsoftware.com>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 15, 2009 at 18:46, Brian
Gernhardt<brian@gernhardtsoftware.com> wrote:
>
>  After adding BLK_SHA1 to my config.mak, git-imap-send started giving me link
>  errors:
>
>  Undefined symbols:
>    "_ERR_get_error", referenced from:
>        _ssl_socket_perror in imap-send.o
>    "_ERR_error_string", referenced from:
>        _ssl_socket_perror in imap-send.o
>
>  Some investigation led me to the fact that BLK_SHA1 removes LIB_4_CRYPTO from
>  EXTLIBS.  That let me find the missing functions in libcrypto.  At first I
>  considered making NEEDS_SSL_WITH_CRYPTO add -lcrypto to the SSL build flags
>  but decided to go this route in case there are platforms that need it one way
>  around and not the other.

As imap-send is the only one which uses the symbols, why not just add
LIB_4_CRYPTO
to its linking command? Like in the broken GMail-patch below:

diff --git a/Makefile b/Makefile
index 02ff867..33971f3 100644
--- a/Makefile
+++ b/Makefile
@@ -1503,7 +1503,7 @@ git-%$X: %.o $(GITLIBS)

 git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
+		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)

 http.o http-walker.o http-push.o: http.h
