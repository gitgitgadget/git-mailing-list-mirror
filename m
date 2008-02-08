From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 18:20:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081809270.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:21:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNXqP-0002Z3-Qa
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 19:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759927AbYBHSU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 13:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759552AbYBHSU1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 13:20:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:57977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757683AbYBHSUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 13:20:25 -0500
Received: (qmail invoked by alias); 08 Feb 2008 18:20:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 08 Feb 2008 19:20:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yGuYRshXyco6RkqmdX8NbEeo0r+e0LrYDBAxWo9
	NbLjQjfxmGIuU6
X-X-Sender: gene099@racer.site
In-Reply-To: <200802081828.43849.kendy@suse.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73121>

Hi,

On Fri, 8 Feb 2008, Jan Holesovsky wrote:

> +static void send_want(int fd[2], const char *remote, int full_info)
> +{
> +	if (full_info)
> +		packet_write(fd[1], "want %s%s%s%s%s%s%s%s%s\n",
> +				remote,
> +				(multi_ack ? " multi_ack" : ""),
> +				(use_sideband == 2 ? " side-band-64k" : ""),
> +				(use_sideband == 1 ? " side-band" : ""),
> +				(args.use_thin_pack ? " thin-pack" : ""),
> +				(args.no_progress ? " no-progress" : ""),
> +				(args.commits_only ? " commits-only" : ""),
> +				(args.exact_objects ? " exact-objects" : ""),
> +				" ofs-delta");
> +	else
> +		packet_write(fd[1], "want %s\n", remote);
> +}

You might want to make the full_info static, and only send the options the 
first time.

> @@ -523,11 +541,15 @@ static int get_pack(int xd[2], char **pack_lockfile)
>  				strcpy(keep_arg + s, "localhost");
>  			*av++ = keep_arg;
>  		}
> +		if (args.exact_objects)
> +			*av++ = "--ignore-remote-alternates";
>  	}
>  	else {
>  		*av++ = "unpack-objects";
>  		if (args.quiet)
>  			*av++ = "-q";
> +		if (args.exact_objects)
> +			*av++ = "--ignore-remote-alternates";
>  	}

You can move this outside of the if() instead of repeating yourself...

> @@ -556,6 +578,7 @@ static struct ref *do_fetch_pack(int fd[2],
>  	unsigned char sha1[20];
>  
>  	get_remote_heads(fd[0], &ref, 0, NULL, 0);
> +
>  	if (is_repository_shallow() && !server_supports("shallow"))
>  		die("Server does not support shallow clients");
>  	if (server_supports("multi_ack")) {

Not strictly necessary, right? ;-)

> @@ -647,12 +686,72 @@ static void fetch_pack_setup(void)
>  	did_setup = 1;
>  }
>  
> +static void read_from_stdin(int *num, char ***records)
> +{
> +	char buffer[4096];
> +	size_t records_num, leftover;
> +	ssize_t ret;
> +
> +	*num = 0;
> +	leftover = 0;
> +
> +	records_num = 4096;
> +	(*records) = xmalloc(records_num * sizeof(char *));
> +
> +	do {
> +		char *p, *last;
> +
> +		ret = xread(0 /*stdin*/, buffer + leftover,
> +				sizeof(buffer) - leftover);
> +		if (ret < 0)
> +			die("read error on input: %s", strerror(errno));
> +
> +		last = buffer;
> +		for (p = buffer; p < buffer + leftover + ret; p++)
> +			if ((!*p || *p == '\n') && (p != last)) {
> +				if (*num >= records_num) {
> +					records_num *= 2;
> +					(*records) = xrealloc(*records,
> +							      records_num * sizeof(char*));
> +				}
> +
> +				if (p - last > 0) {
> +					(*records)[*num] =
> +						strndup(last, p - last);
> +					(*num)++;
> +				}
> +				last = p + 1;
> +			}
> +
> +		leftover = p - last;
> +		if (leftover >= sizeof(buffer))
> +			die("input line too long");
> +		if (leftover < 0)
> +			leftover = 0;
> +
> +		memmove(buffer, last, leftover);
> +	} while (ret > 0);
> +
> +	if (leftover) {
> +		if (*num >= records_num) {
> +			records_num *= 2;
> +			(*records) = xrealloc(*records,
> +					      records_num * sizeof(char*));
> +		}
> +
> +		(*records)[*num] = strndup(buffer, leftover);
> +		(*num)++;
> +	}
> +}
> +

This chunk could use ALLOC_GROW() quite nicely (would make it more 
readable, and avoid errors).  Also, I'd use alloc_nr() instead of the 
doubling.

>  int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  {
>  	int i, ret, nr_heads;
>  	struct ref *ref;
>  	char *dest = NULL, **heads;
> +	int from_stdin;
>  
> +	from_stdin = 0;

You can initialise it to 0 right away...

Unfortunately, I have to go now... so I will review the rest 
(from builtin-fetch.c on) later.

It's great seeing that you work on this!

Thanks,
Dscho
