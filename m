From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 8/9] autoconf: Check for timer_settime
Date: Wed, 10 Sep 2014 17:33:08 +0200
Message-ID: <54106F34.90505@gmail.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>	 <1409330561-11806-8-git-send-email-jacob.e.keller@intel.com>	 <5400B7C2.20603@kdbg.org> <1409334052.18778.21.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sortie@maxsi.org" <sortie@maxsi.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"j6t@kdbg.org" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:33:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRjtG-00080m-U5
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 17:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbaIJPc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 11:32:58 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:54232 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaIJPc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 11:32:57 -0400
Received: by mail-lb0-f175.google.com with SMTP id v6so5103489lbi.34
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BQwCEnOCAKXPjP+Wh0Hq63ksemwJKzYH04tSE7X05ec=;
        b=nECicCdvth07lpRYR3mo08ItMTBOuw4KhE6qvpvNhs+ELQ9BF5dzy8quTZ2w9T+BIL
         7i9SM3/2I6QvsTF+DGMqpSmMRKT3dGzNPq59d0D3hpSfMnbvnxv1oHh5caU8XyVctQvF
         fMnCDIwDOpOKiW7KrU7himjZ6cDaSfoqrwePprAjI7f3PH+KwL4vmHHVvRnpf2jKXmHx
         LmwUvBsAHFBgXMotu+1K5whmwkn1V9eIiX/W7GOVMc9/HcjLRd06PnTeWKs5JRYu+pTv
         JO/mHnXBa59BeQS6YoDpub7fdsr+7M7bZH/lyx8JQnOaMhg8uvBAZy56TuHGrjpDveOk
         eH+w==
X-Received: by 10.152.23.131 with SMTP id m3mr43209016laf.8.1410363175809;
        Wed, 10 Sep 2014 08:32:55 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id oc1sm2018754lbb.45.2014.09.10.08.32.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 08:32:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1409334052.18778.21.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256750>

Am 29.08.2014 19:40, schrieb Keller, Jacob E:
> On Fri, 2014-08-29 at 19:26 +0200, Johannes Sixt wrote:
>> Am 29.08.2014 18:42, schrieb Jacob Keller:
>>> From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
>>>
>>> This function will be used in a following commit.
>>>
>>> The timer_settime function is provided in librt on some systems. We
>>> already use this library sometimes to get clock_gettime, so rework the
>>> logic so we don't link with it twice.
>>>
>>> This function was not previously used by git. This can cause trouble for
>>> people on systems without timer_settime if they only rely on
>>> config.mak.uname. They will need to set NO_TIMER_SETTIME manually.
>>>
>>> Add proper replacement function macros for setitimer and timer_settime
>>> that implement timer_settime as a wrapper for setitimer. In this way, if
>>> the system has setitimer but not timer_settime then we will be able to
>>> call timer_create, timer_settime, and timer_delete correctly and it will
>>> wrap to setitimer under the hood. This will be used in the following
>>> commit.
>>>
>>> Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
>>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>>> ---
>>>  Makefile          | 21 +++++++++++++++++++++
>>>  config.mak.uname  |  3 +++
>>>  configure.ac      |  8 ++++++++
>>>  git-compat-util.h | 20 +++++++++++++++++++-
>>>  4 files changed, 51 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 66329e4b372b..5337ef0b7cd6 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -182,16 +182,22 @@ all::
>>>  #
>>>  # Define NO_SETITIMER if you don't have setitimer()
>>>  #
>>> +# Define NO_TIMER_SETTIME if you don't have timer_settime()
>>> +#
>>>  # Define NO_TIMER_T if you don't have timer_t.
>>> +# This also implies NO_TIMER_SETTIME
>>>  #
>>>  # Define NO_STRUCT_TIMESPEC if you don't have struct timespec
>>> +# This also implies NO_TIMER_SETTIME
>>>  #
>>>  # Define NO_STRUCT_SIGEVENT if you don't have struct sigevent
>>> +# This also implies NO_TIMER_SETTIME
>>>  #
>>>  # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
>>>  # This also implies NO_SETITIMER
>>>  #
>>>  # Define NO_STRUCT_ITIMERSPEC if you don't have struct itimerspec
>>> +# This also implies NO_TIMER_SETTIME
>>>  #
>>>  # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
>>>  # generally faster on your platform than accessing the working directory.
>>> @@ -1348,12 +1354,15 @@ ifdef OBJECT_CREATION_USES_RENAMES
>>>  endif
>>>  ifdef NO_TIMER_T
>>>  	COMPAT_CFLAGS += -DNO_TIMER_T
>>> +	NO_TIMER_SETTIME = YesPlease
>>>  endif
>>>  ifdef NO_STRUCT_TIMESPEC
>>>  	COMPAT_CFLAGS += -DNO_STRUCT_TIMESPEC
>>> +	NO_TIMER_SETTIME = YesPlease
>>>  endif
>>>  ifdef NO_STRUCT_SIGEVENT
>>>  	COMPAT_CFLAGS += -DNO_STRUCT_SIGEVENT
>>> +	NO_TIMER_SETTIME = YesPlease
>>>  endif
>>>  ifdef NO_STRUCT_ITIMERVAL
>>>  	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
>>> @@ -1361,10 +1370,14 @@ ifdef NO_STRUCT_ITIMERVAL
>>>  endif
>>>  ifdef NO_STRUCT_ITIMERSPEC
>>>  	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERSPEC
>>> +	NO_TIMER_SETTIME = YesPlease
>>>  endif
>>>  ifdef NO_SETITIMER
>>>  	COMPAT_CFLAGS += -DNO_SETITIMER
>>>  endif
>>> +ifdef NO_TIMER_SETTIME
>>> +	COMPAT_CFLAGS += -DNO_TIMER_SETTIME
>>> +endif
>>>  ifdef NO_PREAD
>>>  	COMPAT_CFLAGS += -DNO_PREAD
>>>  	COMPAT_OBJS += compat/pread.o
>>> @@ -1524,6 +1537,14 @@ endif
>>>  
>>>  ifdef HAVE_CLOCK_GETTIME
>>>  	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
>>> +	LINK_WITH_LIBRT = YesPlease
>>> +endif
>>> +
>>> +ifndef NO_TIMER_SETTIME
>>> +	LINK_WITH_LIBRT = YesPlease
>>> +endif
>>> +
>>> +ifdef LINK_WITH_LIBRT
>>>  	EXTLIBS += -lrt
>>>  endif
>>>  
>>> diff --git a/config.mak.uname b/config.mak.uname
>>> index f0d93ef868a7..d04deab2dfa8 100644
>>> --- a/config.mak.uname
>>> +++ b/config.mak.uname
>>> @@ -99,6 +99,7 @@ ifeq ($(uname_S),Darwin)
>>>  	USE_ST_TIMESPEC = YesPlease
>>>  	HAVE_DEV_TTY = YesPlease
>>>  	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
>>> +	NO_TIMER_SETTIME = UnfortunatelyYes
>>>  	COMPAT_OBJS += compat/precompose_utf8.o
>>>  	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
>>>  endif
>>> @@ -360,6 +361,7 @@ ifeq ($(uname_S),Windows)
>>>  	NO_STRUCT_TIMESPEC = UnfortunatelyYes
>>>  	NO_STRUCT_SIGEVENT = UnfortunatelyYes
>>>  	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
>>> +	NO_TIMER_SETTIME = UnfortunatelyYes
>>>  
>>>  	CC = compat/vcbuild/scripts/clink.pl
>>>  	AR = compat/vcbuild/scripts/lib.pl
>>> @@ -513,6 +515,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>>>  	NO_STRUCT_TIMESPEC = UnfortunatelyYes
>>>  	NO_STRUCT_SIGEVENT = UnfortunatelyYes
>>>  	NO_STRUCT_ITIMERSPEC = UnfortunatelyYes
>>> +	NO_TIMER_SETTIME = UnfortunatelyYes
>>>  	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
>>>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>>>  	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
>>> diff --git a/configure.ac b/configure.ac
>>> index 954f9ddb03c2..9d6ec41acc82 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -946,6 +946,14 @@ GIT_CHECK_FUNC(setitimer,
>>>  [NO_SETITIMER=YesPlease])
>>>  GIT_CONF_SUBST([NO_SETITIMER])
>>>  #
>>> +# Define NO_TIMER_SETTIME if you don't have timer_settime
>>> +GIT_CHECK_FUNC(timer_settime,
>>> +[NO_TIMER_SETTIME=],
>>> +[AC_SEARCH_LIBS(timer_settime,[rt],
>>> +  [NO_TIMER_SETTIME=],
>>> +  [NO_TIMER_SETTIME=YesPlease])])
>>> +GIT_CONF_SUBST([NO_TIMER_SETTIME])
>>> +#
>>>  # Define NO_STRCASESTR if you don't have strcasestr.
>>>  GIT_CHECK_FUNC(strcasestr,
>>>  [NO_STRCASESTR=],
>>> diff --git a/git-compat-util.h b/git-compat-util.h
>>> index 4ef17df86b0e..b23602196323 100644
>>> --- a/git-compat-util.h
>>> +++ b/git-compat-util.h
>>> @@ -225,7 +225,25 @@ struct itimerspec {
>>>  #endif
>>>  
>>>  #ifdef NO_SETITIMER
>>> -#define setitimer(which,value,ovalue)
>>> +#define setitimer(which,value,ovalue) ((void) (which), (void) (value), (void) (ovalue), errno = ENOSYS, -1)
>>> +#endif
>>> +
>>> +#ifdef NO_TIMER_SETTIME
>>> +#define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) (sevp), (void) (timerp), errno = ENOSYS, -1)
>>> +
>>> +#define timer_delete(timer) do {		\
>>> +	struct itimerval v = {{0,},};		\
>>> +	setitimer(ITIMER_REAL, &v, NULL);	\
>>> +} while (0)
>>> +
>>> +#define timer_settime(timer, flags, value, ovalue) do {				\
>>> +	struct itimerval _ivalue;						\
>>> +	_ivalue.it_interval.tv_sec = value.it_interval.tv_sec;			\
>>> +	_ivalue.it_interval.tv_usec = value.it_interval.tv_nsec / 1000L;	\
>>> +	_ivalue.it_value.tv_sec  value.it_value.tv_sec;				\
>>> +	_ivalue_it_value.tv_usec = value.it_value.tv_nsec / 1000L;		\
>>> +	setitimer(ITIMER_REAL, &_ivalue, NULL);					\
>>> +while (0)
>>>  #endif
>>>  
>>>  #ifndef NO_LIBGEN_H
>>>

This is required to compile on Windows:
--- 8< ---
diff --git a/git-compat-util.h b/git-compat-util.h
index 237c2a5..5dd4ee0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -227,7 +227,9 @@ struct itimerspec {
 #ifdef NO_SETITIMER
 #define setitimer(which,value,ovalue) ((void) (which), (void) (value), (void) (ovalue), errno = ENOSYS, -1)
 #endif

+#ifndef CLOCK_MONOTONIC
+#define CLOCK_MONOTONIC 1
+#endif
 #ifdef NO_TIMER_SETTIME
 #define timer_create(clockid, sevp, timerp) ((void) (clockid), (void) (sevp), (void) (timerp), errno = ENOSYS, -1)

@@ -238,12 +240,12 @@ struct itimerspec {

 #define timer_settime(timer, flags, value, ovalue) do {                                \
        struct itimerval _ivalue;                                               \
-       _ivalue.it_interval.tv_sec = value.it_interval.tv_sec;                  \
-       _ivalue.it_interval.tv_usec = value.it_interval.tv_nsec / 1000L;        \
-       _ivalue.it_value.tv_sec  value.it_value.tv_sec;                         \
-       _ivalue_it_value.tv_usec = value.it_value.tv_nsec / 1000L;              \
+       _ivalue.it_interval.tv_sec = (value)->it_interval.tv_sec;               \
+       _ivalue.it_interval.tv_usec = (value)->it_interval.tv_nsec / 1000L;     \
+       _ivalue.it_value.tv_sec = (value)->it_value.tv_sec;                     \
+       _ivalue.it_value.tv_usec = (value)->it_value.tv_nsec / 1000L;           \
        setitimer(ITIMER_REAL, &_ivalue, NULL);                                 \
-while (0)
+} while (0)
 #endif

 #ifndef NO_LIBGEN_H
--- 8<---

>>
>> This looks like that the features that we need can be mapped back and
>> forth between setitimer() and timer_settime(). So, why don't you define
>> a compat/setitimer.[ch] for your system that does not have setitimer()
>> and implement setitimer() in terms of timer_settime() instead of the
>> other way round? Then you don't need to change any of the client code.
>> Also, you won't have to worry about the odd timer_settime() in OpenBSD.
>>
>> -- Hannes
>>
> 
> You could do that, I suppose, though I personally prefer to use the
> newer standard in the core code, and only fallback to older standards in
> the case where you don't have what is new (instead of the other way
> around).
> 
> Overall it doesn't really matter to me.
> 

While the timer extension (timer_settime) has graduated to mandatory in
the current POSIX spec, the monotonic clock extension is still optional
today (i.e. not necessarily supported even on newer Unices). In contrast
to this, the XSI extensions seem to be widely supported.

IMO the 'obsolescent' marker in the current POSIX spec is no reason to
spring into action (at least not yet). E.g. utimes (also in <sys/time.h>)
has been marked LEGACY in the 2004 version and is no longer LEGACY today.
Btw., we'd also have to find a replacement for gettimeofday and probably
a lot of other stuff...

Therefore I tend to agree with Hannes that we should stick with setitimer
and emulate it on systems that don't have it (as we do on Windows).
