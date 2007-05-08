From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 08 May 2007 16:56:23 -0700
Message-ID: <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
References: <4640FBDE.1000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 01:56:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZY4-000318-Op
	for gcvg-git@gmane.org; Wed, 09 May 2007 01:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969435AbXEHX40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 19:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970710AbXEHX40
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 19:56:26 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44902 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S969435AbXEHX4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 19:56:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508235623.XESE24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 19:56:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wnwP1W0021kojtg0000000; Tue, 08 May 2007 19:56:23 -0400
In-Reply-To: <4640FBDE.1000609@gmail.com> (Dana How's message of "Tue, 08 May
	2007 15:38:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46641>

Dana How <danahow@gmail.com> writes:

> Add config variables pack.compression and core.loosecompression .
> Loose objects will be compressed using level
>   isset(core.loosecompression) ? core.loosecompression :
>   isset(core.compression) ? core.compression : Z_BEST_SPEED
> and objects in packs will be compressed using level
>   isset(pack.compression) ? pack.compression :
>   isset(core.compression) ? core.compression : Z_DEFAULT_COMPRESSION
> pack-objects also accepts --compression=N which
> overrides the latter expression.

Do you think the above is readable?

  Compression level for loose objects is controlled by variable
  core.loosecompression (or core.compression, if the former is
  missing), and defaults to best-speed.

or something like that?

> This applies on top of the git-repack --max-pack-size patchset.

Hmph, that makes the --max-pack-size patchset take this more
trivial and straightforward improvements hostage.  In general,
I'd prefer more elaborate ones based on less questionable
series.

> @@ -444,6 +446,10 @@ static unsigned long write_object(struct sha1file *f,
>  				 * and we do not need to deltify it.
>  				 */
>  
> +	/* differing core & pack compression when loose object -> must recompress */
> +	if (!entry->in_pack && pack_compression_level != zlib_compression_level)
> +		to_reuse = 0;
> +	else

I am not sure if that is worth it, as you do not know if the
loose object you are looking at were compressed with the current
settings.

> diff --git a/cache.h b/cache.h
> index 8e76152..2b3f359 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -283,6 +283,8 @@ extern int warn_ambiguous_refs;
>  extern int shared_repository;
>  extern const char *apply_default_whitespace;
>  extern int zlib_compression_level;
> +extern int core_compression_level;
> +extern int core_compression_seen;

Could we somehow remove _seen?  Perhaps by initializing the
_level to -1?

> +int core_compression_level;
> +int core_compression_seen;

Same here.
