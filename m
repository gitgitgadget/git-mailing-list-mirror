From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC v2 01/16] Implement a remote helper for svn in C.
Date: Tue, 31 Jul 2012 21:26:07 +0200
Message-ID: <1833407.nyI8OqIN5e@flomedio>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com> <7va9yhrz6c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:26:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwI5D-0002kO-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 21:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab2GaT0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 15:26:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53213 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab2GaT0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 15:26:12 -0400
Received: by bkwj10 with SMTP id j10so3446996bkw.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=QmXPWRoQe+gW3SxMHEB5hoFtr7lYmij8swOgT4ngRr8=;
        b=QpQhl7SBGMfGYhJ7t95hHcoOaOC/8SFTa05OjthJWRKu+xh35TWFSGmPc9YoZoi1ky
         jxZQTCaKIiS+fH8gQLCyf+KY3IRzdCVqz8+HYM404lrc4svkDXeV093ZyTzuV6FL6Vez
         caL2pauQbagIZVzZCCM7Ko4iW4SbXFcpy6SlgR5Z/fQtOArt/lwtq3TiZx8SKajf1kwi
         88ypYEcIRYQoQP4nmla3jO33QuBjQDEWqV0m6u4/OeUKMBMiQH8yiBHiqWfRuloiwxqA
         KVBryOFlkT+yLvGNMCNSRbzArqoUMZQpQrnbgbzllbKNJnqNiz/3+jOgWSr8OB8YQd6v
         eTBg==
Received: by 10.204.130.10 with SMTP id q10mr5736310bks.90.1343762770874;
        Tue, 31 Jul 2012 12:26:10 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id 25sm602065bkx.9.2012.07.31.12.26.08
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 12:26:09 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7va9yhrz6c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202673>

On Monday 30 July 2012 09:28:27 Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> > Enables basic fetching from subversion repositories. When processing
> > Remote URLs starting with svn::, git invokes this remote-helper.
> > It starts svnrdump to extract revisions from the subversion repository in
> > the 'dump file format', and converts them to a git-fast-import stream
> > using the functions of vcs-svn/.
> > 
> > Imported refs are created in a private namespace at
> > refs/svn/<remote-name/master. The revision history is imported linearly
> > (no branch detection) and completely, i.e. from revision 0 to HEAD.
> > 
> > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > ---
> > 
> >  contrib/svn-fe/remote-svn.c |  190
> >  +++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 190
> >  insertions(+)
> >  create mode 100644 contrib/svn-fe/remote-svn.c
> > 
> > diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
> > new file mode 100644
> > index 0000000..d5c2df8
> > --- /dev/null
> > +++ b/contrib/svn-fe/remote-svn.c
> > @@ -0,0 +1,190 @@
> > +
> > +#include "cache.h"
> > +#include "remote.h"
> > +#include "strbuf.h"
> > +#include "url.h"
> > +#include "exec_cmd.h"
> > +#include "run-command.h"
> > +#include "svndump.h"
> > +#include "argv-array.h"
> > +
> > +static const char *url;
> > +static const char *private_ref;
> > +static const char *remote_ref = "refs/heads/master";
> > +
> > +int cmd_capabilities(struct strbuf *line);
> > +int cmd_import(struct strbuf *line);
> > +int cmd_list(struct strbuf *line);
> 
> How many of these and other symbols are necessary to be visible
> outside this file?

Will check and make them static.

> 
> > +typedef int (*input_command_handler)(struct strbuf *);
> > +struct input_command_entry {
> > +	const char *name;
> > +	input_command_handler fct;
> > +	unsigned char batchable;	/* whether the command starts or is part of a
> > batch */ +};
> > +
> > +static const struct input_command_entry input_command_list[] = {
> > +		{ "capabilities", cmd_capabilities, 0 },
> > +		{ "import", cmd_import, 1 },
> > +		{ "list", cmd_list, 0 },
> > +		{ NULL, NULL }
> > +};
> > +
> > +int cmd_capabilities(struct strbuf *line)
> > +{
> > +	printf("import\n");
> > +	printf("refspec %s:%s\n\n", remote_ref, private_ref);
> > +	fflush(stdout);
> > +	return 0;
> > +}
> > +
> > +static void terminate_batch() {
> > +	/* terminate a current batch's fast-import stream */
> 
> Style:
> 
> 	static void terminate_batch(void)
> 	{
> 		/* terminate ...
> 

Ok. Opening braces in new lines, right? But inside functions it's ok to have 
them on the same line?

> > +		printf("done\n");
> > +		fflush(stdout);
> > +}
> > +
> > +int cmd_import(struct strbuf *line)
> > +{
> > +	int code, report_fd;
> > +	char *back_pipe_env;
> > +	int dumpin_fd;
> > +	unsigned int startrev = 0;
> > +	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
> > +	struct child_process svndump_proc;
> > +
> > +	/*
> > +	 * When the remote-helper is invoked by transport-helper.c it passes 
the
> > +	 * filename of this pipe in the env-var.
> > +	 */
> 
> s/ it passes/, &/;
> 
> > +	back_pipe_env = getenv("GIT_REPORT_FIFO");
> 
> Can we name "back pipe", "report fifo" and "report fd" more
> consistently and descriptively?
> 
> What kind of "REPORT" are we talking about here?  Is it to carry the
> contents of

This topic (pipe vs. fifo) is still under discussion with Jonathan. I called it 
REPORT, because that was the name of it in vcs-svn. That will change.

> 
> > +	if (!back_pipe_env) {
> > +		die("Cannot get cat-blob-pipe from environment! GIT_REPORT_FIFO has 
to"
> > +				"be set by the caller.");
> > +	}
> 
> Style: unnecesary {} block around a simple statement.  It is OK to
> have such a block early in a series if you add more statements to it
> in later steps, but that does not seem to be the case for this patch
> series.

ack.

> 
> > +	/*
> > +	 * Opening a fifo for reading usually blocks until a writer has opened
> > it too. +	 * Opening a fifo for writing usually blocks until a reader has
> > opened it too. +	 * Therefore, we open with RDWR on both sides to avoid
> > deadlocks. +	 * Especially if there's nothing to do and one pipe end is
> > closed immediately. +	 */
> 
> This smells somewhat fishy "justification".  Are we reading what we
> wrote to the fifo?  Who is expected to come at the other end of the
> fifo?  Is it this process that creates that other process?  Perhaps
> you should open it _after_ spawning the process, telling it to open
> the same fifo for writing (if you are sitting on the reading end)?

Of course, it's a workaround. The fifo is from fast-import to the remote-
helper. I explained the deadlocks that can occur in a mail some days ago. 
Pasted:

"
I believe it can be solved using RDONLY and WRONLY too. Probably we solve it 
by not using the fifo at all.
Currently the blocking comes from the fact, that fast-import doesn't parse 
it's command line at startup. It rather reads an input line first and decides 
whether to parse the argv after reading the first input line or at the end of 
the input. (don't know why)
remote-svn opens the pipe before sending the first command to fast-import and 
blocks on the open, while fast-import waits for input --> deadlock.
with remote-svn: RDWR, fast-import: WRONLY, this works.

Other scenario: Nothing to import, remote-svn only sends 'done' and closes the 
pipe again. After fast-import reads the first line it parses it's command line 
and tries to open the fifo which is already closed on the other side --> 
blocks.
This is solved by using RDWR on both sides.

If we change the points where the pipes are openend and closed, this could be 
circumvented.
"

see http://thread.gmane.org/gmane.comp.version-control.git/199159/focus=202272

> 
> > +	report_fd = open(back_pipe_env, O_RDWR);
> > +	if (report_fd < 0) {
> > +		die("Unable to open fast-import back-pipe! %s", strerror(errno));
> > +	}
> 
> Style: (ditto).
> 
> > +int cmd_list(struct strbuf *line)
> > +{
> > +	printf("? HEAD\n");
> > +	printf("? %s\n\n", remote_ref);
> > +	fflush(stdout);
> > +	return 0;
> > +}
> 
> It somehow feels funny that remote_ref (which seems to be hardcoded
> to "refs/heads/master") and HEAD are listed here, even though the
> other side is not even in the Git land and the name "master" does
> not have any significance.  The name "refs/heads/master" may be
> necessary to form the LHS of the refspec in cmd_capabilities(), but
> it somehow feels more natural to only advertise HEAD here and also
> futz the refspec to printf("refspec HEAD:%s", private_ref) in
> cmd_capabilities().  Perhaps you tried it already and it did not
> work for some reason; I dunno.

Using HEAD as remote_ref, i.e. here (only once) and in the refspec doesn't 
work. Git doesn't import anything then. Using only refs/heads/master works.
So I will drop that hardcoded 'HEAD' here.

> 
> > +int do_command(struct strbuf *line)
> > +{
> > +	const struct input_command_entry *p = input_command_list;
> > +	static int batch_active;
> > +	static struct strbuf batch_command = STRBUF_INIT;
> > +	/*
> > +	 * import commands can be grouped together in a batch.
> > +	 * Batches are ended by \n. If no batch is active the program ends.
> > +	 */
> > +	if (line->len == 0 ) {
> 
> Style: lose the SP before closing parenthesis ")".

ack.
> 
> > +		if (batch_active) {
> > +			terminate_batch();
> > +			batch_active = 0;
> > +			return 0;
> > +		}
> 
> Is it an error to feed an empty line when batch is not active?
> How is the error diagnosed?
> Is the user told about the error, and if so how?

An empty line outside a batch terminates the remote-helper, this signals the 
end of the command stream (according to  the specs).
Return 1 makes the main loop break.
Will add a commment.

> 
> > +		return 1;
> > +	}
> > +	if (batch_active && strcmp(batch_command.buf, line->buf))
> > +		die("Active %s batch interrupted by %s", batch_command.buf, line-
>buf);
> 
> So after issuing "import" that causes batch_active to become true,
> another command e.g. "list" cannot be issued and will result in this
> die() unless the batch is concluded by issuing an empty line.  Can
> an "import" be issued while another "import" batch is in effect?

Hm, as far as i understand it, there is no way how an import can be in a 
different import batch. Because the batch is just a continuous sequence of 
import commands.

> 
> > +	for(p = input_command_list; p->name; p++) {
> > +		if (!prefixcmp(line->buf, p->name) &&
> > +				(strlen(p->name) == line->len || line->buf[strlen(p->name)] 
== ' '))
> > {
> > +			if (p->batchable) {
> > +				batch_active = 1;
> > +				strbuf_release(&batch_command);
> > +				strbuf_addbuf(&batch_command, line);
> 
> Wouldn't it make more sense to get rid of batch_active variable and
> use the presense of batch_command as the signal for the batch in
> effect?  Your "if (batch_active)" becomes "if (batch_command.len)",
> and "batch_active = 0" becomes "strbuf_release(&batch_command)".
> 

Yes, makes more sense.

> > +			}
> > +			return p->fct(line);
> > +		}
> > +	}
> > +	warning("Unknown command '%s'\n", line->buf);
> > +	return 0;
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
> > +
> > +	remote = remote_get(argv[1]);
> > +	url_in = remote->url[0];
> > +	if (argc == 3)
> > +		url_in = argv[2];
> > +
> > +	end_url_with_slash(&buf, url_in);
> > +	url = strbuf_detach(&buf, NULL);
> > +
> > +	strbuf_init(&buf, 0);
> > +	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
> > +	private_ref = strbuf_detach(&buf, NULL);
> > +
> > +	while(1) {
> > +		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
> > +			if (ferror(stdin))
> > +				die_errno("Error reading command stream");
> > +			else
> > +				die_errno("Unexpected end of command stream");
> 
> On the else clause, ferror() did not say there was an error.  What
> errno do we see from die_errno() in that case?

Checked the manpage of ferror: 
"These  functions  should  not fail and do not set the external variable 
errno."
So it doesn't make sense for both, I think.

> 
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
