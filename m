From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] When archiving a repository there is no way to specify a
 file as output.
Date: Fri, 13 Feb 2009 15:05:19 -0800
Message-ID: <7v8woa6iq8.fsf@gitster.siamese.dyndns.org>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1D2@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: <carlos.duclos@nokia.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 00:07:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY77e-0001Pv-DL
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 00:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbZBMXFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 18:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbZBMXFc
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 18:05:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbZBMXFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 18:05:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ACFAF2B12B;
	Fri, 13 Feb 2009 18:05:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A25792B129; Fri,
 13 Feb 2009 18:05:23 -0500 (EST)
In-Reply-To: <599636D7828020419E3AB2DE5CCC8130036BF8B1D2@NOK-EUMSG-02.mgdnok.nokia.com>
 (carlos duclos's message of "Fri, 13 Feb 2009 16:34:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CE3D03A4-FA22-11DD-B2EC-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109784>

<carlos.duclos@nokia.com> writes:

> Short description:
> To enable that I added a new option "--output" that will redirect the
> output to a file instead to stdout.

I won't discuss patch submission technicalities here; they are important
to help you get understood by others, but Jakub covered the issues very
well already.

> When archiving a repository there is no way to send the result to a file
> without using redirection at shell level. Since there are situations
> where redirection is not available, for instance when running git inside
> a continuous integration system which is already redirecting the output,
> I added an option to write the archive to a file directly.

If your CI can run 'git' with four strings 'archive', '--output',
'myout.tar', and 'HEAD' as its parameters, it can certainly run 'sh' with
parameters '-c', 'git archive "$0" >"$1"', 'HEAD' and 'myout.tar'.

In other words, saying "sometimes redirection is not available, and we
must support output file parameter" is not a convincing justification.

The patch is in the "It would be nice if the command allowed --output=file
option, and here is a patch to do so" category.

Which is still a good reason that justifies the change, but it is more
honest and does not overstate its importance.

> diff --git a/archive-zip.c b/archive-zip.c
> index cf28504..dd3ba27 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -14,6 +14,8 @@ static unsigned int zip_offset;
>  static unsigned int zip_dir_offset;
>  static unsigned int zip_dir_entries;
>
> +static int output_fd = 1;
> +
>  #define ZIP_DIRECTORY_MIN_SIZE (1024 * 1024)
>
>  struct zip_local_header {
> @@ -219,12 +221,12 @@ static int write_zip_entry(struct archiver_args
> *args,
>         copy_le32(header.size, uncompressed_size);
>         copy_le16(header.filename_length, pathlen);
>         copy_le16(header.extra_length, 0);
> -       write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
> +       write_or_die(output_fd, &header, ZIP_LOCAL_HEADER_SIZE);

This function takes archiver_args, so args->output_fd is available to you
without introducing a new global variable.  Woudln't it make more sense to
pass archiver_args around to functions that do write() but do not
currently receive it, and use args->output_fd throughout, getting rid of
the global variable?

> +static void create_output_file(const char *output_file, struct
> archiver_args *ar_args)
> +{
> +       int fd = -1;
> +
> +       fd = creat(output_file, S_IRUSR | S_IWUSR);

When the resulting mode does not matter, we try hard to let the user's
umask take effect by not limiting the mode like this ourselves.

> +       if(fd < 0)

Style... "if (fd < 0)".  They are everywhere...

> +static void create_output_file(const char *output_file, struct
> archiver_args *ar_args)
> +{
> +       int fd = -1;
> +
> +       fd = creat(output_file, S_IRUSR | S_IWUSR);
> +       if(fd < 0)
> +               die("could not create archive file");
> +       ar_args->output_fd = fd;
> +}
> +
> ...
> @@ -294,6 +306,14 @@ static int parse_archive_args(int argc, const
> char **argv,
>         if (!base)
>                 base = "";
>
> +       if(output)
> +               create_output_file(output, args);
> +       else
> ...

This is not wrong per-se but I do not like it very much.  Should "parse"
function make an externally observable side effect of creating a file?

It is plausible that sufficiently sick person may want to run

	git archive --output=msgfile --list

to get the list of supported formats in the message file, but if that is
the use case you are trying to support, obviously we would need to open
the output file and dup it to fd=1 instead ;-).

No, I am not seriously suggesting to support the above as a valid use
case, but open-to-dup trick might make the patch much smaller.

Also the correctness of this code is a bit tricky; parse_archive_args() is
called by write_archive() before setup_git_directory() is called, and it
depends on this initialization order to work correctly from inside a
subdirectory.  Otherwise you would be prepending the "prefix" to "output"
before calling create_output_file() here.  It might warrant a comment to
note this fact here.

> ---
>  Documentation/git-archive.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Squash this into the main patch so that the code change and documentation
updates go hand in hand, please.

Also this needs a new test.
