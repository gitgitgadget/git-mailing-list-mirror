Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEF91F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 18:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965153AbcIFS3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:29:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:38950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965144AbcIFS3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:29:46 -0400
Received: (qmail 23975 invoked by uid 109); 6 Sep 2016 18:29:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 18:29:45 +0000
Received: (qmail 28795 invoked by uid 111); 6 Sep 2016 18:29:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 14:29:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 14:29:43 -0400
Date:   Tue, 6 Sep 2016 14:29:43 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
Message-ID: <20160906182942.s2mlge2vg65f5sy4@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com>
 <20160906071255.ggsoj2lh2f3kubhj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609061521410.129229@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609061521410.129229@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2016 at 04:06:32PM +0200, Johannes Schindelin wrote:

> > I think re_search() the correct replacement function but it's been a
> > while since I've looked into it.
> 
> The segfault I investigated happened in a call to strlen(). I see many
> calls to strlen() in compat/regex/... The one that triggers the segfault
> is in regexec(), compat/regex/regexec.c:241.

Yes, that is the important one, I think. The others are for patterns,
error msgs, etc. Of course strlen() is not the only function that cares
about NUL delimiters (and there might even be a "while (*p)" somewhere
in the code).

I always assumed the _point_ of re_search taking a ptr/len pair was
exactly to handle this case. The documentation[1] says:

   `string` is the string you want to match; it can contain newline and
   null characters. `size` is the length of that string.

Which seems pretty definitive to me (that's for re_match(), but
re_search() is defined in the docs in terms of re_match()).

[1] http://www.delorie.com/gnu/docs/regex/regex_47.html

> As to re_search(): I have not been able to reason about its callees in a
> reasonable amount of time. I agree that they *should* not run over the
> buffer, but I cannot easily verify it.

Between the documentation above, and the fact that your new test passes
when we switch to it (see below), I feel pretty good about it.

> The bigger problem is that re_search() is defined in the __USE_GNU section
> of regex.h, and I do not think it is appropriate to universally #define
> said constant before #include'ing regex.h. So it would appear that major
> surgery would be required if we wanted to use regular expressions on
> strings that are not NUL-terminated.

We can contain this to the existing compat/regexec/regexec.c, and just
provide a wrapper that is similar to regexec but takes a ptr/len pair.

Like:

diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 61c9683..b2dd0b7 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -569,6 +569,11 @@ extern int regexec (const regex_t *__restrict __preg,
 		    regmatch_t __pmatch[__restrict_arr],
 		    int __eflags);
 
+extern int regexecn (const regex_t *__restrict __preg,
+		     const char *__restrict __cstring, size_t __length,
+		     size_t __nmatch, regmatch_t __pmatch[__restrict_arr],
+		     int __eflags);
+
 extern size_t regerror (int __errcode, const regex_t *__restrict __preg,
 			char *__restrict __errbuf, size_t __errbuf_size);
 
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index eb5e1d4..8afe26b 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -217,15 +217,16 @@ static reg_errcode_t extend_buffers (re_match_context_t *mctx)
    We return 0 if we find a match and REG_NOMATCH if not.  */
 
 int
-regexec (
+regexecn (
 	const regex_t *__restrict preg,
 	const char *__restrict string,
+	size_t length,
 	size_t nmatch,
 	regmatch_t pmatch[],
 	int eflags)
 {
   reg_errcode_t err;
-  int start, length;
+  int start;
 
   if (eflags & ~(REG_NOTBOL | REG_NOTEOL | REG_STARTEND))
     return REG_BADPAT;
@@ -238,7 +239,7 @@ regexec (
   else
     {
       start = 0;
-      length = strlen (string);
+      /* length already passed in */
     }
 
   __libc_lock_lock (dfa->lock);
@@ -252,6 +253,17 @@ regexec (
   return err != REG_NOERROR;
 }
 
+int
+regexec (
+	const regex_t *__restrict preg,
+	const char *__restrict string,
+	size_t nmatch,
+	regmatch_t pmatch[],
+	int eflags)
+{
+  return regexecn(preg, string, strlen(string), nmatch, pmatch, eflags);
+}
+
 #ifdef _LIBC
 # include <shlib-compat.h>
 versioned_symbol (libc, __regexec, regexec, GLIBC_2_3_4);
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 55067ca..fdd08dd 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -50,9 +50,9 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	xdemitconf_t xecfg;
 
 	if (!one)
-		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
+		return !regexecn(regexp, two->ptr, two->size, 1, &regmatch, 0);
 	if (!two)
-		return !regexec(regexp, one->ptr, 1, &regmatch, 0);
+		return !regexecn(regexp, one->ptr, one->size, 1, &regmatch, 0);
 
 	/*
 	 * We have both sides; need to run textual diff and see if
