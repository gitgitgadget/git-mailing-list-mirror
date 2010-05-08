From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] Do not call release_pack_memory in malloc wrappers when GIT_TRACE is used
Date: Sat, 8 May 2010 17:18:06 +0200
Message-ID: <201005081718.07355.j6t@kdbg.org>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org> <4BDDDA21.4090304@kdbg.org> <201005081713.49937.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 08 17:21:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAlpy-0004xL-09
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 17:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab0EHPUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 11:20:43 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:18365 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753576Ab0EHPUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 11:20:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 319B5A7EBE;
	Sat,  8 May 2010 17:20:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 745EF19F747;
	Sat,  8 May 2010 17:18:07 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <201005081713.49937.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146662>

This avoids a potential race condition when async procedures are
implemented as threads where release_pack_memory() can be called from
different threads without locking under memory pressure.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 It is worthwhile to have this in np/malloc-threading (and in maint or
 master) even if js/async-thread is not in master, yet, because on
 Windows we already have async procedures implemented in threads.

 trace.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/trace.c b/trace.c
index 4229ae1..1e560cb 100644
--- a/trace.c
+++ b/trace.c
@@ -25,6 +25,10 @@
 #include "cache.h"
 #include "quote.h"
 
+void do_nothing(size_t unused)
+{
+}
+
 /* Get a trace file descriptor from GIT_TRACE env variable. */
 static int get_trace_fd(int *need_close)
 {
@@ -72,6 +76,7 @@ void trace_printf(const char *fmt, ...)
 	if (!fd)
 		return;
 
+	set_try_to_free_routine(do_nothing);	/* is never reset */
 	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
@@ -103,6 +108,7 @@ void trace_argv_printf(const char **argv, const char *fmt, ...)
 	if (!fd)
 		return;
 
+	set_try_to_free_routine(do_nothing);	/* is never reset */
 	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
-- 
1.7.1.64.ga1799.dirty
