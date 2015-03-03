From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-credential-store: support XDG config dir
Date: Tue, 03 Mar 2015 23:00:53 +0100
Message-ID: <vpqwq2x3fmy.fsf@anie.imag.fr>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
	<1425414299-24000-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 23:01:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSusC-0003rz-PI
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 23:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757910AbbCCWA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 17:00:59 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53244 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757752AbbCCWA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 17:00:57 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t23M0phA012601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Mar 2015 23:00:51 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t23M0rdX023957;
	Tue, 3 Mar 2015 23:00:53 +0100
In-Reply-To: <1425414299-24000-2-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 4 Mar 2015 04:24:58 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Mar 2015 23:00:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t23M0phA012601
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426024851.81754@PNwjoKIxS7sTSfgcU3EhvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264695>

Paul Tan <pyokagan@gmail.com> writes:

> Teach git-credential-store to read/write credentials from
> $XDG_CONFIG_HOME/git/credentials and ~/.git-credentials where
> appropriate:

Thanks for your patch. Below is a partial review. Don't take my comments
as negative criticisms, they are all directions for improvement. I'm
actually positively surprised by the quality for a first patch :-).
Looking forward to your version2.

> * get: call lookup_credential() on the XDG file first if it exists. If
>   the credential can't be found, call lookup_credential() on the HOME
>   file.
> * erase: Call remove_credential() on both the XDG file if it exists and
>   the HOME file if it exists.
> * store: If the XDG file exists, call store_credential() on the XDG file
>   and remove_credential() on the HOME file to prevent duplicates.
> * If "--file" is provided, use the file for all operations instead.

When writting a commit message, always insist on _why_ you did what you
did, not _what_ you did (the patch already says it). For example, your
proposal for erase makes sense because if you're using "erase", you
probably don't want to leave cleartext passwords in another file. But
you didn't give the argument.

In other words: I hate GNU-style changelogs ;-).

Also, we usually put blank lines between items (read the output of "git
log --no-merges" in git.git to get an idea of the conventions).

> Likewise,
> lookup_credential() returns 1 if it could find the credential, and 0 if
> it could not.

Err, you're changing the calling convention, and you're not the only
caller (git grep lookup_credential).

If you need to change this existing function, best is to start your
series with a preparatory patch that does the calling convention change,
adapts the other caller, and then write your change on top, as [PATCH 2].

> -	if (!strcmp(op, "get"))
> -		lookup_credential(file, &c);
> -	else if (!strcmp(op, "erase"))
> -		remove_credential(file, &c);
> -	else if (!strcmp(op, "store"))
> -		store_credential(file, &c);
> -	else
> +	if (!strcmp(op, "get")) {
> +		if (file) {
> +			lookup_credential(file, &c);
> +		} else {
> +			if (xdg_file && access_or_warn(xdg_file, R_OK, 0) == 0)
> +				ret = lookup_credential(xdg_file, &c);
> +			if (!ret && home_file && access_or_warn(home_file, R_OK, 0) == 0)
> +				lookup_credential(home_file, &c);
> +		}
> +	} else if (!strcmp(op, "erase")) {
> +		if (file) {
> +			remove_credential(file, &c);
> +		} else {
> +			if (xdg_file && access(xdg_file, F_OK) == 0)
> +				remove_credential(xdg_file, &c);
> +			if (home_file && access(home_file, F_OK) == 0)
> +				remove_credential(home_file, &c);

Why is it somethimes access_or_warn and sometimes just access? (genuine
question)

> +		}
> +	} else if (!strcmp(op, "store")) {
> +		if (file) {
> +			store_credential(file, &c);
> +		} else if (xdg_file && access(xdg_file, F_OK) == 0) {
> +			store_credential(xdg_file, &c);
> +			if (home_file && access(home_file, F_OK) == 0 &&
> +			    c.protocol && (c.host || c.path) && c.username
> +			    && c.password)

It would make sense to introduce a helper like sensible_credential(c),
or sanity_check(c). It could be used in store_credential too.

I'm not convinced you need to remove the credential from home_file if
the xdg_file takes precedence. Not saying you shouldn't, but you should
argue more at least.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
