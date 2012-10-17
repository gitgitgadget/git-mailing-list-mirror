From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for .gitattributes
Date: Wed, 17 Oct 2012 09:05:51 +0200
Message-ID: <507E58CF.2040803@viscovery.net>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349877544-17648-1-git-send-email-pclouds@gmail.com> <1349877544-17648-3-git-send-email-pclouds@gmail.com> <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org> <50765CDC.8020509@viscovery.net> <7vpq4p80sn.fsf@alter.siamese.dyndns.org> <5077C7AC.9010301@viscovery.net> <7v4nlx3cc8.fsf@alter.siamese.dyndns.org> <507BA6F0.4090500@viscovery.net> <7vfw5fy8tx.fsf@alter.siamese.dyndns.org> <507D010A.8000904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:06:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TONhj-0002G1-61
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 09:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab2JQHF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 03:05:59 -0400
Received: from so.liwest.at ([212.33.55.24]:33135 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab2JQHF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 03:05:59 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TONhP-0008Nx-RU; Wed, 17 Oct 2012 09:05:52 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 710F21660F;
	Wed, 17 Oct 2012 09:05:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <507D010A.8000904@viscovery.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207897>

Am 10/16/2012 8:39, schrieb Johannes Sixt:
> Am 10/15/2012 18:54, schrieb Junio C Hamano:
>> Ideally, that earlier workaround
>> should have done a logica equivalent of:
>> ...
>> and did so not in-line at the calling site but in a compat/ wrapper
>> for fflush() to eliminate the need for the ifdef.
> 
> Fair enough.
> 
>>> But reverting the EINVAL check from write_or_die.c is out of question,
>>> because that handles a real case.
> 
> Correction: I can't reproduce the error messages that this was working
> around anymore in a brief test. I'll revert the check locally and see what
> happens.

The error is reproducible with this command on Windows:

$ git rev-list HEAD | sed 1q
42b333d8bb8709dfc5783dd4c44bdb6012c2c17d
fatal: write failure on 'stdout': Invalid argument

Let's do as you suggested.

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] maybe_flush_or_die: move a too-loose Windows specific error
 check to compat

Commit b2f5e268 (Windows: Work around an oddity when a pipe with no reader
is written to) introduced a check for EINVAL after fflush() to fight
spurious "Invalid argument" errors on Windows when a pipe was broken. But
this check may hide real errors on systems that do not have the this odd
behavior. Introduce an fflush wrapper in compat/mingw.* so that the treatment
is only applied on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c | 22 ++++++++++++++++++++++
 compat/mingw.h |  3 +++
 write_or_die.c |  7 +------
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index afc892d..4e63838 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -335,6 +335,28 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 	return freopen(filename, otype, stream);
 }
 
+#undef fflush
+int mingw_fflush(FILE *stream)
+{
+	int ret = fflush(stream);
+
+	/*
+	 * write() is used behind the scenes of stdio output functions.
+	 * Since git code does not check for errors after each stdio write
+	 * operation, it can happen that write() is called by a later
+	 * stdio function even if an earlier write() call failed. In the
+	 * case of a pipe whose readable end was closed, only the first
+	 * call to write() reports EPIPE on Windows. Subsequent write()
+	 * calls report EINVAL. It is impossible to notice whether this
+	 * fflush invocation triggered such a case, therefore, we have to
+	 * catch all EINVAL errors whole-sale.
+	 */
+	if (ret && errno == EINVAL)
+		errno = EPIPE;
+
+	return ret;
+}
+
 /*
  * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
  * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
diff --git a/compat/mingw.h b/compat/mingw.h
index 61a6521..eeb08d1 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -185,6 +185,9 @@ FILE *mingw_fopen (const char *filename, const char *otype);
 FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
 #define freopen mingw_freopen
 
+int mingw_fflush(FILE *stream);
+#define fflush mingw_fflush
+
 char *mingw_getcwd(char *pointer, int len);
 #define getcwd mingw_getcwd
 
diff --git a/write_or_die.c b/write_or_die.c
index d45b536..960f448 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -34,12 +34,7 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 			return;
 	}
 	if (fflush(f)) {
-		/*
-		 * On Windows, EPIPE is returned only by the first write()
-		 * after the reading end has closed its handle; subsequent
-		 * write()s return EINVAL.
-		 */
-		if (errno == EPIPE || errno == EINVAL)
+		if (errno == EPIPE)
 			exit(0);
 		die_errno("write failure on '%s'", desc);
 	}
-- 
1.8.0.rc2.1248.g3f5b13f
