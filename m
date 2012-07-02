From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Mon, 2 Jul 2012 06:07:41 -0500
Message-ID: <20120702110741.GA3527@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1374057.qfvOg1c6C6@flobuntu>
 <23122876.7xH9dZiP4M@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 13:08:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SleU1-0001o5-T7
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 13:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab2GBLHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 07:07:52 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:38576 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2GBLHu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 07:07:50 -0400
Received: by ghrr11 with SMTP id r11so3950543ghr.19
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WtWuknwc9XUX4VM17JNGpQvQgzPzuOsalhJTVjECMAI=;
        b=yJY4pM//M7zgvCpYcfaBZwooWblofNQYldE/+ipfnVRsQKrh5E5NrLU72iPL9KQkxN
         +qIobxB+E8umm7ERFoTKpVNipS6RP3E9oLgV5or/Iil2gJcpuyLk74jXHg0SiOcgpxZn
         bRil+Yg2YnJPqxFpsvVu+HUpv5Sre5FXSNdMQatoRhDNyrCzQpopICy54rHbY3SD8nSJ
         70fWe4t0ovrNWqU+QZb8+B1w5+ZaGY3KaFhu9n/LVgzOndrYNvP4KDZQkNcS0DZKKU6b
         I5S2ONXgCSFi8wfIbHo7fedqZLcZNuaVR5EozX9We2HsXM8MuV2mQpeYR3T17O3EoxJp
         Mbuw==
Received: by 10.50.171.98 with SMTP id at2mr4887105igc.26.1341227269705;
        Mon, 02 Jul 2012 04:07:49 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id v17sm18610149igv.7.2012.07.02.04.07.48
        (version=SSLv3 cipher=OTHER);
        Mon, 02 Jul 2012 04:07:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <23122876.7xH9dZiP4M@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200852>

Hi,

Florian Achleitner wrote:

> Experimental implementation.

Ok, so this adds a new program named "remote-svn".  How do I build it?
What does it do?  Will it make my life better?

[...]
> diff: Use fifo instead of pipe: Retrieve the name of the pipe from env and open it
> for svndump.

I'd prefer to avoid this if possible, since it means having to decide
where the pipe goes on the filesystem.  Can you summarize the
discussion in the commit message so future readers understand why
we're doing it?

[...]
> --- /dev/null
> +++ b/contrib/svn-fe/remote-svn.c
> @@ -0,0 +1,207 @@
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>

git-compat-util.h (or some header that includes it) must be the first
header included so the appropriate feature test macros can be defined.
See Documentation/CodingGuidelines for more on that.

> +#include "cache.h"
> +#include "remote.h"
> +#include "strbuf.h"
> +#include "url.h"
> +#include "exec_cmd.h"
> +#include "run-command.h"
> +#include "svndump.h"
> +
> +static int debug = 0;

Small nit: please drop the redundant "= 0" here.  Or:

> +
> +static inline void printd(const char* fmt, ...)
> +{
> +	if(debug) {
> +		va_list vargs;
> +		va_start(vargs, fmt);
> +		fprintf(stderr, "rhsvn debug: ");
> +		vfprintf(stderr, fmt, vargs);
> +		fprintf(stderr, "\n");
> +		va_end(vargs);
> +	}
> +}

Why not use trace_printf and avoid the complication?

[...]

> +
> +static struct remote* remote;
> +static const char* url;
> +const char* private_refs = "refs/remote-svn/";		/* + remote->name. */
> +const char* remote_ref = "refs/heads/master";

Style: '*' attaches to the variable name, to avoid making declarations
like

	char *p, c;

confusing.

> +
> +enum cmd_result cmd_capabilities(struct strbuf* line);
> +enum cmd_result cmd_import(struct strbuf* line);
> +enum cmd_result cmd_list(struct strbuf* line);

What's a cmd_result?  '*' sticks to variable name.

> +
> +enum cmd_result { SUCCESS, NOT_HANDLED, ERROR };

Oh, that's what a cmd_result is. :)  Why not define the type before
using it to avoid keeping the reader in suspense?

What does each result represent?  If this is a convention like

 1: handled
 0: not handled
 -1: error, callee takes care of printing the error message

then please document it in a comment near the caller so the reader can
understand what is happening without too much confusion.  Given such a
comment, does the enum add clarity?

> +typedef enum cmd_result (*command)(struct strbuf*);

When I first read this, I wonder what is being commanded.  Are these
commands passed on the remote helper's standard input, commands passed
on its output, or commands run at some point in the process?  What is
the effect and return value of associated function?  Does the function
always return some success/failure value, or does it sometimes exit?

Maybe a more specific type name would be clearer?

[...]
> +
> +const command command_list[] = {
> +		cmd_capabilities, cmd_import, cmd_list, NULL
> +};

First association is to functions like cmd_fetch() which implement git
subcommands.  So I thought these were going to implement subcommands
like "git remote-svn capabilities", "git remote-svn import" and would
use the same cmd_foo(argc, argv, prefix) calling convention that git
subcommands do.  Maybe a different naming convention could avoid
confusion.

[...]
> +enum cmd_result cmd_capabilities(struct strbuf* line)
> +{
> +	if(strcmp(line->buf, "capabilities"))
> +		return NOT_HANDLED;

Style: missing SP after keyword.

> +
> +	printf("import\n");
> +	printf("\n");
> +	fflush(stdout);
> +	return SUCCESS;
> +}

Why the multiple printf?  Is the flush needed?

[...]
> +
> +enum cmd_result cmd_import(struct strbuf* line)
> +{
> +	const char* revs = "-r0:HEAD";

Style: * goes with ... (I won't point out the rest of these.

> +	int code, report_fd;
> +	char* back_pipe_env;
> +	struct child_process svndump_proc = {
> +			.argv = NULL,		/* comes later .. */

I don't understand this comment.

> +			/* we want a pipe to the child's stdout, but stdin, stderr inherited.
> +			 The user can be asked for e.g. a password */
> +			.in = 0, .out = -1, .err = 0,

Style: comments in git are spelled like this:

			/*
			 * Here I put a sentence or two explaining some
			 * relevant design decision or fact about the world
			 * that will provide useful context for
			 * understanding the following code.
			 */
> +			.no_stdin = 0, .no_stdout = 0, .no_stderr = 0,

I couldn't parse the above comment, so I'm skipping it for now.

[...]
> +			.git_cmd = 0,
> +			.silent_exec_failure = 0,
> +			.stdout_to_stderr = 0,
> +			.use_shell = 0,
> +			.clean_on_exit = 0,
> +			.preexec_cb = NULL,
> +			.env = NULL,
> +			.dir = NULL

Style: C99-style initializers are (unfortunately) not supported in
some compilers we want to support.

No need to initialize all fields --- any trailing unlisted fields
are automatically initialized to zero.

> +	};
> +
> +	if(prefixcmp(line->buf, "import"))

Style: missing SP after keyword (I won't point out the rest of these).

> +		return NOT_HANDLED;
> +
> +	back_pipe_env = getenv("GIT_REPORT_FIFO");
> +	if(!back_pipe_env) {
> +		die("Cannot get cat-blob-pipe from environment!");
> +	}

Does this mean that expected usage is something like

	GIT_REPORT_FIFO=/tmp/foo/bar git clone svn::foo/bar/baz

?  And if I don't do that, I get

	fatal: Cannot get cat-blob-pipe from environment!

and am somehow supposed to understand what to do?

> +
> +	/* opening a fifo for usually reading blocks until a writer has opened it too.
> +	 * Therefore, we open with RDWR.
> +	 */
> +	report_fd = open(back_pipe_env, O_RDWR);
> +	if(report_fd < 0) {
> +		die("Unable to open fast-import back-pipe! %s", strerror(errno));
> +	}

Is this necessary?  Why shouldn't we fork the writer first and wait
for it here?

> +
> +	printd("Opened fast-import back-pipe %s for reading.", back_pipe_env);
> +
> +	svndump_proc.argv = xcalloc(5, sizeof(char*));
> +	svndump_proc.argv[0] = "svnrdump";
> +	svndump_proc.argv[1] = "dump";
> +	svndump_proc.argv[2] = url;
> +	svndump_proc.argv[3] = revs;

Style: could simplify by using struct argv_array.

> +
> +	code = start_command(&svndump_proc);
> +	if(code)
> +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);

start_command() is supposed to have printed a message already when it
fails, unless errno == ENOENT and silent_exec_failure was set.

> +
> +
> +

Style: looks like some stray carriage returns snuck in.

> +	svndump_init_fd(svndump_proc.out, report_fd);
> +	svndump_read(url);
> +	svndump_deinit();
> +	svndump_reset();

Not your fault: this API looks a little overcomplicated.

> +
> +	close(svndump_proc.out);

Important?  Wouldn't finish_command do this?

> +	close(report_fd);

What is the purpose of this step?

> +
> +	code = finish_command(&svndump_proc);
> +	if(code)
> +		warning("Something went wrong with termination of %s, code %d", svndump_proc.argv[0], code);

finish_command() is supposed to print a message when it fails.

> +	free(svndump_proc.argv);
> +
> +	printf("done\n");
> +	return SUCCESS;

Success even if it failed?

> +
> +
> +

Blank lines seem to have snuck in.

> +}
> +
> +enum cmd_result cmd_list(struct strbuf* line)
> +{
> +	if(strcmp(line->buf, "list"))
> +		return NOT_HANDLED;
> +
> +	printf("? HEAD\n");
> +	printf("? %s\n", remote_ref);

Why is this variable?

> +	printf("\n");
> +	fflush(stdout);

Why the flush?

> +	return SUCCESS;
> +}
> +
> +enum cmd_result do_command(struct strbuf* line)
> +{
> +	const command* p = command_list;
> +	enum cmd_result ret;
> +	printd("command line '%s'", line->buf);
> +	while(*p) {
> +		ret = (*p)(line);
> +		if(ret != NOT_HANDLED)
> +			return ret;
> +		p++;
> +	}

If possible, matching commands by name (like git.c does) would make
the behavior easier to predict.

[...]
> +	if (argc < 2) {
> +		fprintf(stderr, "Remote needed\n");
> +		return 1;
> +	}

usage() can be used to write a clearer error message.

[...]
> +
> +	remote = remote_get(argv[1]);
> +	if (argc == 3) {
> +		end_url_with_slash(&buf, argv[2]);
> +	} else if (argc == 2) {
> +		end_url_with_slash(&buf, remote->url[0]);
> +	} else {
> +		warning("Excess arguments!");
> +	}

Style: no need for these braces.  usage() could be used to make it
clearer to the user what she can do next.

[...]
> +	/* build private ref namespace path for this svn remote. */
> +	strbuf_init(&buf, 0);
> +	strbuf_addstr(&buf, private_refs);
> +	strbuf_addstr(&buf, remote->name);
> +	strbuf_addch(&buf, '/');
> +	private_refs = strbuf_detach(&buf, NULL);

What is a private ref namespace path?  An example would make the comment
clearer.

> +
> +	while(1) {
> +		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
> +			if (ferror(stdin))
> +				fprintf(stderr, "Error reading command stream\n");

errno will be meaningful; the message can be made clearer by using it.

Maybe this could use error() or die().

[...]
> +	free((void*)url);
> +	free((void*)private_refs);

Won't this crash?

It would also be nice to add a test case to the t/ directory to make others
changing this code do not accidentally break your new functionality.

Hope that helps,
Jonathan
