From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git tag a builtin.
Date: Fri, 20 Jul 2007 02:10:48 -0700
Message-ID: <7v1wf3zbhj.fsf@assigned-by-dhcp.cox.net>
References: <469FF6E4.9010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 11:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBoVk-0001U9-2b
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 11:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbXGTJKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 05:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754950AbXGTJKv
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 05:10:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65239 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbXGTJKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 05:10:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720091047.EYBF1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Jul 2007 05:10:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RlAo1X00M1kojtg0000000; Fri, 20 Jul 2007 05:10:49 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53074>

Carlos Rica <jasampler@gmail.com> writes:

> This replaces the script "git-tag.sh" with "builtin-tag.c".

Thanks.  Will queue in 'next', and perhaps with a few nit fixups
to merge as the first thing after 1.5.3.

> diff --git a/builtin-tag.c b/builtin-tag.c
> new file mode 100644
> index 0000000..507f510
> --- /dev/null
> +++ b/builtin-tag.c
> @@ -0,0 +1,450 @@
> +/*
> + * Builtin "git tag"
> + *
> + * Copyright (c) 2007 Kristian H??gsberg <krh@redhat.com>,

I've fixed up the name here in my copy.

> +static void launch_editor(const char *path, char **buffer, unsigned long *len)
> +{
> +	const char *editor, *terminal;
> +	struct child_process child;
> +	const char *args[3];
> +	int fd;
> +
> +	editor = getenv("VISUAL");
> +	if (!editor)
> +		editor = getenv("EDITOR");
> +
> +	terminal = getenv("TERM");
> +	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
> +		fprintf(stderr,
> +		"Terminal is dumb but no VISUAL nor EDITOR defined.\n"
> +		"Please supply the message using either -m or -F option.\n");
> +		exit(1);
> +	}
> +
> +	if (!editor)
> +		editor = "vi";

launch-editor() would need adjustment for GIT_EDITOR and
core.editor which should be straightforward.

> +struct tag_filter {
> +	const char *pattern;
> +	int lines;
> +};
> +
> +#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
> +
> +static int show_reference(const char *refname, const unsigned char *sha1,
> +			  int flag, void *cb_data)
> +{
> +	struct tag_filter *filter = cb_data;
> +
> +	if (!fnmatch(filter->pattern, refname, 0)) {
> +		int i;
> +		unsigned long size;
> +		enum object_type type;
> +		char *buf, *sp, *eol;
> +		size_t len;
> +
> +		if (!filter->lines) {
> +			printf("%s\n", refname);
> +			return 0;
> +		}
> +		printf("%-15s ", refname);
> +
> +		sp = buf = read_sha1_file(sha1, &type, &size);
> +		if (!buf || !size)
> +			return 0;

Theoretically, I can create millions of lightweight tags, all of
them pointing at a zero-length blob object (or an empty tree
object) and kill you with memory leak here ;-).

> +		/* skip header */
> +		while (sp + 1 < buf + size &&
> +				!(sp[0] == '\n' && sp[1] == '\n'))
> +			sp++;
> +		/* only take up to "lines" lines, and strip the signature */
> +		for (i = 0, sp += 2; i < filter->lines && sp < buf + size &&
> +				prefixcmp(sp, PGP_SIGNATURE "\n");
> +				i++) {

Minor nit; I would have split this to four physical lines, like:

		for (i = 0, sp += 2;
			i < filter->lines && sp < buf + size &&
			prefixcmp(sp, PGP_SIGNATURE "\n");
			i++) {

The places that semicolons appear are more significant gaps when
reading the code.

> +int cmd_tag(int argc, const char **argv, const char *prefix)
> +{
> ...
> +		if (!strcmp(arg, "-F")) {
> +			unsigned long len;
> +			int fd;
> +
> +			annotate = 1;
> +			i++;
> +			if (i == argc)
> +				die("option -F needs an argument.");
> +
> +			if (!strcmp(argv[i], "-"))
> +				fd = 0;
> +			else {
> +				fd = open(argv[i], O_RDONLY);
> +				if (fd < 0)
> +					die("could not open '%s': %s",
> +						argv[i], strerror(errno));
> +			}
> +			len = 1024;
> +			message = xmalloc(len);

You cannot anticipate how many bytes the user will type (or
pipe-in), but when you opened the file you could fstat() to see
how many bytes you would need to hold the contents of that
file.  Even in stdin case fstat(fd) could tell you the size, but
I am not sure how to tell if the st_size is reliable.  But for
the purposes of "git tag", 1k buffer that grows on demand is
probably cheaper than a fstat() syscall.

> +			if (read_fd(fd, &message, &len)) {
> +				free(message);
> +				die("cannot read %s", argv[i]);
> +			}
> +			continue;

We seem to leak fd here, but the user is doing something insane
if he gives more than one -F anyway, so it probably is Ok, as
long as we have some sanity checks.  Should we barf on "git tag
-m foo -F bar"?  What should we do with "git tag -m one -m two"?

Does the test suite check any of these conditions?

> +	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) >= sizeof(ref))
> +		die("tag name too long: %.*s...", 50, tag);

Cute and considerate ;-).

> diff --git a/git-tag.sh b/contrib/examples/git-tag.sh
> similarity index 100%
> rename from git-tag.sh
> rename to contrib/examples/git-tag.sh

This actually caught my attention for completely different
reason.  If this were removal of git-tag.sh, this would have
conflicted when applied on top of Adam's GIT_EDITOR/core.editor
patch.  With a rename, however, there is no preimage/context
shown, so it just cleanly applied.

Also Johannes's final minor nits.
