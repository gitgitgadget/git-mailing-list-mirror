From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 1/4] Refactor skipping DOS drive prefixes
Date: Fri, 22 Jan 2016 19:50:02 +0100
Message-ID: <56A279DA.8080809@kdbg.org>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:50:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMgmh-0001wS-ST
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 19:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbcAVSuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 13:50:08 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:9982 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbcAVSuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 13:50:06 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pn8lv2Tlpz5tlC;
	Fri, 22 Jan 2016 19:50:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id AB27151EA;
	Fri, 22 Jan 2016 19:50:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284580>

Am 12.01.2016 um 08:57 schrieb Johannes Schindelin:
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 57ca477..b3e5044 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -361,7 +361,15 @@ HANDLE winansi_get_osfhandle(int fd);
>    * git specific compatibility
>    */
>   
> -#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
> +#define has_dos_drive_prefix(path) \
> +	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
> +static inline int mingw_skip_dos_drive_prefix(char **path)
> +{
> +	int ret = has_dos_drive_prefix(*path);
> +	*path += ret;
> +	return ret;
> +}
> +#define skip_dos_drive_prefix mingw_skip_dos_drive_prefix

This triggers

    CC alloc.o
In file included from git-compat-util.h:186,
                 from cache.h:4,
                 from alloc.c:12:
compat/mingw.h: In function 'mingw_skip_dos_drive_prefix':
compat/mingw.h:365: warning: implicit declaration of function 'isalpha'

when I build under the old MSYS environment. While I would understand
that the old MSYS environment is end-of-lifed and not worth your time
catering to, the error is still an indication of a problem.

Notice that mingw.h is #included in line 186 of git-compat-util.h,
isalpha is only (re-)defined much later in line 790. That would explain
the warning. What I do not understand is that you do not observe the
same warning in your MSYS2/MINGWxx environment. It would mean that
<ctype.h> is included somewhere.

At any rate, the resulting binary sometimes uses an isalpha
implementation other than the one provided in git-compat-util.h. The
result is most likely correct, but it is certainly not the intent,
is it?

I did not attempt to build with MSVC, but it is not unlikely that it
shows the same error.

I suggest to move the function definition out of line:

diff --git a/compat/mingw.c b/compat/mingw.c
index 10a51c0..0cebb61 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1915,6 +1915,13 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	return -1;
 }
 
+int mingw_skip_dos_drive_prefix(char **path)
+{
+	int ret = has_dos_drive_prefix(*path);
+	*path += ret;
+	return ret;
+}
+
 int mingw_offset_1st_component(const char *path)
 {
 	char *pos = (char *)path;
diff --git a/compat/mingw.h b/compat/mingw.h
index 9b5db4e..2099b79 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -360,12 +360,7 @@ HANDLE winansi_get_osfhandle(int fd);
 
 #define has_dos_drive_prefix(path) \
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
-static inline int mingw_skip_dos_drive_prefix(char **path)
-{
-	int ret = has_dos_drive_prefix(*path);
-	*path += ret;
-	return ret;
-}
+int mingw_skip_dos_drive_prefix(char **path);
 #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 static inline char *mingw_find_last_dir_sep(const char *path)
