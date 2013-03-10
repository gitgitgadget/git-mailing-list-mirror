From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] shell: new no-interactive-login command to print a
 custom message
Date: Sun, 10 Mar 2013 16:19:14 +0530
Message-ID: <CALkWK0kK3YCwkv26cxVf61yUd8WHmHDG+mFwb2VRwNF3k_40qA@mail.gmail.com>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130309215237.GA24777@elie.Belkin> <20130309220011.GC24777@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 11:50:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEdpK-0001NK-Tq
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 11:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab3CJKtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 06:49:35 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:39444 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab3CJKte (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 06:49:34 -0400
Received: by mail-ia0-f175.google.com with SMTP id e16so1067272iaa.20
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wQ/01a+Ft37H1qeK016aNfcZZ817ISDh4QTXXNApZoI=;
        b=Vyws/D7E2eTafgrxnSiKYeFiRMpUCj8Wq1jv2Bzo8i8hABwNsoCDBrKb6OXfNtm1Ld
         RJKMIDbUb1fbGV0YMC1421uFNJKDC9hP2x2lir49flWZg4tElYCb9iWGtFYafgYoh9xx
         2dbnkBEvUR3zeekM8CzcS9YC8Ee4WJ+ECLR1z/3Zfqb9nzI7U6FwbngAMLH4MPXki/6l
         zlOBI3Klkse1gM4uf33ulwy0cu669jYxqwaVHTOD934jd5QVv0/XJjAmK6pvQPXjZCKL
         eV7jaTSI/9g/B61RW3dBzC0Scyor3T/gyOIX+z34Y9pezu+84028TWfmqceI3uN635g+
         YW+w==
X-Received: by 10.42.204.79 with SMTP id fl15mr5918614icb.57.1362912574365;
 Sun, 10 Mar 2013 03:49:34 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sun, 10 Mar 2013 03:49:14 -0700 (PDT)
In-Reply-To: <20130309220011.GC24777@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217796>

Jonathan Nieder wrote:
>  * If the file ~/git-shell-commands/no-interactive-login exists,
>    run no-interactive-login to let the server say what it likes,
>    then hang up.
>
>  * Otherwise, if ~/git-shell-commands/ is present, start an
>    interactive read-eval-print loop.
>
>  * Otherwise, print the usual configuration hint and hang up.

Excellent.  A way to suppress the ugly warning, and replace it with a
nice message in a non-interactive shell.  You've chosen
"no-interactive-login" as the name of this special file, which is
reasonable.  I'm not too fond of the name "git-shell-commands" in the
first place, but I suspect it's too late to do anything about it now.

> diff --git a/shell.c b/shell.c
> index 84b237fe..1429870a 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -6,6 +6,7 @@
>
>  #define COMMAND_DIR "git-shell-commands"
>  #define HELP_COMMAND COMMAND_DIR "/help"
> +#define NOLOGIN_COMMAND COMMAND_DIR "/no-interactive-login"
>
>  static int do_generic_cmd(const char *me, char *arg)
>  {
> @@ -65,6 +66,18 @@ static void run_shell(void)
>  {
>         int done = 0;
>         static const char *help_argv[] = { HELP_COMMAND, NULL };
> +
> +       if (!access(NOLOGIN_COMMAND, F_OK)) {
> +               /* Interactive login disabled. */

You're just checking for its existence here, not for execute permissions.

> +               const char *argv[] = { NOLOGIN_COMMAND, NULL };
> +               int status;
> +
> +               status = run_command_v_opt(argv, 0);

If "no-interactive-login" doesn't have execute permissions, we'll get
an error from here:

    fatal: cannot exec 'git-shell-commands/no-interactive-login':
Permission denied

Would you like to check that the file has execute permission in
advance to prevent some extra processing (in run_command_v_opt,
start_command and friends) before this message is printed?

Looks good otherwise.
