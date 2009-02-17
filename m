From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-archive: Add new option "--output" to write
 archive to a file instead of stdout.
Date: Tue, 17 Feb 2009 10:38:38 -0800
Message-ID: <7v7i3o6h8x.fsf@gitster.siamese.dyndns.org>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1D6@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <carlos.duclos@nokia.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZUrY-0000sJ-9a
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZBQSio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2009 13:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZBQSio
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:38:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZBQSin convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 13:38:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DC9A22B573;
	Tue, 17 Feb 2009 13:38:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DD5182B554; Tue,
 17 Feb 2009 13:38:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 33AFE66E-FD22-11DD-B04B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110432>

<carlos.duclos@nokia.com> writes:

> 4. Didn't change the tests, it never hurts to have many tests :-)

It actually hurts me a lot.  I run every tests before pushing out the
integration results, and duplicated tests costs me a lot without adding
much value to the process.

> From b68d40dca34d45e2535c50879cce62e3b24a2f30 Mon Sep 17 00:00:00 200=
1
> From: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
> Date: Mon, 16 Feb 2009 18:20:25 +0100
> Subject: [PATCH] git-archive: Add new option "--output" to write arch=
ive to a file instead of stdout.

Very long line that you can be a bit creative to shorten.  E.g.

    git-archive: add --output=3D<file> to send output to a file instead=
 of stdout

Because anything you are adding is new, people can tell that --word is =
an
option from the context, and people who are reading "git log" output kn=
ow
that archive command traditionally writes to standard output.

> When archiving a repository there is no way to specify a file as outp=
ut. This patch adds a new option "--output" that redirects the output t=
o a file instead of stdout.

Very long line I can wrap locally so this by itself is not a grave enou=
gh
offence to ask you to fix and resubmit, but I'm asking you to redo the
tests anyway, so please wrap this while at it.

Needs a sign-off.

> diff --git a/archive.c b/archive.c
> index e6de039..e6af4ec 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -239,6 +239,23 @@ static void parse_treeish_arg(const char **argv,
>  	ar_args->time =3D archive_time;
>  }
> =20
> +static void create_output_file(const char *output_file)
> +{
> +	int output_fd =3D open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0=
666);
> +	if (output_fd < 0)
> +		die("could not create archive file: %s ", output_file);
> +	if (output_fd !=3D 1)
> +		if (dup2(output_fd, 1) < 0) {
> +			/*
> +			 * dup2 closes output_fd on success, if something=20
> +			 * goes wrong we close output_fd here to avoid
> +			 * problems.
> +			 */
> +			close(output_fd);
> +			die("could not redirect output");

The comment and close() are probably unnecessary, as you will die()
immediately.

> +test_expect_success 'tar archive output redirected' '
> +
> +	git archive --format=3Dtar --output=3Dtest.tar HEAD &&
> +	( mkdir untarred2 && cd untarred2 && "$TAR" -xf ../test.tar )
> +
> +	test_cmp sample untarred2/sample
> +
> +'

I agree with Ren=C3=A9 that the test should just create the same archiv=
e twice,
with or without --output=3D, and compare the output.

To protect your patch from future changes that may do something funny t=
o
only one side of the codepath, which is not even very likely knowing th=
e
structure of the code, I'd recommend doing two tests, one for --format=3D=
tar
and another for --format=3Dzip.

Also you do not have to introduce an inconsistent way to give option to
"tar" like the above (note that "tar xf" is the preferred traditional
notation, not "tar -xf", in this script).

Other than that, I think this is ready for 'next'.
