From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] rm: better error message on failure for multiple files
Date: Mon, 10 Jun 2013 16:38:06 +0200
Message-ID: <vpqtxl6ghf5.fsf@anie.imag.fr>
References: <1370874127-4326-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 16:38:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3Eg-00068c-A2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab3FJOiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:38:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33423 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab3FJOiM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:38:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5AEc4EG019045
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 16:38:05 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um3EU-0002Pq-OD; Mon, 10 Jun 2013 16:38:06 +0200
In-Reply-To: <1370874127-4326-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	(Mathieu Lienard--Mayor's message of "Mon, 10 Jun 2013 16:22:06
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 16:38:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227292>

Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr> writes:

> When 'git rm' fails, it now displays a single message
> with the list of files involved, instead of displaying
> a list of messages with one file each.
>
> As an example, the old message:
> 	error: 'foo.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
> 	error: 'bar.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
>
> would now be displayed as:
> 	error: the following files have changes staged in the index:
> 	    foo.txt
> 	    bar.txt
> 	(use --cached to keep the file, or -f to force removal)
>
> Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>list

There's a "list" after my email, probably a typo.

> +/*
> + * PRECONDITION: files_list is a non-empty string_list
> + */

Avoid repeating in comments what the code already says. "file_list is
non-empty" is sufficient, we already know it's a string_list.

> +	if (files_staged.nr)
> +		errs = print_error_files(&files_staged,
> +					 _("the following files have staged "
> +					   "content different from both the"
> +					   "\nfile and the HEAD:"),
> +					 _("\n(use -f to force removal)"));
> +	if (files_cached.nr)
> +		errs = print_error_files(&files_cached,
> +					 _("the following files have changes "
> +					   "staged in the index:"),
> +					 _("\n(use --cached to keep the file, "
> +					   "or -f to force removal)"));

What happens if both conditions are true? It seems the second will
override the first. I think it'd be OK because what matters is that errs
is set by someone, no matter who, and the error message is displayed on
screen, not contained in the variable, but this looks weird.

I'd find it more readable with "errs |= print_error_files(...)".

And actually, you may want to move the if (....nr) inside
print_error_files (wich could then be called print_error_files_maybe).

At least, there should be a test where two conditions are true.

> +	if (files_submodule.nr)
> +		errs = print_error_files(&files_submodule,
> +					 _("the following submodules (or one "
> +					   "of its nested submodule) use a "
> +					   ".git directory:"),
> +					 _("\n(use 'rm -rf' if you really "
> +					   "want to remove i including all "

i -> it
?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
