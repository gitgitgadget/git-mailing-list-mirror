From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 16:36:08 +0700
Message-ID: <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org>
 <4F8E6A12.9090708@viscovery.net>
 <4F8F1BC1.3030607@ramsay1.demon.co.uk>
 <4F8FADCF.5000006@viscovery.net>
 <4F8FB4A0.7090403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 11:37:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKnnY-0003qp-5L
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 11:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab2DSJhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 05:37:03 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:61195 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab2DSJhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 05:37:01 -0400
Received: by dake40 with SMTP id e40so11138921dak.11
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Rk/ocsjeFZdn+jQtlbvD5lD3O5RntTk05jx/QqdoYIA=;
        b=Ut4RnUk6nZQLltVk2djswOytam0XHTPo+WA9JBa4wVw9DTTTr+re+wL+tEYrn09v2X
         6cuwDJx+u4jGSbXi1nYXDjUelFJ2YVQNcGXG7pjuXF+fcQBKKOzHmP5UIBPMUY8985Ie
         Ij5XvtzwKPZqJ46hI+MFq1gQEnV+tnpgHGKZrXVxfgHQKyEnrRhDQ5xQ/ftntEf7j3fy
         id2lEtPbrj6+Kp5zEJuGbjTHr+oF4qM8Hqhq1yfx7MlSEr3ShcIlEOO9NQQTc/xbviaP
         xY09t4EI1PGCF9H3GvWI2NmxYqeCRhYtYR9Dw6QoRiUAUakAHiB0HqiS/j8qr2LxGRMa
         1Lzw==
Received: by 10.68.191.166 with SMTP id gz6mr3615969pbc.164.1334828221473;
        Thu, 19 Apr 2012 02:37:01 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id k9sm1758001pbf.65.2012.04.19.02.36.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 02:37:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 19 Apr 2012 16:36:08 +0700
Content-Disposition: inline
In-Reply-To: <4F8FB4A0.7090403@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195932>

On Thu, Apr 19, 2012 at 08:45:52AM +0200, Johannes Sixt wrote:
> I don't see any mutual exclusion happening in this chain. Perhaps it is
> not needed, provided that the pread() call in get_data_from_pack is
> atomic. But our git_pread() from compat/pread.c, which we use on Windows,
> is not atomic.

OK assume it's Windows' pread thread-safe problem (it does look like
so given how pread.c implements it), maybe this patch will help:

-- 8< --
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 847dbb3..5d539cd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -102,6 +102,10 @@ static pthread_mutex_t work_mutex;
 #define work_lock()		lock_mutex(&work_mutex)
 #define work_unlock()		unlock_mutex(&work_mutex)
 
+#ifdef WIN32
+static pthread_mutex_t pread_mutex;
+#endif
+
 static pthread_key_t key;
 
 static inline void lock_mutex(pthread_mutex_t *mutex)
@@ -124,6 +128,9 @@ static void init_thread(void)
 	init_recursive_mutex(&read_mutex);
 	pthread_mutex_init(&counter_mutex, NULL);
 	pthread_mutex_init(&work_mutex, NULL);
+#ifdef WIN32
+	pthread_mutex_init(&pread_mutex, NULL);
+#endif
 	pthread_key_create(&key, NULL);
 	thread_data = xcalloc(nr_threads, sizeof(*thread_data));
 	threads_active = 1;
@@ -137,6 +144,9 @@ static void cleanup_thread(void)
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
+#ifdef WIN32
+	pthread_mutex_destroy(&pread_mutex);
+#endif
 	pthread_key_delete(key);
 	free(thread_data);
 }
@@ -456,6 +466,20 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 	return data;
 }
 
+#ifdef WIN32
+/* pread is reimplemented in compat/pread.c and is not thread-safe */
+static ssize_t pread_threadsafe(int fd, void *buf, size_t count, off_t from)
+{
+	ssize_t n;
+	lock_mutex(&pread_mutex);
+	n = pread(fd, buf, count, from);
+	unlock_mutex(&pread_mutex);
+	return n;
+}
+#else
+#define pread_threadsafe(fd,buf,count,from) pread(fd, buf, count, from)
+#endif
+
 static void *get_data_from_pack(struct object_entry *obj)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
@@ -474,7 +498,7 @@ static void *get_data_from_pack(struct object_entry *obj)
 
 	do {
 		ssize_t n = (len < 64*1024) ? len : 64*1024;
-		n = pread(pack_fd, inbuf, n, from);
+		n = pread_threadsafe(pack_fd, inbuf, n, from);
 		if (n < 0)
 			die_errno("cannot pread pack file");
 		if (!n)
-- 8< --
