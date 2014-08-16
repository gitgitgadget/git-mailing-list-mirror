From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v3 03/10] setup: convert setup_git_directory_gently_1
 et al. to strbuf
Date: Sat, 16 Aug 2014 23:48:33 +0200
Message-ID: <53EFD1B1.4000909@web.de>
References: <53D694A2.8030007@web.de> <53D695E0.2050209@web.de> <53EFBB8D.20600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 23:49:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIlr7-0001I9-FD
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 23:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaHPVth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 17:49:37 -0400
Received: from mout.web.de ([212.227.17.12]:50707 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbaHPVtg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 17:49:36 -0400
Received: from [192.168.178.27] ([79.253.189.61]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M5x3d-1WTgMF3Fyj-00xu3h; Sat, 16 Aug 2014 23:49:14
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53EFBB8D.20600@web.de>
X-Provags-ID: V03:K0:alJ1/C+Flywid1ss8RuUxBwXLjNRrIPlbLQGRTLalt/61AD02YV
 99uDf6g0dEvZQFTt6Z6QvF+PWuZF8fwkDV4g6STgX+nz2ZHyRYFIPN1GE9v0pA0nZKkQJ7z
 mwHzpJMncLjmxlff9HhFZ/DZVmwNS5/x91TrxsUEhVxtuGutnu9TSdQcV0ar8VhuYYyMgxs
 17AB2t7FuwR9vzrNRygTQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255343>

> Is there a chance to squueze this in:
> 
> 
> $ git diff
> diff --git a/setup.c b/setup.c
> index 526cdf6..fb61860 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -734,7 +734,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
>                  string_list_clear(&ceiling_dirs, 0);
>          }
> 
> -       if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
> +       if (ceil_offset < 0 && has_dos_drive_prefix(cwd.buf))
>                  ceil_offset = 1;
> 
> 

Ouch, thanks for catching this.

Perhaps the following patch should go in as well.

-- >8 --
Subject: [PATCH] turn path macros into inline function

Use static inline functions instead of macros for has_dos_drive_prefix,
offset_1st_component, is_dir_sep and find_last_dir_sep in order to let
the compiler do type checking.

The definitions of offset_1st_component and is_dir_sep are switched
around because the former uses the latter.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..0b6c13a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -264,19 +264,35 @@ extern char *gitbasename(char *);
 #endif
 
 #ifndef has_dos_drive_prefix
-#define has_dos_drive_prefix(path) 0
+static inline int git_has_dos_drive_prefix(const char *path)
+{
+	return 0;
+}
+#define has_dos_drive_prefix git_has_dos_drive_prefix
 #endif
 
-#ifndef offset_1st_component
-#define offset_1st_component(path) (is_dir_sep((path)[0]))
+#ifndef is_dir_sep
+static inline int git_is_dir_sep(int c)
+{
+	return c == '/';
+}
+#define is_dir_sep git_is_dir_sep
 #endif
 
-#ifndef is_dir_sep
-#define is_dir_sep(c) ((c) == '/')
+#ifndef offset_1st_component
+static inline int git_offset_1st_component(const char *path)
+{
+	return is_dir_sep(path[0]);
+}
+#define offset_1st_component git_offset_1st_component
 #endif
 
 #ifndef find_last_dir_sep
-#define find_last_dir_sep(path) strrchr(path, '/')
+static inline char *git_find_last_dir_sep(const char *path)
+{
+	return strrchr(path, '/');
+}
+#define find_last_dir_sep git_find_last_dir_sep
 #endif
 
 #if defined(__HP_cc) && (__HP_cc >= 61000)
-- 
2.1.0
