From: Josef Sipek <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH] guilt(1): simplifications...
Date: Thu, 14 Jun 2007 10:58:45 -0400
Message-ID: <20070614145845.GA934@filer.fsl.cs.sunysb.edu>
References: <11818254621527-git-send-email-madcoder@debian.org> <11818254621458-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 16:58:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyqmi-0001Zk-5G
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 16:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbXFNO6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 10:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbXFNO6t
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 10:58:49 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:36413 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbXFNO6s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 10:58:48 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l5EEwjos002494;
	Thu, 14 Jun 2007 10:58:45 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l5EEwjnX002492;
	Thu, 14 Jun 2007 10:58:45 -0400
Content-Disposition: inline
In-Reply-To: <11818254621458-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50202>

On Thu, Jun 14, 2007 at 02:50:58PM +0200, Pierre Habouzit wrote:
>   + using awk to avoid local variables
>   + more clever with sed
>   + reimplement munge_hash_range with case
> 
>   and some whitespace problems.

Few tiny comments.

Thanks for the patches.

... 
>  # usage: do_make_header <hash>
>  do_make_header()
>  {
> -	# which revision do we want to work with?
> -	local rev="$1"
> -
>  	# we should try to work with commit objects only
> -	if [ `git-cat-file -t "$rev"` != "commit" ]; then
> -		echo "Hash $rev is not a commit object" >&2
> +	if [ `git-cat-file -t "$1"` != "commit" ]; then
> +		echo "Hash $1 is not a commit object" >&2
>  		echo "Aborting..." >&2
>  		exit 2
>  	fi
>  
> -	# get the author line from the commit object
> -	local author=`git-cat-file -p "$rev" | grep -e '^author ' | head -1`
> -
> -	# strip the timestamp & '^author ' string
> -	author=`echo "$author" | sed -e 's/^author //' -e 's/ [0-9]* [+-]*[0-9][0-9]*$//'`
> -
> -	git-cat-file -p "$rev" | awk "
> -BEGIN{ok=0}
> -(ok==1){print \$0; print \"\nFrom: $author\"; ok=2; next}
> -(ok==2){print \$0}
> -/^\$/ && (ok==0){ok=1}
> -"
> +	git-cat-file -p "$1" | sed -e \
> +		'1,/^$/ {
> +			/^author/ {
> +				s/^author /From: /
> +				s/ [0-9]* [+-]*[0-9][0-9]*$//
> +				p
> +			}
> +			/^$/p
> +			d
> +		}'

You changed the output slightly. The original awk script outputed:

>>>>>
the first line of the commit message

From: foo@....

remainder of the commit message
<<<<<

Yours outputs:

>>>>>
From: foo@....

the entire commit message
<<<<<

I'd like to keep the previous format as it makes it easier to grab the first
line of each patch file to get the "short summary" (assuming you follow the
kernel/git/guilt commit message conventions). This doesn't make anything in
guilt easier, it just makes the patch files more friendly to other tools one
might use. (Especially if they grab the first line and use it as the subject
in emails.)



> @@ -260,17 +246,12 @@ head_check()
>  # usage: series_insert_patch <patchname>
>  series_insert_patch()
>  {
> -	local top=`get_top | sed -e 's,/,\\\\/,g'`
> -	local new=`echo "$1" | sed -e 's,/,\\\\/,g'` 
> -
> -	if [ ! -z "$top" ]; then
> -		sed -i -e "s/^$top\$/$top\n$new/" "$series"
> -	else
> -		# don't use $new here as it would only complicate things
> -		echo "$1" > "$series.tmp"
> -		cat "$series" >> "$series.tmp"
> -		mv "$series.tmp" "$series"
> -	fi
> +	awk -v top="`get_top`" -v new="$1" '{
> +			if (top == "" && NR == 1) print new;
> +			print $0;
> +			if (top != "" && top == $0) print new;
> +		}' "$series" > "$series.tmp"
> +	mv "$series.tmp" "$series"
>  }
>  
>  # usage: series_remove_patch <patchname>
> @@ -283,10 +264,11 @@ series_remove_patch()
>  # usage: series_rename_patch <oldname> <newname>
>  series_rename_patch()
>  {
> -	local old=`echo "$1" | sed -e 's,/,\\\\/,g'`
> -	local new=`echo "$2" | sed -e 's,/,\\\\/,g'` 
> +	awk -v old="$1" -v new="$2" \
> +		'{ if ($0 == old) print new; else print $0 }' \
> +		"$series.tmp" > "$series"
 
Shouldn't that be '"$series" > "$series.tmp"' ?

> -	sed -i -e "s/^$old\$/$new/" "$series"
> +	mv "$series.tmp" "$series"
>  }
>  
>  # Beware! This is one of the few (only?) places where we modify the applied
> @@ -295,10 +277,15 @@ series_rename_patch()
>  # usage: applied_rename_patch <oldname> <newname>
>  applied_rename_patch()
>  {
> -	local old=`echo "$1" | sed -e 's,/,\\\\/,g'`
> -	local new=`echo "$2" | sed -e 's,/,\\\\/,g'` 
> +	awk -v old="$1" -v new="$2" \
> +			'BEGIN{FS=":"}
> +			{ if ($1 ~ /^[0-9a-f]*$/ && length($1) == 40 && substr($0, 42) == old)
> +				print substr($0, 0, 41) new;
> +			else
> +				print;
> +			}' "$applied" > "$applied.new"
                                                 ^^^^

> -	sed -i -e "s/^\\([0-9a-f]\\{40\\}\\):$old\$/\\1:$new/" "$applied"
> +	mv "$applied.tmp" "$applied"
                    ^^^^

.new or .tmp?

Josef "Jeff" Sipek.

-- 
The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself. Therefore all progress
depends on the unreasonable man.
		- George Bernard Shaw
