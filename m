From: Andrew Rodland <andrew@cleverdomain.org>
Subject: USE_NSEC bug?
Date: Wed, 20 Mar 2013 02:36:32 -0400
Message-ID: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 07:37:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UICdy-0004O1-8T
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 07:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab3CTGgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 02:36:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab3CTGge convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Mar 2013 02:36:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66446941C
	for <git@vger.kernel.org>; Wed, 20 Mar 2013 02:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=mime-version
	:date:message-id:subject:from:to:content-type
	:content-transfer-encoding; s=sasl; bh=nYk/72mRcXQvpEw3HMmQI+SGs
	WU=; b=hqE+le6HXnP/GT7csb+yiHBK+Kg2Ksou9WPD79e6dneZgLi9E27N5Qpxr
	KjRPEhFsFLciV1Vdq+Uaf5AWMoccto5d6PijEcsDD6frQY5z2DpwCjarJkWJXjd5
	oXeU8yNzrrMknXyW7rOUsOzHQFRtfKPvtvHc7VvtZkm7LB7Mnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B88F941B
	for <git@vger.kernel.org>; Wed, 20 Mar 2013 02:36:33 -0400 (EDT)
Received: from mail-ia0-f177.google.com (unknown [209.85.210.177]) (using
 TLSv1 with cipher RC4-SHA (128/128 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 006489418 for
 <git@vger.kernel.org>; Wed, 20 Mar 2013 02:36:32 -0400 (EDT)
Received: by mail-ia0-f177.google.com with SMTP id y25so1101373iay.8 for
 <git@vger.kernel.org>; Tue, 19 Mar 2013 23:36:32 -0700 (PDT)
X-Received: by 10.50.40.162 with SMTP id y2mr3481872igk.65.1363761392454;
 Tue, 19 Mar 2013 23:36:32 -0700 (PDT)
Received: by 10.43.67.70 with HTTP; Tue, 19 Mar 2013 23:36:32 -0700 (PDT)
X-Pobox-Relay-ID: 816A58E6-9128-11E2-BEC5-4AAA2E706CDE-16769786!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218571>

While investigating this StackOverflow question:
http://stackoverflow.com/questions/15516168/how-to-cross-compile-git-fo=
r-arm
I found that fetch-pack.c uses ST_MTIME_NSEC outside of the protection
of #ifdef USE_NSEC. This results in a broken build if
!defined(USE_NSEC) && !defined(NO_NSEC) and the target system doesn't
happen to be recent glibc.

I'm not sure where to pin the bug exactly =97 on fetch-pack.c, on
git-compat-util.h, on configure for not seeing if one of those fields
actually exists and setting NO_NSEC otherwise, or elsewhere, but I
would be tempted to fix it in one of the two below ways, which should
always be foolproof when !defined(USE_NSEC). That seems right to me,
since USE_NSEC is an experimental-ish feature.

Please Cc any replies as I'm not subscribed.

Way one (smaller diff for an uglier result):

--

diff --git a/git-compat-util.h b/git-compat-util.h
index 90e0372..222caaa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -638,10 +638,13 @@ void git_qsort(void *base, size_t nmemb, size_t s=
ize,
 # define FORCE_DIR_SET_GID 0
 #endif

 #ifdef NO_NSEC
 #undef USE_NSEC
+#endif
+
+#ifndef USE_NSEC
 #define ST_CTIME_NSEC(st) 0
 #define ST_MTIME_NSEC(st) 0
 #else
 #ifdef USE_ST_TIMESPEC
 #define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))

--

Way two (bigger diff for a prettier result):

diff --git a/git-compat-util.h b/git-compat-util.h
index 90e0372..0a15b1a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -638,20 +638,23 @@ void git_qsort(void *base, size_t nmemb, size_t s=
ize,
 # define FORCE_DIR_SET_GID 0
 #endif

 #ifdef NO_NSEC
 #undef USE_NSEC
-#define ST_CTIME_NSEC(st) 0
-#define ST_MTIME_NSEC(st) 0
-#else
-#ifdef USE_ST_TIMESPEC
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
-#else
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
 #endif
+
+#ifdef USE_NSEC
+# ifdef USE_ST_TIMESPEC
+#  define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec)=
)
+#  define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec)=
)
+# else
+#  define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
+#  define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
+# endif
+#else /* !USE_NSEC */
+# define ST_CTIME_NSEC(st) 0
+# define ST_MTIME_NSEC(st) 0
 #endif

 #ifdef UNRELIABLE_FSTAT
 #define fstat_is_reliable() 0
 #else
