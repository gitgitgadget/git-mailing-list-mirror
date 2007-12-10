From: Andreas Ericsson <ae@op5.se>
Subject: Re: Better value for chunk_size when threaded
Date: Mon, 10 Dec 2007 11:26:59 +0100
Message-ID: <475D1473.5090809@op5.se>
References: <9e4733910712061558k19fbc864ia1fb7a3431fd2603@mail.gmail.com> <alpine.LFD.0.99999.0712062014060.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 11:27:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1frJ-00081i-J4
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 11:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbXLJK1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 05:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbXLJK1F
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 05:27:05 -0500
Received: from mail.op5.se ([193.201.96.20]:47291 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbXLJK1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 05:27:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5B09C1F08028;
	Mon, 10 Dec 2007 11:27:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vBozYGT+5zSh; Mon, 10 Dec 2007 11:27:00 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 6CEEF1F08027;
	Mon, 10 Dec 2007 11:27:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.0.99999.0712062014060.555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67699>

Nicolas Pitre wrote:
> On Thu, 6 Dec 2007, Jon Smirl wrote:
> 
>> I tried some various ideas out for chunk_size and the best strategy I
>> found was to simply set it to a constant. How does 20,000 work on
>> other CPUs?
> 
> That depends on the object size.  If you have a repo with big objects 
> but only 1000 of them for example, then the constant doesn't work.
> 
> Ideally I'd opt for a value that tend towards around 5 seconds worth of 
> work per segment, or something like that.  Maybe using the actual 
> objects size could be another way.
> 
>> I'd turn on default threaded support with this change. With threads=1
>> versus non-threaded there is no appreciable difference in the time.
> 
> Would need a way to determine pthreads availability from Makefile.
> 
>> Is there an API to ask how many CPUs are in the system? It would be
>> nice to default the number of threads equal to the number of CPUs and
>> only use pack.threads=X to override.
> 
> If there is one besides futzing with /proc/cpuinfo I'd like to know 
> about it.  Bonus points if it is portable.
> 

Here is such a one. I've sent it before, using git-send-email, but that
one doesn't seem to work too well for all list-members, probably because
my own laptop appears to be the original SMTP-server and its name can't
be looked up. Sorry for inlining it here instead of sending it as a mail
on its own, but I have absolutely no idea how to get git-send-email to
do ldap authentication and connect to our tls-enabled smtp-server
without using /usr/bin/sendmail and adding my laptop as originating
smtp-server.

This patch replaces the one I sent earlier and *should* work on
everything from Irix and AIX to Linux, Windows and every other
posixish system. It passes all tests, both with and without
THREADED_DELTA_SEARCH, and causes our weekly repack of our
mother-ship repos to run roughly 4 times as fast (4 cores, no
previous thread config).

Extract with
   sed -n -e /^##SEDMEHERE##/,/##TOHERE##/p -e /^##/d

##SEDMEHERE##
From ddf08303bd7962be385abbd5e964455a90ed6055 Mon Sep 17 00:00:00 2001
From: Andreas Ericsson <ae@op5.se>
Date: Thu, 6 Dec 2007 22:09:27 +0100
Subject: [PATCH] pack-objects: Add runtime detection of number of CPU's

Packing objects can be done in parallell nowadays, but
it's only done if the config option pack.threads is set
to a value above 1. Because of that, the code-path used
is sometimes not the most optimal one.

This patch adds a routine to detect the number of active
CPU's at runtime, which should provide a better default
and activate the (hopefully) better codepath more often.

The code is a rework of "numcpus.c", written by one
Philip Willoughby <pgw99@doc.ic.ac.uk>. numcpus.c is in
the public domain and can presently be downloaded from
http://csgsoft.doc.ic.ac.uk/numcpus/

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 builtin-pack-objects.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 250dc56..ccf5198 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -17,6 +17,13 @@
 
 #ifdef THREADED_DELTA_SEARCH
 #include <pthread.h>
+# ifdef _WIN32
+#  define WIN32_LEAN_AND_MEAN
+# include <windows.h>
+# endif
+# if defined(hpux) || defined(__hpux) || defined(_hpux)
+#  include <sys/pstat.h>
+# endif
 #endif
 
 static const char pack_usage[] = "\
@@ -70,7 +77,7 @@ static int progress = 1;
 static int window = 10;
 static uint32_t pack_size_limit;
 static int depth = 50;
-static int delta_search_threads = 1;
+static long delta_search_threads;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress *progress_state;
@@ -2004,6 +2011,44 @@ static int adjust_perm(const char *path, mode_t mode)
 	return adjust_shared_perm(path);
 }
 
+/*
+ * this is a disgusting nest of #ifdef's. I just love
+ * non-portable interfaces. By doing it in two steps
+ * we can get the function to be fairly coherent anyways
+ */
+#ifndef _SC_NPROCESSORS_ONLN
+# ifdef _SC_NPROC_ONLN
+#  define _SC_NPROCESSORS_ONLN _SC_NPROC_ONLN
+# elif defined _SC_CRAY_NCPU
+#  define _SC_NPROCESSORS_ONLN _SC_CRAY_NCPU
+# endif
+#endif
+static long active_cpu_count(void)
+{
+#ifdef THREADED_DELTA_SEARCH
+# ifdef _SC_NPROCESSORS_ONLN
+	long ncpus;
+
+	if ((ncpus = (long)sysconf(_SC_NPROCESSORS_ONLN)) > 0)
+		return ncpus;
+# else
+#  ifdef _WIN32
+	SYSTEM_INFO info;
+	GetSystemInfo(&info);
+
+	return (long)info.dwNumberOfProcessors;
+#  endif /* _WIN32 */
+#  if defined(hpux) || defined(__hpux) || defined(_hpux)
+	struct pst_dynamic psd;
+
+	if (!pstat_getdynamic(&psd, sizeof(psd), (size_t)1, 0))
+		return (long)psd.psd_proc_cnt;
+#  endif /* hpux */
+# endif /* _SC_NPROCESSORS_ONLN */
+#endif /* THREADED_DELTA_SEARCH */
+	return 1;
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -2019,6 +2064,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	rp_av[1] = "--objects"; /* --thin will make it --objects-edge */
 	rp_ac = 2;
 
+	delta_search_threads = active_cpu_count();
+
 	git_config(git_pack_config);
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
-- 
1.5.3.6.2031.gf9bdc
##TOHERE##

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
