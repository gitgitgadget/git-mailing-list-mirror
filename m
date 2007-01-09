From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 1/2] gitweb: add a simple wrapper for FCGI support
Date: Wed, 10 Jan 2007 01:28:50 +1300
Message-ID: <45A38A82.2060307@vilain.net>
References: <11678969111362-git-send-email-normalperson@yhbt.net> <11678969781711-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 13:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4G6W-0004de-BX
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 13:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXAIM3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 07:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbXAIM3V
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 07:29:21 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:57643 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXAIM3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 07:29:20 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 54A69157085; Wed, 10 Jan 2007 01:29:14 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id B94C313A018;
	Wed, 10 Jan 2007 01:29:08 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11678969781711-git-send-email-normalperson@yhbt.net>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36356>

Eric Wong wrote:
> The FCGI wrapper is designed to be spawned from the
> command-line, and can be backgrounded there.  No
> FCGI-specific spawners are necessary.
> 
> Since we re-eval gitweb.cgi on every request, I've
> quieted warnings for redefined functions.
> 

I never did submit this; perhaps I should've...

http://utsl.gen.nz/gitweb/?p=gitweb;a=commitdiff;h=56d7d436;hp=2326acfa

Sam.

> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  .gitignore              |    1 +
>  Makefile                |    6 +++++
>  gitweb/gitweb-fcgi.perl |   51 +++++++++++++++++++++++++++++++++++++++++++++++
>  gitweb/gitweb.perl      |    1 +
>  4 files changed, 59 insertions(+), 0 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 2904f12..700ac4f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -137,6 +137,7 @@ git-whatchanged
>  git-write-tree
>  git-core-*/?*
>  gitweb/gitweb.cgi
> +gitweb/gitweb.fcgi
>  test-date
>  test-delta
>  test-dump-cache-tree
> diff --git a/Makefile b/Makefile
> index fa1a022..3e94def 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -684,6 +684,12 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
>  	chmod +x $@+
>  	mv $@+ $@
>  
> +gitweb/gitweb.fcgi: gitweb/gitweb-fcgi.perl
> +	rm -f $@ $@+
> +	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' $< >$@+
> +	chmod +x $@+
> +	mv $@+ $@
> +
>  git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
>  	rm -f $@ $@+
>  	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> diff --git a/gitweb/gitweb-fcgi.perl b/gitweb/gitweb-fcgi.perl
> new file mode 100644
> index 0000000..2b7d5bf
> --- /dev/null
> +++ b/gitweb/gitweb-fcgi.perl
> @@ -0,0 +1,51 @@
> +#!/usr/bin/perl -w
> +use strict;
> +use FCGI;
> +use CGI;
> +use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
> +
> +sub usage {
> +	print STDERR "$0 --fcgi-socket=(path|[host]:port) ",
> +	             "--cgi-bin=path\n";
> +	exit 1;
> +}
> +
> +my ($fcgi_sock, $cgi_bin);
> +GetOptions('fcgi-socket|s=s' => \$fcgi_sock,
> +           'cgi-bin|c=s' => \$cgi_bin) or usage();
> +
> +usage() unless ($fcgi_sock && $cgi_bin);
> +
> +die "FastCGI socket: $fcgi_sock already exists!\n" if (-S $fcgi_sock);
> +die "CGI executable: $cgi_bin does not exist!\n" if (!-f $cgi_bin);
> +
> +# gitweb will exit, make it throw an exception instead:
> +no warnings qw/once/;
> +*CORE::GLOBAL::exit = sub { die 'gitweb_exit' };
> +use warnings;
> +
> +# FCGI will erase the current %ENV; so make sure we save this:
> +my $gwcfg = $ENV{GITWEB_CONFIG};
> +
> +my $fcgi_req = FCGI::Request(\*STDIN, \*STDOUT, \*STDERR, \%ENV,
> +                             FCGI::OpenSocket($fcgi_sock, 128),
> +                             FCGI::FAIL_ACCEPT_ON_INTR);
> +while ($fcgi_req->Accept >= 0) {
> +	unless ($ENV{PATH_INFO}) {
> +		# nginx currently fails to set PATH_INFO,
> +		# so we'll do it ourselves
> +		my $pi = $ENV{SCRIPT_NAME};
> +		$pi =~ s!^/\+!!;
> +		$ENV{PATH_INFO} = $pi;
> +	}
> +	# clear CGI query parameters set inside gitweb so we can reparse
> +	# the %ENV fed to us
> +	CGI::initialize_globals();
> +	$ENV{GITWEB_CONFIG} = $gwcfg if defined $gwcfg;
> +	do $cgi_bin;
> +	delete $ENV{PATH_INFO};
> +}
> +
> +END {
> +	unlink $fcgi_sock if (defined $fcgi_sock && -S $fcgi_sock);
> +}
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 2179054..4a9189b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -9,6 +9,7 @@
>  
>  use strict;
>  use warnings;
> +no warnings qw(redefine); # for FCGI
>  use CGI qw(:standard :escapeHTML -nosticky);
>  use CGI::Util qw(unescape);
>  use CGI::Carp qw(fatalsToBrowser);
