Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE1A1F45F
	for <e@80x24.org>; Wed,  8 May 2019 07:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEHHrH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 03:47:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55960 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfEHHrG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 03:47:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B1CC150656;
        Wed,  8 May 2019 03:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l2vnyilLOTFizLg8VL31H0mYas0=; b=hRUyqF
        KeyvMAKAoBEaeToHApeJE7swQaCXfGmCcuMzDH9uAO13iTNaog8L1SpVo4pBDXrl
        KsOgLiqAZvkOKVU8gcqZ9T17NUnQaEZEMyPbtw6frk5vgsSeX/LaWje054woPEw/
        hzNvC/LuggrZiU+jWh+2jIK9mNSbkilADI1xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qTdxfsBpZiqJjHV7HgRuiR/zm8PyQStT
        4tnyH9Y/MQrLA9Kky2NNrcdgqlO4spOW95lD2bctjKrV6uWvpWcSMb7Dc0Ms252A
        1VGMXLWsJqoxrLOusqMylZfzhfzAVb1nOZXA89jrm/KQ54z1xsf53JKUS+gon0cL
        wrL5tFcZD2k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90674150655;
        Wed,  8 May 2019 03:47:01 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C421D150652;
        Wed,  8 May 2019 03:47:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan McGregor <dkm560@usask.ca>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "McGregor\, Dan" <dan.mcgregor@usask.ca>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-compat-util: undefine fileno if defined
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
        <20190209023621.75255-1-dan.mcgregor@usask.ca>
        <20190212134537.GA26137@ash>
        <D8E7C7D0-04E5-4802-80FA-2477F2C0D240@usask.ca>
Date:   Wed, 08 May 2019 16:46:59 +0900
In-Reply-To: <D8E7C7D0-04E5-4802-80FA-2477F2C0D240@usask.ca> (Dan McGregor's
        message of "Sat, 16 Feb 2019 02:33:27 +0000")
Message-ID: <xmqqk1f1gzgs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76AD7284-7165-11E9-88A0-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan McGregor <dkm560@usask.ca> writes:

>>I don't think this is enough. At least fbsd defines this
>>
>>#define    fileno(p)    (!__isthreaded ? __sfileno(p) : (fileno)(p))
>>
>>so one of the two functions will be used depending on __isthreaded
>>flag. Your forcing to use fileno, ignoring __sfileno, is technically
>>not correct.
>>
>>For the record, at least fbsd also defines feof, ferror, clearerr,
>>getc and putc in the same way. But at least I don't see how something
>>like feof(fp++) could cause bad side effects.
>>
>>So, how about something like this? A teeny bit longer than your
>>version, but I think it's easier to control long term.
>
> Yes, this looks pretty reasonable to me too.

Sorry for pinging this ancient thread, but while reviewing the
stalled topics, this one caught my attention.  The very original
<20190201193004.88736-1-dan.mcgregor@usask.ca> said that the problem
it wants to solve was that the code that passes (void*) parameter to
fileno(), fflush() and rewind() misbehaved, as these are all macros
on your system.

We solved the problem for fileno() being a macro eventually with
18a4f6be ("git-compat-util: work around fileno(fp) that is a macro",
2019-02-12), but what about the other two?

Here comes a weather-balloon to see if we should pursue tying this
loose end.

One thing to note is that this reveals that the build rule for
vcs-svn stuff may be cleaned up before we do this as a separate
step, but I think I saw another topics to move it out of the main
build so perhaps I'll leave it out and leave it to be worried about
separately ;-)

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 8 May 2019 16:12:20 +0900
Subject: [PATCH] git-compat-util: rewind(fp)/fflush(fp) could be macros

On various BSD's, rewind(fp) is implemented as a macro that directly
accesses the fields in the FILE * object, which breaks a function
that accepts a "void *fp" parameter and calls rewind(fp) and expect
it to work.  The same issue has been resolved for fileno(fp) earlier,
which is shared by fflush(fp) as well.

Work it around by adding a compile-time knob REWIND_IS_A_MACRO and
FFLUSH_IS_A_MACRO for these two other functions that tells us to
insert a real helper function in the middle of the callchain.

I'll leave it up to those who do work on affected platforms to add
entries to config.mak.uname.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile          | 18 ++++++++++++++++--
 compat/fflush.c   |  7 +++++++
 compat/rewind.c   |  7 +++++++
 git-compat-util.h | 16 ++++++++++++++++
 4 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 compat/fflush.c
 create mode 100644 compat/rewind.c

diff --git a/Makefile b/Makefile
index 6e8d017e8e..1e18092583 100644
--- a/Makefile
+++ b/Makefile
@@ -433,6 +433,10 @@ all::
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
 #
+# Define FFLUSH_IS_A_MACRO if fflush() is a macro, not a real function.
+#
+# Define REWIND_IS_A_MACRO if rewind() is a macro, not a real function.
+#
 # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
 # default environment variables to be passed when a pager is spawned, e.g.
 #
@@ -1795,6 +1799,16 @@ ifdef HAVE_WPGMPTR
 	BASIC_CFLAGS += -DHAVE_WPGMPTR
 endif
 
+ifdef FFLUSH_IS_A_MACRO
+	COMPAT_CFLAGS += -DFFLUSH_IS_A_MACRO
+	COMPAT_OBJS += compat/fflush.o
+endif
+
+ifdef REWIND_IS_A_MACRO
+	COMPAT_CFLAGS += -DREWIND_IS_A_MACRO
+	COMPAT_OBJS += compat/rewind.o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2404,8 +2418,8 @@ git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
-	$(VCSSVN_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(VCSSVN_LIB) $(LIBS)
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
diff --git a/compat/fflush.c b/compat/fflush.c
new file mode 100644
index 0000000000..55ac3e5542
--- /dev/null
+++ b/compat/fflush.c
@@ -0,0 +1,7 @@
+#define COMPAT_CODE_FFLUSH
+#include "../git-compat-util.h"
+
+int git_fflush(FILE *stream)
+{
+	return fflush(stream);
+}
diff --git a/compat/rewind.c b/compat/rewind.c
new file mode 100644
index 0000000000..e56656ff96
--- /dev/null
+++ b/compat/rewind.c
@@ -0,0 +1,7 @@
+#define COMPAT_CODE_REWIND
+#include "../git-compat-util.h"
+
+void git_rewind(FILE *stream)
+{
+	rewind(stream);
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 29a19902aa..f35a857785 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1234,6 +1234,22 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
+#ifdef FFLUSH_IS_A_MACRO
+int git_fflush(FILE *stream);
+# ifndef COMPAT_CODE_FFLUSH
+#  undef fflush
+#  define fflush(p) git_fflush(p)
+# endif
+#endif
+
+#ifdef REWIND_IS_A_MACRO
+void git_rewind(FILE *stream);
+# ifndef COMPAT_CODE_REWIND
+#  undef rewind
+#  define rewind(p) git_rewind(p)
+# endif
+#endif
+
 /*
  * Our code often opens a path to an optional file, to work on its
  * contents when we can successfully open it.  We can ignore a failure
-- 
2.21.0-777-g83232e3864



