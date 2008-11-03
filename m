From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] pack-objects: honor '.keep' files
Date: Mon, 3 Nov 2008 08:17:34 -0800
Message-ID: <20081103161734.GK15463@spearce.org>
References: <14536526.1225596838300.JavaMail.teamon@b301.teamon.com> <1225643477-32319-1-git-send-email-foo@foo.com> <1225643477-32319-2-git-send-email-foo@foo.com> <4002818.1225643406819.JavaMail.teamon@b303.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, nico@cam.org
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 03 17:18:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx28g-0007oW-QK
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbYKCQRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 11:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754442AbYKCQRg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:17:36 -0500
Received: from george.spearce.org ([209.20.77.23]:54849 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbYKCQRf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 11:17:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9794F3835F; Mon,  3 Nov 2008 16:17:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4002818.1225643406819.JavaMail.teamon@b303.teamon.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99958>

drafnel@gmail.com wrote:
> From: Brandon Casey <drafnel@gmail.com>
> 
> By default, pack-objects creates a pack file with every object specified by
> the user. There are two options which can be used to exclude objects which
> are accessible by the repository.
> 
>    1) --incremental
>      This excludes any object which already exists in an accessible pack.
> 
>    2) --local
>      This excludes any object which exists in a non-local pack.
> 
> With this patch, both arguments also cause objects which exist in packs
> marked with a .keep file to be excluded. Only the --local option requires
> an explicit check for the .keep file. If the user doesn't want the objects
> in a pack marked with .keep to be exclude, then the .keep file should be
> removed.
> 
> Additionally, this fixes the repack bug which allowed porcelain repack to
> create packs which contained objects already contained in existing packs
> marked with a .keep file.

This looks sane to me, but I'm holding off on the ack because
I don't like the way the flags are managed in struct packed_git.
(See my reply to 1/3 in the series.)

 
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
> 
> 
> This seems to be the correct fix.
> 
> I thought about two alternatives:
> 
>   1) New option to pack-objects which causes it to honor .keep files
> 
>      I didn't think this was necessary since that is why we have .keep
>      files in the first place.
> 
>      So, now there are three variants:
> 
>      Neither --incremental or --local is used)
>         Ignore repo packs, pack is created using all objects specified by
>         user.
>      --incremental is used)
>         Look at repo packs, exclude already packed objects (including those
>         marked with .keep file)
>      --local is used)
>         Look at repo packs, exclude objects in non-local packs (including local
>         objects marked with .keep file)
> 
>   2) Always honor .keep files, even when --incremental or --local is
>      not specified. 
> 
>      I think this may be counter-intuitive, since if you specify all of
>      the objects explicitly, without using any other options, you expect
>      all of those objects to be placed into the created pack file. If
>      .keep is always honored, then a new option would be required to
>      indicate ignoring .keep files, or we would adopt the platform that
>      "the user must just remove the .keep file".
> 
> 
> So, honoring .keep files only with --incremental (which is a side effect) or
>  --local seems to be the most appropriate.
> 
> Comments welcome.
> 
> -brandon
> 
> 
>  builtin-pack-objects.c |    2 +-
>  t/t7700-repack.sh      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 6a8b9bf..5199e54 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -701,7 +701,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  				break;
>  			if (incremental)
>  				return 0;
> -			if (local && !ispacklocal(p))
> +			if (local && (!ispacklocal(p) || haspackkeep(p)))
>  				return 0;
>  		}
>  	}
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 1489e68..b6b02da 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -4,7 +4,7 @@ test_description='git repack works correctly'
>  
>  . ./test-lib.sh
>  
> -test_expect_failure 'objects in packs marked .keep are not repacked' '
> +test_expect_success 'objects in packs marked .keep are not repacked' '
>  	echo content1 > file1 &&
>  	echo content2 > file2 &&
>  	git add . &&
> -- 
> 1.6.0.2.588.g3102
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Shawn.
