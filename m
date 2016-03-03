From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] pull --rebase: add --[no-]autostash flag
Date: Thu, 03 Mar 2016 18:24:01 +0100
Message-ID: <vpqd1rbiifi.fsf@anie.imag.fr>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pyokagan@gmail.com, gitster@pobox.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 18:24:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abWz1-0003fY-3z
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 18:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbcCCRYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 12:24:09 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37142 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbcCCRYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 12:24:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u23HNxHf029512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Mar 2016 18:23:59 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u23HO1VT032565;
	Thu, 3 Mar 2016 18:24:01 +0100
In-Reply-To: <1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Thu, 3 Mar 2016 21:43:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Mar 2016 18:23:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u23HNxHf029512
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457630640.13069@P7AaxmAatCzpgjwdGWKubQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288194>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> If rebase.autoStash configuration variable is 
> set, there is no way to override it for 
> "git pull --rebase" from the command line.
>
> Teach "git pull --rebase" the --[no]autostash
> command line flag which overrides the current
> value of rebase.autostash, if set. As "git rebase"
> understands the --[no]autostash option, it's 
> just a matter of passing the option to underlying 
> "git rebase" when "git pull --rebase" is called.

We normally wrap text with a bit less than 80 columns. Yours is wrappet
at 50 columns which makes it look weird.

> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -85,6 +85,7 @@ static char *opt_squash;
>  static char *opt_commit;
>  static char *opt_edit;
>  static char *opt_ff;
> +static int opt_autostash = -1;

Instead of going through this 3-valued "true/false/unset", I would have
let opt_autostash = 0 by default, and read the configuration before the
call to parse_options (the usual way to apply precedence: read from low
precedence to high precedence).

But this is a bit less easy than it seems, since the code currently
checks the configuration variable only when --rebase is given, so my
version would do a useless call to git_config_get_bool() when --rebase
is not given. So I think your version is OK.

> +	else {
> +		/* If --[no-]autostash option is called without --rebase */
> +		if (opt_autostash == 0)
> +			die(_("--no-autostash option is only valid with --rebase."));
> +		else if (opt_autostash == 1)

The else is not needed since the other branch dies.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
