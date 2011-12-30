From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] expanded hook api with stdio support
Date: Fri, 30 Dec 2011 10:47:55 +0100
Message-ID: <4EFD88CB.3050403@kdbg.org>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net> <1325207240-22622-2-git-send-email-joey@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Dec 30 10:48:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgZ4J-0004hc-Kg
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 10:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065Ab1L3JsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 04:48:01 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:51432 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751857Ab1L3JsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 04:48:00 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4172B1001F;
	Fri, 30 Dec 2011 10:46:27 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E274219F5FA;
	Fri, 30 Dec 2011 10:47:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <1325207240-22622-2-git-send-email-joey@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187797>

Am 30.12.2011 02:07, schrieb Joey Hess:
> Finally, the API is designed to be extended in the future, to support
> running multiple programs for a single hook action (such as the contents
> of a .git/hooks/hook.d/ , or a system-wide hook). This design goal led
> to the "generator" and "reader" members of the struct hook, which are
> specified such that they can be called repeatedly, with data flowing
> between them (via the "data" member), like this:
>     generator | hook_prog_1 | reader | generator | hook_prog_2 | reader

IMHO, this is overengineered. I don't think that we need something like
this in the foreseeable future, particularly because such a pipeline or
multi-hook infrastructure can easily be constructed by the (single) hook
script itself.

IOW, none of the three function pointers should be needed (not even the
feeder, see below), at least not in a first step.

IMO, as the first step, the user of this infrastructure should only be
required to construct the hook input as a strbuf, and receive the hook
output, if needed, also as a strbuf.

> +`run_hook_complex`::
> +
> +	Run a hook, with the caller providing its stdin and/or parsing its
> +	stdout.
> +	Takes a pointer to a `struct hook` that specifies the details,
> +	including the name of the hook, any parameters to pass to it,
> +	and how to handle the stdin and stdout. (See below.)
> +	If the hook does not exist or is not executable, the return value
> +	will be zero.
> +	If it is executable, the hook will be executed and the exit
> +	status of the hook is returned.

What is the rationale for these error modes? It is as if a non-existent
or non-executable hook counts as 'success'. (I'm not saying that this
would be wrong, I'm just asking.)

>  
>  Data structures
>  ---------------
> @@ -241,3 +252,45 @@ a forked process otherwise:
>  
>  . It must not change the program's state that the caller of the
>    facility also uses.
> +
> +* `struct hook`
> +
> +This describes a hook to run.
> +
> +The caller:
> +
> +1. allocates and clears (memset(&hook, 0, sizeof(hook));) a
> +   struct hook variable;
> +2. initializes the members;
> +3. calls hook();

run_hook_complex()?

> +4. if necessary, accesses data read from the hook in .data
> +5. frees the struct hook.

> +The `feeder` is run asynchronously to feed the generated stdin into the hook.
> +It is passed the handle to write to, the strbuf containing the stdin, and 
> +a pointer to the `struct hook`, and should return non-zero on failure.
> +Typically it is set to either `feed_hook_in_full`, or `feed_hook_incomplete`.

IMO, this is overengineered. See below.

> +	res |= start_command(&child);
> +	if (res) goto hook_out;

Please write this conditional in two lines.

> +/* A feeder that ensures the hook consumes all its stdin. */
> +int feed_hook_in_full(int handle, struct strbuf *buf, struct hook *hook)
> +{
> +	if (write_in_full(handle, buf->buf, buf->len) != buf->len) {
> +		warning("%s hook failed to consume all its input", hook->name);

Really? Could there not be any other error condition? The warning would
be correct only if errno == EPIPE, and this error will be returned only
if SIGPIPE is ignored. Does this happen anywhere?

Futhermore, if all data was written to the pipe successfully, there is
no way to know whether the reader consumed everything.

IOW, I don't it is worth to make the distinction. However, I do think
that the parent process must be protected against SIGPIPE.

> +		return 1;
> +	}
> +	else
> +		return 0;
> +}

-- Hannes
