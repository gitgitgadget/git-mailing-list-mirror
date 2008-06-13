From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3] git-instaweb: Enhanced auto-discovery of httpd and call conventions. Removed backticks.
Date: Fri, 13 Jun 2008 10:02:14 -0700
Message-ID: <20080613170214.GF5966@yp-box.dyndns.org>
References: <1213264759-5264-1-git-send-email-flavio@polettix.it> <1213307695-2563-1-git-send-email-flavio@polettix.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Flavio Poletti <flavio@polettix.it>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7CgC-0004V6-55
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 19:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbYFMRCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 13:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbYFMRCQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 13:02:16 -0400
Received: from hand.yhbt.net ([66.150.188.102]:47616 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYFMRCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 13:02:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 078D97DC026;
	Fri, 13 Jun 2008 10:02:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1213307695-2563-1-git-send-email-flavio@polettix.it>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84901>

Flavio Poletti <flavio@polettix.it> wrote:
> This patch allows calling:
> 
>    git-instaweb -d apache2
> 
> and have the script Do The Right Thing. In particular, the auto-discovery
> mechanism has been extended in order to be used for module listing as
> well, and the call convention is that if the daemon is apache2/lighttpd
> and the parameter to the "-d" option does not end by "-f", the "-f" is
> added to the end of the option itself.
> 
> Changed all backticks to $( ... ) as per Documentation/CodingGuidelines:
> 
>    For shell scripts specifically (not exhaustive):
> 
>       - We prefer $( ... ) for command substitution; unlike ``, it
>          properly nests.  It should have been the way Bourne spelled
>          it from day one, but unfortunately isn't.
> 
> The rationale is that the POSIX shell does support $( ... ), and git
> does make use of it rather extensively. (Thanks to Jakub Narebski for
> pointing this out).
> 
> Signed-off-by: Flavio Poletti <flavio@polettix.it>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
> 
> Sorry for the traffic, but I noticed that a stray warning was emitted
> due to a last-second change (which teaches me once more that those
> "innocent" last-second it-cannot-spoil-anything changes are the
> most poisonus snakes in programming.
> 
>  git-instaweb.sh |   48 +++++++++++++++++++++++++++++++++---------------
>  1 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 6f91c8f..af0fde5 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -22,10 +22,10 @@ restart        restart the web server
>  . git-sh-setup
>  
>  fqgitdir="$GIT_DIR"
> -local="`git config --bool --get instaweb.local`"
> -httpd="`git config --get instaweb.httpd`"
> -port=`git config --get instaweb.port`
> -module_path="`git config --get instaweb.modulepath`"
> +local="$(git config --bool --get instaweb.local)"
> +httpd="$(git config --get instaweb.httpd)"
> +port=$(git config --get instaweb.port)
> +module_path="$(git config --get instaweb.modulepath)"
>  
>  conf="$GIT_DIR/gitweb/httpd.conf"
>  
> @@ -37,11 +37,21 @@ test -z "$httpd" && httpd='lighttpd -f'
>  # any untaken local port will do...
>  test -z "$port" && port=1234
>  
> -start_httpd () {
> -	httpd_only="`echo $httpd | cut -f1 -d' '`"
> +resolve_full_httpd () {
> +	case "$httpd" in
> +	*apache2*|*lighttpd*)
> +		# ensure that the apache2/lighttpd command ends with "-f"
> +		if ! echo "$httpd" | grep -- '-f *$' >/dev/null 2>&1
> +		then
> +			httpd="$httpd -f"
> +		fi
> +		;;
> +	esac
> +
> +	httpd_only="$(echo $httpd | cut -f1 -d' ')"
>  	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null;; esac
>  	then
> -		$httpd "$fqgitdir/gitweb/httpd.conf"
> +		full_httpd=$httpd
>  	else
>  		# many httpds are installed in /usr/sbin or /usr/local/sbin
>  		# these days and those are not in most users $PATHs
> @@ -51,16 +61,23 @@ start_httpd () {
>  		do
>  			if test -x "$i/$httpd_only"
>  			then
> -				# don't quote $httpd, there can be
> -				# arguments to it (-f)
> -				$i/$httpd "$fqgitdir/gitweb/httpd.conf"
> +				full_httpd=$i/$httpd
>  				return
>  			fi
>  		done
> -		echo "$httpd_only not found. Install $httpd_only or use" \
> -		     "--httpd to specify another http daemon."
> +
> +		echo >&2 "$httpd_only not found. Install $httpd_only or use" \
> +		     "--httpd to specify another httpd daemon."
>  		exit 1
>  	fi
> +}
> +
> +start_httpd () {
> +	# here $httpd should have a meaningful value
> +	resolve_full_httpd
> +
> +	# don't quote $full_httpd, there can be arguments to it (-f)
> +	$full_httpd "$fqgitdir/gitweb/httpd.conf"
>  	if test $? != 0; then
>  		echo "Could not execute http daemon $httpd."
>  		exit 1
> @@ -68,7 +85,7 @@ start_httpd () {
>  }
>  
>  stop_httpd () {
> -	test -f "$fqgitdir/pid" && kill `cat "$fqgitdir/pid"`
> +	test -f "$fqgitdir/pid" && kill $(cat "$fqgitdir/pid")
>  }
>  
>  while test $# != 0
> @@ -116,7 +133,7 @@ do
>  done
>  
>  mkdir -p "$GIT_DIR/gitweb/tmp"
> -GIT_EXEC_PATH="`git --exec-path`"
> +GIT_EXEC_PATH="$(git --exec-path)"
>  GIT_DIR="$fqgitdir"
>  export GIT_EXEC_PATH GIT_DIR
>  
> @@ -215,7 +232,8 @@ PerlPassEnv GIT_EXEC_DIR
>  EOF
>  	else
>  		# plain-old CGI
> -		list_mods=`echo "$httpd" | sed "s/-f$/-l/"`
> +		resolve_full_httpd
> +		list_mods=$(echo "$full_httpd" | sed "s/-f$/-l/")
>  		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
>  		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
>  		cat >> "$conf" <<EOF
> -- 
> 1.5.5.4
> 
