Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CE82035F
	for <e@80x24.org>; Fri, 28 Oct 2016 22:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942883AbcJ1WGp (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 18:06:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65535 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1761948AbcJ1WGj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 18:06:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 771814A884;
        Fri, 28 Oct 2016 18:06:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4hLs4WfiIlmS069jDBBigYii/6E=; b=QADOU6
        D6xQZavQsUyoRJkjO7cE+i8dclYSCcdUmAj5PhsgY+k0G4Kv7SV7aoakmuv2f5ID
        9wf/80RKXJsKSFT32y0pHEOXkZp9U9xi91fifg/p8fJHfzz+gnLBMWT9sCC/KgzP
        7/ZyE5rSrTHskK7+U/sIRpiiOVjIFpKfVzfMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oBXMDOc7wDJZGXDE4gpf3u9HBc2h5Rjh
        8+jgAotCuMl95jXHy5AUJLBKVS77sjoEAYsDe+Vr+KwtyS366TBG/Dil1MhHZmfC
        EGfBXVVJGibwlmImJCvhpFBk7tAGQaL7wHjaLXwkBGsxKfmQnLpsFH0YcEoVzzzu
        AuIS/4aFYzI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E4CA4A883;
        Fri, 28 Oct 2016 18:06:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5AC04A882;
        Fri, 28 Oct 2016 18:06:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCHv2 27/36] attr: convert to new threadsafe API
References: <20161028185502.8789-1-sbeller@google.com>
        <20161028185502.8789-28-sbeller@google.com>
Date:   Fri, 28 Oct 2016 15:06:35 -0700
In-Reply-To: <20161028185502.8789-28-sbeller@google.com> (Stefan Beller's
        message of "Fri, 28 Oct 2016 11:54:53 -0700")
Message-ID: <xmqqinscxh5g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC24279E-9D5A-11E6-AB50-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Probably this needs to be squashed in, now the MinGW discussion has
settled.

 attr.c         | 2 +-
 common-main.c  | 2 ++
 compat/mingw.c | 4 ----
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 082b5ed343..961218a0d5 100644
--- a/attr.c
+++ b/attr.c
@@ -50,7 +50,7 @@ static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 #ifndef NO_PTHREADS
 
-static pthread_mutex_t attr_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t attr_mutex;
 #define attr_lock()		pthread_mutex_lock(&attr_mutex)
 #define attr_unlock()		pthread_mutex_unlock(&attr_mutex)
 void attr_start(void) { pthread_mutex_init(&attr_mutex, NULL); }
diff --git a/common-main.c b/common-main.c
index 44a29e8b13..d4699cd404 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec_cmd.h"
+#include "attr.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
@@ -32,6 +33,7 @@ int main(int argc, const char **argv)
 	sanitize_stdfds();
 
 	git_setup_gettext();
+	attr_start();
 
 	argv[0] = git_extract_argv0_path(argv[0]);
 
diff --git a/compat/mingw.c b/compat/mingw.c
index 51ed76326b..3fbfda5978 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -5,7 +5,6 @@
 #include "../strbuf.h"
 #include "../run-command.h"
 #include "../cache.h"
-#include "../attr.h"
 
 #define HCAST(type, handle) ((type)(intptr_t)handle)
 
@@ -2233,9 +2232,6 @@ void mingw_startup(void)
 	/* initialize critical section for waitpid pinfo_t list */
 	InitializeCriticalSection(&pinfo_cs);
 
-	/* initialize critical sections in the attr code */
-	attr_start();
-
 	/* set up default file mode and file modes for stdin/out/err */
 	_fmode = _O_BINARY;
 	_setmode(_fileno(stdin), _O_BINARY);
