From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] simplify inclusion of pthread.h
Date: Fri, 10 Dec 2010 13:47:54 -0600
Message-ID: <20101210194754.GB6801@burratino>
References: <20101210114839.GA5771@burratino>
 <7vhbeleber.fsf@alter.siamese.dyndns.org>
 <20101210194637.GA6801@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 20:48:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR8xF-0005Bo-SV
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 20:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab0LJTsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 14:48:14 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63697 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab0LJTsN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 14:48:13 -0500
Received: by qwa26 with SMTP id 26so4224862qwa.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 11:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TIle7SYXP1nO3+Fs+0WSZjkIqonyfl9YoIaEiBgQyDU=;
        b=Cf8EYXY0inBff6pAaC9uLdPXljRsXNOOk3PiPoZObG6AfM7g7rvWbvnKZmeTZv3M4b
         LMDdigYCIJfUiJoeOAYn6cmBJZ+YBUcWPc0YoDSMUPrDzGg8buASzhgLZoQYu7LIxV9B
         XWvkvPvu0mvl1Ruq3fkSPWNk0cQkB9VN6FKxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FuI2Iz0RDq5eopqv/Dr2iEgilpMKnUJIpBt8Lz5Zk8EKrQsnERouY/RKFGrXNURxBu
         EK0XaHq1QLaeL1BIVzX2LmxaoQx1cyCIJoEkJTLpzxsmO736Z2P2V4nJLLufH+Hm2wob
         8lcgnUY2RwqrkltahAv2WIXISzanVWJTePDQI=
Received: by 10.229.251.204 with SMTP id mt12mr986017qcb.182.1292010492437;
        Fri, 10 Dec 2010 11:48:12 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id m7sm2192772qck.25.2010.12.10.11.48.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 11:48:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210194637.GA6801@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163434>

In v1.7.1.1~56^2 (Thread-safe xmalloc and xrealloc needs a recursive
mutex, 2010-04-08), the thread-utils header started using
pthread_mutex_t, so callers, which generally had been using

	#ifndef NO_PTHREADS
	#include "thread-utils.h"
	#include <pthread.h>
	#endif

before, were changed to include <pthread.h> first.  It is simpler to
let thread-utils.h take care of the whole matter.  This way, we can
later add more things that the threaded part of the system would need
to thread-utils.h inside "ifndef NO_PTHREADS" and they will
automatically get included by all headers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/grep.c         |    4 ----
 builtin/pack-objects.c |    4 ----
 thread-utils.h         |    4 ++++
 transport-helper.c     |    4 ----
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index adb5424..fdf7131 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -17,11 +17,7 @@
 #include "grep.h"
 #include "quote.h"
 #include "dir.h"
-
-#ifndef NO_PTHREADS
-#include <pthread.h>
 #include "thread-utils.h"
-#endif
 
 static char const * const grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]",
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f027b3a..b0503b2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -16,11 +16,7 @@
 #include "list-objects.h"
 #include "progress.h"
 #include "refs.h"
-
-#ifndef NO_PTHREADS
-#include <pthread.h>
 #include "thread-utils.h"
-#endif
 
 static const char pack_usage[] =
   "git pack-objects [ -q | --progress | --all-progress ]\n"
diff --git a/thread-utils.h b/thread-utils.h
index 1727a03..6fb98c3 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -1,7 +1,11 @@
 #ifndef THREAD_COMPAT_H
 #define THREAD_COMPAT_H
 
+#ifndef NO_PTHREADS
+#include <pthread.h>
+
 extern int online_cpus(void);
 extern int init_recursive_mutex(pthread_mutex_t*);
 
+#endif
 #endif /* THREAD_COMPAT_H */
diff --git a/transport-helper.c b/transport-helper.c
index 3a50856..4e4754c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -8,11 +8,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "string-list.h"
-
-#ifndef NO_PTHREADS
-#include <pthread.h>
 #include "thread-utils.h"
-#endif
 
 static int debug;
 
-- 
1.7.2.4
