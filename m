From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] instaweb: added support Ruby's WEBrick server
Date: Tue, 18 Sep 2007 13:40:33 -0700
Message-ID: <20070918204012.GA28273@untitled>
References: <20070918121634.E8EFF814635@cyrano>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mike dalessio <mike@csa.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXjs8-0003Hz-DS
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 22:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbXIRUkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbXIRUkf
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 16:40:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51427 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbXIRUke (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 16:40:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 073CC7DC029;
	Tue, 18 Sep 2007 13:40:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070918121634.E8EFF814635@cyrano>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58632>

mike dalessio <mike@csa.net> wrote:
> running the webrick server with git requires Ruby and Ruby's YAML and
> Webrick libraries (both of which come standard with Ruby). nice for
> single-user standalone invocations.
> 
> the --httpd=webrick option generates a ruby script on the fly to read
> httpd.conf options and invoke the web server via library call. this
> script is placed in the .git/gitweb directory. it also generates a
> shell script in a feeble attempt to invoke ruby in a portable manner,
> which assumes that 'ruby' is in the user's $PATH.
> 
> Signed-off-by: Mike Dalessio <mike@csa.net>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  Documentation/git-instaweb.txt |    3 +-
>  git-instaweb.sh                |   44 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
> index cec60ee..914fc4c 100644
> --- a/Documentation/git-instaweb.txt
> +++ b/Documentation/git-instaweb.txt
> @@ -27,7 +27,8 @@ OPTIONS
>  	The HTTP daemon command-line that will be executed.
>  	Command-line options may be specified here, and the
>  	configuration file will be added at the end of the command-line.
> -	Currently, lighttpd and apache2 are the only supported servers.
> +	Currently, lighttpd, apache2 and webrick are the only supported
> +	servers.
>  	(Default: lighttpd)
>  
>  -m|--module-path::
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index b79c6b6..803a754 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -37,7 +37,9 @@ start_httpd () {
>  	else
>  		# many httpds are installed in /usr/sbin or /usr/local/sbin
>  		# these days and those are not in most users $PATHs
> -		for i in /usr/local/sbin /usr/sbin
> +		# in addition, we may have generated a server script
> +		# in $fqgitdir/gitweb.
> +		for i in /usr/local/sbin /usr/sbin $fqgitdir/gitweb
>  		do
>  			if test -x "$i/$httpd_only"
>  			then
> @@ -137,6 +139,43 @@ GIT_DIR="$fqgitdir"
>  export GIT_EXEC_PATH GIT_DIR
>  
>  
> +webrick_conf () {
> +	# generate a standalone server script in $fqgitdir/gitweb.
> +	cat > "$fqgitdir/gitweb/$httpd.rb" <<EOF
> +require 'webrick'
> +require 'yaml'
> +options = YAML::load_file(ARGV[0])
> +options[:StartCallback] = proc do
> +  File.open(options[:PidFile],"w") do |f|
> +    f.puts Process.pid
> +  end
> +end
> +options[:ServerType] = WEBrick::Daemon
> +server = WEBrick::HTTPServer.new(options)
> +['INT', 'TERM'].each do |signal|
> +  trap(signal) {server.shutdown}
> +end
> +server.start
> +EOF
> +	# generate a shell script to invoke the above ruby script,
> +	# which assumes _ruby_ is in the user's $PATH. that's _one_
> +	# portable way to run ruby, which could be installed anywhere,
> +	# really.
> +	cat > "$fqgitdir/gitweb/$httpd" <<EOF
> +#! /bin/sh
> +ruby $fqgitdir/gitweb/$httpd.rb \$*
> +EOF
> +	chmod +x "$fqgitdir/gitweb/$httpd"
> +
> +	cat > "$conf" <<EOF
> +:Port: $port
> +:DocumentRoot: "$fqgitdir/gitweb"
> +:DirectoryIndex: ["gitweb.cgi"]
> +:PidFile: "$fqgitdir/pid"
> +EOF
> +	test "$local" = true && echo ':BindAddress: "127.0.0.1"' >> "$conf"
> +}
> +
>  lighttpd_conf () {
>  	cat > "$conf" <<EOF
>  server.document-root = "$fqgitdir/gitweb"
> @@ -237,6 +276,9 @@ case "$httpd" in
>  *apache2*)
>  	apache2_conf
>  	;;
> +webrick)
> +	webrick_conf
> +	;;
>  *)
>  	echo "Unknown httpd specified: $httpd"
>  	exit 1
> -- 
> 1.5.2.5
> 

-- 
Eric Wong
