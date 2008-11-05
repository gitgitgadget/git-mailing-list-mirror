From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 3/3] pack-objects: honor '.keep' files
Date: Wed, 05 Nov 2008 16:37:16 -0600
Message-ID: <GV8cY3fn8l5UV5cNoPN8bHchWt9u2tbZ8j_ypkiY-ZLfO1tx9d7ebA@cipher.nrlssc.navy.mil>
References: <-RiFxYEd9Wiq2fWX74zYGUiEwrzLeoFDb1KuG3-Xo-s@cipher.nrlssc.navy.mil> <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:39:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxr1g-000276-Pj
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937AbYKEWhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbYKEWhq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:37:46 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59334 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbYKEWho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:37:44 -0500
Received: by mail.nrlssc.navy.mil id mA5MbH9G011566; Wed, 5 Nov 2008 16:37:17 -0600
In-Reply-To: <LSyxMgVV7zAWRvSezvxyUc6-kz2gK6MRVKonKSf1pAmdqO-jeuMFIw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Nov 2008 22:37:17.0277 (UTC) FILETIME=[0E81D0D0:01C93F97]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100193>


Junio,

Please leave this in pu for now, I have some concerns that I haven't
had time to write down yet.

-brandon


Brandon Casey wrote:
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
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>  builtin-pack-objects.c |    2 +-
>  t/t7700-repack.sh      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 15b80db..8be9113 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -701,7 +701,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  				break;
>  			if (incremental)
>  				return 0;
> -			if (local && !p->pack_local)
> +			if (local && (!p->pack_local || p->pack_keep))
>  				return 0;
>  		}
>  	}
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 27af5ab..5b1cd05 100755
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
