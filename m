From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 003/160] gettext: fix bug in git-sh-i18n's eval_gettext() by using envsubst(1)
Date: Sun, 14 Nov 2010 15:07:25 +0000
Message-ID: <1289747245-23263-3-git-send-email-avarab@gmail.com>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 16:08:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHeBr-0008Ge-Sd
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 16:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab0KNPIR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 10:08:17 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40937 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907Ab0KNPIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 10:08:12 -0500
Received: by mail-ww0-f44.google.com with SMTP id 29so498242wwb.1
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LfjjfOKazqMa0nJTmXSkHIYKYDiy4v5z6F74tgd/Axs=;
        b=DDZqwDosAMOdi34I91jks8xdpfn8nMfoyr5fZVubEYMRqCGyf1bpBorhoX9cvM9tt/
         VutOafNAvmnkEv+DKa5daqThlNNLfpf+2KHXBS742PLIxSB9a6K40zVZGVxjkIU+AIZn
         Pv1zS3/hoXAb81uao0IbxDNc/a616jvVfqT+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ph5OgJph/WYjyndJRJCVcaR2KoLLsii065ZGS/D+jnfOXB1pHJK0017uuyjxPKsNGG
         8M+LW/MT3pg+l6sRC7j8tHLbNAa2n4PtQstg5rxPBjK5sBCMvBmbZn4rwvlhLUDaekiA
         Ca7BjAwMRP9tElIhPQAr1qC52cUk91PrQ+xUk=
Received: by 10.216.73.16 with SMTP id u16mr5451215wed.94.1289747290125;
        Sun, 14 Nov 2010 07:08:10 -0800 (PST)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e12sm3208820wer.12.2010.11.14.07.08.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 07:08:09 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.326.g36065a
In-Reply-To: <1289747245-23263-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161417>

Change eval_gettext(1) in git-sh-i18n.sh to use a modified version of
gettext's envsubst(1) program, instead of using a clever (but broken)
printf + eval + printf trick.

Our previous fallback would incorrectly handle cases where the
variable being interpolated contained spaces. E.g.:

    cmd=3D"git foo"; eval_gettext "command: \$cmd"

Would emit "command: gitfoo", instead of the correct "command: git
foo". This happened with a message in git-am.sh that used the $cmdline
variable.

To work around this, and to improve our variable expansion behavior
(eval has security issues) I've imported a stripped-down version of
gettext's envsubst(1) program.

Using it we pass the latter of the two tests added along with this
patch (the first one was just added for completeness).

Since we want to test both our fallback eval_gettext() and the one
we'll end up using (i.e. on Solaris) the new tests are executed in
both t0200-gettext-basic.sh and t0201-gettext-fallbacks.sh.

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
 .gitignore                   |    1 +
 Makefile                     |    1 +
 git-sh-i18n.sh               |   14 +-
 sh-i18n--envsubst.c          |  444 ++++++++++++++++++++++++++++++++++=
++++++++
 t/lib-gettext.sh             |   24 +++
 t/t0200-gettext.sh           |    3 +
 t/t0201-gettext-fallbacks.sh |    3 +
 7 files changed, 485 insertions(+), 5 deletions(-)
 create mode 100644 sh-i18n--envsubst.c

diff --git a/.gitignore b/.gitignore
index 80ca718..d2d9ec2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -126,6 +126,7 @@
 /git-send-email
 /git-send-pack
 /git-sh-i18n
+/git-sh-i18n--envsubst
 /git-sh-setup
 /git-shell
 /git-shortlog
diff --git a/Makefile b/Makefile
index 67d94d3..1ef4648 100644
--- a/Makefile
+++ b/Makefile
@@ -420,6 +420,7 @@ PROGRAM_OBJS +=3D shell.o
 PROGRAM_OBJS +=3D show-index.o
 PROGRAM_OBJS +=3D upload-pack.o
 PROGRAM_OBJS +=3D http-backend.o
+PROGRAM_OBJS +=3D sh-i18n--envsubst.o
=20
 PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
=20
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 698a000..3aac21c 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -48,10 +48,12 @@ then
=20
 	# Solaris has a gettext(1) but no eval_gettext(1)
 	eval_gettext () {
-		gettext_out=3D$(gettext "$1")
-		gettext_eval=3D"printf '%s' \"$gettext_out\""
-		printf "%s" "`eval \"$gettext_eval\"`"
+		gettext "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
 	}
+
 else
 	# Since gettext.sh isn't available we'll have to define our own
 	# dummy pass-through functions.
@@ -65,7 +67,9 @@ else
 	}
=20
 	eval_gettext () {
-		gettext_eval=3D"printf '%s' \"$1\""
-		printf "%s" "`eval \"$gettext_eval\"`"
+		printf "%s" "$1" | (
+			export PATH $(git sh-i18n--envsubst --variables "$1");
+			git sh-i18n--envsubst "$1"
+		)
 	}
 fi
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
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 831ee38..f0101fc 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -40,3 +40,27 @@ else
 	test_set_prereq NO_GETTEXT
 	say "# lib-gettext: No GETTEXT support available"
 fi
+
+test_eval_gettext_interpolation() {
+	test_expect_success NO_GETTEXT_POISON 'eval_gettext: our eval_gettext=
() fallback can interpolate whitespace variables' '
+	    git_am_cmdline=3D"git am" &&
+	    printf "test git am" >expect &&
+	    eval_gettext "test \$git_am_cmdline" >actual &&
+	    test_cmp expect actual
+	'
+
+	test_expect_success NO_GETTEXT_POISON 'eval_gettext: git am $cmdline =
bug' '
+	    cmdline=3D"git am -3" &&
+	    export cmdline &&
+	    cat >expect <<EOF &&
+When you have resolved this problem run "git am -3 --resolved".
+If you would prefer to skip this patch, instead run "git am -3 --skip"=
=2E
+To restore the original branch and stop patching run "git am -3 --abor=
t".
+EOF
+	    eval_gettext "When you have resolved this problem run \"\$cmdline=
 --resolved\".
+If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
+To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"." >actual &&
+	    echo >>actual &&
+	    test_cmp expect actual
+	'
+}
diff --git a/t/t0200-gettext.sh b/t/t0200-gettext.sh
index 8853d8a..58948fa 100755
--- a/t/t0200-gettext.sh
+++ b/t/t0200-gettext.sh
@@ -105,4 +105,7 @@ test_expect_success GETTEXT_LOCALE 'sanity: Some ge=
ttext("") data for real local
     test -s real-locale
 '
=20
+# Test eval_gettext() interpolation with the actual eval_gettext funct=
ion
+test_eval_gettext_interpolation
+
 test_done
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.s=
h
index 47ce4f6..d2dc4af 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -46,4 +46,7 @@ test_expect_success 'eval_gettext: our eval_gettext()=
 fallback can interpolate v
     test_cmp expect actual
 '
=20
+# Test eval_gettext() interpolation with the fallback eval_gettext fun=
ction
+test_eval_gettext_interpolation
+
 test_done
--=20
1.7.2.3
