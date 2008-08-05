From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Teach fsck and prune that tmp_obj_ file names may not
	be 14 bytes long
Date: Tue, 5 Aug 2008 12:07:22 -0700
Message-ID: <20080805190722.GC27207@spearce.org>
References: <I1vUBkF5DO9PiWvc0SRIfOHigaNX9d2kNHLqpAUceLenX-_BWPAliQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 05 21:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQRtR-0001N8-Rt
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 21:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761001AbYHETHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759058AbYHETHY
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 15:07:24 -0400
Received: from george.spearce.org ([209.20.77.23]:51212 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757550AbYHETHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 15:07:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A382538419; Tue,  5 Aug 2008 19:07:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <I1vUBkF5DO9PiWvc0SRIfOHigaNX9d2kNHLqpAUceLenX-_BWPAliQ@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91454>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> As Shawn pointed out, not all temporary file creation routines can
> ensure that the generated temporary file is of a certain length.
> e.g. Java's createTempFile(prefix, suffix). So just depend on the
> prefix 'tmp_obj_' for detection.
> 
> Update prune, and fix the "fix" introduced by a08c53a1 :)

Arrrrgh!  :-)

Thanks for cleaning up my mess.
 
> Signed-off-by: Brandon "appendixless" Casey <casey@nrlssc.navy.mil>
> ---
>  builtin-fsck.c  |    2 +-
>  builtin-prune.c |    9 ++++-----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin-fsck.c b/builtin-fsck.c
> index 6eb7da8..d3f3de9 100644
> --- a/builtin-fsck.c
> +++ b/builtin-fsck.c
> @@ -385,7 +385,7 @@ static void fsck_dir(int i, char *path)
>  			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
>  			continue;
>  		}
> -		if (prefixcmp(de->d_name, "tmp_obj_"))
> +		if (!prefixcmp(de->d_name, "tmp_obj_"))
>  			continue;
>  		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
>  	}
> diff --git a/builtin-prune.c b/builtin-prune.c
> index 947de8c..c767a0a 100644
> --- a/builtin-prune.c
> +++ b/builtin-prune.c
> @@ -69,11 +69,6 @@ static int prune_dir(int i, char *path)
>  			if (de->d_name[0] != '.')
>  				break;
>  			continue;
> -		case 14:
> -			if (prefixcmp(de->d_name, "tmp_obj_"))
> -				break;
> -			prune_tmp_object(path, de->d_name);
> -			continue;
>  		case 38:
>  			sprintf(name, "%02x", i);
>  			memcpy(name+2, de->d_name, len+1);
> @@ -90,6 +85,10 @@ static int prune_dir(int i, char *path)
>  			prune_object(path, de->d_name, sha1);
>  			continue;
>  		}
> +		if (!prefixcmp(de->d_name, "tmp_obj_")) {
> +			prune_tmp_object(path, de->d_name);
> +			continue;
> +		}
>  		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
>  	}
>  	if (!show_only)
> -- 
> 1.5.6.2
> 

-- 
Shawn.
