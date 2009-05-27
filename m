From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/4] git-am: refactor 'cleaning up and aborting'
Date: Wed, 27 May 2009 00:19:41 -0700
Message-ID: <7v1vqbj9ma.fsf@alter.siamese.dyndns.org>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-4-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:20:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9DR6-0004uj-34
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 09:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944AbZE0HTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761138AbZE0HTo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 03:19:44 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39009 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760623AbZE0HTk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 03:19:40 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090527071942.NWZO25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Wed, 27 May 2009 03:19:42 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id wXKh1b0084aMwMQ04XKhXz; Wed, 27 May 2009 03:19:41 -0400
X-Authority-Analysis: v=1.0 c=1 a=f_Kceuf0DboA:10 a=VcgI3XYSUP0A:10
 a=pGLkceISAAAA:8 a=HKmsviM8rS3QV20aXo8A:9 a=uw8oNDb1kFKxdmbbVFsA:7
 a=CM88JSBRb9eJvQxzQL22hZVP29sA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120041>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Introduce a clean_abort function that echoes an optional error message
> to standard error, removes the dotest directory and exits with status 1.
>
> Use it when patch format detection or patch splitting fails early.
> ---

S-o-b;

>  git-am.sh |   29 +++++++++++++++--------------
>  1 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 1a00830..057acfe 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -134,6 +134,15 @@ It does not apply to blobs recorded in its index."
>      unset GITHEAD_$his_tree
>  }
>  
> +clean_abort () {
> +	if test $# -gt 0
> +	then
> +		echo "$@" > /dev/stderr

	echo >&2 "$@"

> +	fi
> +	rm -fr "$dotest"
> +	exit 1
> +}
> +
>  patch_format=
>  
>  check_patch_format () {
> @@ -192,22 +201,18 @@ check_patch_format () {
>  				fi
>  				;;
>  		esac
> -	} < "$1"
> +	} < "$1" || clean_abort
>  }
>  
>  split_patches () {
>  	case "$patch_format" in
>  	mbox)
> -		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
> -			rm -fr "$dotest"
> -			exit 1
> -		}
> +		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" || clean_abort
>  		;;
>  	stgit-series)
>  		if test $# -ne 1
>  		then
> -			echo "Only one StGIT patch series can be applied at once"
> -			exit 1
> +			clean_abort "Only one StGIT patch series can be applied at once"
>  		fi
>  		series_dir=`dirname "$1"`
>  		series_file="$1"
> @@ -222,7 +227,7 @@ split_patches () {
>  			shift
>  			# remove the arg coming from the first-line comment
>  			shift
> -		} < "$series_file"
> +		} < "$series_file" || clean_abort
>  		# set the patch format appropriately
>  		patch_format=stgit
>  		# now handle the actual StGIT patches
> @@ -254,18 +259,14 @@ split_patches () {
>  					print "Subject:", $0 ;
>  					subject = 1;
>  				}
> -			}' "$stgit" > "$dotest/$msgnum" || {
> -				echo "Failed to import $patch_format patch $stgit"
> -				exit 1
> -			}
> +			}' "$stgit" > "$dotest/$msgnum" || clean_abort
>  		done
>  		echo "$this" > "$dotest/last"
>  		this=
>  		msgnum=
>  		;;
>  	*)
> -		echo "Patch format $patch_format is not supported."
> -		exit 1
> +		clean_abort "Patch format $patch_format is not supported."
>  		;;
>  	esac
>  }
> -- 
> 1.6.3.1.248.gb44be
