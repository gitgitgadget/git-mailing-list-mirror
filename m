From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make git-tag a builtin.
Date: Wed, 11 Jul 2007 22:46:29 -0700
Message-ID: <7vps2yxjgq.fsf@assigned-by-dhcp.cox.net>
References: <46952755.2050307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 07:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8rVc-0000mg-Jk
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 07:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbXGLFqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 12 Jul 2007 01:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXGLFqd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 01:46:33 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56681 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbXGLFqc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 01:46:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712054631.MTJJ1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Jul 2007 01:46:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NVmW1X00P1kojtg0000000; Thu, 12 Jul 2007 01:46:31 -0400
In-Reply-To: <46952755.2050307@gmail.com> (Carlos Rica's message of "Wed, 11
	Jul 2007 20:54:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52246>

Carlos Rica <jasampler@gmail.com> writes:

> Mime-Version: 1.0
> Content-Type: text/plain; charset=3Dwindows-1252

Hmmmmmm.....

> This replaces the script "git-tag.sh" with "builtin-tag.c".
> It is based in a previous work on it from Kristian H=C3=B8gsberg.
>
> There are some minor changes in the behaviour of "git tag" here:
> "git tag -v" now can get more than one tag to verify, like "git tag -=
d" did,
> "git tag" with no arguments prints all tags, more like "git branch" d=
oes, and
> the template for the edited message adds an empty line, like in "git =
commit".

These probably are good changes (except that "no argument" case
might be a bit annoying, but I guess it's Ok).  Is there any
need for documentation updates with these changes?

> diff --git a/builtin-tag.c b/builtin-tag.c
> new file mode 100644
> index 0000000..1824379
> --- /dev/null
> +++ b/builtin-tag.c
> @@ -0,0 +1,430 @@
> +/*
> + * Builtin "git tag"
> + *
> + * Copyright (c) 2007 Kristian H??gsberg <krh@redhat.com>,

I do not know how the above would come out, but it surely was
not H=C3=B8gsberg in the copy I received...

We probably should make sure our sources are in UTF-8; I suspect
builtin-branch.c is not.

> + *                    Carlos Rica <jasampler@gmail.com>
> + * Based on git-tag.sh and mktag.c by Linus Torvalds.
> + */
> +
> +#include "cache.h"
> +#include "builtin.h"
> +#include "refs.h"
> +#include "tag.h"
> +#include "run-command.h"
> +
> +static const char builtin_tag_usage[] =3D
> +  "git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f=
 | -d | -v] [-m <msg>] <tagname> [<head>]";
> +
> +static char signingkey[1000];
> +static int lines;
> +
> +static void launch_editor(const char *path, char **buffer, unsigned =
long *len)
> +{
> +	const char *editor, *terminal;
> +	struct child_process child;
> +	const char *args[3];
> +	int fd;
> +
> +	editor =3D getenv("VISUAL");
> +	if (!editor)
> +		editor =3D getenv("EDITOR");
> +
> +	terminal =3D getenv("TERM");
> +	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
> +		fprintf(stderr,
> +		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
> +		"Please supply the message using either -m or -F option.\n");
> +		exit(1);
> +	}

Ah, this is taken from git-commit.sh ;-) Does your "git tag"
support the -F option (builtin_tag_usage[] does not seem to
mention it)?  I wonder what happens when this function migrates
to editor.c and a new program, other than git-tag and
git-commit, that is without -F nor -m options wants to call
this.

> +	if (!editor)
> +		editor =3D "vi";
> +
> +	memset(&child, 0, sizeof(child));
> +	child.argv =3D args;
> +	args[0] =3D editor;
> +	args[1] =3D path;
> +	args[2] =3D NULL;
> +
> +	if (run_command(&child))
> +		die("could not launch editor %s.", editor);

This message is not quite true, isn't it?  The editor might have
been launched but exited with non-zero status.

> +	fd =3D open(path, O_RDONLY);
> +	if (fd =3D=3D -1)
> +		die("could not read %s.", path);

And this is "could not open", with probably strerror(errno) to
be helpful.

> +	if (read_pipe(fd, buffer, len))
> +		die("could not read message file '%s': %s",
> +		    path, strerror(errno));
> +	close(fd);
> +}
> +
> +#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> +
> +static int show_reference(const char *refname, const unsigned char *=
sha1,
> +			  int flag, void *cb_data)
> +{
> ...
> +}

Ok.

> +static int list_tags(const char *pattern)
> +{
> ...
> +}

Ok.

> +static int delete_tags(const char **argv)
> +{
> +	const char **p;
> +	char ref[PATH_MAX];
> +	int had_error =3D 0;
> +	unsigned char sha1[20];
> +
> +	for (p =3D argv; *p; p++) {
> +		if (snprintf(ref, sizeof ref, "refs/tags/%s", *p) > sizeof ref)
> +			die("tag name '%s' too long.", *p);

"sizeof foo" may be proper ANSI C, but somehow many people seem
to find "sizeof(foo)" much easier to read, including me.=20

I think the overflow check is wrong.  snprintf() does not write
more than sizeof(ref) including the training NUL, but when its
output is truncated, it returns the number of bytes that would
have been written to the buffer, excluding the NUL termination.
What this means is that if it returns sizeof(ref), it also is a
case of overflow.  Further, if C library is not C99, e.g. older
glibc (say 2.0.6), it could return negative status indicating an
error condition upon truncated output.

I suspect you inherited these problems from builtin-branch.c,
but we'd better fix them there as well.

> +		if (!resolve_ref(ref, sha1, 1, NULL)) {
> +			fprintf(stderr, "tag '%s' not found.\n", *p);
> +			had_error =3D 1;
> +			continue;
> +		}

We might want to call error("tag '%s' not found.") instead for
later libification...

> ...
> +}
> +
> +static int run_verify_tag_command(unsigned char *sha1)
> +{
> +	int ret;
> +	const char *argv_verify_tag[] =3D {"git-verify-tag",
> +					"-v", "SHA1_HEX", NULL};
> +	argv_verify_tag[2] =3D sha1_to_hex(sha1);
> +
> +	ret =3D run_command_v_opt(argv_verify_tag, 0);
> +
> +	if (ret <=3D -10000)
> +		die("unable to run %s\n", argv_verify_tag[0]);
> +	return -ret;
> +}

I wonder why you need to differentiate between ERR_RUN_COMMAND_*
and non-zero exit status...  Also do you need to "return -ret",
instead of not negating?  In C programs error returns are often
negative and finish_command() follows that convention.

> +static int verify_tags(const char **argv)
> +{
> ...
> +}

Ok.

> +static int do_sign(char *buffer, size_t size, size_t max)
> +{
> +	struct child_process gpg;
> +	const char *args[4];
> +	char *bracket;
> +	int len;
> +
> +	if (signingkey[0] =3D=3D '\0') {
> +		strlcpy(signingkey, git_committer_info(1), sizeof signingkey);
> +		bracket =3D strchr(signingkey, '>');
> +		if (bracket)
> +			bracket[1] =3D '\0';
> +	}

Hmph.  Silently truncate with strlcpy instead of erroring out on
insanely long committer info?

> +	memset(&gpg, 0, sizeof(gpg));
> +	gpg.argv =3D args;
> +	gpg.in =3D -1;
> +	gpg.out =3D -1;
> +	args[0] =3D "gpg";
> +	args[1] =3D "-bsau";
> +	args[2] =3D signingkey;
> +	args[3] =3D NULL;
> +
> +	if (start_command(&gpg))
> +		die("could not run gpg.");
> +
> +	write_or_die(gpg.in, buffer, size);
> +	close(gpg.in);
> +	gpg.close_in =3D 0;
> +	len =3D read_in_full(gpg.out, buffer + size, max - size);

Bi-di pipes makes me nervous, but this case should be Ok. It
could try writing "---BEGIN PGP SIGNATURE---" before reading
from you and get stuck because you are not reading from it but
that is only in theory.

I wonder why our read_in_full and write_in_full do not return
ssize_t although that's how they count things internally.  At
least you could make do_sign() to return ssize_t, and change the
die() to "return error()" to have the caller deal with it, which
would be easier for people other than "git tag -s" to call this
if they later want to.

What happens when gpg gave more than you expect?  We get
truncated signature and I do not see any code to notice the
breakage...

> +
> +	finish_command(&gpg);
> +
> +	return size + len;
> +}
> +
> +static const char tag_template[] =3D
> +	"\n"
> +	"#\n"
> +	"# Write a tag message\n"
> +	"#\n";
> +
> +static int git_tag_config(const char *var, const char *value)
> +{
> ...
> +}

Ok, except for the same strlcpy comment above.

> +#define MAX_SIGNATURE_LENGTH 1024
> +/* message must be NULL or allocated, it will be reallocated and fre=
ed */
> +static void create_tag(const unsigned char *object, const char *tag,
> +		       char *message, int sign, unsigned char *result)
> +{
> +	enum object_type type;
> +	char header_buf[1024], *buffer;
> +	int header_len, max_size;
> +	unsigned long size;
> +
> +	type =3D sha1_object_info(object, NULL);
> +	if (type <=3D 0)
> +	    die("bad object type.");
> +
> +	header_len =3D snprintf(header_buf, sizeof header_buf,
> +			  "object %s\n"
> +			  "type %s\n"
> +			  "tag %s\n"
> +			  "tagger %s\n\n",
> +			  sha1_to_hex(object),
> +			  typename(type),
> +			  tag,
> +			  git_committer_info(1));
> +
> +	if (header_len >=3D sizeof header_buf)
> +		die("tag header too big.");

This comparison '>=3D' is correct (i.e. not '>'), as opposed to
the one I commented way above.

> +	if (!message) {
> ...
> +	}
> +	else {
> +		buffer =3D message;
> +		size =3D strlen(message);
> +	}
> +
> +	size =3D stripspace(buffer, size, 1);
> +
> +	if (!message && !size)
> +		die("no tag message?");

Why check 'message' here?

> ...
> +	free(buffer);
> +}

The rest is Ok.

> +int cmd_tag(int argc, const char **argv, const char *prefix)
> +{
> ...
> +		if (!strcmp(arg, "-F")) {
> +			unsigned long len;
> +			annotate =3D 1;
> +			i++;
> +			if  (i =3D=3D argc)
> +				die("option -F needs an argument.");
> +
> +			fd =3D open(argv[i], O_RDONLY);
> +			if (fd < 0)
> +				die("cannot open %s", argv[1]);

The shell script version relies on the magic "cat -" to read
from standard input upon "git tag -F -".  It is understandable
that both of you and Dscho missed it, though.

> +			len =3D 1024;
> +			message =3D xmalloc(len);
> +			if (read_pipe(fd, &message, &len))
> +				die("cannot read %s", argv[1]);
> +			message =3D xrealloc(message, len + 1);
> +			message[len] =3D '\0';
> +			continue;
> +		}

We might be better off if read_pipe() is renamed to read_fd()
and made internally always NUL-terminate the buffer (but not
count that NUL as part of length).  I dunno.

> +		if (!strcmp(arg, "-u")) {
> +			annotate =3D 1;
> +			sign =3D 1;
> +			i++;
> +			if  (i =3D=3D argc)
> +				die("option -u needs an argument.");
> +			strlcpy(signingkey, argv[i], sizeof signingkey);
> +			continue;

Extra space "if  (expr".  Return from strlcpy() not checked?

> +	if (snprintf(ref, sizeof ref, "refs/tags/%s", tag) > sizeof ref)
> +		die("tag '%s' too long.", tag);

This use of snprintf() and checking the overflow as error is
much nicer, don't you think, instead of silently ignoring
truncation?

> ...
> +}

The remainder of cmd_tag() looks Ok.
