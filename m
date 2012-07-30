From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2 01/16] Implement a remote helper for svn in C.
Date: Mon, 30 Jul 2012 09:28:27 -0700
Message-ID: <7va9yhrz6c.fsf@alter.siamese.dyndns.org>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:28:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svspv-0007sv-Ii
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab2G3Q2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 12:28:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299Ab2G3Q2b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:28:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C44ED8A2B;
	Mon, 30 Jul 2012 12:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YqVRxAWMb48yN8zUNE4YiKMG/s0=; b=lpJ4+e
	EghSs4WcTzyC4sfLY7wwqLK9tU5ztrdl6oqacjSO/qc2ZPc5bioIDISpIuVWS/SI
	cVf5sfHgTXqDDVpVw0pfLkz5t6nZ7vxVYpjV9jS0sRc6oKqeeSWjiWKTcHwk1Mx3
	TakilhRqbh8TJB7/T/VBlf0WM1NObSYCAj9mU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HeOa9Yy175YCIjsQlvySY+WGDTcuyFFd
	fWeZuUBrub9GRZ7OeXqsk50k7llMFN9zh8JrmYdi0y7fEA8obCWyWdmv3HywaJCa
	fZQbnt9zWWBmlTItGtrj4kDZLqsRjGOTvhKbNe7G34tDaVRCvf6hlEBqlogiYTYK
	GV7srLjbAjg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0E208A2A;
	Mon, 30 Jul 2012 12:28:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D20A8A28; Mon, 30 Jul 2012
 12:28:29 -0400 (EDT)
In-Reply-To: <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 (Florian Achleitner's message of "Mon, 30 Jul 2012 16:31:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98AC1F66-DA63-11E1-81E4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202572>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Enables basic fetching from subversion repositories. When processing Remote URLs
> starting with svn::, git invokes this remote-helper.
> It starts svnrdump to extract revisions from the subversion repository in the
> 'dump file format', and converts them to a git-fast-import stream using
> the functions of vcs-svn/.
>
> Imported refs are created in a private namespace at refs/svn/<remote-name/master.
> The revision history is imported linearly (no branch detection) and completely,
> i.e. from revision 0 to HEAD.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  contrib/svn-fe/remote-svn.c |  190 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 contrib/svn-fe/remote-svn.c
>
> diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
> new file mode 100644
> index 0000000..d5c2df8
> --- /dev/null
> +++ b/contrib/svn-fe/remote-svn.c
> @@ -0,0 +1,190 @@
> +
> +#include "cache.h"
> +#include "remote.h"
> +#include "strbuf.h"
> +#include "url.h"
> +#include "exec_cmd.h"
> +#include "run-command.h"
> +#include "svndump.h"
> +#include "argv-array.h"
> +
> +static const char *url;
> +static const char *private_ref;
> +static const char *remote_ref = "refs/heads/master";
> +
> +int cmd_capabilities(struct strbuf *line);
> +int cmd_import(struct strbuf *line);
> +int cmd_list(struct strbuf *line);

How many of these and other symbols are necessary to be visible
outside this file?

> +typedef int (*input_command_handler)(struct strbuf *);
> +struct input_command_entry {
> +	const char *name;
> +	input_command_handler fct;
> +	unsigned char batchable;	/* whether the command starts or is part of a batch */
> +};
> +
> +static const struct input_command_entry input_command_list[] = {
> +		{ "capabilities", cmd_capabilities, 0 },
> +		{ "import", cmd_import, 1 },
> +		{ "list", cmd_list, 0 },
> +		{ NULL, NULL }
> +};
> +
> +int cmd_capabilities(struct strbuf *line)
> +{
> +	printf("import\n");
> +	printf("refspec %s:%s\n\n", remote_ref, private_ref);
> +	fflush(stdout);
> +	return 0;
> +}
> +
> +static void terminate_batch() {
> +	/* terminate a current batch's fast-import stream */

Style:

	static void terminate_batch(void)
	{
		/* terminate ...

> +		printf("done\n");
> +		fflush(stdout);
> +}
> +
> +int cmd_import(struct strbuf *line)
> +{
> +	int code, report_fd;
> +	char *back_pipe_env;
> +	int dumpin_fd;
> +	unsigned int startrev = 0;
> +	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
> +	struct child_process svndump_proc;
> +
> +	/*
> +	 * When the remote-helper is invoked by transport-helper.c it passes the
> +	 * filename of this pipe in the env-var.
> +	 */

s/ it passes/, &/;

> +	back_pipe_env = getenv("GIT_REPORT_FIFO");

Can we name "back pipe", "report fifo" and "report fd" more
consistently and descriptively?

What kind of "REPORT" are we talking about here?  Is it to carry the
contents of 

> +	if (!back_pipe_env) {
> +		die("Cannot get cat-blob-pipe from environment! GIT_REPORT_FIFO has to"
> +				"be set by the caller.");
> +	}

Style: unnecesary {} block around a simple statement.  It is OK to
have such a block early in a series if you add more statements to it
in later steps, but that does not seem to be the case for this patch
series.

> +	/*
> +	 * Opening a fifo for reading usually blocks until a writer has opened it too.
> +	 * Opening a fifo for writing usually blocks until a reader has opened it too.
> +	 * Therefore, we open with RDWR on both sides to avoid deadlocks.
> +	 * Especially if there's nothing to do and one pipe end is closed immediately.
> +	 */

This smells somewhat fishy "justification".  Are we reading what we
wrote to the fifo?  Who is expected to come at the other end of the
fifo?  Is it this process that creates that other process?  Perhaps
you should open it _after_ spawning the process, telling it to open
the same fifo for writing (if you are sitting on the reading end)?

> +	report_fd = open(back_pipe_env, O_RDWR);
> +	if (report_fd < 0) {
> +		die("Unable to open fast-import back-pipe! %s", strerror(errno));
> +	}

Style: (ditto).

> +int cmd_list(struct strbuf *line)
> +{
> +	printf("? HEAD\n");
> +	printf("? %s\n\n", remote_ref);
> +	fflush(stdout);
> +	return 0;
> +}

It somehow feels funny that remote_ref (which seems to be hardcoded
to "refs/heads/master") and HEAD are listed here, even though the
other side is not even in the Git land and the name "master" does
not have any significance.  The name "refs/heads/master" may be
necessary to form the LHS of the refspec in cmd_capabilities(), but
it somehow feels more natural to only advertise HEAD here and also
futz the refspec to printf("refspec HEAD:%s", private_ref) in
cmd_capabilities().  Perhaps you tried it already and it did not
work for some reason; I dunno.

> +int do_command(struct strbuf *line)
> +{
> +	const struct input_command_entry *p = input_command_list;
> +	static int batch_active;
> +	static struct strbuf batch_command = STRBUF_INIT;
> +	/*
> +	 * import commands can be grouped together in a batch.
> +	 * Batches are ended by \n. If no batch is active the program ends.
> +	 */
> +	if (line->len == 0 ) {

Style: lose the SP before closing parenthesis ")".

> +		if (batch_active) {
> +			terminate_batch();
> +			batch_active = 0;
> +			return 0;
> +		}

Is it an error to feed an empty line when batch is not active?
How is the error diagnosed?
Is the user told about the error, and if so how?

> +		return 1;
> +	}
> +	if (batch_active && strcmp(batch_command.buf, line->buf))
> +		die("Active %s batch interrupted by %s", batch_command.buf, line->buf);

So after issuing "import" that causes batch_active to become true,
another command e.g. "list" cannot be issued and will result in this
die() unless the batch is concluded by issuing an empty line.  Can
an "import" be issued while another "import" batch is in effect?

> +	for(p = input_command_list; p->name; p++) {
> +		if (!prefixcmp(line->buf, p->name) &&
> +				(strlen(p->name) == line->len || line->buf[strlen(p->name)] == ' ')) {
> +			if (p->batchable) {
> +				batch_active = 1;
> +				strbuf_release(&batch_command);
> +				strbuf_addbuf(&batch_command, line);

Wouldn't it make more sense to get rid of batch_active variable and
use the presense of batch_command as the signal for the batch in
effect?  Your "if (batch_active)" becomes "if (batch_command.len)",
and "batch_active = 0" becomes "strbuf_release(&batch_command)".

> +			}
> +			return p->fct(line);
> +		}
> +	}
> +	warning("Unknown command '%s'\n", line->buf);
> +	return 0;
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
> +
> +	remote = remote_get(argv[1]);
> +	url_in = remote->url[0];
> +	if (argc == 3)
> +		url_in = argv[2];
> +
> +	end_url_with_slash(&buf, url_in);
> +	url = strbuf_detach(&buf, NULL);
> +
> +	strbuf_init(&buf, 0);
> +	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
> +	private_ref = strbuf_detach(&buf, NULL);
> +
> +	while(1) {
> +		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
> +			if (ferror(stdin))
> +				die_errno("Error reading command stream");
> +			else
> +				die_errno("Unexpected end of command stream");

On the else clause, ferror() did not say there was an error.  What
errno do we see from die_errno() in that case?

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
