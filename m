Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EA020193
	for <e@80x24.org>; Wed, 26 Oct 2016 08:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbcJZIwj (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 04:52:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:60701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753415AbcJZIwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 04:52:36 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MRoyH-1cS5D735E9-00StoT; Wed, 26 Oct 2016 10:52:24
 +0200
Date:   Wed, 26 Oct 2016 10:52:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org, bmwill@google.com,
        pclouds@gmail.com
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
In-Reply-To: <20161022233225.8883-28-sbeller@google.com>
Message-ID: <alpine.DEB.2.20.1610261049470.3264@virtualbox>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-28-sbeller@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XJdWuc8ejY8U5SQeCvvricJnHSmfbpDgG5nicmWKS89s+bHEyzL
 k3PVvdI8ZJr/+7b6z3GvkemPElaAZPjmNqwkS8mBN0J7sW9HpEfEKYjyTG+JYkXL5+sAK7k
 ayxgWjGDJsm6SPzv1e6AHDs2Bt5WVsg4P/NKPwI0wBXz3MI/3X03vaLDXY0cLR3r8PE0Hfd
 o0hhfvx/SweZgZPTOp1mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4EizRXpt+0Y=:XPRQKyQSJUYwhj9EDCjaJ4
 N8KYcewZ69X82MtCbwQVen8TpQXgFpzZWmIY3iybJJNuhJp4M5AKfz9hEKygv1ldXrj05VnZf
 7fV0V94Cw0cDlRk/Y6T3z4hWDy+Vu7ORyZeX0A9+PSDobQbjHAWc/7DdQIfiMMZyGFlME//YL
 w+sTkoOtAW5LXvN+iUjqGeNaQU2PvMxuUMxHH7vb/58G5tb8wklMBRpaTRFFNMys0LBM7z/Jg
 dx9QofLpTScBRdc/bHBJCzXKXmgLZkaUWrKMjSPVS8gOQ8UOPA+ruNxPZ6NXQ0q5uCNZ2Et1G
 77wpEVnzQvxBkMo0tv72Y7mPS2QGrH43JpzjkiISriyRiiRrgitYOL/Z/2DDybd20jkton3ur
 1BC1i0NvVN8tUcYN4vHOBqPjFqMlmYpuXa28sWCWKUpZhsxozNXLgbBySlZYOB4GLpGmBXQv0
 7ElGKN5Aib4p5J3dPI0VSCl3NmovVn/pIae52UzcHRT6qr09tXpHRkyR2bPWU7Alv3y23LBLf
 ztnsJO5ESGxV9oD9HYkR9qGDh3L6VK1vmArdK9Rn6q9GfSZ2YDBRON32M6Ceh5kkpCTF+0Uri
 flN7ypBKYHBzAvuPPdLin3E35d65UPxvR8PEX7AnrKxRdyDDHXlqDxPcpSw9o9nPf8uQwdqlo
 ALHF6FGlqn0YP7z0puk2mlXG+d5EbMngLmB7JxuwM34yppe2iyLg6JU4/k6/Sc/jbiTc0NJEC
 kbrmwvs+aGT/CG00sf2WlCifWfolxSc2jODhScXKFMZ7Hy3UpL+9Zg+gWKoXAYN6CofVM2yBe
 cztk8yD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Sat, 22 Oct 2016, Stefan Beller wrote:

> @@ -46,6 +47,19 @@ struct git_attr {
>  static int attr_nr;
>  static struct git_attr *(git_attr_hash[HASHSIZE]);
>  
> +#ifndef NO_PTHREADS
> +
> +static pthread_mutex_t attr_mutex;
> +#define attr_lock()		pthread_mutex_lock(&attr_mutex)
> +#define attr_unlock()		pthread_mutex_unlock(&attr_mutex)

This mutex is never initialized. That may work on the system you tested,
but it is incorrect, and it does segfault on Windows. A lot.

I need *at least* something like this to make it stop crashing all over
the test suite:

-- snipsnap --
diff --git a/attr.c b/attr.c
index d5a6aa9..6933504 100644
--- a/attr.c
+++ b/attr.c
@@ -50,7 +50,16 @@ static struct git_attr *(git_attr_hash[HASHSIZE]);
 #ifndef NO_PTHREADS
 
 static pthread_mutex_t attr_mutex;
-#define attr_lock()pthread_mutex_lock(&attr_mutex)
+static inline void attr_lock(void)
+{
+	static int initialized;
+
+	if (!initialized) {
+		pthread_mutex_init(&attr_mutex, NULL);
+		initialized = 1;
+	}
+	pthread_mutex_lock(&attr_mutex);
+}
 #define attr_unlock()pthread_mutex_unlock(&attr_mutex)
 
 #else

