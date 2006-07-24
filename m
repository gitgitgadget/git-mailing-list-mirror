From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH 1/2] add git-quote: shell and C quoting tool
Date: Tue, 25 Jul 2006 01:12:59 +0200
Message-ID: <20060724231259.GA14792@steel.home>
References: <20060716222757.GA10135@steel.home> <7vwta3h7r2.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 01:13:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G59bv-0005dG-P3
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 01:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWGXXNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 19:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWGXXNM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 19:13:12 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:3977 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932318AbWGXXNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 19:13:10 -0400
Received: from fwd28.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1G59bl-0004OM-02; Tue, 25 Jul 2006 01:13:05 +0200
Received: from tigra.home (rIEH9-ZBoe3MVzpbV4Slk0bgkP9gbdV3FbwEvkrOeN2VLAKi7-+8Ej@[84.160.82.84]) by fwd28.sul.t-online.de
	with esmtp id 1G59bg-1DeeGG0; Tue, 25 Jul 2006 01:13:00 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3A561277AF;
	Tue, 25 Jul 2006 01:13:00 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G59bf-0002i1-TC; Tue, 25 Jul 2006 01:12:59 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwta3h7r2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-ID: rIEH9-ZBoe3MVzpbV4Slk0bgkP9gbdV3FbwEvkrOeN2VLAKi7-+8Ej
X-TOI-MSGID: 941c8a68-c644-4c95-b60d-031af65bc482
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24153>

Junio C Hamano, Mon, Jul 24, 2006 07:49:53 +0200:
> > In case anyone asks why isn't it a standalone tool nor is it put into
> > git-stripspace: I don't know. Maybe it should be.
> 
> This organization is fine by me.
> 
>  * unquote?

Not done yet. I actually never expected it to be used for unquoting,
being naturally unquoted by bash. C-quoting was done just because it
was so simple to do. I have no idea where could that be used.

>  * doc?

Done. Sorry for missing that.

> > +enum {SHELL_QUOTE, C_QUOTE};
> > +static int style = SHELL_QUOTE,
> > +	   use_stdin = 0;
> 
> Shouldn't style be of type which is that unnamed enum?

It should. Done.

> > +static const char *separator = NULL; /* default is space */
> > +static unsigned sep_len = 0;
> 
> It is not clear if this is separator of input side or output
> side (after reading the code it becomes somewhat obvious that
> you are talking about output separator), and if the default is
> space wouldn't it make more sense to set that here?

Right. It is out_separator now.

> > +static const char builtin_quote_usage[] =
> > +"git-quote [--c] [--sep=<c-quoted> | -z] ( [--stdin] | [--] ... )";
> > +
> > +static void print_quoted(const char *text)
> > +{
> > +	switch (style)
> > +	{
> > +	case SHELL_QUOTE:
> > +		sq_quote_print(stdout, text);
> > +		break;
> > +	case C_QUOTE:
> > +		quote_c_style(text, NULL, stdout, 0);
> > +		break;
> > +	}
> 
> Not a big deal but aren't these going to write out things quoted
> when they do not need to?  To help scripts, it might be worth
> adding "check if this needs quoting" interface perhaps?

Not done yet. "--no-overquote"?

> > +		if (!strcmp(arg, "--c")) {
> 
> Perhaps "--c-style" with "-c" as a shorthand, (and
> "--shell-style" with "-s" to complement)?

Done. --sh-style.

> > +			style = C_QUOTE;
> > +			continue;
> > +		}
> > +		if (!strcmp(arg, "-z")) {
> > +			separator = "";
> > +			sep_len = 1;
> > +			continue;
> > +		}
> 
> Is it plausible that somebody might want to feed you NUL
> terminated sequence as input (iow you might want to give them
> choice of separator on the input side)?

Done. -z sets both separators to NUL, --in-separator=<c-style> defines
by its first character the input separator. I.e.:

$ find | git quote -z --in-separator='\n'
'a'\0'b'\0''

which is not all that useful...

> > +		if (!strncmp(arg, "--sep=", 6)) {
> 
> Perhaps "--separator" (or "--output-separator") with whatever
> shorthand is handy?

--out-separator. No idea of a shortcut, though

> > +			separator = unquote_c_style(tmp, &end);
> > +			sep_len = strlen(separator);
> 
> If the parameter is a malformed c-quoted string, you would dump
> core here.

Oops. Fixed.

> > +	if (!separator) {
> > +		sep_len = 1;
> > +		separator = "\x20";
> 
> Any reason you needed to spell it in hex?  Is this trying to
> be portable to EBCDIC (or trying to prevent the code to be
> ported there)?  I dunno.

Visibility. I have dificulty seeing spaces and tabs.
I changed it anyway, maybe that's just me.

> > +		while (EOF != (ch = fgetc(stdin))) {
> 
> Looks similar to strbuf.c::read_line() loop...
> 

Indeed. Replaced.

I attach the updated patch here, because it is obviously is not quite
finished yet and I probably wont have enough time over the week. So
maybe someone takes over. Or it'll be taken as is, that happens too.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

diff --git a/Documentation/git-quote.txt b/Documentation/git-quote.txt
new file mode 100644
index 0000000..98b2859
--- /dev/null
+++ b/Documentation/git-quote.txt
@@ -0,0 +1,70 @@
+git-quote(1)
+============
+
+NAME
+----
+git-quote - Quote given text according to Shell or C rules
+
+
+SYNOPSIS
+--------
+'git-quote' [-c] [-s] [-s] [--out-separator=<c-quoted>] 
+	[--in-separator=<c-quoted>] [-z] [--] ...
+'git-quote' ... --stdin < <stream>
+
+DESCRIPTION
+-----------
+Quote the lines according to the given rules, which can be Shell backslash
+quoting (every line is enclosed in single ticks, backslash and single tick
+quoted specially) or a C quoting (use double ticks and backslash-prefixed
+symbols).
+
+The separator options are handled in the order they are given, so one
+can save some typing by giving "-z" first, and overriding input or
+output separator as needed.
+
+OPTIONS
+-------
+-c|--c-style::
+	Select C-style quoting
+
+-s|--sh-style::
+	Select Shell-style quoting. This is default.
+
+--out-separator=<c-quoted>::
+	Specify the separator between the output elements. If the separator
+	have to contain special characters, they must be quoted according
+	to C quoting rules (double ticks are not essential).
+	The ASCII space is default output separator.
+
+--in-separator=<c-quoted>::
+	Specify the separator between the input elements. Only the
+	first character of <c-quoted> is used.
+	Used only if --stdin is also given. The default is LF.
+
+-z::
+	Separate the elements on output and expect elements separated
+	on input with NUL character.
+	Used only if --stdin is also given.
+
+--stdin::
+	Specify that the elements have to be read from stdin.
+	This option ends command line parsing.
+	Also, if there were no output separator set by previous
+	--out-separator or -z, this option will set it to LF.
+
+<stream>::
+	Byte stream to act on.
+
+Author
+------
+Written by Alex Riesen <raa.lkml@gmail.com>
+
+Documentation
+--------------
+Documentation by Alex Riesen.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index 3e085df..4df2951 100644
--- a/Makefile
+++ b/Makefile
@@ -246,7 +246,8 @@ BUILTIN_OBJS = \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
-	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o
+	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
+	builtin-quote.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-quote.c b/builtin-quote.c
new file mode 100644
index 0000000..d9d4b00
--- /dev/null
+++ b/builtin-quote.c
@@ -0,0 +1,123 @@
+/*
+ * "git quote" builtin command
+ *
+ * DOES NOT QUOTE \0 (truncates lines at it)
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "strbuf.h"
+#include "quote.h"
+
+static enum {SHELL_QUOTE, C_QUOTE} style = SHELL_QUOTE;
+static int use_stdin = 0;
+static const char *out_separator = NULL; /* default is space */
+static unsigned out_separator_len = 0;
+
+static const char builtin_quote_usage[] =
+"git-quote [-c | -s] [--out-separator=<c-quoted> | -z] ( [--stdin] | [--] ... )";
+
+static void print_quoted(const char *text)
+{
+	switch (style)
+	{
+	case SHELL_QUOTE:
+		sq_quote_print(stdout, text);
+		break;
+	case C_QUOTE:
+		quote_c_style(text, NULL, stdout, 0);
+		break;
+	}
+	fwrite(out_separator, 1, out_separator_len, stdout);
+}
+
+static char *unquote_c_arg(const char *arg)
+{
+	const char *end;
+	char *tmp;
+	char *result;
+	if ('"' == *arg)
+		tmp = strdup(arg);
+	else {
+		size_t l = strlen(arg);
+		tmp = malloc(l + 3);
+		sprintf(tmp, "\"%s\"", arg);
+	}
+	result = unquote_c_style(tmp, &end);
+	free(tmp);
+	return result;
+}
+
+int cmd_quote(int argc, const char **argv, char **envp)
+{
+	int in_separator = '\n';
+	int i;
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (arg[0] != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "--stdin")) {
+			use_stdin = 1;
+			if ( !out_separator ) {
+				out_separator = "\n";
+				out_separator_len = 1;
+			}
+			break;
+		}
+		if (!strcmp(arg, "--c-style") || !strcmp(arg, "-c")) {
+			style = C_QUOTE;
+			continue;
+		}
+		if (!strcmp(arg, "--sh-style") || !strcmp(arg, "-s")) {
+			style = SHELL_QUOTE;
+			continue;
+		}
+		if (!strcmp(arg, "-z")) {
+			in_separator = 0;
+			out_separator = "";
+			out_separator_len = 1;
+			continue;
+		}
+		if (!strncmp(arg, "--out-separator=", 16)) {
+			arg += 16;
+			out_separator = unquote_c_arg(arg);
+			if (!out_separator)
+				die("malformed separator '%s'", arg);
+			out_separator_len = strlen(out_separator);
+			/* this will leak if multiple --sep= given */
+			continue;
+		}
+		if (!strncmp(arg, "--in-separator=", 15)) {
+			char *sep;
+			arg += 15;
+			sep = unquote_c_arg(arg);
+			if (!sep || !*sep)
+				die("malformed separator '%s'", arg);
+			in_separator = *sep;
+			free(sep);
+			continue;
+		}
+		die(builtin_quote_usage);
+	}
+	if (!out_separator) {
+		out_separator_len = 1;
+		out_separator = " ";
+	}
+	if (use_stdin) {
+		struct strbuf line;
+		strbuf_init(&line);
+
+		while (!line.eof) {
+			read_line(&line, stdin, in_separator);
+			if (line.len)
+				print_quoted(line.buf);
+		}
+	} else
+		for (; argv[i]; ++i)
+			print_quoted(argv[i]);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 5339d86..9bd522e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -64,4 +64,6 @@ extern int mailinfo(FILE *in, FILE *out,
 
 extern int cmd_stripspace(int argc, const char **argv, char **envp);
 extern void stripspace(FILE *in, FILE *out);
+
+extern int cmd_quote(int argc, const char **argv, char **envp);
 #endif
diff --git a/git.c b/git.c
index ee5a0e8..f94d25a 100644
--- a/git.c
+++ b/git.c
@@ -202,6 +202,7 @@ static void handle_internal_command(int 
 		{ "update-ref", cmd_update_ref },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg },
 		{ "prune", cmd_prune },
+		{ "quote", cmd_quote },
 	};
 	int i;
 
