From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/5] msvc: test-svn-fe: Fix linker "unresolved external" error
Date: Thu, 31 Jan 2013 18:32:55 +0000
Message-ID: <510AB8D7.5000706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:39:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0z2a-0007Mm-1p
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387Ab3AaSik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:38:40 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:48881 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756300Ab3AaSif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:38:35 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id D0DFD18C712;
	Thu, 31 Jan 2013 18:38:34 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id E71F618C710;	Thu, 31 Jan 2013 18:38:33 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Thu, 31 Jan 2013 18:38:32 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215147>

In particular, while linking test-svn-fe.exe, the linker complains
that the external symbol _strtoull is unresolved. A call to this
function was added in commit ddcc8c5b ("vcs-svn: skeleton of an svn
delta parser", 25-12-2010).

The NO_STRTOULL build variable attempts to provide support to old
systems which can't even declare 'unsigned long long' variables,
let alone provide the strtoll() or strtoull() functions. Setting
this build variable does not provide an implementation of these
functions. Rather, it simply allows the compat implementations
of strto{i,u}max() to use strtol() and strtoul() instead.

In order to fix the linker error on systems with NO_STRTOULL set,
currently MSVC and OSF1, we can substitute a call to strtoumax().

However, we can easily provide support for the strtoull() and
strtoll() functions on MSVC, since they are essentially already
available as _strtoui64() and _strtoi64(). This allows us to
remove NO_STRTOULL for MSVC.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/msvc.h    | 2 ++
 config.mak.uname | 1 -
 test-svn-fe.c    | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/msvc.h b/compat/msvc.h
index aa4b563..96b6d60 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -12,6 +12,8 @@
 #define __attribute__(x)
 #define strncasecmp  _strnicmp
 #define ftruncate    _chsize
+#define strtoull     _strtoui64
+#define strtoll      _strtoi64
 
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
diff --git a/config.mak.uname b/config.mak.uname
index 7e52f3c..bfb8a39 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -327,7 +327,6 @@ ifeq ($(uname_S),Windows)
 	# NEEDS_LIBICONV = YesPlease
 	NO_ICONV = YesPlease
 	NO_STRTOUMAX = YesPlease
-	NO_STRTOULL = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 0f2d9a4..120ec96 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -24,7 +24,7 @@ static int apply_delta(int argc, char *argv[])
 		die_errno("cannot open preimage");
 	if (buffer_init(&delta, argv[3]))
 		die_errno("cannot open delta");
-	if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
+	if (svndiff0_apply(&delta, (off_t) strtoumax(argv[4], NULL, 0),
 					&preimage_view, stdout))
 		return 1;
 	if (buffer_deinit(&preimage))
-- 
1.8.1
