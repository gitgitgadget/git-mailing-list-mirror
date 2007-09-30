From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Sun, 30 Sep 2007 13:43:12 -0700
Message-ID: <7vbqbjg9zz.fsf@gitster.siamese.dyndns.org>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
	<1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:20:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6Cy-0004Xs-9y
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbXI3VUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXI3VUE
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:20:04 -0400
Received: from lollipop.listbox.com ([208.210.124.78]:53376 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbXI3VUD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:20:03 -0400
X-Greylist: delayed 2204 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Sep 2007 17:20:02 EDT
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id 30B8F414B04
	for <git@vger.kernel.org>; Sun, 30 Sep 2007 16:46:11 -0400 (EDT)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 210B813F0A9;
	Sun, 30 Sep 2007 16:43:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C338C13F026;
	Sun, 30 Sep 2007 16:43:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59567>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> This prepares the API of git_connect() and finish_connect() to operate on
> a struct child_process. Currently, we just use that object as a placeholder
> for the pid that we used to return. A follow-up patch will change the
> implementation of git_connect() and finish_connect() to make full use
> of the object.

Good description, except removal of checks for negative return
of the calling sites raised my eyebrow and had me spend a few
more minutes to review than necessary (see below).

> diff --git a/builtin-archive.c b/builtin-archive.c
> index 04385de..76db6cf 100644
> --- a/builtin-archive.c
> +++ b/builtin-archive.c
> @@ -30,7 +30,7 @@ static int run_remote_archiver(const char *remote, int argc,
>  {
>  	char *url, buf[LARGE_PACKET_MAX];
>  	int fd[2], i, len, rv;
> -	pid_t pid;
> +	struct child_process *chld;

Is "child" a reserved keyword or something that we need to avoid
its use as an identifier?

>  	const char *exec = "git-upload-archive";
>  	int exec_at = 0;
>  
> @@ -46,9 +46,7 @@ static int run_remote_archiver(const char *remote, int argc,
>  	}
>  
>  	url = xstrdup(remote);
> -	pid = git_connect(fd, url, exec, 0);
> -	if (pid < 0)
> -		return pid;
> +	chld = git_connect(fd, url, exec, 0);
>  

Interesting.  This and other callers of git_connect() were
prepared to see git_connect() to report errors with negative PID
but the callee simply died --- so this change is not regressing
by removing an early error return.  It would be better to have
something like this in the commit log message:

	Old code had early-return-on-error checks at the calling
	sites of git_connect(), but the callee simply died on
	errors without returning negative values.  This patch
	removes such bogosity.

> diff --git a/connect.c b/connect.c
> index 3d5c4ab..f6dcab9 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -468,21 +468,22 @@ char *get_port(char *host)
>  }
>  
>  /*
> - * This returns 0 if the transport protocol does not need fork(2),
> + * This returns NULL if the transport protocol does not need fork(2),
>   * or a process id if it does.  Once done, finish the connection

It does not return a process ID anymore, so this comment needs
to be updated.  Instead, you now return a struct child_process
that is newly allocated, and needs to be deallocated somehow.
At the end of finish_connect() might be a good place to do so.

>   * with finish_connect() with the value returned from this function
> - * (it is safe to call finish_connect() with 0 to support the former
> + * (it is safe to call finish_connect() with NULL to support the former
>   * case).
>   *
> - * Does not return a negative value on error; it just dies.
> + * If it returns, the connect is successful; it just dies on errors.
>   */
> -pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
> +struct child_process *git_connect(int fd[2], char *url,
> +				  const char *prog, int flags)
>  {
> ...
> -int finish_connect(pid_t pid)
> +int finish_connect(struct child_process *chld)
>  {
> -	if (pid == 0)
> +	if (chld == NULL)
>  		return 0;
>  
> -	while (waitpid(pid, NULL, 0) < 0) {
> +	while (waitpid(chld->pid, NULL, 0) < 0) {
>  		if (errno != EINTR)
>  			return -1;
>  	}

But it seems you don't, leaking the struct.  I see this is fixed
in the next patch in the series, but it would be nicer to have
the free from the very beginning.
