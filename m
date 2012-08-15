From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v3 01/16] Implement a remote helper for svn in C.
Date: Wed, 15 Aug 2012 14:00:31 +0200
Message-ID: <38446278.5ZUZChB0NF@flomedio>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vhas59r0b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 14:00:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1cHL-0008Lv-0L
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 14:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab2HOMAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 08:00:43 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38889 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab2HOMAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 08:00:42 -0400
Received: by bkwj10 with SMTP id j10so488287bkw.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=ufmf6LDHwxFo6z4yDC6GpcWd+QqOyEa9f3QT/MLR8P0=;
        b=ODMHYcnOQGMcjIcTKj89OWV1Yv70YGrLEy5Rq/Ka6LxELaGwOmHU6k75YubLTJaKRn
         +LZJt2KcvzSIugMNu+EH2Z6WJaMPKifSs7ztopvBgJzpSOfbLuqy6KInij2sa9Df30mn
         n5i7qrpq5qMPtCvtSVsmJnnLXR90lXwl1A3UN0ST+LTU1DUFm6/+jpJ3kbARN0T+JbrG
         yXt/0evqb8jM+svOuEylYEOO2qz0/u8wYt/BssT70MeNBtLc9/7tOdLWtQ6s1juMGydZ
         q3uP7Uw5PbKxx9IRkXKibw8DdJEnQ72+L+v40LmE9a34fwNBNvz7ERNQJWp3E3jrEDdT
         Iz7Q==
Received: by 10.204.154.211 with SMTP id p19mr7859520bkw.12.1345032040899;
        Wed, 15 Aug 2012 05:00:40 -0700 (PDT)
Received: from flomedio.localnet (089144206028.atnat0015.highway.a1.net. [89.144.206.28])
        by mx.google.com with ESMTPS id m9sm666268bkm.10.2012.08.15.05.00.35
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Aug 2012 05:00:39 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vhas59r0b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203469>

On Tuesday 14 August 2012 13:07:32 Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> > Enable basic fetching from subversion repositories. When processing remote
> > URLs starting with svn::, git invokes this remote-helper.
> > It starts svnrdump to extract revisions from the subversion repository in
> > the 'dump file format', and converts them to a git-fast-import stream
> > using the functions of vcs-svn/.
> 
> (nit) the above is a bit too wide, isn't it?
> 
> > Imported refs are created in a private namespace at
> > refs/svn/<remote-name/master.
> (nit) missing closing '>'?
> 
> > The revision history is imported linearly (no branch detection) and
> > completely, i.e. from revision 0 to HEAD.
> > 
> > The 'bidi-import' capability is used. The remote-helper expects data from
> > fast-import on its stdin. It buffers a batch of 'import' command lines
> > in a string_list before starting to process them.
> > 
> > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > ---
> > diff:
> > - incorporate review
> > - remove redundant strbuf_init
> > - add 'bidi-import' to capabilities
> > - buffer all lines of a command batch in string_list
> > 
> >  contrib/svn-fe/remote-svn.c |  183
> >  +++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 183
> >  insertions(+)
> >  create mode 100644 contrib/svn-fe/remote-svn.c
> > 
> > diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
> > new file mode 100644
> > index 0000000..ce59344
> > --- /dev/null
> > +++ b/contrib/svn-fe/remote-svn.c
> > @@ -0,0 +1,183 @@
> > +
> 
> Remove.
> 
> > +#include "cache.h"
> > +#include "remote.h"
> > +#include "strbuf.h"
> > +#include "url.h"
> > +#include "exec_cmd.h"
> > +#include "run-command.h"
> > +#include "svndump.h"
> > +#include "notes.h"
> > +#include "argv-array.h"
> > +
> > +static const char *url;
> > +static const char *private_ref;
> > +static const char *remote_ref = "refs/heads/master";
> 
> Just wondering; is this name "master" (or "refs/heads/" for that
> matter) significant in any way when talking to a subversion remote?

No, it isn't. But it has to specify something in the list command.

> 
> > +static int cmd_capabilities(const char *line);
> > +static int cmd_import(const char *line);
> > +static int cmd_list(const char *line);
> > +
> > +typedef int (*input_command_handler)(const char *);
> > +struct input_command_entry {
> > +	const char *name;
> > +	input_command_handler fct;
> > +	unsigned char batchable;	/* whether the command starts or is part of a
> > batch */ +};
> > +
> > +static const struct input_command_entry input_command_list[] = {
> > +		{ "capabilities", cmd_capabilities, 0 },
> 
> One level too deeply indented?
> 
> > +		{ "import", cmd_import, 1 },
> > +		{ "list", cmd_list, 0 },
> > +		{ NULL, NULL }
> > +};
> > +
> > +static int cmd_capabilities(const char *line) {
> > +	printf("import\n");
> > +	printf("bidi-import\n");
> > +	printf("refspec %s:%s\n\n", remote_ref, private_ref);
> > +	fflush(stdout);
> > +	return 0;
> > +}
> > +
> > +static void terminate_batch(void)
> > +{
> > +	/* terminate a current batch's fast-import stream */
> > +		printf("done\n");
> 
> Likewise.
> 
> > +		fflush(stdout);
> > +}
> > +
> > +static int cmd_import(const char *line)
> > +{
> > +	int code;
> > +	int dumpin_fd;
> > +	unsigned int startrev = 0;
> > +	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
> > +	struct child_process svndump_proc;
> > +
> > +	memset(&svndump_proc, 0, sizeof (struct child_process));
> 
> Please lose SP between sizeof and '('.
> 
> > +	svndump_proc.out = -1;
> > +	argv_array_push(&svndump_argv, "svnrdump");
> > +	argv_array_push(&svndump_argv, "dump");
> > +	argv_array_push(&svndump_argv, url);
> > +	argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
> > +	svndump_proc.argv = svndump_argv.argv;
> 
> (just me making a mental note) We read from "svnrdump", which would
> read (if it ever does) from the same stdin as ours and spits (if it
> ever does) its errors to the same stderr as ours.

Yes. svnrdump sometimes queries passwords, in this case it reads stdin, from 
the the terminal, and it writes errors and the password prompt to stderr, the 
terminal.

> 
> > +
> > +	code = start_command(&svndump_proc);
> > +	if (code)
> > +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> > +	dumpin_fd = svndump_proc.out;
> > +
> > +	code = start_command(&svndump_proc);
> > +	if (code)
> > +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> > +	dumpin_fd = svndump_proc.out;
> 
> You start it twice without finishing the first invocation, or just a
> double paste?

Sorry, thats garbage. It's meant to be only once. This was a mistake in a 
rebase merge.

> 
> > +	svndump_init_fd(dumpin_fd, STDIN_FILENO);
> > +	svndump_read(url, private_ref);
> > +	svndump_deinit();
> > +	svndump_reset();
> > +
> > +	close(dumpin_fd);
> 
> (my mental note) And at this point, we finished feeding whatever
> comes out of "svnrdump" to svndump_read().
> 
> > +	code = finish_command(&svndump_proc);
> > +	if (code)
> > +		warning("%s, returned %d", svndump_proc.argv[0], code);
> > +	argv_array_clear(&svndump_argv);
> > +
> > +	return 0;
> 
> Other than the "twice?" puzzle, this function looks straightforward.
> 
> > +}
> > +
> > +static int cmd_list(const char *line)
> > +{
> > +	printf("? %s\n\n", remote_ref);
> > +	fflush(stdout);
> > +	return 0;
> > +}
> > +
> > +static int do_command(struct strbuf *line)
> > +{
> > +	const struct input_command_entry *p = input_command_list;
> > +	static struct string_list batchlines = STRING_LIST_INIT_DUP;
> > +	static const struct input_command_entry *batch_cmd;
> > +	/*
> > +	 * commands can be grouped together in a batch.
> > +	 * Batches are ended by \n. If no batch is active the program ends.
> > +	 * During a batch all lines are buffered and passed to the handler
> > function +	 * when the batch is terminated.
> > +	 */
> > +	if (line->len == 0) {
> > +		if (batch_cmd) {
> > +			struct string_list_item *item;
> > +			for_each_string_list_item(item, &batchlines)
> > +				batch_cmd->fct(item->string);
> 
> (style) I think we tend to call these unnamed functions "fn" in our
> codebase.
> 
> > +			terminate_batch();
> > +			batch_cmd = NULL;
> > +			string_list_clear(&batchlines, 0);
> > +			return 0;	/* end of the batch, continue reading other commands. */
> > +		}
> > +		return 1;	/* end of command stream, quit */
> > +	}
> > +	if (batch_cmd) {
> > +		if (strcmp(batch_cmd->name, line->buf))
> > +			die("Active %s batch interrupted by %s", batch_cmd->name, line-
>buf);
> > +		/* buffer batch lines */
> > +		string_list_append(&batchlines, line->buf);
> > +		return 0;
> > +	}
> 
> A "batch-able" command, e.g. "import", will first cause the
> batch_cmd to point at the command structure in this function, and
> then the next and subsequent lines, as long as the input line is
> exactly the same as the current batch_cmd->name, e.g. "import", is
> appended into batchlines.
> 
> Would this mean that you can feed something like this:
> 
> 	import foobar
>         import
>         import
>         import
> 
>         another command
> 
> and buffer the four "import" lines in batchlines, and then on the
> empty line, have the for-each-string-list-item loop to call
> cmd_import() on "import foobar", "import", "import", then "import"
> (literally, without anything other than "import" on the line).
> 
> How is that useful?  With that "if (strcmp(batch_cmd->name, line->buf))",
> I cannot think of other valid input to make this "batch" mechanism
> to trigger and do something useful.  Am I missing something?
> 
That's a mistake I made when adding the line buffering. It should allow 
commands like:

import foo
import bar

some other command.

For this helper in it's current state it's anyways not useful to send more 
than one import command, because it can only import revisions it doesn't yet 
have. So a second import would always do nothing.
The import batches are specified in Documentation/git-remote-helpers.txt.
So this helper should support it, I thought.
The buffering of import lines is necessary with the bidi-import capability, 
suggested by Jonathan. It uses the helper's stdin for command input and for 
reading fast-imports output. So we must make sure these two datastreams don't 
mix.

> > +
> > +	for(p = input_command_list; p->name; p++) {
> 
> Have a SP between for and '('.
> 
> > +		if (!prefixcmp(line->buf, p->name) &&
> > +				(strlen(p->name) == line->len || line->buf[strlen(p->name)] == ' 
'))
> > {
> 
> A line way too wide.
> 
> > +			if (p->batchable) {
> > +				batch_cmd = p;
> > +				string_list_append(&batchlines, line->buf);
> > +				return 0;
> > +			}
> > +			return p->fct(line->buf);
> > +		}
> 
> OK, so a command word on a line by itself, or a command word
> followed by a SP (probably followed by its arguments) on a line
> triggers a command lookup, and individual command implementation
> parses the line.
> 
> > +	}
> > +	warning("Unknown command '%s'\n", line->buf);
> > +	return 0;
> 
> Why isn't this an error?

Yeah, it should.

> 
> > +}
> > +
> > +int main(int argc, const char **argv)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	int nongit;
> > +	static struct remote *remote;
> > +	const char *url_in;
> > +
> > +	git_extract_argv0_path(argv[0]);
> > +	setup_git_directory_gently(&nongit);
> > +	if (argc < 2 || argc > 3) {
> > +		usage("git-remote-svn <remote-name> [<url>]");
> > +		return 1;
> > +	}
> 
> If this is an importer, you would be importing _into_ a git
> repository, no?  How can you not error out when you are not in one?
> In other words, why &nongit with *_gently()?

Hm .. in fact it only feeds into fast-import. But you're right, it doesn't 
make much sense. I took remote-curl.c as a guideline for these first lines.
Will use the non-gentle function.

> 
> > +	remote = remote_get(argv[1]);
> > +	url_in = remote->url[0];
> > +	if (argc == 3)
> > +		url_in = argv[2];
> 
> Shouldn't it be more like this?
> 
> 	url_in = (argc == 3) ? argv[2] : remote->url[0];

Yes, much nicer.

> 
> > +	end_url_with_slash(&buf, url_in);
> > +	url = strbuf_detach(&buf, NULL);
> > +
> > +	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
> > +	private_ref = strbuf_detach(&buf, NULL);
> > +
> > +	while(1) {
> > +		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
> > +			if (ferror(stdin))
> > +				die("Error reading command stream");
> > +			else
> > +				die("Unexpected end of command stream");
> > +		}
> > +		if (do_command(&buf))
> > +			break;
> > +		strbuf_reset(&buf);
> > +	}
> > +
> > +	strbuf_release(&buf);
> > +	free((void*)url);
> > +	free((void*)private_ref);
> > +	return 0;
> > +}
