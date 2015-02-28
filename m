From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 3/5] connect.c: connect to a remote service with some
 flags
Date: Sat, 28 Feb 2015 12:11:46 +0100
Message-ID: <54F1A272.80401@web.de>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com> <1425085318-30537-1-git-send-email-sbeller@google.com> <1425085318-30537-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 12:12:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRfJP-0001YP-NJ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 12:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbbB1LLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 06:11:55 -0500
Received: from mout.web.de ([212.227.15.3]:63590 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbbB1LLy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 06:11:54 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MZUjd-1YDApX41E5-00LAtG; Sat, 28 Feb 2015 12:11:51
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1425085318-30537-4-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:RAnfH4Isxy4K4drZ0RnPNTakv7MB7DGEY+7f4755lXBRG8nqgoR
 6AsazNh1x7HDxyNZGYmmCoSdUkkMP2FNrCZTYx9P0NbiK0JaFIHj7NMmOyY35JXiUcjhWEy
 eE6o6ufG1N/u3stlC6uY+VJCqvjuy5+oihhqf+IfapCN3WujhzemuaG/it9GlI6MacHh4Ou
 HZlqzS/N8gkKgua+Q4F3Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264525>

On 2015-02-28 02.01, Stefan Beller wrote:

> If this is over git protocol, the flags is appended as the next
> parameter after host=. If it's ssh, a new argument is appended to the
> command line.
> 
> None of the callers use this now though.
> 
> [sb: originally by pclouds, rebased as jk implemented 1823bea10,
> (git_connect: use argv_array), so any error is mine]
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/fetch-pack.c |  2 +-
>  builtin/send-pack.c  |  2 +-
>  connect.c            | 18 ++++++++++++------
>  connect.h            |  2 +-
>  transport.c          |  3 ++-
>  5 files changed, 17 insertions(+), 10 deletions(-)
> 
[]

> diff --git a/connect.c b/connect.c
> index 062e133..7b6b241 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -650,7 +650,9 @@ static struct child_process no_fork = CHILD_PROCESS_INIT;
>   * the connection failed).
>   */
>  struct child_process *git_connect(int fd[2], const char *url,
> -				  const char *prog, int flags)
> +				  const char *prog,
> +				  const char *service_flags,
The name "service_flags" reminds me on a service:
We connect to a service, but we are not a service.

And "flags" is often used for different bits, collected in an int, but not a "string"

Options are used at the command line, or arguments.
How about "extra_arg", or "extra_option", or "option_str", or simply "options" (or "option") ? 
> +				  int flags)
>  {
>  	char *hostandport, *path;
>  	struct child_process *conn = &no_fork;
> @@ -685,10 +687,13 @@ struct child_process *git_connect(int fd[2], const char *url,
>  		 * Note: Do not add any other headers here!  Doing so
>  		 * will cause older git-daemon servers to crash.
>  		 */
> -		packet_write(fd[1],
> -			     "%s %s%chost=%s%c",
> -			     prog, path, 0,
> -			     target_host, 0);
> +		if (!service_flags)
> +			packet_write(fd[1], "%s %s%chost=%s%c",
> +				     prog, path, 0, target_host, 0);
> +		else
> +			packet_write(fd[1], "%s %s%chost=%s%c%s%c",
> +				     prog, path, 0, target_host, 0,
> +				     service_flags, 0);
We don't need this "big if" here, a simple "?" will do:
 
			packet_write(fd[1], "%s %s%chost=%s%c%s%c",
				     prog, path, 0, target_host, 0,
				     options ? options : "", /* old service_flasgs */ 
                                     0);
