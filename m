From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 26 Jul 2012 10:31:57 +0200
Message-ID: <44779150.xA3SZNmQ1h@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <23122876.7xH9dZiP4M@flobuntu> <20120702110741.GA3527@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 10:32:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuJUa-0004de-2h
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 10:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab2GZIcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 04:32:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49820 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab2GZIcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 04:32:05 -0400
Received: by bkwj10 with SMTP id j10so1098921bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=KdSJl5AhnSvfGqrgpaFXDl5hCMpBzWilDry4uea0BG0=;
        b=Vf2QlJsIXrowmYfqNWXeRh7U9tay5zFpjvIGMV0dY709rmbHiQ078LeNtZ4tL8i3a4
         JFXnWDsSty5as7PuWK6uwpLQs3ajxeeonN+JMiMp32yQBMHUSfeozOc6VmTRPDpySm8d
         CY22e5Rb+XWWM4Rt8+KZOzoR1cXObcDlvrgY906Pf8XCtamsUKE0eSi5SzGLzXdHEZiI
         s+1wftRJXxBPuJECplPX5qvLZA2r8BYYzAH9v307efpD20XWq+5GfYCDWcxlTQXi4luT
         kJn5zpTl2vYjFz+vawB2LOxScJFOH36t/nZPqs9JPbNfNY3GyVsICwsRPot6hUGf8XN+
         UerQ==
Received: by 10.204.13.82 with SMTP id b18mr13636153bka.118.1343291524113;
        Thu, 26 Jul 2012 01:32:04 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id y20sm13976985bkv.11.2012.07.26.01.31.58
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 01:32:00 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120702110741.GA3527@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202250>

Hi!

Most of this review went into the new version.. 
For the remaining points, some comments follow.

On Monday 02 July 2012 06:07:41 Jonathan Nieder wrote:
> Hi,
> 
> Florian Achleitner wrote:

> 
> > --- /dev/null
> > +++ b/contrib/svn-fe/remote-svn.c
> > @@ -0,0 +1,207 @@
> > +
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <stdio.h>
> 
> git-compat-util.h (or some header that includes it) must be the first
> header included so the appropriate feature test macros can be defined.
> See Documentation/CodingGuidelines for more on that.

check.

> 
> > +#include "cache.h"
> > +#include "remote.h"
> > +#include "strbuf.h"
> > +#include "url.h"
> > +#include "exec_cmd.h"
> > +#include "run-command.h"
> > +#include "svndump.h"
> > +
> > +static int debug = 0;
> 
> Small nit: please drop the redundant "= 0" here.  Or:

check.

> > +
> > +static inline void printd(const char* fmt, ...)
> > +{
> > +	if(debug) {
> > +		va_list vargs;
> > +		va_start(vargs, fmt);
> > +		fprintf(stderr, "rhsvn debug: ");
> > +		vfprintf(stderr, fmt, vargs);
> > +		fprintf(stderr, "\n");
> > +		va_end(vargs);
> > +	}
> > +}
> 
> Why not use trace_printf and avoid the complication?

Hm.. I tried. It wasn't exactly what I wanted. When I use trace_printf, it's 
activated together with all other traces. I can use trace_vprintf and specify 
a key, but I would always have to print the header "rhsvn debug: " and the key 
by hand. So I could replace vfprintf in this function by trace_vprintf to do 
that. But then there's not much simplification. (?)


> > +
> > +enum cmd_result cmd_capabilities(struct strbuf* line);
> > +enum cmd_result cmd_import(struct strbuf* line);
> > +enum cmd_result cmd_list(struct strbuf* line);
> 
> What's a cmd_result?  '*' sticks to variable name.
> 
> > +
> > +enum cmd_result { SUCCESS, NOT_HANDLED, ERROR };
> 
> Oh, that's what a cmd_result is. :)  Why not define the type before
> using it to avoid keeping the reader in suspense?
> 
> What does each result represent?  If this is a convention like
> 
>  1: handled
>  0: not handled
>  -1: error, callee takes care of printing the error message
> 
> then please document it in a comment near the caller so the reader can
> understand what is happening without too much confusion.  Given such a
> comment, does the enum add clarity?

Hm.. the enum now has SUCCESS, NOT_HANDLED, TERMINATE.
It gives the numbers a name, thats it.

> 
> > +typedef enum cmd_result (*command)(struct strbuf*);
> 
> When I first read this, I wonder what is being commanded.  Are these
> commands passed on the remote helper's standard input, commands passed
> on its output, or commands run at some point in the process?  What is
> the effect and return value of associated function?  Does the function
> always return some success/failure value, or does it sometimes exit?
> 
> Maybe a more specific type name would be clearer?

I renamed it to input_command_handler. Unfortunately the remote-helper spec 
calls what is sent to the helper a 'command'.

> 
> [...]
> 
> > +
> > +const command command_list[] = {
> > +		cmd_capabilities, cmd_import, cmd_list, NULL
> > +};
> 
> First association is to functions like cmd_fetch() which implement git
> subcommands.  So I thought these were going to implement subcommands
> like "git remote-svn capabilities", "git remote-svn import" and would
> use the same cmd_foo(argc, argv, prefix) calling convention that git
> subcommands do.  Maybe a different naming convention could avoid
> confusion.

Ok.. same as above, they are kind of commands. Of course I can change the 
names. For me it's not too confusing, because I don't know the git subcommands 
convention very well. You can choose a name.

> 
> [...]
> 
> > +enum cmd_result cmd_capabilities(struct strbuf* line)
> > +{
> > +	if(strcmp(line->buf, "capabilities"))
> > +		return NOT_HANDLED;
> 
> Style: missing SP after keyword.
> 
> > +
> > +	printf("import\n");
> > +	printf("\n");
> > +	fflush(stdout);
> > +	return SUCCESS;
> > +}
> 
> Why the multiple printf?  Is the flush needed?

Excess printf gone.
Flush is needed. Otherwise it doesn't flush and the other end waits forever.
Don't know exactly why. Some pipe-buffer ..

> > +
> > +	/* opening a fifo for usually reading blocks until a writer has opened
> > it too. +	 * Therefore, we open with RDWR.
> > +	 */
> > +	report_fd = open(back_pipe_env, O_RDWR);
> > +	if(report_fd < 0) {
> > +		die("Unable to open fast-import back-pipe! %s", strerror(errno));
> > +	}
> 
> Is this necessary?  Why shouldn't we fork the writer first and wait
> for it here?

Yes, necessary. Blocking on this open call prevents fast-import as well as the 
remote helper from reading and writing on their normal command streams.
This leads to deadlocks.

E.g. If there's have nothing to import, the helper sends only 'done' to fast-
import and quits. That might happen before fast-import opened this pipe.
Then it waits forever because the reader has already closed it.


> > +
> > +	code = start_command(&svndump_proc);
> > +	if(code)
> > +		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> 
> start_command() is supposed to have printed a message already when it
> fails, unless errno == ENOENT and silent_exec_failure was set.
> 

Yes, but it doesn't die, right?

> > +
> > +	close(svndump_proc.out);
> 
> Important?  Wouldn't finish_command do this?
> 

As far as I understood it, it doesn't close extra created pipes. Probably I 
just didn't find it in the code ..

> > +	close(report_fd);
> 
> What is the purpose of this step?

Close the back-report pipe end of the remote-helper.

> 
> > +
> > +	code = finish_command(&svndump_proc);
> > +	if(code)
> > +		warning("Something went wrong with termination of %s, code %d",
> > svndump_proc.argv[0], code);
> finish_command() is supposed to print a message when it fails.

I changed the message text. It should tell us if svnrdump exited with non-
zero.

> 
> > +	free(svndump_proc.argv);
> > +
> > +	printf("done\n");
> > +	return SUCCESS;
> 
> Success even if it failed?

On fatal errors it dies.

> > +enum cmd_result do_command(struct strbuf* line)
> > +{
> > +	const command* p = command_list;
> > +	enum cmd_result ret;
> > +	printd("command line '%s'", line->buf);
> > +	while(*p) {
> > +		ret = (*p)(line);
> > +		if(ret != NOT_HANDLED)
> > +			return ret;
> > +		p++;
> > +	}
> 
> If possible, matching commands by name (like git.c does) would make
> the behavior easier to predict.
> 

There is some usecase for this. The intention was, that command handlers 
should be able to process more than one 'name'. E.g. an import batch is 
terminated by a newline. This newline is handled by the import handler if it 
is a batch. (This feature wasn't implemented in the version reviewed here.)

So I decided to let the handler functions tell if they handle this line.

> [...]
> 
> > +	if (argc < 2) {
> > +		fprintf(stderr, "Remote needed\n");
> > +		return 1;
> > +	}
> 
> usage() can be used to write a clearer error message.

> [...]
> 
> > +	free((void*)url);
> > +	free((void*)private_refs);
> 
> Won't this crash?

Crash? It frees detached strbuf buffers.

> 
> It would also be nice to add a test case to the t/ directory to make others
> changing this code do not accidentally break your new functionality.

check.

> 
> Hope that helps,
> Jonathan

It helped ;)

thx, Florian
