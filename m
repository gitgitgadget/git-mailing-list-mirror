From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [Alt. PATCH 1/2] repack: add -F flag to let user choose between
 --no-reuse-delta/object
Date: Mon, 27 Sep 2010 10:10:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009271009490.1146@xanadu.home>
References: <20100927133104.25ce5285@jk.gs>
 <alpine.LFD.2.00.1009270742250.1146@xanadu.home>
 <20100927141936.590d71b3@jk.gs>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_QW1514aUn0DBnq9n41oEIg)"
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Sep 27 16:10:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0EPU-0005nw-LA
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 16:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759164Ab0I0OKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 10:10:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40839 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab0I0OKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 10:10:15 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L9E0088CSP25A40@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 27 Sep 2010 10:10:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100927141936.590d71b3@jk.gs>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157333>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_QW1514aUn0DBnq9n41oEIg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Mon, 27 Sep 2010, Jan Krüger wrote:

> In 479b56ba ('make "repack -f" imply "pack-objects --no-reuse-object"'),
> git repack -f was changed to include recompressing all objects on the
> zlib level on the assumption that if the user wants to spend that much
> time already, some more time won't hurt (and recompressing is useful if
> the user changed the zlib compression level).
> 
> However, "some more time" can be quite long with very big repositories,
> so some users are going to appreciate being able to choose. If we are
> going to give them the choice, --no-reuse-object will probably be
> interesting a lot less frequently than --no-reuse-delta. Hence, this
> reverts -f to the old behaviour (--no-reuse-delta) and adds a new -F
> option that replaces the current -f.
> 
> Measurements taken using this patch on a current clone of git.git
> indicate a 17% decrease in time being made available to users:
> 
> git repack -Adf  34.84s user 0.56s system 145% cpu 24.388 total
> git repack -AdF  38.79s user 0.56s system 133% cpu 29.394 total
> 
> Signed-off-by: Jan Krüger <jk@jk.gs>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
> 
> --- Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > I personally don't find --no-reuse-object particularly useful.  I
> > hardly imagine that people are changing the pack compression level
> > that often if at all.  So I doubt moving the current
> > --no-reuse-object behavior to -F and reverting -f to
> > --no-reuse-delta would cause any serious inconvenience.  It certainly
> > won't _break_ anything.  So you have my ACK to do that change.
> 
> Here we go.
> 
>  Documentation/git-repack.txt |    6 +++++-
>  git-repack.sh                |    6 ++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 8c67d17..9566727 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -8,7 +8,7 @@ git-repack - Pack unpacked objects in a repository
>  
>  SYNOPSIS
>  --------
> -'git repack' [-a] [-A] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
> +'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=N] [--depth=N]
>  
>  DESCRIPTION
>  -----------
> @@ -62,6 +62,10 @@ other objects in that pack they already have locally.
>  	linkgit:git-pack-objects[1].
>  
>  -f::
> +	Pass the `--no-reuse-delta` option to `git-pack-objects`, see
> +	linkgit:git-pack-objects[1].
> +
> +-F::
>  	Pass the `--no-reuse-object` option to `git-pack-objects`, see
>  	linkgit:git-pack-objects[1].
>  
> diff --git a/git-repack.sh b/git-repack.sh
> index 1eb3bca..769baaf 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -10,7 +10,8 @@ git repack [options]
>  a               pack everything in a single pack
>  A               same as -a, and turn unreachable objects loose
>  d               remove redundant packs, and run git-prune-packed
> -f               pass --no-reuse-object to git-pack-objects
> +f               pass --no-reuse-delta to git-pack-objects
> +F               pass --no-reuse-object to git-pack-objects
>  n               do not run git-update-server-info
>  q,quiet         be quiet
>  l               pass --local to git-pack-objects
> @@ -34,7 +35,8 @@ do
>  		unpack_unreachable=--unpack-unreachable ;;
>  	-d)	remove_redundant=t ;;
>  	-q)	GIT_QUIET=t ;;
> -	-f)	no_reuse=--no-reuse-object ;;
> +	-f)	no_reuse=--no-reuse-delta ;;
> +	-F)	no_reuse=--no-reuse-object ;;
>  	-l)	local=--local ;;
>  	--max-pack-size|--window|--window-memory|--depth)
>  		extra="$extra $1=$2"; shift ;;
> -- 
> 1.7.2.3.392.g02377.dirty
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_QW1514aUn0DBnq9n41oEIg)--
