From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Mon, 23 Jul 2007 01:52:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707230141080.14781@racer.site>
References: <46A3F43C.3030101@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 02:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICmAU-0004Br-Tv
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 02:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764740AbXGWAwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763090AbXGWAwy
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 20:52:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:47689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761650AbXGWAwx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 20:52:53 -0400
Received: (qmail invoked by alias); 23 Jul 2007 00:52:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 23 Jul 2007 02:52:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GKzlyXvPGg40hOZkDVOKCZU+8TYPhLKx/P38+K8
	bQPnpaa2pUm7v/
X-X-Sender: gene099@racer.site
In-Reply-To: <46A3F43C.3030101@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53379>

Hi,

On Mon, 23 Jul 2007, Carlos Rica wrote:

> +static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
> +{
> +	struct child_process gpg;
> +	const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
> +	char *path, *eol;
> +	size_t len;
> +	int fd, ret;
> +
> +	path = xstrdup(git_path("VTAG_TMP"));
> +	fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> +	if (fd < 0)
> +		return error("could not create temporary file '%s': %s",
> +						path, strerror(errno));
> +	if (write_in_full(fd, buf, size) < 0)
> +		return error("failed writing temporary file '%s': %s",
> +						path, strerror(errno));
> +	close(fd);

I just tested something like "gpg --verify - - < <filename>" and it 
worked...

> +	/* find the length without signature */
> +	len = 0;
> +	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE "\n")) {
> +		eol = memchr(buf + len, '\n', size - len);
> +		len += eol ? eol - (buf + len) + 1 : size - len;
> +	}

How about this instead:

	const char *sig = strstr(buf, "\n" PGP_SIGNATURE "\n"));
	if (!sig)
		sig = buf + len;

Hmm?

But of course only if gpg does not grok "git cat-file tag <signed-tag> |
gpg --verify - -".

> +	remove(path);

I think we use unlink() consistently, since we are sure it is no 
directory.

> +	if (type <= OBJ_NONE)
> +		return error("%s: bad object type.", name);
> +	if (type != OBJ_TAG)
> +		return error("%s: cannot verify a non-tag object of type %s.",
> +				name, typename(type));

These two can be unified into one, right?

> +int cmd_verify_tag(int argc, const char **argv, const char *prefix)
> +{
> +	int i, verbose = 0, had_error = 0;
> +
> +	git_config(git_default_config);
> +
> +	if (argc == 1)
> +		usage(builtin_verify_tag_usage);
> +
> +	i = 1;

You can initialise i above.

> +	if (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose")) {
> +		verbose = 1;
> +		i++;
> +	}
> +
> +	signal(SIGPIPE, SIG_IGN);
> +	while (i < argc)
> +		if (verify_tag(argv[i++], verbose))

Heh.  I thought that you only made this a separate function to help 
building it into builtin-tag...

That was quick!

Ciao,
Dscho
