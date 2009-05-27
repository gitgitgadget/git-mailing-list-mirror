From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/4] git-am foreign patch support: autodetect some patch formats
Date: Wed, 27 May 2009 00:19:40 -0700
Message-ID: <7vd49vj9mb.fsf@alter.siamese.dyndns.org>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:20:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9DR5-0004uj-Ct
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 09:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760233AbZE0HTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 03:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761386AbZE0HTl
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 03:19:41 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42726 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761410AbZE0HTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 03:19:39 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090527071941.OLLD20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Wed, 27 May 2009 03:19:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id wXKg1b0044aMwMQ04XKgXr; Wed, 27 May 2009 03:19:40 -0400
X-Authority-Analysis: v=1.0 c=1 a=S15djls4RtoA:10 a=amMmSd6g5qsA:10
 a=pGLkceISAAAA:8 a=-lQvamUIZXVBCp6VTdgA:9 a=6TueLPoIT_nHhVreVLQ5YtK10g0A:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120042>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> +	# otherwise, check the first few lines of the first patch to try
> +	# to detect its format
> +	{
> +		read l1
> +		read l2
> +		read l3
> +		case "$l1" in
> +			From\ *)
> +				patch_format=mbox
> +				;;
> +			From:\ *)
> +				patch_format=mbox
> +				;;
> +			'# This series applies on GIT commit'*)
> +				patch_format=stgit-series
> +				;;
> +			"# HG changeset patch")
> +				patch_format=hg
> +				;;
> +			*)
> +				# if the second line is empty and the third is
> +				# a From, Author or Date entry, this is very
> +				# likely an StGIT patch
> +				if test "x$l2" = x
> +				then
> +					case "$l3" in
> +						From:\ *)
> +							patch_format=stgit
> +							;;
> +						Author:\ *)
> +							patch_format=stgit
> +							;;
> +						Date:\ *)
> +							patch_format=stgit
> +							;;
> +						*)
> +							;;
> +					esac
> +				fi
> +				;;
> +		esac

Don't make the case unnecessary too deep nor redundant.

	...
	read l3
	case "$l1" in
	"From "* | "From: "* )
		patch_format=mbox
		;;
	"# This ...")
		...
		;;
	*)
		case "$l2,$l3" in
		,"From: "* | ,"Author: "* | ,"Date: "*)
			patch_format=stgit
			;;
		esac
		;;
	esac

> +	} < "$1"
>  }
>  
>  split_patches () {
> -- 
> 1.6.3.1.248.gb44be
