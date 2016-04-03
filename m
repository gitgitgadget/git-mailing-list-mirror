From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 1/4] builtin/verify-tag.c: Ignore SIGPIPE on
 gpg-interface
Date: Sun, 3 Apr 2016 08:50:27 +0200
Message-ID: <5700BD33.6090602@kdbg.org>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-2-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Sun Apr 03 08:50:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ambrv-0006UD-96
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 08:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbcDCGuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 02:50:32 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:49102 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbcDCGuc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 02:50:32 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3qd5NQ0lbgz5tl9;
	Sun,  3 Apr 2016 08:50:29 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 610D85218;
	Sun,  3 Apr 2016 08:50:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <1459638975-17705-2-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290631>

Am 03.04.2016 um 01:16 schrieb santiago@nyu.edu:
> From: Santiago Torres <santiago@nyu.edu>
>
> The verify_signed_buffer comand might cause a SIGPIPE signal when the
> gpg child process terminates early (due to a bad keyid, for example) and
> git tries to write to it afterwards. Previously, ignoring SIGPIPE was
> done on the builtin/gpg-verify.c command to avoid this issue. However,
> any other caller who wanted to use the verify_signed_buffer command
> would have to include this signal call.
>
> Instead, we use sigchain_push(SIGPIPE, SIG_IGN) on the
> verify_signed_buffer call (pretty much like in sign_buffer()) so
> that any caller is not required to perform this task. This will avoid
> possible mistakes by further developers using verify_signed_buffer.
>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> Notes:
>   I dropped the multiline comment altogheter.
>
>   builtin/verify-tag.c | 3 ---
>   gpg-interface.c      | 3 +++
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 00663f6..77f070a 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -95,9 +95,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>   	if (verbose)
>   		flags |= GPG_VERIFY_VERBOSE;
>
> -	/* sometimes the program was terminated because this signal
> -	 * was received in the process of writing the gpg input: */
> -	signal(SIGPIPE, SIG_IGN);
>   	while (i < argc)
>   		if (verify_tag(argv[i++], flags))
>   			had_error = 1;
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 3dc2fe3..c1f6b2d 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -232,6 +232,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>   	if (gpg_output)
>   		gpg.err = -1;
>   	args_gpg[3] = path;
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
>   	if (start_command(&gpg)) {
>   		unlink(path);
>   		return error(_("could not run gpg."));

But no sigchain_pop() in the error path that we see here?

Perhaps you can even defer the sigchain_push() until after start_command()?

> @@ -250,6 +252,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>   	close(gpg.out);
>
>   	ret = finish_command(&gpg);
> +	sigchain_pop(SIGPIPE);
>
>   	unlink_or_warn(path);
>
>

-- Hannes
