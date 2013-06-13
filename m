From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 4/4] git-mw: Adding preview tool in git-mw.perl
Date: Thu, 13 Jun 2013 14:13:25 +0200
Message-ID: <vpq61xiryxm.fsf@anie.imag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-5-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 13 14:13:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un6PK-0000Xp-K5
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 14:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab3FMMNe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 08:13:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40093 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab3FMMNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 08:13:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5DCDOFC023051
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 14:13:25 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Un6P8-00041G-7E; Thu, 13 Jun 2013 14:13:26 +0200
In-Reply-To: <1371118039-18925-5-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 13 Jun 2013 12:07:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 13 Jun 2013 14:13:25 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227722>

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> This final commit adds the preview subcommand to git mw. It works as =
such:
> 1- Find the remote name of the current branch's upstream and check if=
 it's a
> mediawiki one.
> 1b- If it's not found or if it's not a mediawiki one. It will list al=
l the
> mediawiki remotes configured and ask the user to replay the command w=
ith the
> --remote option set.
> 2- Parse the content of the local file (or blob) (given as argument) =
using
> the distant mediawiki's API
> 3- Retrieve the current page on the distant mediawiki
> 4- Replaces all content in that page with the newly parsed one
> 5- Convert relative links into absolute
> 6- Save the result on disk
>
> The command accepts those options:
>   --autoload | -a tries to launch the newly generated file in the use=
r's
>                   default browser (using git web--browse)
>   --remote | -r provides a way to select the distant mediawiki in whi=
ch
>                 the user wants to preview his file (or blob)
>   --output | -o enables the user to choose the output filename. Defau=
lt
>                 output filename is based on the input filename in whi=
ch
>                 the extension '.mw' is replaced with '.html'
>   --blob | -b tells the script that the last argument is a blob and n=
ot
>               a filename

A commit messages that answers the "what?" and "how?" questions (as
opposed to "why?") is always suspicious: doesn't the message belong
elsewhere?

Here, you have a nice user documentation for command-line options, and
the actual user doc is much poorer:

> +sub preview_help {
> +	print <<'END';
> +usage: git mw preview [--remote|-r <remote name>] [--autoload|-a]
> +                      [--output|-o <output filename>] <filename>
> +
> +    -r, --remote    Specify which mediawiki should be used
> +    -o, --output    Name of the output file
> +    -a, --autoload  Autoload the page in your default web browser
> +END

(shorter description, missing --blob)

> +	} else { # file mode
> +		if (! -e $file_name) {
> +			die "File $file_name does not exists \n";

We're just setting a convention to use ${var} in string interpolation
(Celestin's perlcritic patch series), so better do it right now ;-).

Did you try "make perlcritic" on your code?

> +	# Default preview_file_name is file_name with .html ext
> +	if ($preview_file_name eq '') {

EMPTY ?

> +	if ($remote_name eq '') {

EMPTY ?

> +	# Load template page
> +	$template =3D get("$remote_url/index.php?title=3D$wiki_page_name")
> +		or die "You need to create $wiki_page_name before previewing it";

I got hit again by the HTTPS certificate validation failure. It would
make sense to have a more detailed error message, including the URL,
because having the same error:

You need to create Accueil before previewing it at /home/moy/local/usr-=
wheezy/libexec/git-core/git-mw line 182.

for any kind of HTTP failure is a painful. Doesn't "get" return an HTTP
code? If so, your message would make sense for 404 errors, but not for
the others.

> +	$mw_content_text =3D $html_tree->look_down('id', 'mw-content-text')=
;

Unfortunately, this doesn't seem standard. It doesn't work on
https://ensiwiki.ensimag.fr/index.php/Accueil at least (which is my mai=
n
use-case :-( ).

At least, you should check $mw_content_text and have a nice error
message here. As much as possible, you should allow a way to solve it
(make the lookup configurable in .git/config, or allow the user to
specify an arbitrary HTML template to plug onto, or display the raw,
incomplete, HTML).

I replaced 'mw-content-text' with 'bodyContent' and it worked.

Then I got

Wide character in print at /usr/lib/perl/5.14/IO/Handle.pm line 159.

but the file was generated. There are encoding problems: the title says
"Le Wiki des &Atilde;&copy;tudiants et enseignants" (it should be a =C9=
).

I guess you fed the API with an improper encoding (double UTF-8
encoding, or UTF-8 announced as latin-1 or so), and the API returned yo=
u
some hard-coded, badly encoded, rendered HTML.

> @@ -41,6 +241,7 @@ usage: git mw <command> <args>
> =20
>  git mw commands are:
>      Help        Display help information about git mw
> +    Preview 	Parse and render local file into HTML
>  END

Lower-case help and preview.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
