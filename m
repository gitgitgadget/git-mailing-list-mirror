Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F4320401
	for <e@80x24.org>; Wed, 21 Jun 2017 20:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdFUUrz (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 16:47:55 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33827 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdFUUry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 16:47:54 -0400
Received: by mail-wr0-f169.google.com with SMTP id 77so150814473wrb.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icJnpJIHSD9wjm45VA/Ekfm/oK7AGclLCfhPtH5Y/sQ=;
        b=eCQWP003Azb7EKeYi8U75J7dEy8tAQaKld/dQEG1NY6j5mR9vLx4kr/HqleDXBtkhq
         jYb8Au7g9+ptDmOOFJYpYTJCyAm4lNhx2VOHmLNbkFhVPhlBRaQ03x3POqvthea4G6K8
         hSB3kivwqyR/zzIJnW6hGqogbOZrO5WLLKUGiTkAadbvJT/DW+ua+7jQVgdxSWovLaAS
         tijvsTfcTIgF5iroaPqGAjIu7oszcmPF4rg2gfvRdchoCvrUwln6RxAxMYFpsZfdksUT
         ZTX0keraNI24Dx1onWMpDdKuNcmD57zGH8nGM0EzAoijnchoJ7NMuYKWz874RjvdXpcF
         9GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icJnpJIHSD9wjm45VA/Ekfm/oK7AGclLCfhPtH5Y/sQ=;
        b=ub224yTn1KC6JbEX4uRhGRG6Rabz4kZmpkrf9Ipkz3xunqMw/SxxHGxImSZ8JM2Fgr
         wK/YxqQVqkX4oS+jWO8tjQZO3aOwkCCUMRrBQ5RTJppQg3CcBRa4Uzs6M2rXlRNzpNlH
         gjDC2Z776cFZz5T/yNd/PHkQecgJbTBm3jx2Ys7dG2lRHMQU9RZXmTHG1G749sdt+1Ay
         KYjJ2T29zGcqKQFADpA+3EbrUBFVp+1I/vWu8d0XSeFndX/+fgP8LmRK5Ocw6SiMC7GM
         CbcFlyYvBH1z/7LDzjFFrJ4m+owum2YHgwv+f2PuwVgbCcQqQ60bdii9H+qtsQNaGVKo
         LTpA==
X-Gm-Message-State: AKS2vOzyQwCQXNIGlIl5dBklLFnaZV/gomNtVfzIy8j6dZZmHPUCu08/
        W/2ke7mEyAeOCwmOBdI=
X-Received: by 10.80.142.25 with SMTP id 25mr26434728edw.104.1498078072521;
        Wed, 21 Jun 2017 13:47:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4sm9478354eds.48.2017.06.21.13.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 13:47:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] die(): stop hiding errors due to overzealous recursion guard
Date:   Wed, 21 Jun 2017 20:47:42 +0000
Message-Id: <20170621204742.15722-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <87podz8v6v.fsf@gmail.com>
References: <87podz8v6v.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the recursion limit for the default die routine from a *very*
low 1 to 1024. This ensures that infinite recursions are broken, but
doesn't lose the meaningful error messages under threaded execution
where threads concurrently start to die.

The intent of the existing code, as explained in commit
cd163d4b4e ("usage.c: detect recursion in die routines and bail out
immediately", 2012-11-14), is to break infinite recursion in cases
where the die routine itself calls die(), and would thus infinitely
recurse.

However, doing that very aggressively by immediately printing out
"recursion detected in die handler" if we've already called die() once
means that threaded invocations of git can end up only printing out
the "recursion detected" error, while hiding the meaningful error.

An example of this is running a threaded grep which dies on execution
against pretty much any repo, git.git will do:

    git grep -P --threads=8 '(*LIMIT_MATCH=1)-?-?-?---$'

With the current version of git this will print some combination of
multiple PCRE failures that caused the abort and multiple "recursion
detected", some invocations will print out multiple "recursion
detected" errors with no PCRE error at all!

Before this change, running the above grep command 1000 times against
git.git[1] and taking the top 20 results will on my system yield the
following distribution of actual errors ("E") and recursion
errors ("R"):

    322 E R
    306 E
    116 E R R
     65 R R
     54 R E
     49 E E
     44 R
     15 E R R R
      9 R R R
      7 R E R
      5 R R E
      3 E R R R R
      2 E E R
      1 R R R R
      1 R R R E
      1 R E R R

The exact results are obviously random and system-dependent, but this
shows the race condition in this code. Some small part of the time
we're about to print out the actual error ("E") but another thread's
recursion error beats us to it, and sometimes we print out nothing but
the recursion error.

With this change we get, now with "W" to mean the new warning being
emitted indicating that we've called die() many times:

    502 E
    160 E W E
    120 E E
     53 E W
     35 E W E E
     34 W E E
     29 W E E E
     16 E E W
     16 E E E
     11 W E E E E
      7 E E W E
      4 W E
      3 W W E E
      2 E W E E E
      1 W W E
      1 W E W E
      1 E W W E E E
      1 E W W E E
      1 E W W E
      1 E W E E W

Which still sucks a bit, due to a still present race-condition in this
code we're sometimes going to print out several errors still, or
several warnings, or two duplicate errors without the warning.

But we will never have a case where we completely hide the actual
error as we do now.

Now, git-grep could make use of the pluggable error facility added in
commit c19a490e37 ("usage: allow pluggable die-recursion checks",
2013-04-16). There's other threaded code that calls set_die_routine()
or set_die_is_recursing_routine().

But this is about fixing the general die() behavior with threading
when we don't have such a custom routine yet. Right now the common
case is not an infinite recursion in the handler, but us losing error
messages by default because we're overly paranoid about our recursion
check.

So let's just set the recursion limit to a number higher than the
number of threads we're ever likely to spawn. Now we won't lose
errors, and if we have a recursing die handler we'll still die within
microseconds.

There are race conditions in this code itself, in particular the
"dying" variable is not thread mutexed, so we e.g. won't be dying at
exactly 1024, or for that matter even be able to accurately test
"dying == 2", see the cases where we print out more than one "W"
above.

But that doesn't really matter, for the recursion guard we just need
to die "soon", not at exactly 1024 calls, and for printing the correct
error and only one warning most of the time in the face of threaded
death this is good enough and a net improvement on the current code.

1. for i in {1..1000}; do git grep -P --threads=8 '(*LIMIT_MATCH=1)-?-?-?---$' 2>&1|perl -pe 's/^fatal: r.*/R/; s/^fatal: p.*/E/; s/^warning.*/W/' | tr '\n' ' '; echo; done | sort | uniq -c | sort -nr | head -n 20

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This replaces v1 and takes into account the feedback in this thread
(thanks everyone!).

The commit message is also much improved and includes more rationale
originally in my reply to Stefan in 87podz8v6v.fsf@gmail.com

 usage.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/usage.c b/usage.c
index 2f87ca69a8..1ea7df9a20 100644
--- a/usage.c
+++ b/usage.c
@@ -44,7 +44,23 @@ static void warn_builtin(const char *warn, va_list params)
 static int die_is_recursing_builtin(void)
 {
 	static int dying;
-	return dying++;
+	/*
+	 * Just an arbitrary number X where "a < x < b" where "a" is
+	 * "maximum number of pthreads we'll ever plausibly spawn" and
+	 * "b" is "something less than Inf", since the point is to
+	 * prevent infinite recursion.
+	 */
+	static const int recursion_limit = 1024;
+
+	dying++;
+	if (dying > recursion_limit) {
+		return 1;
+	} else if (dying == 2) {
+		warning("die() called many times. Recursion error or racy threaded death!");
+		return 0;
+	} else {
+		return 0;
+	}
 }
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
-- 
2.13.1.611.g7e3b11ae1

