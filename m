From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git tag a builtin.
Date: Fri, 20 Jul 2007 09:53:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707200928050.14781@racer.site>
References: <469FF6E4.9010501@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 10:53:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBoFE-0004il-Km
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 10:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbXGTIxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 04:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbXGTIxj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 04:53:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:33519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752062AbXGTIxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 04:53:38 -0400
Received: (qmail invoked by alias); 20 Jul 2007 08:53:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 20 Jul 2007 10:53:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190Gog0L8t0DmYP+tqqylUXZQ3ZSwT0HRfEehQJI6
	Q15E03TnDNvXsH
X-X-Sender: gene099@racer.site
In-Reply-To: <469FF6E4.9010501@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53073>

Hi,

On Fri, 20 Jul 2007, Carlos Rica wrote:

> diff --git a/builtin-tag.c b/builtin-tag.c
> new file mode 100644
> index 0000000..507f510
> --- /dev/null
> +++ b/builtin-tag.c
> @@ -0,0 +1,450 @@
> +/*
> + * Builtin "git tag"
> + *
> + * Copyright (c) 2007 Kristian Hv/gsberg <krh@redhat.com>,

In case of encoding problems, I suggest uploading it to repo.or.cz, so it 
can be pulled.  Uploading has more advantages, such as visibility and 
a free backup, too...

> +typedef int (*func_tag)(const char *name, const char *ref,
> +				const unsigned char *sha1);
> +
> +static int do_tag_names(const char **argv, func_tag fn)

Neat!  Just a minor style nit here, though: in refs.h, we have something 
similar, and I would have expected to read "each_tag_name_fn" and 
"for_each_tag_name" instead of "func_tag" and "do_tag_names", 
respectively.  Hmm?

> +static ssize_t do_sign(char *buffer, size_t size, size_t max)
> +{
> +	struct child_process gpg;
> +	const char *args[4];
> +	char *bracket;
> +	int len;
> +
> +	if (!*signingkey) {
> +		if (strlcpy(signingkey, git_committer_info(1),
> +				sizeof(signingkey)) >= sizeof(signingkey))

sizeof(signingkey) - 1?

> +	len = read_in_full(gpg.out, buffer + size, max - size);
> +
> +	finish_command(&gpg);
> +
> +	if (len == max - size)
> +		return error("could not read the entire signature from gpg.");

Maybe at a later stage, and if this turns out to be not sufficient to 
begin with, we might consider not using a buffer, but writing 
incrementally into an object right away.  Think "git hash-object -w 
--stdin".

But at the moment, this is not a problem, so let's keep it as-is.

> +static int git_tag_config(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "user.signingkey")) {
> +		if (!value)
> +			die("user.signingkey without value");
> +		if (strlcpy(signingkey, value, sizeof(signingkey))
> +						>= sizeof(signingkey))

sizeof(signingkey) - 1?

> +static void create_tag(const unsigned char *object, const char *tag,
> +		       char *message, int sign, unsigned char *result)
> +{
> +	enum object_type type;
> +	char header_buf[1024], *buffer;
> +	int header_len, max_size;
> +	unsigned long size;
> +
> +	type = sha1_object_info(object, NULL);
> +	if (type <= 0)

Maybe use OBJ_NONE instead of 0?  Dunno.

> +	    die("bad object type.");
> +
> +	header_len = snprintf(header_buf, sizeof(header_buf),
> +			  "object %s\n"
> +			  "type %s\n"
> +			  "tag %s\n"
> +			  "tagger %s\n\n",
> +			  sha1_to_hex(object),
> +			  typename(type),
> +			  tag,
> +			  git_committer_info(1));
> +
> +	if (header_len >= sizeof(header_buf))

sizeof(header_buf) - 1?

> +	memmove(buffer + header_len, buffer, size);

Just two ideas for the future (it is not really important now, so we 
should not do it now):

- Instead of memmove()ing, we could teach read_fd() to take an offset, 
  too.

- launch_editor() could learn to write the buffer itself (IMHO it is more 
  common to write a buffer to the file before editing it, than editing an 
  existing file).

But as I said, this is just something to keep in mind, not to change now.

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
> +			if (read_fd(fd, &message, &len)) {

With your recent sanification of read_fd(), you can initialise len and 
message to 0 and NULL, respectively.

> +		if (!strcmp(arg, "-u")) {
> +			annotate = 1;
> +			sign = 1;
> +			i++;
> +			if (i == argc)
> +				die("option -u needs an argument.");
> +			if (strlcpy(signingkey, argv[i], sizeof(signingkey))
> +							>= sizeof(signingkey))

sizeof(signingkey) - 1?

> +				die("argument to option -u too long");
> +			continue;
> +		}
> +		if (!strcmp(arg, "-l")) {
> +			return list_tags(argv[i + 1], lines);
> +		}
> +		if (!strcmp(arg, "-d")) {
> +			return do_tag_names(argv + i + 1, delete_tag);
> +		}
> +		if (!strcmp(arg, "-v")) {
> +			return do_tag_names(argv + i + 1, verify_tag);
> +		}

Please lose the "{..}" around single lines.

> +	if (get_sha1(object_ref, object))
> +		die("Failed to resolve '%s' as a valid ref.", object_ref);
> +
> +	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) >= sizeof(ref))

sizeof(ref) - 1?

> diff --git a/git-tag.sh b/contrib/examples/git-tag.sh
> similarity index 100%
> rename from git-tag.sh
> rename to contrib/examples/git-tag.sh

That should make Nico and Junio happy.

These are my last minor nits.  If nobody else has objections, let's put 
this ship to sea.

Ciao,
Dscho
