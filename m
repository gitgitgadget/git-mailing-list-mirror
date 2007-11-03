From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reuse previous annotation when overwriting a tag
Date: Sat, 3 Nov 2007 11:54:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031148460.4362@racer.site>
References: <1194082273-19486-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 12:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHbJ-0001CD-CL
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbXKCLz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 07:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXKCLz1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:55:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:34916 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752975AbXKCLz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:55:26 -0400
Received: (qmail invoked by alias); 03 Nov 2007 11:55:24 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp039) with SMTP; 03 Nov 2007 12:55:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bpgore4YbQowvLa3r5ftKNprszZZr+zy7dsPJis
	iAJA1EQliScnMY
X-X-Sender: gene099@racer.site
In-Reply-To: <1194082273-19486-1-git-send-email-mh@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63241>

Hi,

On Sat, 3 Nov 2007, Mike Hommey wrote:

> diff --git a/builtin-tag.c b/builtin-tag.c
> index 66e5a58..cfd8017 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -247,9 +247,42 @@ static int git_tag_config(const char *var, const char *value)
>  	return git_default_config(var, value);
>  }
>  
> +static void write_annotation(int fd, const unsigned char *sha1)

Technically, it is the "body".

> +{
> +	int i;
> +	unsigned long size;
> +	enum object_type type;
> +	char *buf, *sp, *eol;
> +	size_t len;
> +
> +	sp = buf = read_sha1_file(sha1, &type, &size);
> +	if (!buf)
> +		return;
> +	if (!size || (type != OBJ_TAG)) {

Please lose the extra parents.

> +		free(buf);
> +		return;
> +	}
> +	/* skip header */
> +	while (sp + 1 < buf + size &&
> +			!(sp[0] == '\n' && sp[1] == '\n'))
> +		sp++;

This can be done much easier with 'sp = strstr(buf, "\n\n");'.  You can 
even do that before the previous if(), to free() && return if there is no 
body.

> +	/* strip the signature */
> +	for (i = 0, sp += 2; sp < buf + size &&
> +			prefixcmp(sp, PGP_SIGNATURE "\n");
> +			i++) {
> +		eol = memchr(sp, '\n', size - (sp - buf));
> +		len = eol ? eol - sp : size - (sp - buf);
> +		write_or_die(fd, sp, len + 1);
> +		if (!eol)
> +			break;
> +		sp = eol + 1;
> +	}
> +	free(buf);

This can be done much easier with 'eob = strstr(sp, "\n" PGP_SIGNATURE 
"\n");'.

> +}
> +
>  static void create_tag(const unsigned char *object, const char *tag,
>  		       struct strbuf *buf, int message, int sign,
> -			   unsigned char *result)
> +			unsigned char *prev, unsigned char *result)

This changes indentation.

> @@ -282,6 +315,10 @@ static void create_tag(const unsigned char *object, const char *tag,
>  		if (fd < 0)
>  			die("could not create file '%s': %s",
>  						path, strerror(errno));
> +
> +		if (prev)
> +			write_annotation(fd, prev);
> +
>  		write_or_die(fd, tag_template, strlen(tag_template));

Isn't an "else" missing before the write_or_die() here?

> @@ -308,7 +345,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buf;
>  	unsigned char object[20], prev[20];
> -	int annotate = 0, sign = 0, force = 0, lines = 0, message = 0;
> +	int annotate = 0, sign = 0, force = 0, lines = 0,
> +	    message = 0, existed = 0;
>  	char ref[PATH_MAX];
>  	const char *object_ref, *tag;
>  	int i;
> @@ -417,9 +455,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		hashclr(prev);
>  	else if (!force)
>  		die("tag '%s' already exists", tag);
> +	else
> +		existed = 1;
>  
>  	if (annotate)
> -		create_tag(object, tag, &buf, message, sign, object);
> +		create_tag(object, tag, &buf, message, sign,
> +			   existed ? prev : NULL, object);

Why not teach write_annotations() (or write_tag_body() like I would prefer 
it to be called) to grok a null_sha1?  It's not like we care for 
performance here, but rather for readability and ease of use.

Ciao,
Dscho
