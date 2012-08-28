From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 01/16] Implement a remote helper for svn in C
Date: Tue, 28 Aug 2012 10:08:17 -0700
Message-ID: <7v7gsi3nec.fsf@alter.siamese.dyndns.org>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:03:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Q87-0003i1-AM
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab2H1SC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:02:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2H1SCy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:02:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D48E59212;
	Tue, 28 Aug 2012 14:02:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=q3OObKeUTk5cwiZ9YH4TCdgxE/0=; b=LzOB8bZT+Y3oRZ8ASIG9
	DXs+2H+fZIDok2VK99JkeRHM/8MOg93/hsKhBIbWCtCoxb88HLbIDajFU6dk1lB4
	hyOwCRm6eHFFGrlk/6uppFEuQFFV95hBe1hsnzpyaqLQ487o9yj0oKWC2TIfSaj3
	phDGhOK1lc9E5Bvne+RbJCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=FybrpTmUe3ZVm8TPqUFasGdct/sERqTKGNFrEQvfSrZTdD
	xHNyN+U1XBx0g6kKt1h/7CZ+V7Q58d4NLjAZcUp9xjMn505WPmsxJaJ0bMnRa+zi
	2q3Xaxf62LBmMFOuPm7o0nlWlre1biJ1qVRd1o5ShgJz7CQjkCo+i9zZEhQ/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C19969211;
	Tue, 28 Aug 2012 14:02:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2C72920E; Tue, 28 Aug 2012
 14:02:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9636796E-F13A-11E1-9C60-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204439>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> Enable basic fetching from subversion repositories. When processing
> remote URLs starting with testsvn::, git invokes this remote-helper.
> It starts svnrdump to extract revisions from the subversion repository
> in the 'dump file format', and converts them to a git-fast-import stream
> using the functions of vcs-svn/.
>
> Imported refs are created in a private namespace at
> refs/svn/<remote-name>/master.  The revision history is imported
> linearly (no branch detection) and completely, i.e. from revision 0 to
> HEAD.
>
> The 'bidi-import' capability is used. The remote-helper expects data
> from fast-import on its stdin. It buffers a batch of 'import' command
> lines in a string_list before starting to process them.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  remote-testsvn.c |  174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 174 insertions(+)
>  create mode 100644 remote-testsvn.c
>
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> new file mode 100644
> index 0000000..ebe803b
> --- /dev/null
> +++ b/remote-testsvn.c
> @@ -0,0 +1,174 @@
> +#include "cache.h"
> +#include "remote.h"
> +#include "strbuf.h"
> +#include "url.h"
> +#include "exec_cmd.h"
> +#include "run-command.h"
> +#include "vcs-svn/svndump.h"
> +#include "notes.h"
> +#include "argv-array.h"
> +
> +static const char *url;
> +static const char *private_ref;
> +static const char *remote_ref = "refs/heads/master";
> +
> +static int cmd_capabilities(const char *line);
> +static int cmd_import(const char *line);
> +static int cmd_list(const char *line);
> +
> +typedef int (*input_command_handler)(const char *);
> +struct input_command_entry {
> +	const char *name;
> +	input_command_handler fn;
> +	unsigned char batchable;	/* whether the command starts or is part of a batch */
> +};
> +
> +static const struct input_command_entry input_command_list[] = {
> +	{ "capabilities", cmd_capabilities, 0 },
> +	{ "import", cmd_import, 1 },
> +	{ "list", cmd_list, 0 },
> +	{ NULL, NULL }
> +};
> +
> +static int cmd_capabilities(const char *line) {

Style:

	static int cmd_capabilities(const char *line)
        {

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
> +	printf("done\n");
> +	fflush(stdout);
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
> +	memset(&svndump_proc, 0, sizeof(struct child_process));
> +	svndump_proc.out = -1;
> +	argv_array_push(&svndump_argv, "svnrdump");
> +	argv_array_push(&svndump_argv, "dump");
> +	argv_array_push(&svndump_argv, url);
> +	argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
> +	svndump_proc.argv = svndump_argv.argv;
> +
> +	code = start_command(&svndump_proc);
> +	if (code)
> +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> +	dumpin_fd = svndump_proc.out;
> +
> +	svndump_init_fd(dumpin_fd, STDIN_FILENO);
> +	svndump_read(url, private_ref);
> +	svndump_deinit();
> +	svndump_reset();
> +
> +	close(dumpin_fd);
> +	code = finish_command(&svndump_proc);
> +	if (code)
> +		warning("%s, returned %d", svndump_proc.argv[0], code);
> +	argv_array_clear(&svndump_argv);
> +
> +	return 0;
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
> +				batch_cmd->fn(item->string);
> +			terminate_batch();
> +			batch_cmd = NULL;
> +			string_list_clear(&batchlines, 0);
> +			return 0;	/* end of the batch, continue reading other commands. */
> +		}
> +		return 1;	/* end of command stream, quit */
> +	}
> +	if (batch_cmd) {
> +		if (prefixcmp(batch_cmd->name, line->buf))
> +			die("Active %s batch interrupted by %s", batch_cmd->name, line->buf);
> +		/* buffer batch lines */
> +		string_list_append(&batchlines, line->buf);
> +		return 0;
> +	}
> +
> +	for (p = input_command_list; p->name; p++) {
> +		if (!prefixcmp(line->buf, p->name) && (strlen(p->name) == line->len ||
> +				line->buf[strlen(p->name)] == ' ')) {
> +			if (p->batchable) {
> +				batch_cmd = p;
> +				string_list_append(&batchlines, line->buf);
> +				return 0;
> +			}
> +			return p->fn(line->buf);
> +		}
> +	}
> +	die("Unknown command '%s'\n", line->buf);
> +	return 0;
> +}
> +
> +int main(int argc, const char **argv)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	static struct remote *remote;
> +	const char *url_in;
> +
> +	git_extract_argv0_path(argv[0]);
> +	setup_git_directory();
> +	if (argc < 2 || argc > 3) {
> +		usage("git-remote-svn <remote-name> [<url>]");
> +		return 1;
> +	}
> +
> +	remote = remote_get(argv[1]);
> +	url_in = (argc == 3) ? argv[2] : remote->url[0];
> +
> +	end_url_with_slash(&buf, url_in);
> +	url = strbuf_detach(&buf, NULL);
> +
> +	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
> +	private_ref = strbuf_detach(&buf, NULL);
> +
> +	while(1) {

Style:

	while (1) {

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

Style:

	free((void *)url);
	free((void *)private_ref);

[PATCH 12/16] adds another instance of this.

Having said that, it might be cleaner to prepare two strbuf
dedicated for these variables, borrow url and private_ref out of
them while they are used as the program level globals, and use
strbuf_release() at the end.

> +	return 0;
> +}
