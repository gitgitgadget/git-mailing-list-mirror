From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Sat, 08 Jun 2013 21:00:30 +0200
Message-ID: <vpqzjv0tokx.fsf@anie.imag.fr>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, celestin.matte@ensimag.fr
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Sat Jun 08 21:00:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlONj-0008Oh-BV
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 21:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab3FHTAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 15:00:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44048 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469Ab3FHTAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 15:00:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r58J0SSo016052
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 21:00:29 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlONL-0001bH-1M; Sat, 08 Jun 2013 21:00:31 +0200
In-Reply-To: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Fri, 7 Jun 2013 23:50:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 08 Jun 2013 21:00:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r58J0SSo016052
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371322833.51719@02KxHHyIIuUq5gKNcAqsrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226857>

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> The #7 issue on git-mediawiki's issue tracker [1] states that the ability to
> preview content without pushing would be a nice thing to have.
>
> This commit is a first attempt to achieve it. It adds a new git command,
> named `git mw`. This command accepts the subcommands `help` and `preview`
> for now.

Review could be easier if you have PATCH 1/2 introducing the command
with only "help" (essentially to check that the build system works), and
then focus on "preview".

I won't insist in splitting this particular commit, just take it as an
advice for future work.

> --- a/contrib/mw-to-git/Makefile
> +++ b/contrib/mw-to-git/Makefile
> @@ -5,13 +5,17 @@
>  ## Build git-remote-mediawiki
>  
>  SCRIPT_PERL=git-remote-mediawiki.perl
> +SCRIPT_PERL_MW=git-mw.perl

Why do you need another variable? Just adding git-mw.perl to SCRIPT_PERL
should do it, no? (Well, probably the make SCRIPT_PERL=$(SCRIPT_PERL)
lacks quotes around the argument, but then you should fix that).

> +# Constants
> +# Mediawiki filenames can contain forward slashes. This variable decides by which pattern they should be replaced
> +Readonly::scalar $SLASH_REPLACEMENT => "%2F";

This one is copied from git-remote-mediawiki.perl, and is a
git-mediawiki specific thing, so it would not make sense to put it into
Git.pm. This starts convincing me that we should have a GitMediawiki.pm
or so, and both scripts should use it.

Another option would be to put everything in git-remote-mediawiki.perl,
and probably to have "git mw" as a wrapper around it (to avoid having to
type "git remote-mediawiki" which is a bit long).

But the script starts being a bit long, so I think it makes more sense
to split it. So I'd say

PATCH 1/3 : introduce "git mw"
PATCH 2/3 : move sharable code to a new module (and make sure it's
            installed properly by "make install")
PATCH 3/3 : actually implement the preview feature

Perhaps others will have other/better advices.

> +	# Auto-loading in browser
> +	if ($autoload) {
> +		open(my $browser, "-|:encoding(UTF-8)", "xdg-open ".$preview_file_name);

That could be read from Git's configuration, and default to xdg-open.
But you don't want to hardcode it in the middle of the code.

Also, why use open if you don't want to communicate with the process?
system would be sufficient, and won't need close.

Prefer passing an array of arguments, instead of concatenating strings
and then rely on command-line parsing to re-split it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
