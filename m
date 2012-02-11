From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 2/3] help.c: make term_columns() cached and export it
Date: Sat, 11 Feb 2012 11:49:24 +0100
Message-ID: <4F3647B4.8090803@in.waw.pl>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com> <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl> <1328891972-23695-3-git-send-email-zbyszek@in.waw.pl> <CACsJy8AjqqEpJr64DJUqVumw1sB2g3pvuz-g4DxhmS-ZbGhY3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 11:50:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwAWn-0000x3-PY
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 11:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab2BKKte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 05:49:34 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52375 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab2BKKtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 05:49:33 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RwAWI-0008Jk-LP; Sat, 11 Feb 2012 11:49:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <CACsJy8AjqqEpJr64DJUqVumw1sB2g3pvuz-g4DxhmS-ZbGhY3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190508>

On 02/11/2012 05:36 AM, Nguyen Thai Ngoc Duy wrote:
> 2012/2/10 Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>:
>> Since term_columns() will usually fail, when a pager is installed,
>> the cache is primed before the pager is installed. If a pager is not
>> installed, then the cache will be set on first use.
>
> Conflict alert. term_columns() is also moved out of help.c in
> nd/columns series on pu, commit cb0850f (Save terminal width before
> setting up pager - 2012-02-04)

Thanks for the heads-up. I think that the two patches should be
merged, especially because there's an error in cb0850f (a variable is
read-only, never written).

Tweaks to cb0850f (Save terminal width before setting up pager -=20
2012-02-04):

[This actually was done on top of today's pu, so it will not apply
  cleanly to cb0850f].

- term_columns() lives in pager.c so it should be declared in
   cache.h like other public functions in pager.c. It has nothing to do
   with columns.h.
- simplify logic to use a static variable instead of two global
   variables (cb0850f actually doesn't work at all because
   spawned_pager wasn't ever set).
- check the cache first, then do getenv(COLUMNS) + atoi, then do
   ioctl(). The behaviour is equivalent to checking COLUMNS first, but
   is slightly more efficient.
- document the function
- remove #include "column.h" added in 88c9754c4097 column: Fix some
   compiler and sparse warnings (Wed Feb 8 2012).

Junio suggested that "a new file, term.c or something, be a lot more
suitable home for the function you will be reusing from diff and other
parts of the system". Nevertheless, I think that adding two files (.c
and .h) to hold one function isn't worth it. It can live in pager.c.
Terminal size is logically connected to paging after all.
---
  cache.h  |    1 +
  column.h |    1 -
  pager.c  |   64 +++++++++++++++++++++++-----------------
  3 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/cache.h b/cache.h
index 6c70dbc..b4422d4 100644
--- a/cache.h
+++ b/cache.h
@@ -1196,6 +1196,7 @@ extern void setup_pager(void);
  extern const char *pager_program;
  extern int pager_in_use(void);
  extern int pager_use_color;
+extern int term_columns(void);

  extern const char *editor_program;
  extern const char *askpass_program;
diff --git a/column.h b/column.h
index b9dec64..142299e 100644
--- a/column.h
+++ b/column.h
@@ -17,7 +17,6 @@ struct column_options {
  	const char *nl;
  };

-extern int term_columns(void);
  extern void print_columns(const struct string_list *list,
  			  unsigned int mode,
  			  struct column_options *opts);
diff --git a/pager.c b/pager.c
index fe203a7..d105761 100644
--- a/pager.c
+++ b/pager.c
@@ -7,21 +7,6 @@
  #define DEFAULT_PAGER "less"
  #endif

-static int spawned_pager;
-static int max_columns;
-
-static int retrieve_terminal_width(void)
-{
-#ifdef TIOCGWINSZ
-	struct winsize ws;
-	if (ioctl(1, TIOCGWINSZ, &ws))  /* e.g., ENOSYS */
-		return 0;
-	return ws.ws_col;
-#else
-	return 0;
-#endif
-}
-
  /*
   * This is split up from the rest of git so that we can do
   * something different on Windows.
@@ -88,16 +73,15 @@ const char *git_pager(int stdout_is_tty)
  void setup_pager(void)
  {
  	const char *pager =3D git_pager(isatty(1));
-	int width;

  	if (!pager || pager_in_use())
  		return;

-	setenv("GIT_PAGER_IN_USE", "true", 1);
+	/* prime the term_columns() cache before it is too
+	 * late and stdout is replaced */
+	(void) term_columns();

-	width =3D retrieve_terminal_width();
-	if (width)
-		max_columns =3D width;
+	setenv("GIT_PAGER_IN_USE", "true", 1);

  	/* spawn the pager */
  	pager_argv[0] =3D pager;
@@ -132,17 +116,43 @@ int pager_in_use(void)
  	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
  }

+/*
+ * Return cached value (if set) or $COLUMNS (if set and positive) or
+ * ioctl(1, TIOCGWINSZ).ws_col (if positive) or 80.
+ *
+ * $COLUMNS even if set, is usually not exported, so
+ * the variable can be used to override autodection.
+ * This behaviour conforms to The Single UNIX Specification, Version 2
+ *=20
(http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html#tag_002_0=
03).
+ */
  int term_columns(void)
  {
-	char *col_string =3D getenv("COLUMNS");
+	static int term_columns_cache;
+
+	char *col_string;
  	int n_cols;

-	if (col_string && (n_cols =3D atoi(col_string)) > 0)
-		return n_cols;
+	if (term_columns_cache)
+		return term_columns_cache;
+
+	col_string =3D getenv("COLUMNS");
+	if (col_string && (n_cols =3D atoi(col_string)) > 0) {
+		term_columns_cache =3D n_cols;
+		return term_columns_cache;
+	}

-	if (spawned_pager && max_columns)
-		return max_columns;
+#ifdef TIOCGWINSZ
+	{
+		struct winsize ws;
+		if (!ioctl(1, TIOCGWINSZ, &ws)) {
+			if (ws.ws_col) {
+				term_columns_cache =3D ws.ws_col;
+				return term_columns_cache;
+			}
+		}
+	}
+#endif

-	n_cols =3D retrieve_terminal_width();
-	return n_cols ? n_cols : 80;
+	term_columns_cache =3D 80;
+	return term_columns_cache;
  }
--=20
1.7.9.310.g883d84c.dirty
