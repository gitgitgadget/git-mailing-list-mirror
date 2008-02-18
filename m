From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Technical documentation of the run-command API
Date: Sun, 17 Feb 2008 18:25:08 -0800
Message-ID: <7vir0nvw57.fsf@gitster.siamese.dyndns.org>
References: <1203280783.47b89b8f11891@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:26:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQviC-0003TX-Ht
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 03:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbYBRCZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 21:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbYBRCZz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 21:25:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbYBRCZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 21:25:54 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 681066852;
	Sun, 17 Feb 2008 21:25:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 58FA26850; Sun, 17 Feb 2008 21:25:46 -0500 (EST)
In-Reply-To: <1203280783.47b89b8f11891@webmail.nextra.at> (Johannes Sixt's
 message of "Sun, 17 Feb 2008 21:39:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74219>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>
> This is the first time I post via my webmail client, so I can't
> properly followup to our earlier discussion, and it'll probably be
> whitespace damaged :( But it's meant to collect feedback.

Actually it came out quite fine, and more importantly, the
content is quite clearly written.

It would have been clearer that the patch cleared all the stub
text and rewrote the real contents for the first time, if it was
formatted with -B, though.

> Also, I'm asciidoc challenged...

That's Ok.  We can work out formatting details later.

>  Documentation/technical/api-run-command.txt |  169 +++++++++++++++++++++++++--
>  1 files changed, 159 insertions(+), 10 deletions(-)
>  rewrite Documentation/technical/api-run-command.txt (82%)
> 
> diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
> dissimilarity index 82%
> index 19d2f64..0ef50bf 100644
> --- a/Documentation/technical/api-run-command.txt
> +++ b/Documentation/technical/api-run-command.txt
> @@ -1,10 +1,159 @@
> -run-command API
> -===============
> -
> -Talk about <run-command.h>, and things like:
> -
> -* Environment the command runs with (e.g. GIT_DIR);
> -* File descriptors and pipes;
> -* Exit status;
> -
> -(Hannes, Dscho, Shawn)
> +run-command API
> +===============
> +
> +The run-command API offers a versatile tool to run sub-processes with
> +redirected input and output as well as with a modified environment
> +and an alternate current directory.
> +
> +A similar API offers the capability to run a function asynchronously,
> +which is primarily used to capture the output that the function
> +produces in the caller in order to process it.
> ...
> +Data structures
> ...
> +. Specify 0 to inherit the channel from parent.

The responsibility to close the FD inherited thusly lies on...?

> ...
> +	.stdout_to_stderr: stdout of the child is redirected to the
> +		parent's stderr (i.e. *not* to what .err or
> +		.no_stderr specify).

Perhaps we would want to say something about the usual caveat on
deadlocks caused by careless use of bidi pipes?

> +* `struct async`
> +
> +This describes a function to run asynchronously, whose purpose is
> +to produce output that the caller reads
> +
> +The caller:
> +
> +1. allocates and clears (memset(&asy, '0', sizeof(asy));) a
> +   struct async variable;
> +2. initializes .proc and .data;
> +3. calls start_async();
> +4. processes the data by reading from the fd in .out;
> +5. closes .out;
> +6. calls finish_async().
> +
> +The function has the following signature:

This talks about the function to be set to .proc member?  It was
not clear in my first reading.

> +	int proc(int fd, void *data);
> +
> +. fd specifies a writable file descriptor to which the function must
> +  write the data that it produces. The function *must* close this
> +  descriptor before it returns.
> +
> +. data is the value that the caller has specified in the .data member
> +  of struct async.
> +
> +. The return value of the function is 0 on success and non-zero
> +  on failure.

... and how does that status affects whom?

> +There are serious restrictions on what the asynchronous function can do:
> +
> +. It cannot change the global state in a way that the caller notices;
> +  in other words, .out is the only communication channel to the caller.
> +
> +. It must not modify global state that the caller of the facility also
> +  accesses.

global state meaning?  global variables, environment, etc?  Are
you trying to say "even though on UNIX this is implemented by a
pipe to a forked process, do not assume so --- it could be
running in the same address space as a separate thread"?
