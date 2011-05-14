From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 1/4] git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
Date: Sat, 14 May 2011 13:47:42 +0000
Message-ID: <1305380865-21339-2-git-send-email-avarab@gmail.com>
References: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 15:48:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLFCT-0007GJ-Eo
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 15:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651Ab1ENNsA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 09:48:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58119 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1ENNr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 09:47:57 -0400
Received: by eyx24 with SMTP id 24so916697eyx.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=xpKRNbA+dPfKBxqzZAxfQ2DrWEM8CH1EUICJs5/HOTE=;
        b=pScxYHaIJ9NjVLFZK9v19FRCZdMSjAZZAuLPfLZiNCvk2hlPs5FOIqpbX9JeMDKrpo
         LqTsndqasKNg2YdFXmDv7ChRP4+VNWO+wAjNxQVqM7yGE03ReKRalw22E+x/hEmR0P6O
         aWsOgZkTMInUR3LA2EDhht7mgMa4XTkVIROqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vjB2bQfWOuehzy9Y3tYFB9Tog8hKcwF6A/ZPOMHa8xU+rkM7vPeaS6e47Ss92Ycdne
         YpNl3OFzi0jRLMkqCDLUapvw9QS0qvwrkVf75qE4jT6ajabvZSqKnuJfn6u7DWtC+apm
         riO0cbEPy2pRlHtyzaOXsvOGj3JI4T+4giIDA=
Received: by 10.14.21.133 with SMTP id r5mr1009565eer.249.1305380875327;
        Sat, 14 May 2011 06:47:55 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y9sm2110298eeh.8.2011.05.14.06.47.54
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 06:47:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173585>

Add a git-sh-i18n--envsubst program which is a stripped-down version
of the GNU envsubst(1) program that comes with GNU gettext for use in
the eval_gettext() fallback.

We need a C helper program because implementing eval_gettext() purely
in shell turned out to be unworkable. Digging through the Git mailing
list archives will reveal two shell implementations of eval_gettext
that are almost good enough, but fail on an edge case which is tested
for in the tests which are part of this patch.

These are the modifications I made to envsubst.c as I turned it into
sh-i18n--envsubst.c:

 * Added our git-compat-util.h header for xrealloc() and friends.

 * Removed inclusion of gettext-specific headers.

 * Removed most of main() and replaced it with my own. The modified
   version only does option parsing for --variables. That's all it
   needs.

 * Modified error() invocations to use our error() instead of
   error(3).

 * Replaced the gettext XNMALLOC(n, size) macro with just
   xmalloc(n). Since XNMALLOC() only allocated char's.

 * Removed the string_list_destroy function. It's redundant (also in
   the upstream code).

 * Replaced the use of stdbool.h (a C99 header) by doing the following
   replacements on the code:

    * s/bool/unsigned short int/g
    * s/true/1/g
    * s/false/0/g

Reported-by: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore                              |    2 +
 Documentation/git-sh-i18n--envsubst.txt |   26 ++
 Makefile                                |    1 +
 sh-i18n--envsubst.c                     |  444 +++++++++++++++++++++++=
++++++++
 t/t0201-gettext-fallbacks.sh            |   51 ++++
 5 files changed, 524 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sh-i18n--envsubst.txt
 create mode 100644 sh-i18n--envsubst.c
 create mode 100755 t/t0201-gettext-fallbacks.sh

diff --git a/.gitignore b/.gitignore
index 711fce7..1ccf797 100644
--- a/.gitignore
+++ b/.gitignore
@@ -127,6 +127,8 @@
 /git-rm
 /git-send-email
 /git-send-pack
+/git-sh-i18n
+/git-sh-i18n--envsubst
 /git-sh-setup
 /git-shell
 /git-shortlog
diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/gi=
t-sh-i18n--envsubst.txt
new file mode 100644
index 0000000..f5bbf77
--- /dev/null
+++ b/Documentation/git-sh-i18n--envsubst.txt
@@ -0,0 +1,26 @@
+git-sh-i18n--envsubst(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-sh-i18n--envsubst - Git's own envsubst(1) for i18n fallbacks
+
+DESCRIPTION
+-----------
+
+This is not a command the end user would want to run.  Ever.
+This documentation is meant for people who are studying the
+plumbing scripts and/or are writing new ones.
+
+git-sh-i18n--envsubst is Git's stripped-down copy of the GNU
+`envsubst(1)` program that comes with the GNU gettext package. It's
+used internally by linkgit:git-sh-i18n[1] to interpolate the variables
+passed to the the `eval_gettext` function.
+
+No promises are made about the interface, or that this
+program won't disappear without warning in the next version
+of Git. Don't use it.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 320ccc7..56944c6 100644
--- a/Makefile
+++ b/Makefile
@@ -414,6 +414,7 @@ PROGRAM_OBJS +=3D shell.o
 PROGRAM_OBJS +=3D show-index.o
 PROGRAM_OBJS +=3D upload-pack.o
 PROGRAM_OBJS +=3D http-backend.o
+PROGRAM_OBJS +=3D sh-i18n--envsubst.o
=20
 PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
=20
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
new file mode 100644
index 0000000..8db71b1
--- /dev/null
+++ b/sh-i18n--envsubst.c
@@ -0,0 +1,444 @@
+/*
+ * sh-i18n--envsubst.c - a stripped-down version of gettext's envsubst=
(1)
+ *
+ * Copyright (C) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+ *
+ * This is a modified version of
+ * 67d0871a8c:gettext-runtime/src/envsubst.c from the gettext.git
+ * repository. It has been stripped down to only implement the
+ * envsubst(1) features that we need in the git-sh-i18n fallbacks.
+ *
+ * The "Close standard error" part in main() is from
+ * 8dac033df0:gnulib-local/lib/closeout.c. The copyright notices for
+ * both files are reproduced immediately below.
+ */
+
+#include "git-compat-util.h"
+
+/* Substitution of environment variables in shell format strings.
+   Copyright (C) 2003-2007 Free Software Foundation, Inc.
+   Written by Bruno Haible <bruno@clisp.org>, 2003.
+
+   This program is free software; you can redistribute it and/or modif=
y
+   it under the terms of the GNU General Public License as published b=
y
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundat=
ion,
+   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. =
 */
+
+/* closeout.c - close standard output and standard error
+   Copyright (C) 1998-2007 Free Software Foundation, Inc.
+
+   This program is free software; you can redistribute it and/or modif=
y
+   it under the terms of the GNU General Public License as published b=
y
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software Foundat=
ion,
+   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA. =
 */
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+/* If true, substitution shall be performed on all variables.  */
+static unsigned short int all_variables;
+
+/* Forward declaration of local functions.  */
+static void print_variables (const char *string);
+static void note_variables (const char *string);
+static void subst_from_stdin (void);
+
+int
+main (int argc, char *argv[])
+{
+  /* Default values for command line options.  */
+  unsigned short int show_variables =3D 0;
+
+  switch (argc)
+	{
+	case 1:
+	  error ("we won't substitute all variables on stdin for you");
+	  /*
+	  all_variables =3D 1;
+      subst_from_stdin ();
+	  */
+	case 2:
+	  /* echo '$foo and $bar' | git sh-i18n--envsubst --variables '$foo a=
nd $bar' */
+	  all_variables =3D 0;
+	  note_variables (argv[1]);
+      subst_from_stdin ();
+	  break;
+	case 3:
+	  /* git sh-i18n--envsubst --variables '$foo and $bar' */
+	  if (strcmp(argv[1], "--variables"))
+		error ("first argument must be --variables when two are given");
+	  show_variables =3D 1;
+      print_variables (argv[2]);
+	  break;
+	default:
+	  error ("too many arguments");
+	  break;
+	}
+
+  /* Close standard error.  This is simpler than fwriteerror_no_ebadf,=
 because
+     upon failure we don't need an errno - all we can do at this point=
 is to
+     set an exit status.  */
+  errno =3D 0;
+  if (ferror (stderr) || fflush (stderr))
+    {=20
+      fclose (stderr);
+      exit (EXIT_FAILURE);
+    }
+  if (fclose (stderr) && errno !=3D EBADF)
+    exit (EXIT_FAILURE);
+
+  exit (EXIT_SUCCESS);
+}
+
+/* Parse the string and invoke the callback each time a $VARIABLE or
+   ${VARIABLE} construct is seen, where VARIABLE is a nonempty sequenc=
e
+   of ASCII alphanumeric/underscore characters, starting with an ASCII
+   alphabetic/underscore character.
+   We allow only ASCII characters, to avoid dependencies w.r.t. the cu=
rrent
+   encoding: While "${\xe0}" looks like a variable access in ISO-8859-=
1
+   encoding, it doesn't look like one in the BIG5, BIG5-HKSCS, GBK, GB=
18030,
+   SHIFT_JIS, JOHAB encodings, because \xe0\x7d is a single character =
in these
+   encodings.  */
+static void
+find_variables (const char *string,
+		void (*callback) (const char *var_ptr, size_t var_len))
+{
+  for (; *string !=3D '\0';)
+    if (*string++ =3D=3D '$')
+      {
+	const char *variable_start;
+	const char *variable_end;
+	unsigned short int valid;
+	char c;
+
+	if (*string =3D=3D '{')
+	  string++;
+
+	variable_start =3D string;
+	c =3D *string;
+	if ((c >=3D 'A' && c <=3D 'Z') || (c >=3D 'a' && c <=3D 'z') || c =3D=
=3D '_')
+	  {
+	    do
+	      c =3D *++string;
+	    while ((c >=3D 'A' && c <=3D 'Z') || (c >=3D 'a' && c <=3D 'z')
+		   || (c >=3D '0' && c <=3D '9') || c =3D=3D '_');
+	    variable_end =3D string;
+
+	    if (variable_start[-1] =3D=3D '{')
+	      {
+		if (*string =3D=3D '}')
+		  {
+		    string++;
+		    valid =3D 1;
+		  }
+		else
+		  valid =3D 0;
+	      }
+	    else
+	      valid =3D 1;
+
+	    if (valid)
+	      callback (variable_start, variable_end - variable_start);
+	  }
+      }
+}
+
+
+/* Print a variable to stdout, followed by a newline.  */
+static void
+print_variable (const char *var_ptr, size_t var_len)
+{
+  fwrite (var_ptr, var_len, 1, stdout);
+  putchar ('\n');
+}
+
+/* Print the variables contained in STRING to stdout, each one followe=
d by a
+   newline.  */
+static void
+print_variables (const char *string)
+{
+  find_variables (string, &print_variable);
+}
+
+
+/* Type describing list of immutable strings,
+   implemented using a dynamic array.  */
+typedef struct string_list_ty string_list_ty;
+struct string_list_ty
+{
+  const char **item;
+  size_t nitems;
+  size_t nitems_max;
+};
+
+/* Initialize an empty list of strings.  */
+static inline void
+string_list_init (string_list_ty *slp)
+{
+  slp->item =3D NULL;
+  slp->nitems =3D 0;
+  slp->nitems_max =3D 0;
+}
+
+/* Append a single string to the end of a list of strings.  */
+static inline void
+string_list_append (string_list_ty *slp, const char *s)
+{
+  /* Grow the list.  */
+  if (slp->nitems >=3D slp->nitems_max)
+    {
+      size_t nbytes;
+
+      slp->nitems_max =3D slp->nitems_max * 2 + 4;
+      nbytes =3D slp->nitems_max * sizeof (slp->item[0]);
+      slp->item =3D (const char **) xrealloc (slp->item, nbytes);
+    }
+
+  /* Add the string to the end of the list.  */
+  slp->item[slp->nitems++] =3D s;
+}
+
+/* Compare two strings given by reference.  */
+static int
+cmp_string (const void *pstr1, const void *pstr2)
+{
+  const char *str1 =3D *(const char **)pstr1;
+  const char *str2 =3D *(const char **)pstr2;
+
+  return strcmp (str1, str2);
+}
+
+/* Sort a list of strings.  */
+static inline void
+string_list_sort (string_list_ty *slp)
+{
+  if (slp->nitems > 0)
+    qsort (slp->item, slp->nitems, sizeof (slp->item[0]), cmp_string);
+}
+
+/* Test whether a string list contains a given string.  */
+static inline int
+string_list_member (const string_list_ty *slp, const char *s)
+{
+  size_t j;
+
+  for (j =3D 0; j < slp->nitems; ++j)
+    if (strcmp (slp->item[j], s) =3D=3D 0)
+      return 1;
+  return 0;
+}
+
+/* Test whether a sorted string list contains a given string.  */
+static int
+sorted_string_list_member (const string_list_ty *slp, const char *s)
+{
+  size_t j1, j2;
+
+  j1 =3D 0;
+  j2 =3D slp->nitems;
+  if (j2 > 0)
+    {
+      /* Binary search.  */
+      while (j2 - j1 > 1)
+	{
+	  /* Here we know that if s is in the list, it is at an index j
+	     with j1 <=3D j < j2.  */
+	  size_t j =3D (j1 + j2) >> 1;
+	  int result =3D strcmp (slp->item[j], s);
+
+	  if (result > 0)
+	    j2 =3D j;
+	  else if (result =3D=3D 0)
+	    return 1;
+	  else
+	    j1 =3D j + 1;
+	}
+      if (j2 > j1)
+	if (strcmp (slp->item[j1], s) =3D=3D 0)
+	  return 1;
+    }
+  return 0;
+}
+
+
+/* Set of variables on which to perform substitution.
+   Used only if !all_variables.  */
+static string_list_ty variables_set;
+
+/* Adds a variable to variables_set.  */
+static void
+note_variable (const char *var_ptr, size_t var_len)
+{
+  char *string =3D xmalloc (var_len + 1);
+  memcpy (string, var_ptr, var_len);
+  string[var_len] =3D '\0';
+
+  string_list_append (&variables_set, string);
+}
+
+/* Stores the variables occurring in the string in variables_set.  */
+static void
+note_variables (const char *string)
+{
+  string_list_init (&variables_set);
+  find_variables (string, &note_variable);
+  string_list_sort (&variables_set);
+}
+
+
+static int
+do_getc ()
+{
+  int c =3D getc (stdin);
+
+  if (c =3D=3D EOF)
+    {
+      if (ferror (stdin))
+	error ("error while reading standard input");
+    }
+
+  return c;
+}
+
+static inline void
+do_ungetc (int c)
+{
+  if (c !=3D EOF)
+    ungetc (c, stdin);
+}
+
+/* Copies stdin to stdout, performing substitutions.  */
+static void
+subst_from_stdin ()
+{
+  static char *buffer;
+  static size_t bufmax;
+  static size_t buflen;
+  int c;
+
+  for (;;)
+    {
+      c =3D do_getc ();
+      if (c =3D=3D EOF)
+	break;
+      /* Look for $VARIABLE or ${VARIABLE}.  */
+      if (c =3D=3D '$')
+	{
+	  unsigned short int opening_brace =3D 0;
+	  unsigned short int closing_brace =3D 0;
+
+	  c =3D do_getc ();
+	  if (c =3D=3D '{')
+	    {
+	      opening_brace =3D 1;
+	      c =3D do_getc ();
+	    }
+	  if ((c >=3D 'A' && c <=3D 'Z') || (c >=3D 'a' && c <=3D 'z') || c =3D=
=3D '_')
+	    {
+	      unsigned short int valid;
+
+	      /* Accumulate the VARIABLE in buffer.  */
+	      buflen =3D 0;
+	      do
+		{
+		  if (buflen >=3D bufmax)
+		    {
+		      bufmax =3D 2 * bufmax + 10;
+		      buffer =3D xrealloc (buffer, bufmax);
+		    }
+		  buffer[buflen++] =3D c;
+
+		  c =3D do_getc ();
+		}
+	      while ((c >=3D 'A' && c <=3D 'Z') || (c >=3D 'a' && c <=3D 'z')
+		     || (c >=3D '0' && c <=3D '9') || c =3D=3D '_');
+
+	      if (opening_brace)
+		{
+		  if (c =3D=3D '}')
+		    {
+		      closing_brace =3D 1;
+		      valid =3D 1;
+		    }
+		  else
+		    {
+		      valid =3D 0;
+		      do_ungetc (c);
+		    }
+		}
+	      else
+		{
+		  valid =3D 1;
+		  do_ungetc (c);
+		}
+
+	      if (valid)
+		{
+		  /* Terminate the variable in the buffer.  */
+		  if (buflen >=3D bufmax)
+		    {
+		      bufmax =3D 2 * bufmax + 10;
+		      buffer =3D xrealloc (buffer, bufmax);
+		    }
+		  buffer[buflen] =3D '\0';
+
+		  /* Test whether the variable shall be substituted.  */
+		  if (!all_variables
+		      && !sorted_string_list_member (&variables_set, buffer))
+		    valid =3D 0;
+		}
+
+	      if (valid)
+		{
+		  /* Substitute the variable's value from the environment.  */
+		  const char *env_value =3D getenv (buffer);
+
+		  if (env_value !=3D NULL)
+		    fputs (env_value, stdout);
+		}
+	      else
+		{
+		  /* Perform no substitution at all.  Since the buffered input
+		     contains no other '$' than at the start, we can just
+		     output all the buffered contents.  */
+		  putchar ('$');
+		  if (opening_brace)
+		    putchar ('{');
+		  fwrite (buffer, buflen, 1, stdout);
+		  if (closing_brace)
+		    putchar ('}');
+		}
+	    }
+	  else
+	    {
+	      do_ungetc (c);
+	      putchar ('$');
+	      if (opening_brace)
+		putchar ('{');
+	    }
+	}
+      else
+	putchar (c);
+    }
+}
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.s=
h
new file mode 100755
index 0000000..54d98b9
--- /dev/null
+++ b/t/t0201-gettext-fallbacks.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D'Gettext Shell fallbacks'
+
+. ./test-lib.sh
+. "$GIT_BUILD_DIR"/git-sh-i18n
+
+test_expect_success 'gettext: our gettext() fallback has pass-through =
semantics' '
+    printf "test" >expect &&
+    gettext "test" >actual &&
+    test_i18ncmp expect actual &&
+    printf "test more words" >expect &&
+    gettext "test more words" >actual &&
+    test_i18ncmp expect actual
+'
+
+test_expect_success 'eval_gettext: our eval_gettext() fallback has pas=
s-through semantics' '
+    printf "test" >expect &&
+    eval_gettext "test" >actual &&
+    test_i18ncmp expect actual &&
+    printf "test more words" >expect &&
+    eval_gettext "test more words" >actual &&
+    test_i18ncmp expect actual
+'
+
+test_expect_success 'eval_gettext: our eval_gettext() fallback can int=
erpolate variables' '
+    printf "test YesPlease" >expect &&
+    GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=3DYesPlease eval_gettext "test=
 \$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" >actual &&
+    test_i18ncmp expect actual
+'
+
+test_expect_success 'eval_gettext: our eval_gettext() fallback can int=
erpolate variables with spaces' '
+    cmdline=3D"git am" &&
+    export cmdline;
+    printf "When you have resolved this problem run git am --resolved.=
" >expect &&
+    eval_gettext "When you have resolved this problem run \$cmdline --=
resolved." >actual
+    test_i18ncmp expect actual
+'
+
+test_expect_success 'eval_gettext: our eval_gettext() fallback can int=
erpolate variables with spaces and quotes' '
+    cmdline=3D"git am" &&
+    export cmdline;
+    printf "When you have resolved this problem run \"git am --resolve=
d\"." >expect &&
+    eval_gettext "When you have resolved this problem run \"\$cmdline =
--resolved\"." >actual
+    test_i18ncmp expect actual
+'
+
+test_done
--=20
1.7.4.4
