From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Wed, 2 Jan 2013 04:46:36 -0500
Message-ID: <20130102094635.GD9328@sigill.intra.peff.net>
References: <201301012240.10722.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 02 10:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqKuj-00086e-GY
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 10:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666Ab3ABJqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 04:46:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41261 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab3ABJqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 04:46:50 -0500
Received: (qmail 28789 invoked by uid 107); 2 Jan 2013 09:47:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jan 2013 04:47:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2013 04:46:36 -0500
Content-Disposition: inline
In-Reply-To: <201301012240.10722.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212511>

On Tue, Jan 01, 2013 at 10:40:08PM +0100, Torsten B=C3=B6gershausen wro=
te:

> Add the perl script "check-non-portable-shell.pl" to detect non-porta=
ble
> shell syntax

Cool. Thanks for adding more test-lint. But...

> diff --git a/t/Makefile b/t/Makefile
> index 88e289f..7b0c4dc 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -23,7 +23,7 @@ TGITWEB =3D $(sort $(wildcard t95[0-9][0-9]-*.sh))
> =20
>  all: $(DEFAULT_TEST_TARGET)
> =20
> -test: pre-clean $(TEST_LINT)
> +test: pre-clean test-lint-shell-syntax $(TEST_LINT)
>  	$(MAKE) aggregate-results-and-cleanup

I do not think it should be a hard-coded dependency of "test", as then
there is no way to turn it off. It would make more sense to me to set a
default TEST_LINT that includes it, but could be overridden by the user=
=2E

>  prove: pre-clean $(TEST_LINT)
> @@ -43,7 +43,7 @@ clean-except-prove-cache:
>  clean: clean-except-prove-cache
>  	$(RM) .prove
> =20
> -test-lint: test-lint-duplicates test-lint-executable
> +test-lint: test-lint-duplicates test-lint-executable test-lint-shell=
-syntax

This, however, is right. The point of "test-lint" is "use all the lint"=
,
so adding it here makes sense (and anyone who has set "TEST_LINT =3D
test-lint" will get the new check).

> +test-lint-shell-syntax:
> +	$(PERL_PATH) check-non-portable-shell.pl $(T)

This is wrong if $(PERL_PATH) contains spaces, no? Doing "$(PERL_PATH)"
is also wrong, because the expansion happens in 'make', and a
$(PERL_PATH) with double-quotes would fool the shell. Since we export
$PERL_PATH, I think doing:

  "$$PERL_PATH"" check-non-portable-shell.pl $(T)

would be sufficient.

> --- /dev/null
> +++ b/t/check-non-portable-shell.pl
> @@ -0,0 +1,67 @@
> +#!/usr/bin/perl -w

This "-w" is ignored, since we execute by using $PERL_PATH. Maybe "use
warnings" instead?

> +sub check_one_file($) {

Perl subroutine prototypes are generally frowned on unless there is a
good reason to use them.

> +	my $lineno=3D1;

Perl keeps track of this for you in the "$." variable.

> +	my $filename=3Dshift;

And if you use the automagic "<>" handle, this is already in $ARGV (but
note that you need to do a little bit of magic to make that work with
$.; see the entry for "$." in perlvar, and "eof" in perlfunc).

> +	open(FINPUT, "<$filename") || die "Couldn't open filename $filename=
";
> +	my @fdata =3D <FINPUT>;
> +	close(FINPUT);
> +
> +	while (my $line =3D shift @fdata) {

Not that our test scripts are so huge they won't fit into memory, but i=
t
is generally good practice to loop on the handle rather than reading al=
l
of the lines into an array.

> +    do {

What's this do block for?

> +      # sed -i
> +      if ($line =3D~ /^\s*sed\s+-i/) {
> +        printf("%s:%d:error: \"sed -i not portable\" %s\n", $filenam=
e, $lineno, $line);
> +				$exitcode=3D1;
> +      }

These would be a lot more readable if the printf was pulled out into a
helper function. And you can avoid the escaped quotes by using perl's q=
q
operator. E.g., qq(this string has "quotes" in it).

Also, putting a space before the "error:" matches what gcc outputs,
which some editors (e.g., vim) can recognize and let the user jump
straight to the error.

> +while (@ARGV) {
> +	my $arg =3D shift @ARGV;
> +  check_one_file($arg);
> +}

You can replace this with the magic <> filehandle.


So taking all of that, a more idiomatic perl script would look somethin=
g
like:

  my $exit_code;
  sub err {
    my $msg =3D shift;
    print "$ARGV:$.: error: $msg: $_\n";
    $exit_code =3D 1;
  }

  while (<>) {
    chomp;
    if (/^\s*sed\s+-i/) {
      err('sed -i is not portable');
    }
    # ...and so on

    # this resets our $. for each file
    close ARGV if eof;
  }
  exit $exit_code;

I'd personally probably write the conditions like:

  /^\s*sed\s+-i/ and err('sed -i is not portable');

to make the structure of the program (i.e., a list of conditions to
complain about) clear, but I know not everybody agrees with such a ters=
e
style.

-Peff
