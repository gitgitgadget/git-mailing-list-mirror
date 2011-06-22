From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCHv2 7/9] archive: implement configurable tar filters
Date: Wed, 22 Jun 2011 08:09:51 +0200
Message-ID: <4E01872F.8070503@lsrfire.ath.cx>
References: <20110622011923.GA30370@sigill.intra.peff.net> <20110622012631.GG30604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 22 08:10:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZGdh-0003Q4-8N
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 08:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab1FVGKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 02:10:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:36289 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1FVGKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 02:10:05 -0400
Received: from [192.168.2.106] (p4FFDB633.dip.t-dialin.net [79.253.182.51])
	by india601.server4you.de (Postfix) with ESMTPSA id ACBF02F8079;
	Wed, 22 Jun 2011 08:10:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110622012631.GG30604@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176220>

Hello,

just a quick comment before I drop off the net for a few days.  I like
the series a lot, especially the refactorings in patches 1 to 6.

Am 22.06.2011 03:26, schrieb Jeff King:
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index 9c750e2..726bf63 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -101,6 +101,16 @@ tar.umask::
>  	details.  If `--remote` is used then only the configuration of
>  	the remote repository takes effect.
>  
> +tar.<format>.command::

Would switching around format and "command" be better?

	[tar "command"]
		tar.gz = gzip -cn
		tar.xz = xz -c

> diff --git a/archive-tar.c b/archive-tar.c
> index bed9a9b..5c30747 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -4,6 +4,7 @@
>  #include "cache.h"
>  #include "tar.h"
>  #include "archive.h"
> +#include "run-command.h"
>  
>  #define RECORDSIZE	(512)
>  #define BLOCKSIZE	(RECORDSIZE * 20)
> @@ -13,6 +14,9 @@ static unsigned long offset;
>  
>  static int tar_umask = 002;
>  
> +static int write_tar_filter_archive(const struct archiver *ar,
> +				    struct archiver_args *args);
> +
>  /* writes out the whole block, but only if it is full */
>  static void write_if_needed(void)
>  {
> @@ -220,6 +224,60 @@ static int write_global_extended_header(struct archiver_args *args)
>  	return err;
>  }
>  
> +static struct archiver **tar_filters;
> +static int nr_tar_filters;
> +static int alloc_tar_filters;
> +
> +static struct archiver *find_tar_filter(const char *name, int len)
> +{
> +	int i;
> +	for (i = 0; i < nr_tar_filters; i++) {
> +		struct archiver *ar = tar_filters[i];
> +		if (!strncmp(ar->name, name, len) && !ar->name[len])
> +			return ar;
> +	}
> +	return NULL;
> +}
> +
> +static int tar_filter_config(const char *var, const char *value, void *data)
> +{
> +	struct archiver *ar;
> +	const char *dot;
> +	const char *name;
> +	const char *type;
> +	int namelen;
> +
> +	if (prefixcmp(var, "tar."))
> +		return 0;
> +	dot = strrchr(var, '.');
> +	if (dot == var + 9)
> +		return 0;
> +
> +	name = var + 4;
> +	namelen = dot - name;
> +	type = dot + 1;
> +
> +	ar = find_tar_filter(name, namelen);
> +	if (!ar) {
> +		ar = xcalloc(1, sizeof(*ar));
> +		ar->name = xmemdupz(name, namelen);
> +		ar->write_archive = write_tar_filter_archive;
> +		ar->flags = ARCHIVER_WANT_COMPRESSION_LEVELS;
> +		ALLOC_GROW(tar_filters, nr_tar_filters + 1, alloc_tar_filters);
> +		tar_filters[nr_tar_filters++] = ar;
> +	}
> +
> +	if (!strcmp(type, "command")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		free(ar->data);
> +		ar->data = xstrdup(value);
> +		return 0;
> +	}

Why not register it right here instead of adding it to the intermediate
list?  And are duplicates handled properly, e.g. system has "gzip -cn"
and local wants "gzip -c"?
