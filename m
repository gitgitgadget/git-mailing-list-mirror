From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Bisect: implement "bisect dunno" to mark untestable
 revisions.
Date: Mon, 8 Oct 2007 04:49:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080444290.4174@racer.site>
References: <20071008053450.a52d7c5e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 05:50:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iejd2-00035o-Hj
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 05:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbXJHDtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 23:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbXJHDtt
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 23:49:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:58235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752820AbXJHDtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 23:49:49 -0400
Received: (qmail invoked by alias); 08 Oct 2007 03:49:46 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp021) with SMTP; 08 Oct 2007 05:49:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KZ7EyAaJKa7BAGGImCPaginMRj09EWDA6TvNY10
	7wANJZs1RQmI5S
X-X-Sender: gene099@racer.site
In-Reply-To: <20071008053450.a52d7c5e.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60284>

Hi,

On Mon, 8 Oct 2007, Christian Couder wrote:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 388887a..c556318 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -143,7 +145,7 @@ bisect_write_bad() {
>  
>  bisect_good() {
>  	bisect_autostart
> -        case "$#" in
> +	case "$#" in

White space breakage.

> @@ -153,7 +155,6 @@ bisect_good() {
>  		rev=$(git rev-parse --verify "$rev^{commit}") || exit
>  		bisect_write_good "$rev"
>  		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
> -

?

> @@ -164,6 +165,28 @@ bisect_write_good() {
>  	echo "# good: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
>  }
>  
> +bisect_dunno() {
> +	bisect_autostart
> +	case "$#" in
> +	0)    revs=$(git rev-parse --verify HEAD) || exit ;;
> +	*)    revs=$(git rev-parse --revs-only --no-flags "$@") &&
> +		test '' != "$revs" || die "Bad rev input: $@" ;;
> +	esac
> +	for rev in $revs
> +	do
> +		rev=$(git rev-parse --verify "$rev^{commit}") || exit
> +		bisect_write_dunno "$rev"
> +		echo "git-bisect dunno $rev" >>"$GIT_DIR/BISECT_LOG"

Should the last line not be put into bisect_write_dunno?  OTOH this is the 
only call site of that function, so I strongly doubt that the function 
(consisting of 3 lines, where the first is 'rev="$1"') is necessary at 
all.

> @@ -206,17 +229,104 @@ bisect_auto_next() {
>  	bisect_next_check && bisect_next || :
>  }
>  
> +search_dunno() {
> +	_hash="$1"
> +	_dunno="$2"
> +
> +	for _val in $_dunno ; do
> +		case $_hash in $_val) return 1 ;; esac
> +	done

This would be faster as

	case " $1" in " $2") return 1 ;; esac

I guess.

But as I said in the other reply, I think this logic belongs into the C 
core, instead of generating mostly useless information, passing it down to 
the script, and filtering it out again.

Thanks,
Dscho
