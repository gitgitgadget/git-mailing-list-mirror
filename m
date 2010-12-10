From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: avoid dependency on thread-utils.h
Date: Fri, 10 Dec 2010 10:21:48 -0800
Message-ID: <7vhbeleber.fsf@alter.siamese.dyndns.org>
References: <20101210114839.GA5771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 19:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR7ba-0001VK-Lq
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 19:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab0LJSV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 13:21:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab0LJSV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 13:21:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3E8432FB;
	Fri, 10 Dec 2010 13:22:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pmXa7okYrcjlFUVd5kfamRzxxfU=; b=Ai2FA+
	J5kmha8XE5gfW4UinKGV7zmVQhPDQ2bsJnsAQZs4SYJGFjcvK/cZT24q3VvkHgmJ
	GcZ+9yFiHX4XcUudxSaDRkMJE1iZDwUF4MCjrmKxDopMmLwvmD6ajTNZp37MtAba
	NDOkrnT4jz+p7BOB6CSbjHnsDNBvU06vUePlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wz8Q9Osuj+ZTdrCHV6dQQWISuPsQ+rca
	wrju/N327s3LHtAb+SnxgnfOuRyoVnexV7LFQBwAUmQkDTQ4PFxnmMnfEYSP0SnL
	0JVk7QeJ9llH3+XWvWJbcSNlk5Uoqlai2Xj8fWWlbtoDCYT9I3pz7RZpjXcmJl2h
	Mq7gSriHPZE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A419C32F6;
	Fri, 10 Dec 2010 13:22:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4402132F3; Fri, 10 Dec 2010
 13:22:15 -0500 (EST)
In-Reply-To: <20101210114839.GA5771@burratino> (Jonathan Nieder's message of
 "Fri\, 10 Dec 2010 05\:48\:39 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6CAC20B0-048A-11E0-A0BA-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163424>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Since the transport-helper does not use recursive mutexes or ask the
> number of cores, it does not require any declarations from the
> thread-utils lib.  Removing the unnecessary #include avoids false
> positives from "make CHECK_HEADER_DEPENDENCIES=1".

Sorry, I was slow and took me some time to realize what is going on.

Isn't it more like "Makefile does not say transport-helper.o depends on
thread-utils.h, but transport-helper.c does include it"?  IOW, it not a
false positive; perhaps a real but an unnecessary positive.

> The #include directive in question was added in 7851b1e60
> (remote-fd/ext: finishing touches after code review, 2010-11-17),
> at the same times as the necessary #include for <pthread.h>.

I think the whole four-line block was cut & paste from other places that
use the threading, namely grep.c and pack-objects.c.

I wonder if it is better to do something like this instead.  This way, we
can later add more things that threaded part of the system would need to
thread-utils.h inside "ifndef NO_PTHREADS" and they will automatically get
included by all the threaders.


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
 
