From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Test environment of git-remote-mw
Date: Fri, 01 Jun 2012 13:49:53 +0200
Message-ID: <vpqmx4n9rq6.fsf@bauges.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
	<1338547317-26088-1-git-send-email-guillaume.sasdy@ensimag.imag.fr>
	<1338547317-26088-2-git-send-email-guillaume.sasdy@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Charles Roussel <charles.roussel@ensimag.fr>,
	Simon Cathebras <Simon.Cathebras@ensimag.imag.fr>,
	Simon Perrat <Simon.Perrat@ensimag.imag.fr>,
	Charles Roussel <Charles.Roussel@ensimag.imag.fr>,
	Julien Khayat <Julien.Khayat@ensimag.imag.fr>
To: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 01 13:50:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaQMk-0000bG-J2
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 13:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746Ab2FALt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 07:49:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48061 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756609Ab2FALt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 07:49:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q51BfOxX027798
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 13:41:24 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SaQMc-0008Uh-ES; Fri, 01 Jun 2012 13:49:54 +0200
In-Reply-To: <1338547317-26088-2-git-send-email-guillaume.sasdy@ensimag.imag.fr>
	(Guillaume Sasdy's message of "Fri, 1 Jun 2012 12:41:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 01 Jun 2012 13:41:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q51BfOxX027798
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339155685.85948@97vnnPxYzKRB5tTMAVDpHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198981>

Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr> writes:

>  # CONFIGURATION VARIABLES
> -# You might want to change those ones ...
> +# You might want to change these ones
>  #
>  WIKI_DIR_NAME="wiki"            # Name of the wiki's directory
>  WIKI_DIR_INST="/var/www"        # Directory of the web server
>  TMP="/tmp"                      # Temporary directory for downloads
> -                                # Absolute address needed!
> +                                # Absolute path required!
>  SERVER_ADDR="localhost"         # Web server's address
>  
> -#
>  # CONFIGURATION
> -# You should not change those ones unless you know what you to
> +# You should not change these ones unless you know what you do

I already mentionned in in your v1, but these fixups do not belong to
PATCH 2/3. You do not want reviewers to see your mistakes in PATCH 1/2
and see the fix in PATCH 2/3.

> +wiki_getpage () {
> +	../test-gitmw.pl get_page -p "$1" "$2"
> +}

Any reason why test-gitmw.pl and wiki_getpage have this slightly
different API? The perl version has a "-p" flag, and the shell command
has only positionnal arguments.

I'd rather have a more uniform way to wrap calls to test-gitmw.pl in
shell, like

wiki_<something> () {
	../test-gitmw.pl <something> "$@"
}

Then, you probably want to move the API documentation (i.e. comments you
put before the shell functions) in, or next to the Perl script, and
avoid repeating it in the shell.

> +# git_content <dir_1> <dir_2>
> +#
> +# Compare the contents of directories <dir_1> and <dir_2> with diff
> +# and exits with error 1 if they do not match. The program will
> +# not look into .git in the process.
> +git_content () {

Didn't I already say that the naming was strange? A function that
compares something shouldn't be called just "content".

> +	result=$(diff -r -b --exclude=".git" "$1" "$2")
> +
> +	if echo $result | grep -q ">" ; then

Why grep, when the exit status of diff tells you about the differences
already?

> +# git_exist <rep_name> <file_name>
> +#
> +# Check the existence of <file_name> into the git repository
> +# <rep_name> and exits with error 1 if it is absent.
> +git_exist () {
> +	result=$(find "$1" -type f -name "$2")
> +
> +	if ! echo $result | grep -q "$2" ; then

Missing quotes around $result.

Why do you need grep again? You just want to check whether "$result" is
empty (test -z).

> +		echo "test failed: file $2 does not exist in $1"
> +		exit 1

die

?

> +wiki_page_exist () {
> +	wiki_getpage "$1" .
> +
> +	if test -f "$1".mw ; then
> +		echo "test failed: file $1 not found on wiki"
> +		exit 1

likewise.

> +fail()
> +{

Style: fail () {

Plus, didn't we say "die" was already there for this?

> +        # Replace spaces by underscore in the page name
> +	$pagename=~s/\ /_/;

Indent with space (didn't I already mention that?).

> +my $login = $ARGV[0];
> +
> +if ($login eq "-p")

Feels weird. If you're not sure it's a login, why call the variable
$login?

Any reason not to use Perl's option parsing?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
