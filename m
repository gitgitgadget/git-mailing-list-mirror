From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pager: drop "wait for output to run less" hack
Date: Tue, 05 Jun 2012 08:42:14 -0700
Message-ID: <7vwr3lpxyh.fsf@alter.siamese.dyndns.org>
References: <20120605085604.GA27298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 17:42:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbvtm-0006IH-11
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 17:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab2FEPmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 11:42:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab2FEPmR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 11:42:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3AAE86FF;
	Tue,  5 Jun 2012 11:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HGp+MQ3E+oMCNGtCCvowON0Rug0=; b=PKjcK3
	O0iHY7F6jXdoHklL4Wmu5s2PCtrezMxUv6J7iO+lX+O1tGjaIT2iOaaFWSx4/x6y
	ZifOJB6Nin2eI+PGbONlkYYEQ5+VclVYgj3xHyh2y6Wt/pctckfXaxfcW13MCyd1
	l3JSBN/5qRmitRkxWEK1Drb1Wi5R9lv6Exgv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h7iWA2wLAhzgXPywFts615kc8+TyaFWs
	DjspWgtsxjk0sASNL2pMamvARXWiihOSL3CI3Jyymqc7ommKHirJ2oFEuy5Xzc5t
	2WDtNXh6nDcJBqePb/EGDUX57ZTXc5VANUMrxs/wVrxfnl4p7j09uHOU4ZWPGEQs
	mWpBJrMaFtg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAB9386FE;
	Tue,  5 Jun 2012 11:42:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0F1F86FC; Tue,  5 Jun 2012
 11:42:15 -0400 (EDT)
In-Reply-To: <20120605085604.GA27298@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jun 2012 04:56:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06AFDB8E-AF25-11E1-87EF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199252>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 05, 2012 at 02:56:28AM -0400, Jeff King wrote:
>
>> > +static int fd_to_close;
>> > +void close_fd_prexec_cb(void)
>> > +{
>> > +	if(debug)
>> > +		fprintf(stderr, "close_fd_prexec_cb closing %d\n", fd_to_close);
>> > +	close(fd_to_close);
>> > +}
>> 
>> Note that preexec_cb does not work at all on Windows, as it assumes a
>> forking model (rather than a spawn, which leaves no room to execute
>> arbitrary code in the child). If all you want to do is open an extra
>> pipe, then probably run-command should be extended to handle this
>> (though I have no idea how complex that would be for the Windows side of
>> things, it is at least _possible_, as opposed to preexec_cb, which will
>> never be possible).
>
> I'm really tempted to do this:

Why (I am slower than my usual slow self today, so pardon me)?

Aren't these already protected with "ifndef WIN32"?

>
> -- >8 --
> Commit 35ce862 (pager: Work around window resizing bug in
> 'less', 2007-01-24) causes git's pager sub-process to wait
> to receive input after forking but before exec-ing the
> pager. To handle this, run-command had to grow a "pre-exec
> callback" feature. Unfortunately, this feature does not work
> at all on Windows (where we do not fork), and interacts
> poorly with run-command's parent notification system. Its
> use should be discouraged.
>
> The bug in less was fixed in version 406, which was released
> in June 2007. It is probably safe at this point to remove
> our workaround. That lets us rip out the preexec_cb feature
> entirely.

Ah, OK.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I checked, and even RHEL5 is on less 436. So besides people on antique
> "I installed less from source more than 5 years ago" systems, my only
> concern would be that some other pager depends on this hack in a weird
> way. But I have never heard of such a thing, so...

Hrm...

>  pager.c       | 18 ------------------
>  run-command.c | 10 ----------
>  run-command.h |  1 -
>  3 files changed, 29 deletions(-)
>
> diff --git a/pager.c b/pager.c
> index 4dcb08d..c0b4387 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -11,21 +11,6 @@
>   * something different on Windows.
>   */
>  
> -#ifndef WIN32
> -static void pager_preexec(void)
> -{
> -	/*
> -	 * Work around bug in "less" by not starting it until we
> -	 * have real input
> -	 */
> -	fd_set in;
> -
> -	FD_ZERO(&in);
> -	FD_SET(0, &in);
> -	select(1, &in, NULL, &in, NULL);
> -}
> -#endif
> -
>  static const char *pager_argv[] = { NULL, NULL };
>  static struct child_process pager_process;
>  
> @@ -93,9 +78,6 @@ void setup_pager(void)
>  		static const char *env[] = { "LESS=FRSX", NULL };
>  		pager_process.env = env;
>  	}
> -#ifndef WIN32
> -	pager_process.preexec_cb = pager_preexec;
> -#endif
>  	if (start_command(&pager_process))
>  		return;
>  
> diff --git a/run-command.c b/run-command.c
> index 606791d..dff28a7 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -394,16 +394,6 @@ fail_pipe:
>  					unsetenv(*cmd->env);
>  			}
>  		}
> -		if (cmd->preexec_cb) {
> -			/*
> -			 * We cannot predict what the pre-exec callback does.
> -			 * Forgo parent notification.
> -			 */
> -			close(child_notifier);
> -			child_notifier = -1;
> -
> -			cmd->preexec_cb();
> -		}
>  		if (cmd->git_cmd) {
>  			execv_git_cmd(cmd->argv);
>  		} else if (cmd->use_shell) {
> diff --git a/run-command.h b/run-command.h
> index 44f7d2b..850c638 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -39,7 +39,6 @@ struct child_process {
>  	unsigned stdout_to_stderr:1;
>  	unsigned use_shell:1;
>  	unsigned clean_on_exit:1;
> -	void (*preexec_cb)(void);
>  };
>  
>  int start_command(struct child_process *);
