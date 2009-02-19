From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Thu, 19 Feb 2009 23:44:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902192337040.6223@intel-tinevez-2-302>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902151942.15055.robin.rosenberg.lists@dewire.com> <7vvdrbjwbt.fsf@gitster.siamese.dyndns.org> <200902192321.17802.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 23:46:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaHep-0006fs-Kr
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 23:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbZBSWon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 17:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbZBSWom
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 17:44:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:33056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754223AbZBSWol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 17:44:41 -0500
Received: (qmail invoked by alias); 19 Feb 2009 22:44:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 19 Feb 2009 23:44:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/KeljLUc/bSIaO9Scclvsv/wN8KWXY4acPsxJKp
	wqQ3T4bdVvJox6
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200902192321.17802.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110763>

Hi,

On Thu, 19 Feb 2009, Robin Rosenberg wrote:

> Here is a new version on my ammendments to Junios patch.

s/on/of/

> 
> -- robin
> 
> From 67347a63ce5ba324a750eb2c1ed7b9b0260d966a Mon Sep 17 00:00:00 2001
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Thu, 19 Feb 2009 23:18:59 +0100
> Subject: [PATCH] Recover from some known repack failure situations
> 
> For the know problems that we can recover from we exit
> with code 2 instead of 1.

s/know/known/

> Also removed the old packs when repack succeeds

s/removed/remove/  s/$/./

> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---

I'd suggest a complete rewording of the commit message, though:

	repack: exit with status 2 for non-fatal errors

	Under certain circumstances, e.g. on Windows, when a pack file 
	is still in use, deleting files can fail.

	This is a non-fatal error condition, as the repository is not 
	corrupted as a consequence; however, it is an error nevertheless, 
	as $GIT_DIR takes more space than it should.

	We indicate that special condition with an exit status 2.

> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index aaa8852..e5ecd66 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -24,6 +24,12 @@ associated index file.
>  Packs are used to reduce the load on mirror systems, backup
>  engines, disk storage, etc.
>  
> +On Windows repacking may fail because packs that should be replaced
> +are locked by other programs. In this case the program will recover
> +from the situation with an exit code of 2. The user does not have
> +to take any action to recover. For repacking to succeed the user
> +mustc stop the offending program or wait for it to close the packs.

s/The user does not have to take any action to recover. //

(It is not true)

s/mustc/must/

> +
>  OPTIONS
>  -------
>  
> diff --git a/git-repack.sh b/git-repack.sh
> index 0f13043..519c83a 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -136,8 +136,15 @@ then
>  		do
>  			echo >&2 "WARNING:   old-$file -> $file"
>  		done
> +		exit 1
>  	fi
> -	exit 1
> +	echo >&2 "INFO: We recovered from the repack error, but your repo"
> +	echo >&2 "INFO: is probably suboptimally packed. You may try to repack"
> +	echo >&2 "INFO: later. A common reason for repacking failure is that"
> +	echo >&2 "INFO: a Windows program was locking one of the old pack files."
> +	echo >&2 "INFO: To repack successfully you may have to close that program"

Two long lines.

> +	echo >&2 "INFO: before repacking."
> +	exit 2
>  fi
>  
>  # Now the ones with the same name are out of the way...
> @@ -152,6 +159,15 @@ do
>  	exit
>  done
>  
> +# Remove the "old-" files

s/old-/old-pack-/

> +for name in $names
> +do
> +	rm -f "$PACKDIR/old-pack-$name.idx"
> +	rm -f "$PACKDIR/old-pack-$name.pack"
> +done
> +
> +# End of pack replacement.

Is this comment really needed here?

Ciao,
Dscho
