From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 7 Apr 2010 16:45:55 +0200
Message-ID: <20100407144555.GA23911@fredrik-laptop>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
 <20100407031655.GA7156@spearce.org>
 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:46:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWWH-00020V-4Y
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561Ab0DGOqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:46:10 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:34047 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0DGOqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:46:09 -0400
Received: by ewy20 with SMTP id 20so571203ewy.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ecKpyWilZlzcyYhR3Ih2dZB3FiN1zZz+5yfyFwNSzuI=;
        b=oy5uL2zAL0ElUIEyaszdTasT6VSDJzSqIZtvg0U6LWmZ47zRN8XZXBxAMunCBcf3GN
         lWRtLusCEuhf6Vuc4Fgq+7EdS+YyAMwC4H1JuKMAmZBwNQOK7mSpkjYxd5ZI40cIriD3
         ZS8WQHUxFSO0TYd2RvRGaF4mFPrVaYXrDaDHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lPIVyszIJTMO/vrJEY8/BFvLjZIxD5+JUSmiQd/fmzNFwXMVfgwF5tFSYaRw8LdsEX
         44UBYnsDa/NIGq7bD0lrUtjmWDwL1k+T8Qb2WQbMQKkIWoqhLyrTiFo2st1HXsdSEi6D
         h2IfB9h6RbGMtPXOM0heVEeX6IyBmi22IRAUc=
Received: by 10.213.53.70 with SMTP id l6mr5481942ebg.45.1270651564522;
        Wed, 07 Apr 2010 07:46:04 -0700 (PDT)
Received: from fredrik-laptop (c83-250-155-64.bredband.comhem.se [83.250.155.64])
        by mx.google.com with ESMTPS id 13sm704738ewy.9.2010.04.07.07.45.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 07:45:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144228>

On Wed, Apr 07, 2010 at 09:17:04AM -0400, Nicolas Pitre wrote:
> On Wed, 7 Apr 2010, Shawn Pearce wrote:
> > You mentioned avoiding a recursive mutex only because windows
> > emulation doesn't have support for it.  But that's exactly what we
> > need here.  Shouldn't windows have a recursive mutex object that can
> > just be used inside of the emulation layer when we really need a
> > recursive mutex?
> 
> Maybe.  That would in fact just mean pushing the double mutex issue into 
> the pthread emulation instead of having it outside it.  This would 
> impact performances for all mutexes although only one instance of them 
> currently require a recursive behavior.

As I mentioned in another mail in this thread, our mutex
implementation on WIN32 already is recursive. It is implemented on top
of the CRITICAL_SECTION type, which is recursive. See
http://msdn.microsoft.com/en-us/library/ms682530%28VS.85%29.aspx

We only need something like the following (on top of Nico's previous
patch). Warning: It hasn't even been compile tested on WIN32.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 65f797f..19e42cf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1559,7 +1559,7 @@ static pthread_cond_t progress_cond;
  */
 static void init_threaded_search(void)
 {
-	pthread_mutex_init(&read_mutex, NULL);
+	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
diff --git a/thread-utils.c b/thread-utils.c
index 4f9c829..3c8d817 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include <pthread.h>
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
@@ -43,3 +44,24 @@ int online_cpus(void)
 
 	return 1;
 }
+
+int init_recursive_mutex(pthread_mutex_t *m)
+{
+#ifdef _WIN32
+	/* The mutexes in the WIN32 pthreads emulation layer are
+	 * recursive, so we don't have to do anything extra here. */
+	return pthread_mutex_init(m, NULL);
+#else
+	pthread_mutexattr_t a;
+	int ret;
+	if (pthread_mutexattr_init(&a))
+		die("pthread_mutexattr_init failed: %s", strerror(errno));
+
+	if (pthread_mutexattr_settype(&a, PTHREAD_MUTEX_RECURSIVE))
+		die("pthread_mutexattr_settype failed: %s", strerror(errno));
+
+	ret = pthread_mutex_init(m, &a);
+	pthread_mutexattr_destroy(&a);
+	return ret;
+#endif
+}
diff --git a/thread-utils.h b/thread-utils.h
index cce4b77..1727a03 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -2,5 +2,6 @@
 #define THREAD_COMPAT_H
 
 extern int online_cpus(void);
+extern int init_recursive_mutex(pthread_mutex_t*);
 
 #endif /* THREAD_COMPAT_H */
