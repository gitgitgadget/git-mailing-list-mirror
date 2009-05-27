From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/4] git-am foreign patch support: StGIT support
Date: Wed, 27 May 2009 00:19:40 -0700
Message-ID: <7v7i03j9mb.fsf@alter.siamese.dyndns.org>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9DR7-0004uj-Cb
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 09:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761383AbZE0HTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 03:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757909AbZE0HTn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 03:19:43 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39007 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761412AbZE0HTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 03:19:39 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090527071942.NWZM25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Wed, 27 May 2009 03:19:42 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id wXKg1b00B4aMwMQ04XKgXu; Wed, 27 May 2009 03:19:41 -0400
X-Authority-Analysis: v=1.0 c=1 a=u217S5DB6-EA:10 a=VLcXo6BCFe0A:10
 a=pGLkceISAAAA:8 a=0KG2QjlQkSYAfJyHZjIA:9 a=xfXX30WnhZ-BEyznEIkA:7
 a=-4FgxZIQkMAe9i4__Oa0jMYYzP4A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120040>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Support StGIT patches by implementing a simple awk-based converter
> mimicking StGIT's own parse_patch. Also support StGIT patch series by
> 'exploding' the index into a lif of files and re-running the mail
> splitting with patch_format set to stgit.
> ---
>  git-am.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 4cf66aa..1a00830 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -203,6 +203,66 @@ split_patches () {
>  			exit 1
>  		}
>  		;;
> +	stgit-series)
> +		if test $# -ne 1
> +		then
> +			echo "Only one StGIT patch series can be applied at once"
> +			exit 1
> +		fi
> +		series_dir=`dirname "$1"`
> +		series_file="$1"
> +		shift
> +		{
> +			set x
> +			while read filename
> +			do
> +				set "$@" "$series_dir/$filename"
> +			done
> +			# remove the safety x
> +			shift
> +			# remove the arg coming from the first-line comment
> +			shift
> +		} < "$series_file"
> +		# set the patch format appropriately
> +		patch_format=stgit
> +		# now handle the actual StGIT patches
> +		split_patches "$@"

Can an stgit patch file (or the leading pathname for that matter) have IFS
character in its name?

> +		;;
> +	stgit)
> +		this=0
> +		for stgit in "$@"
> +		do
> +			this=`expr "$this" + 1`
> +			msgnum=`printf "%0${prec}d" $this`
> +			touch "$dotest/$msgnum"

Portability tip from an old timer: do not create a new empty file with
"touch" (only use that command to update the timestamp of an existing
file).

Instead say

	>"$dotest/$msgnum"

> +			# Awk version of StGIT parse_patch. The first nonemptyline
> +			# not starting with Author, From or Date is the
> +			# subject, and the body starts with the next nonempty
> +			# line not starting with Author, From or Date
> +			awk 'BEGIN { subject=0 }
> +			{
> +				if (subject > 1)
> +					print ;
> +				else if (/^$/) next ;
> +				else if (/^Author:/) print sub("Author", "From"), $ORS ;

Can any token that match Author other than the initial "Author: " appear
on this line?

Since we rely on Perl but not awk in core-ish part of the scripted
Porcelains, it might be a good idea to write this in Perl as well.

> +				else if (/^(From|Date)/) print ;
> +				else if (subject) {
> +					subject = 2 ;
> +					print "" ;
> +					print ;
> +				} else {
> +					print "Subject:", $0 ;
> +					subject = 1;
> +				}
> +			}' "$stgit" > "$dotest/$msgnum" || {
> +				echo "Failed to import $patch_format patch $stgit"
> +				exit 1
> +			}
> +		done
> +		echo "$this" > "$dotest/last"
> +		this=
> +		msgnum=
> +		;;
>  	*)
>  		echo "Patch format $patch_format is not supported."
>  		exit 1
> -- 
> 1.6.3.1.248.gb44be
