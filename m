From: Max L <infthi.inbox@gmail.com>
Subject: Re: [PATCH 1/6] run_external_diff: use an argv_array for the command line
Date: Sun, 20 Apr 2014 02:09:49 +0400
Message-ID: <CAA6TxYu=AX_RWQq4gr7cv6ZppPerRw30NY_Wbi1r8qEBma7Ctg@mail.gmail.com>
References: <20140419191128.GA9266@sigill.intra.peff.net>
	<20140419191706.GA8981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 20 00:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbdSN-0005K9-Tb
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 00:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbaDSWJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 18:09:52 -0400
Received: from mail-qc0-f193.google.com ([209.85.216.193]:64739 "EHLO
	mail-qc0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaDSWJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 18:09:50 -0400
Received: by mail-qc0-f193.google.com with SMTP id e16so993980qcx.0
        for <git@vger.kernel.org>; Sat, 19 Apr 2014 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4wyUZmJUGVIuoaumlwn8oyEdR6JWLnJo5zkCcP9xTyE=;
        b=saJW8IDyAGjSaEbhzKAaN9CJXiL4T+mHnHxClNFPuWMYu2nG9JmFf7qFTNF0CYzTIR
         DfjGMbRDFFxj5gHb5J5dEq3DIRbXiLQMXld3jORGXE0l3ShqwrGiQRWMsJp/wZvktb+n
         76z/K81+pKuQx6Xw1KQbJlWnclfyc7NbwTG+6KeBjBLeev9WbFsuA12BZLsSuZJUwCYT
         qJvNnKL9mWOgRHVD6UBxrMgNGrxBeD3CVAL5uWPhLb+jjyKTQBI/RG9sHbd3QgPZv0zD
         0qX7p+tHj/sa1UUMjiJZpV8G7yB8OG2/aqN17meFuUqGm58sfassFpCjRm9IztuHYuhw
         sPtw==
X-Received: by 10.224.49.67 with SMTP id u3mr28872700qaf.63.1397945389713;
 Sat, 19 Apr 2014 15:09:49 -0700 (PDT)
Received: by 10.140.21.113 with HTTP; Sat, 19 Apr 2014 15:09:49 -0700 (PDT)
In-Reply-To: <20140419191706.GA8981@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246543>

One more note: at this moment the problem is slightly deeper. This
array is next passed to the execvp function, which now falls with
EFAULT on two my machines (both faced this problem after upgrading to
ubuntu 14.04, everything 'worked' fine before, looks like now execvp
checks input more strictly). This leads to non-working 'git difftool'.

2014-04-19 23:17 GMT+04:00, Jeff King <peff@peff.net>:
> We currently generate the command-line for the external
> command using a fixed-length array of size 10. But if there
> is a rename, we actually need 11 elements (10 items, plus a
> NULL), and end up writing a random NULL onto the stack.
>
> Rather than bump the limit, let's just an argv_array, which
> makes this sort of error impossible.
>
> Noticed-by: Max L <infthi.inbox@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was actually noticed by a GitHub user, who proposed bumping
> the array size to 11:
>
>   https://github.com/git/git/pull/92
>
> Even though this fix is a bigger change, I'd rather do it this way, as
> it is more obviously correct to a reader (and it solves the problem
> forever). I pulled the name/email from that commit, but please let me
> know if you'd prefer to be credited differently.
>
>  diff.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 539997f..b154284 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -16,6 +16,7 @@
>  #include "submodule.h"
>  #include "ll-merge.h"
>  #include "string-list.h"
> +#include "argv-array.h"
>
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -2902,9 +2903,8 @@ static void run_external_diff(const char *pgm,
>  			      int complete_rewrite,
>  			      struct diff_options *o)
>  {
> -	const char *spawn_arg[10];
> +	struct argv_array argv = ARGV_ARRAY_INIT;
>  	int retval;
> -	const char **arg = &spawn_arg[0];
>  	struct diff_queue_struct *q = &diff_queued_diff;
>  	const char *env[3] = { NULL };
>  	char env_counter[50];
> @@ -2915,23 +2915,22 @@ static void run_external_diff(const char *pgm,
>  		const char *othername = (other ? other : name);
>  		temp_one = prepare_temp_file(name, one);
>  		temp_two = prepare_temp_file(othername, two);
> -		*arg++ = pgm;
> -		*arg++ = name;
> -		*arg++ = temp_one->name;
> -		*arg++ = temp_one->hex;
> -		*arg++ = temp_one->mode;
> -		*arg++ = temp_two->name;
> -		*arg++ = temp_two->hex;
> -		*arg++ = temp_two->mode;
> +		argv_array_push(&argv, pgm);
> +		argv_array_push(&argv, name);
> +		argv_array_push(&argv, temp_one->name);
> +		argv_array_push(&argv, temp_one->hex);
> +		argv_array_push(&argv, temp_one->mode);
> +		argv_array_push(&argv, temp_two->name);
> +		argv_array_push(&argv, temp_two->hex);
> +		argv_array_push(&argv, temp_two->mode);
>  		if (other) {
> -			*arg++ = other;
> -			*arg++ = xfrm_msg;
> +			argv_array_push(&argv, other);
> +			argv_array_push(&argv, xfrm_msg);
>  		}
>  	} else {
> -		*arg++ = pgm;
> -		*arg++ = name;
> +		argv_array_push(&argv, pgm);
> +		argv_array_push(&argv, name);
>  	}
> -	*arg = NULL;
>  	fflush(NULL);
>
>  	env[0] = env_counter;
> @@ -2940,8 +2939,9 @@ static void run_external_diff(const char *pgm,
>  	env[1] = env_total;
>  	snprintf(env_total, sizeof(env_total), "GIT_DIFF_PATH_TOTAL=%d", q->nr);
>
> -	retval = run_command_v_opt_cd_env(spawn_arg, RUN_USING_SHELL, NULL, env);
> +	retval = run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env);
>  	remove_tempfile();
> +	argv_array_clear(&argv);
>  	if (retval) {
>  		fprintf(stderr, "external diff died, stopping at %s.\n", name);
>  		exit(1);
> --
> 1.9.1.656.ge8a0637
>
>
