From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 1/5] get_series: Remove comments from end of series lines
Date: Mon, 30 Jul 2007 23:50:18 -0400
Message-ID: <20070731035018.GC12918@filer.fsl.cs.sunysb.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu> <11858514812742-git-send-email-eclesh@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Tue Jul 31 05:50:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFikf-0008J7-9I
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 05:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937327AbXGaDu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 23:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935901AbXGaDuZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 23:50:25 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:41810 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935797AbXGaDuY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 23:50:24 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6V3oIS6013906;
	Mon, 30 Jul 2007 23:50:18 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6V3oIQ8013904;
	Mon, 30 Jul 2007 23:50:18 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <11858514812742-git-send-email-eclesh@ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54316>

On Mon, Jul 30, 2007 at 08:11:17PM -0700, Eric Lesh wrote:
...
> @@ -290,14 +296,17 @@ series_insert_patch()
>  # usage: series_remove_patch <patchname>
>  series_remove_patch()
>  {
> -	grep -v "^$1\$" < "$series" > "$series.tmp"
> +	grep -v "^$1[[:space:]]*#*" < "$series" > "$series.tmp"
>  	mv "$series.tmp" "$series"
>  }

I haven't tested it, but I believe that this change would be very
bad...suppose you have series with patches "foo" and "foo-2". Now if you try
to remove foo, the regexp would end up being:

"^foo[ ]*#*"

This would match both patches!
  
>  # usage: series_rename_patch <oldname> <newname>
>  series_rename_patch()
>  {
> -	awk -v old="$1" -v new="$2" \
> +	# Rename the patch, but preserve comments on the line
> +	old=$(grep -e "^$1[[:space:]]*" $series)

This could match multiple lines.

> +	new=$(echo "$old" | sed -e "s,^$1,$2,")

One more comment about sed...there are a number of place in guilt that take
patch names and create regexps from them, but don't make sure things get
properly escaped. I guess all the sed changes should be done in one go.

Also, beware that this is in a function, so setting $new and $old affects
the _all_ of guilt. One way around it would be a force subshell to execute
using parenthesis around the contents of the function body.

> +	awk -v old="$old" -v new="$new" \
>  		'{ if ($0 == old) print new; else print $0 }' \
>  		"$series" > "$series.tmp"
>  
> diff --git a/regression/050-series.sh b/regression/050-series.sh
> index eb23540..4c47e9d 100755
> --- a/regression/050-series.sh
> +++ b/regression/050-series.sh
> @@ -26,7 +26,7 @@ modify
>  add
>  
>  remove
> -mode
> +mode # and text
>  #sure
>  DONE
>  }

Good :)

Jeff.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
