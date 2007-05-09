From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Wed, 9 May 2007 02:30:16 +0200
Message-ID: <20070509003016.GJ4489@pasky.or.cz>
References: <4640FBDE.1000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 02:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hla4Z-0007w9-9E
	for gcvg-git@gmane.org; Wed, 09 May 2007 02:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbXEIAaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 20:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbXEIAaV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 20:30:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56135 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbXEIAaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 20:30:20 -0400
Received: (qmail 28962 invoked by uid 2001); 9 May 2007 02:30:16 +0200
Content-Disposition: inline
In-Reply-To: <4640FBDE.1000609@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46646>

On Wed, May 09, 2007 at 12:38:22AM CEST, Dana How wrote:
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 8824793..e80a1d6 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -444,6 +446,10 @@ static unsigned long write_object(struct sha1file *f,
>  				 * and we do not need to deltify it.
>  				 */
>  
> +	/* differing core & pack compression when loose object -> must recompress */
> +	if (!entry->in_pack && pack_compression_level != zlib_compression_level)
> +		to_reuse = 0;
> +	else
>  	if (!entry->in_pack && !entry->delta) {

Style: the else and if should be probably on the same line.

>  		unsigned char *map;
>  		unsigned long mapsize;
> @@ -1624,6 +1630,16 @@ static int git_pack_config(const char *k, const char *v)
>  		window = git_config_int(k, v);
>  		return 0;
>  	}
> +	if (!strcmp(k, "pack.compression")) {
> +		int level = git_config_int(k, v);
> +		if (level == -1)
> +			level = Z_DEFAULT_COMPRESSION;
> +		else if (level < 0 || level > Z_BEST_COMPRESSION)
> +			die("bad pack compression level %d", level);
> +		pack_compression_level = level;
> +		pack_compression_seen = 1;
> +		return 0;
> +	}
>  	return git_default_config(k, v);
>  }
>  

Where is this documented?

> @@ -1761,6 +1779,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  				usage(pack_usage);
>  			continue;
>  		}
> +		if (!prefixcmp(arg, "--compression=")) {
> +			char *end;
> +			int level = strtoul(arg+14, &end, 0);
> +			if (!arg[14] || *end)
> +				usage(pack_usage);
> +			if (level == -1)
> +				level = Z_DEFAULT_COMPRESSION;
> +			else if (level < 0 || level > Z_BEST_COMPRESSION)
> +				die("bad pack compression level %d", level);
> +			pack_compression_level = level;
> +			continue;
> +		}
>  		if (!prefixcmp(arg, "--window=")) {
>  			char *end;
>  			window = strtoul(arg+9, &end, 0);

Where is this documented?

> diff --git a/config.c b/config.c
> index 70d1055..5627ed6 100644
> --- a/config.c
> +++ b/config.c
> @@ -304,13 +306,27 @@ int git_default_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> -	if (!strcmp(var, "core.compression")) {
> +	if (!strcmp(var, "core.loosecompression")) {

Is this config variable documented?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
