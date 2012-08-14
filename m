From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 01/16] Implement a remote helper for svn in C.
Date: Tue, 14 Aug 2012 13:07:32 -0700
Message-ID: <7vhas59r0b.fsf@alter.siamese.dyndns.org>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 22:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1NOx-0004m8-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 22:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469Ab2HNUHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 16:07:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab2HNUHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 16:07:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDE7479C0;
	Tue, 14 Aug 2012 16:07:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i/OK/lMCDGtCLSHgV9LmMiR1n7Y=; b=M2wVSz
	Xs62pC6r//7bQ3wVzj41zmokF2w13qmNVWU8yRO5W/tW+H0b+E9XNIFKkXvlKeFX
	R9ut5MNG5pcItT3FypkTcNTLGfTBDQSY5OOdy3s1u6YOWtI2Ka1Z7R/8LOAdhcq9
	fpH6A5KU5Nwu0/S6kZDitxeyt3k+oYIybu7zU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K3tN9i8a0Y7awWFNM7azHSVKy2lJM31P
	/eiwbEu0r6eBjK7sjYInPZ1YTHRJp2tLhQKgWOkNUlTLA2rx2yucoUcBVhUbIlEX
	tu4VgB9dmUaI2tcn/UN0dBUFivGSF6R+pBcBL92OkUugYVpvvQ0nYtGbfFdc7auh
	cb/TUULv8Fs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BADB079BF;
	Tue, 14 Aug 2012 16:07:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DC6279BE; Tue, 14 Aug 2012
 16:07:33 -0400 (EDT)
In-Reply-To: <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Tue, 14 Aug 2012 21:13:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF581802-E64B-11E1-92BE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203441>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Enable basic fetching from subversion repositories. When processing remote URLs
> starting with svn::, git invokes this remote-helper.
> It starts svnrdump to extract revisions from the subversion repository in the
> 'dump file format', and converts them to a git-fast-import stream using
> the functions of vcs-svn/.

(nit) the above is a bit too wide, isn't it?

> Imported refs are created in a private namespace at refs/svn/<remote-name/master.

(nit) missing closing '>'?

> The revision history is imported linearly (no branch detection) and completely,
> i.e. from revision 0 to HEAD.
>
> The 'bidi-import' capability is used. The remote-helper expects data from
> fast-import on its stdin. It buffers a batch of 'import' command lines
> in a string_list before starting to process them.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
> diff:
> - incorporate review
> - remove redundant strbuf_init
> - add 'bidi-import' to capabilities
> - buffer all lines of a command batch in string_list
>
>  contrib/svn-fe/remote-svn.c |  183 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100644 contrib/svn-fe/remote-svn.c
>
> diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
> new file mode 100644
> index 0000000..ce59344
> --- /dev/null
> +++ b/contrib/svn-fe/remote-svn.c
> @@ -0,0 +1,183 @@
> +

Remove.

> +#include "cache.h"
> +#include "remote.h"
> +#include "strbuf.h"
> +#include "url.h"
> +#include "exec_cmd.h"
> +#include "run-command.h"
> +#include "svndump.h"
> +#include "notes.h"
> +#include "argv-array.h"
> +
> +static const char *url;
> +static const char *private_ref;
> +static const char *remote_ref = "refs/heads/master";

Just wondering; is this name "master" (or "refs/heads/" for that
matter) significant in any way when talking to a subversion remote?

> +static int cmd_capabilities(const char *line);
> +static int cmd_import(const char *line);
> +static int cmd_list(const char *line);
> +
> +typedef int (*input_command_handler)(const char *);
> +struct input_command_entry {
> +	const char *name;
> +	input_command_handler fct;
> +	unsigned char batchable;	/* whether the command starts or is part of a batch */
> +};
> +
> +static const struct input_command_entry input_command_list[] = {
> +		{ "capabilities", cmd_capabilities, 0 },

One level too deeply indented?

> +		{ "import", cmd_import, 1 },
> +		{ "list", cmd_list, 0 },
> +		{ NULL, NULL }
> +};
> +
> +static int cmd_capabilities(const char *line) {
> +	printf("import\n");
> +	printf("bidi-import\n");
> +	printf("refspec %s:%s\n\n", remote_ref, private_ref);
> +	fflush(stdout);
> +	return 0;
> +}
> +
> +static void terminate_batch(void)
> +{
> +	/* terminate a current batch's fast-import stream */
> +		printf("done\n");

Likewise.

> +		fflush(stdout);
> +}
> +
> +static int cmd_import(const char *line)
> +{
> +	int code;
> +	int dumpin_fd;
> +	unsigned int startrev = 0;
> +	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
> +	struct child_process svndump_proc;
> +
> +	memset(&svndump_proc, 0, sizeof (struct child_process));

Please lose SP between sizeof and '('.

> +	svndump_proc.out = -1;
> +	argv_array_push(&svndump_argv, "svnrdump");
> +	argv_array_push(&svndump_argv, "dump");
> +	argv_array_push(&svndump_argv, url);
> +	argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
> +	svndump_proc.argv = svndump_argv.argv;

(just me making a mental note) We read from "svnrdump", which would
read (if it ever does) from the same stdin as ours and spits (if it
ever does) its errors to the same stderr as ours.

> +
> +	code = start_command(&svndump_proc);
> +	if (code)
> +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> +	dumpin_fd = svndump_proc.out;
> +
> +	code = start_command(&svndump_proc);
> +	if (code)
> +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> +	dumpin_fd = svndump_proc.out;

You start it twice without finishing the first invocation, or just a
double paste?

> +	svndump_init_fd(dumpin_fd, STDIN_FILENO);
> +	svndump_read(url, private_ref);
> +	svndump_deinit();
> +	svndump_reset();
> +
> +	close(dumpin_fd);

(my mental note) And at this point, we finished feeding whatever
comes out of "svnrdump" to svndump_read().

> +	code = finish_command(&svndump_proc);
> +	if (code)
> +		warning("%s, returned %d", svndump_proc.argv[0], code);
> +	argv_array_clear(&svndump_argv);
> +
> +	return 0;

Other than the "twice?" puzzle, this function looks straightforward.

> +}
> +
> +static int cmd_list(const char *line)
> +{
> +	printf("? %s\n\n", remote_ref);
> +	fflush(stdout);
> +	return 0;
> +}
> +
> +static int do_command(struct strbuf *line)
> +{
> +	const struct input_command_entry *p = input_command_list;
> +	static struct string_list batchlines = STRING_LIST_INIT_DUP;
> +	static const struct input_command_entry *batch_cmd;
> +	/*
> +	 * commands can be grouped together in a batch.
> +	 * Batches are ended by \n. If no batch is active the program ends.
> +	 * During a batch all lines are buffered and passed to the handler function
> +	 * when the batch is terminated.
> +	 */
> +	if (line->len == 0) {
> +		if (batch_cmd) {
> +			struct string_list_item *item;
> +			for_each_string_list_item(item, &batchlines)
> +				batch_cmd->fct(item->string);

(style) I think we tend to call these unnamed functions "fn" in our
codebase.

> +			terminate_batch();
> +			batch_cmd = NULL;
> +			string_list_clear(&batchlines, 0);
> +			return 0;	/* end of the batch, continue reading other commands. */
> +		}
> +		return 1;	/* end of command stream, quit */
> +	}
> +	if (batch_cmd) {
> +		if (strcmp(batch_cmd->name, line->buf))
> +			die("Active %s batch interrupted by %s", batch_cmd->name, line->buf);
> +		/* buffer batch lines */
> +		string_list_append(&batchlines, line->buf);
> +		return 0;
> +	}

A "batch-able" command, e.g. "import", will first cause the
batch_cmd to point at the command structure in this function, and
then the next and subsequent lines, as long as the input line is
exactly the same as the current batch_cmd->name, e.g. "import", is
appended into batchlines.

Would this mean that you can feed something like this:

	import foobar
        import
        import
        import

        another command

and buffer the four "import" lines in batchlines, and then on the
empty line, have the for-each-string-list-item loop to call
cmd_import() on "import foobar", "import", "import", then "import"
(literally, without anything other than "import" on the line).

How is that useful?  With that "if (strcmp(batch_cmd->name, line->buf))",
I cannot think of other valid input to make this "batch" mechanism
to trigger and do something useful.  Am I missing something?

> +
> +	for(p = input_command_list; p->name; p++) {

Have a SP between for and '('.

> +		if (!prefixcmp(line->buf, p->name) &&
> +				(strlen(p->name) == line->len || line->buf[strlen(p->name)] == ' ')) {

A line way too wide.

> +			if (p->batchable) {
> +				batch_cmd = p;
> +				string_list_append(&batchlines, line->buf);
> +				return 0;
> +			}
> +			return p->fct(line->buf);
> +		}

OK, so a command word on a line by itself, or a command word
followed by a SP (probably followed by its arguments) on a line
triggers a command lookup, and individual command implementation
parses the line.

> +	}
> +	warning("Unknown command '%s'\n", line->buf);
> +	return 0;

Why isn't this an error?

> +}
> +
> +int main(int argc, const char **argv)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int nongit;
> +	static struct remote *remote;
> +	const char *url_in;
> +
> +	git_extract_argv0_path(argv[0]);
> +	setup_git_directory_gently(&nongit);
> +	if (argc < 2 || argc > 3) {
> +		usage("git-remote-svn <remote-name> [<url>]");
> +		return 1;
> +	}

If this is an importer, you would be importing _into_ a git
repository, no?  How can you not error out when you are not in one?
In other words, why &nongit with *_gently()?

> +	remote = remote_get(argv[1]);
> +	url_in = remote->url[0];
> +	if (argc == 3)
> +		url_in = argv[2];

Shouldn't it be more like this?

	url_in = (argc == 3) ? argv[2] : remote->url[0];

> +	end_url_with_slash(&buf, url_in);
> +	url = strbuf_detach(&buf, NULL);
> +
> +	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
> +	private_ref = strbuf_detach(&buf, NULL);
> +
> +	while(1) {
> +		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
> +			if (ferror(stdin))
> +				die("Error reading command stream");
> +			else
> +				die("Unexpected end of command stream");
> +		}
> +		if (do_command(&buf))
> +			break;
> +		strbuf_reset(&buf);
> +	}
> +
> +	strbuf_release(&buf);
> +	free((void*)url);
> +	free((void*)private_ref);
> +	return 0;
> +}
