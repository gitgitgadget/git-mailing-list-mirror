From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Fri, 05 Aug 2011 10:48:43 -0700
Message-ID: <7vipqb3g1w.fsf@alter.siamese.dyndns.org>
References: <1312560614-20772-1-git-send-email-pascal@obry.net>
 <1312560614-20772-3-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theo Niessink <theo@taletn.com>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Aug 05 19:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpOVv-0006so-Ah
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 19:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab1HERsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 13:48:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab1HERsq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 13:48:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C75F3470;
	Fri,  5 Aug 2011 13:48:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ztAiFo9413kcsJBIq5sEMb4OHTs=; b=Yk+eWs
	cpN/MDlcWS8vUbYo2VGe3+1uNE/kSdY92VOq5amkRMo0wpXSmdUm+HaMS2Hs5ngB
	+2sA4LJTYKdCOsGNQZoyKlrCxfKTWpc2fUzJl+9dmOzpCIGDQalNtlUq9iTsBF/i
	yI8ong8KW0SaOlghAO8hda2qzb92Fa9AQhGwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I9BV3P9VMLY8BOI/kp/jwu6JVGHT1g+3
	Vnpm89aSumJsgtz8nCoFD8sL7vlW6Ne2o5PDpMXWXhat2RlnrTllriAGYBTzLecg
	mxiCu0rEjeSOJQ9ZymXMK/AOCDqhIPF0RYHTN1zayHyKw96PcIlmiKTluGiHaydJ
	YGxHMRC24bU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63390346F;
	Fri,  5 Aug 2011 13:48:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B594A346E; Fri,  5 Aug 2011
 13:48:44 -0400 (EDT)
In-Reply-To: <1312560614-20772-3-git-send-email-pascal@obry.net> (Pascal
 Obry's message of "Fri, 5 Aug 2011 18:10:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A069328-BF8B-11E0-B4F6-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178809>

Pascal Obry <pascal@obry.net> writes:

> In fact Cygwin supports both, so make Git agree with this.
> The failing case is when a file is committed in a sub-dir of the
> repository using a log message from a file specified with a DOS
> style path-name. To reproduce:
>
>    $ cd src
>    $ git commit -F c:\tmp\log.txt file.c
>    fatal: could not read log file 'src/c:\tmp\log.txt': No such file \
>    or directory.
>
> Signed-off-by: Pascal Obry <pascal@obry.net>
> ---
>  compat/cygwin.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/compat/cygwin.h b/compat/cygwin.h
> index a3229f5..de9737c 100644
> --- a/compat/cygwin.h
> +++ b/compat/cygwin.h
> @@ -7,3 +7,6 @@ extern stat_fn_t cygwin_lstat_fn;
>  
>  #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
>  #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
> +
> +#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
> +#define is_dir_sep(c) ((c) == '/' || (c) == '\\')

I wonder if these two that are the same as mingw should further be
consolidated into one implementation, something like below.

Note that I am just wondering, not suggesting, without knowing which is
better.

 compat/cygwin.h   |    5 ++---
 compat/mingw.h    |    3 +--
 git-compat-util.h |   11 ++++-------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/compat/cygwin.h b/compat/cygwin.h
index de9737c..ef0889b 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -1,12 +1,11 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
+#define DOS_STYLE_DIR_SEP 1
+
 typedef int (*stat_fn_t)(const char*, struct stat*);
 extern stat_fn_t cygwin_stat_fn;
 extern stat_fn_t cygwin_lstat_fn;
 
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
-
-#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
-#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
diff --git a/compat/mingw.h b/compat/mingw.h
index 547568b..26ca0ef 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -298,8 +298,7 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
  * git specific compatibility
  */
 
-#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
-#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
+#define DOS_STYLE_DIR_SEP 1
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 
diff --git a/git-compat-util.h b/git-compat-util.h
index c2c94cd..133f331 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -211,7 +211,9 @@ extern char *gitbasename(char *);
 #define has_dos_drive_prefix(path) 0
 #endif
 
-#if !defined(find_last_dir_sep) && defined(is_dir_sep)
+#if defined(DOS_STYLE_DIR_SEP)
+#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
+#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 static inline char *compat_find_last_dir_sep(const char *path)
 {
 	char *ret = NULL;
@@ -221,13 +223,8 @@ static inline char *compat_find_last_dir_sep(const char *path)
 	return ret;
 }
 #define find_last_dir_sep compat_find_last_dir_sep
-#endif
-
-#ifndef is_dir_sep
+#else
 #define is_dir_sep(c) ((c) == '/')
-#endif
-
-#ifndef find_last_dir_sep
 #define find_last_dir_sep(path) strrchr(path, '/')
 #endif
 
