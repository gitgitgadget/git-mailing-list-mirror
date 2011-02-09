From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] Move term_columns() to pager.c and save terminal
 width before pager
Date: Tue, 8 Feb 2011 23:14:56 -0600
Message-ID: <20110209051456.GA28159@elie>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <1297178541-31124-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 06:15:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn2OZ-0000NA-A2
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 06:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822Ab1BIFPG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 00:15:06 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35883 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab1BIFPF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 00:15:05 -0500
Received: by iwn9 with SMTP id 9so6450084iwn.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 21:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MDCj5AjcIaCivclXuAiT/5y9OAF/legzo6fSC4ZyM/k=;
        b=iwmM5pZ3nNjCN13YXETkHQGdN2b8QF12nXgKrUMSkEp+erSoii+SqfiVsTucDBRm9N
         uSSgEVaUIV20HNELXPQVV6bzJbjy+9IHSTsbWFmIrpoaZHYAu3KC9maH4RyJVQIRkNeV
         qUyiJXk6rxSEdrihd+km4bYKqXBmWlLycbC6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vNqdL1nlyrjA0gLN6oBA6GM+8PIYih/2CACWSgycy15MC5LsLeUtJZsonWd7g9WKIJ
         g3cZ98am7Ku0AqQiZJEvNWcQ1U+IgzudwicCYhXKW2vkkJxEL+U4roVDuGCtPbRyJlsi
         7NLyD22Azj0PaXD9buV/KBhxbjdJkI8aBNtOg=
Received: by 10.42.164.201 with SMTP id h9mr21526766icy.203.1297228503931;
        Tue, 08 Feb 2011 21:15:03 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id u9sm408022ibe.20.2011.02.08.21.14.59
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 21:15:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297178541-31124-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166391>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> term_columns() checks for terminal width via ioctl(1).

ioctl(2). :)

I like the idea of checking width before launching a pager
and exporting it, yes.

> --- a/cache.h
> +++ b/cache.h
> @@ -1045,6 +1045,7 @@ extern void setup_pager(void);
>  extern const char *pager_program;
>  extern int pager_in_use(void);
>  extern int pager_use_color;
> +extern int term_columns();

Should say (void) rather than leaving the parameter list unspecified,
no?

It will only be needed by a few translation units, I hope.  Putting
it in column.h can avoid some pointless recompilation.

[...]
> +++ b/pager.c
> @@ -12,6 +12,7 @@
>   */
> =20
>  static int spawned_pager;
> +static int max_columns;

Could be stored in the COLUMNS environment variable, but an integer
variable like this is is simpler.

[...]
> @@ -80,6 +81,15 @@ void setup_pager(void)
> =20
>  	spawned_pager =3D 1; /* means we are emitting to terminal */
> =20
> +#ifdef TIOCGWINSZ
> +	{
> +		struct winsize ws;
> +		if (!ioctl(1, TIOCGWINSZ, &ws)) {
> +			if (ws.ws_col)
> +				max_columns =3D ws.ws_col;
> +		}
> +	}
> +#endif

Mm, repeated code.

How about something like this on top?  Not sure if the
"if (ws.ws_col)" is useful.  I've left it alone.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    1 +
 cache.h  |    1 -
 column.h |    6 ++++++
 help.c   |    1 +
 pager.c  |   48 ++++++++++++++++++++++++++----------------------
 5 files changed, 34 insertions(+), 23 deletions(-)
 create mode 100644 column.h

diff --git a/Makefile b/Makefile
index 775ee83..ed9e94b 100644
--- a/Makefile
+++ b/Makefile
@@ -1956,6 +1956,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
+pager.o help.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/cache.h b/cache.h
index bcbd5f2..d83d68c 100644
--- a/cache.h
+++ b/cache.h
@@ -1045,7 +1045,6 @@ extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
-extern int term_columns();
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/column.h b/column.h
new file mode 100644
index 0000000..55d8067
--- /dev/null
+++ b/column.h
@@ -0,0 +1,6 @@
+#ifndef COLUMN_H
+#define COLUMN_H
+
+extern int term_columns(void);
+
+#endif
diff --git a/help.c b/help.c
index 1344208..62a479b 100644
--- a/help.c
+++ b/help.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "column.h"
 #include "levenshtein.h"
 #include "help.h"
 #include "common-cmds.h"
diff --git a/pager.c b/pager.c
index ad447cf..e6f7d86 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "column.h"
=20
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
@@ -14,6 +15,21 @@
 static int spawned_pager;
 static int max_columns;
=20
+#ifdef TIOCGWINSZ
+static int retrieve_terminal_width(void)
+{
+	struct winsize ws;
+	if (ioctl(1, TIOCGWINSZ, &ws))	/* e.g., ENOSYS */
+		return 0;
+	return ws.ws_col;
+}
+#else
+static int retrieve_terminal_width(void)
+{
+	return 0;
+}
+#endif
+
 #ifndef WIN32
 static void pager_preexec(void)
 {
@@ -75,21 +91,17 @@ const char *git_pager(int stdout_is_tty)
 void setup_pager(void)
 {
 	const char *pager =3D git_pager(isatty(1));
+	int width;
=20
 	if (!pager)
 		return;
=20
 	spawned_pager =3D 1; /* means we are emitting to terminal */
=20
-#ifdef TIOCGWINSZ
-	{
-		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws)) {
-			if (ws.ws_col)
-				max_columns =3D ws.ws_col;
-		}
-	}
-#endif
+	width =3D retrieve_terminal_width();
+	if (width)
+		max_columns =3D width;
+
 	/* spawn the pager */
 	pager_argv[0] =3D pager;
 	pager_process.use_shell =3D 1;
@@ -127,24 +139,16 @@ int pager_in_use(void)
 	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
 }
=20
-int term_columns()
+int term_columns(void)
 {
 	char *col_string =3D getenv("COLUMNS");
 	int n_cols;
=20
 	if (col_string && (n_cols =3D atoi(col_string)) > 0)
 		return n_cols;
-
-	else if (spawned_pager && max_columns)
+	if (spawned_pager && max_columns)
 		return max_columns;
-#ifdef TIOCGWINSZ
-	else {
-		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws)) {
-			if (ws.ws_col)
-				return ws.ws_col;
-		}
-	}
-#endif
-	return 80;
+
+	n_cols =3D retrieve_terminal_width();
+	return n_cols ? n_cols : 80;
 }
--=20
1.7.4
