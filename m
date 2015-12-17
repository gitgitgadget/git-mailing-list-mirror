From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2] submodule: Port resolve_relative_url from shell to C
Date: Thu, 17 Dec 2015 19:55:43 +0100
Message-ID: <5673052F.7050000@kdbg.org>
References: <1450311999-3992-1-git-send-email-sbeller@google.com>
 <1450311999-3992-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, jens.lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 19:55:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9diS-0000eI-6t
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 19:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbbLQSzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 13:55:48 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:29727 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbLQSzr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 13:55:47 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pM2b51tQqz5tlJ;
	Thu, 17 Dec 2015 19:55:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 244AB53B0;
	Thu, 17 Dec 2015 19:55:44 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <1450311999-3992-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282666>

Am 17.12.2015 um 01:26 schrieb Stefan Beller:
> This reimplements the helper function `resolve_relative_url` in shell
> in C. This functionality is needed in C for introducing the groups
> feature later on. When using groups, the user should not need to run
> `git submodule init`, but it should be implicit at all appropriate places,
> which are all in C code. As the we would not just call out to `git
> submodule init`, but do a more fine grained structure there, we actually
> need all the init functionality in C before attempting the groups
> feature. To get the init functionality in C, rewriting the
> resolve_relative_url subfunction is a major step.
>
> This also improves the performance:
> (Best out of 3) time ./t7400-submodule-basic.sh
> Before:
> real	0m9.575s
> user	0m2.683s
> sys	0m6.773s
> After:
> real	0m9.293s
> user	0m2.691s
> sys	0m6.549s
>
> That's about 3%.

I appreciate this effort as it should help us on Windows. Although the
numbers (and my own timings) suggest that this is only a small step
forward. That's not surprising as the patch removes only two forks.

As to the implementation, find a patch below that removes the ifdefs
and a few other suggestions. It is a mechanical conversion without
understanding what relative_url() does. I have the gut feeling that the
two strbuf_addf towards the end of the function can be contracted and
the temporarily allocate copy in 'out' can be removed.

If there were a few examples in the comment above the function, it
would be much simpler to understand.

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b925bed..8ec0975 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "remote.h"
 #include "refs.h"
+#include "connect.h"
 
 static const char *get_default_remote(void)
 {
@@ -31,34 +32,23 @@ static const char *get_default_remote(void)
 		return xstrdup(dest);
 }
 
-static int has_same_dir_prefix(const char *str, const char **out)
+static int starts_with_dot_slash(const char *str)
 {
-#ifdef GIT_WINDOWS_NATIVE
-	return skip_prefix(str, "./", out)
-		|| skip_prefix(str, ".\\", out);
-#else
-	return skip_prefix(str, "./", out);
-#endif
+	return str[0] == '.' && is_dir_sep(str[1]);
 }
 
-static int has_upper_dir_prefix(const char *str, const char **out)
+static int starts_with_dot_dot_slash(const char *str)
 {
-#ifdef GIT_WINDOWS_NATIVE
-	return skip_prefix(str, "../", out)
-		|| skip_prefix(str, "..\\", out);
-#else
-	return skip_prefix(str, "../", out);
-#endif
+	return str[0] == '.' && str[1] == '.' && is_dir_sep(str[2]);
 }
 
-static char *last_dir_separator(const char *str)
+static char *last_dir_separator(char *str)
 {
-#ifdef GIT_WINDOWS_NATIVE
-	return strrchr(str, "/")
-		|| strrchr(str, "\\");
-#else
-	return strrchr(str, '/');
-#endif
+	char* p = str + strlen(str);
+	while (p-- != str)
+		if (is_dir_sep(*p))
+			return p;
+	return NULL;
 }
 
 /*
@@ -85,9 +75,10 @@ static const char *relative_url(const char *url, const char *up_path)
 	size_t len;
 	char *remoteurl = NULL;
 	char *sep = "/";
-	const char *out;
+	char *out;
 	struct strbuf sb = STRBUF_INIT;
 	const char *remote = get_default_remote();
+
 	strbuf_addf(&sb, "remote.%s.url", remote);
 
 	if (git_config_get_string(sb.buf, &remoteurl))
@@ -98,22 +89,23 @@ static const char *relative_url(const char *url, const char *up_path)
 	if (is_dir_sep(remoteurl[len]))
 		remoteurl[len] = '\0';
 
-	if (strchr(remoteurl, ':') || is_dir_sep(*remoteurl))
+	if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
 		is_relative = 0;
-	else if (has_same_dir_prefix(remoteurl, &out) ||
-		    has_upper_dir_prefix(remoteurl, &out))
+	else if (starts_with_dot_slash(remoteurl) ||
+		    starts_with_dot_dot_slash(remoteurl))
 		is_relative = 1;
 	else {
 		is_relative = 1;
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "./%s", remoteurl);
+		free(remoteurl);
 		remoteurl = strbuf_detach(&sb, NULL);
 	}
 
 	while (url) {
-		if (has_upper_dir_prefix(url, &out)) {
+		if (starts_with_dot_dot_slash(url)) {
 			char *rfind;
-			url = out;
+			url += 3;
 
 			rfind = last_dir_separator(remoteurl);
 			if (rfind)
@@ -130,22 +122,23 @@ static const char *relative_url(const char *url, const char *up_path)
 						remoteurl = ".";
 				}
 			}
-		} else if (has_same_dir_prefix(url, &out))
-			url = out;
-		else
+		} else if (starts_with_dot_slash(url)) {
+			url += 2;
+		} else
 			break;
 	}
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s%s", remoteurl, sep, url);
 
-	if (!has_same_dir_prefix(sb.buf, &out))
-		out = sb.buf;
-	out = xstrdup(out);
+	if (starts_with_dot_slash(sb.buf))
+		out = strdup(sb.buf + 2);
+	else
+		out = xstrdup(sb.buf);
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s%s", is_relative && up_path ? up_path : "", out);
 
-	free((char*)out);
+	free(out);
 	return strbuf_detach(&sb, NULL);
 }
 
