From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: optionally read config from GITWEB_CONFIG
Date: Wed, 2 Aug 2006 13:51:20 -0700 (PDT)
Message-ID: <20060802205120.84032.qmail@web31808.mail.mud.yahoo.com>
References: <20060802192333.GA30861@coredump.intra.peff.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:51:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Nga-0002Pb-8W
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWHBUvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWHBUvV
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:51:21 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:26288 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751359AbWHBUvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 16:51:20 -0400
Received: (qmail 84034 invoked by uid 60001); 2 Aug 2006 20:51:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VX8LBhzKqjDlIbYHdyFY9yt4tnJV9VPgVFHlDzlsmoRiAp9TRq/3DlI7rXrxcZwwGR7dKLuVlAyHMKNlRL5/X9tqGJw7DJNRiWYf5manHMreCtD124QN3ZWR92wg2642IQ9sBSqWhzEaZ0e4dNBMv7Zttr609RUUQ1FUMuWWIQA=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Wed, 02 Aug 2006 13:51:20 PDT
To: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060802192333.GA30861@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24684>

--- Jeff King <peff@peff.net> wrote:
> Configuration will first be taken from variables inside the gitweb.cgi
> script, which in turn come from the Makefile. Afterwards, the contents of
> GITWEB_CONFIG are read, overriding the builtin defaults.
> 
> This should eliminate the need for editing the gitweb script at all. Users
> should edit the Makefile and/or add a config file.

I don't think users should even edit the Makefile.  Makefiles are normally
edited when the _build_ environment differs, not when the deployment
environment differs.

For example, some of us use the same gitweb.cgi/perl/pl (or whatever the
next completely unnecessary renaming would be) for deployment on several
"sites" and repositories.

I cannot imagine anyone who actually _uses_ and maintains gitweb.cgi/perl/pl
to edit the Makefile for their deployment, thus having to have a forked off
branch(es) for each of their deployments (which the only diff editing the Makefile).

    Luben

> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is on top of next.
> 
> This patch seemed to get a favorable response, so I cleaned it up and
> actually tested it. The main changes are reordering a few of the setup
> statements so that changes introduced in the config file are respected
> as suggested by Matthias (and a few by me). It would be good if other
> gitweb people could check it over and/or try it with their config to
> make sure I didn't miss anything.
> 
>  Makefile           |    2 ++
>  gitweb/gitweb.perl |   19 ++++++++++++-------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 2562a2c..170d082 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -127,6 +127,7 @@ GIT_PYTHON_DIR = $(prefix)/share/git-cor
>  # DESTDIR=
>  
>  # default configuration for gitweb
> +GITWEB_CONFIG = gitweb_config.perl
>  GITWEB_SITENAME =
>  GITWEB_PROJECTROOT = /pub/git
>  GITWEB_LIST =
> @@ -629,6 +630,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
>  	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>  	    -e 's|@@GIT_VERSION@@|$(GIT_VERSION)|g' \
>  	    -e 's|@@GIT_BINDIR@@|$(bindir)|g' \
> +	    -e 's|@@GITWEB_CONFIG@@|$(GITWEB_CONFIG)|g' \
>  	    -e 's|@@GITWEB_SITENAME@@|$(GITWEB_SITENAME)|g' \
>  	    -e 's|@@GITWEB_PROJECTROOT@@|$(GITWEB_PROJECTROOT)|g' \
>  	    -e 's|@@GITWEB_LIST@@|$(GITWEB_LIST)|g' \
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1db1414..d5b2de8 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -31,14 +31,8 @@ # absolute fs-path which will be prepend
>  #our $projectroot = "/pub/scm";
>  our $projectroot = "@@GITWEB_PROJECTROOT@@";
>  
> -# version of the core git binary
> -our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
> -
>  # location for temporary files needed for diffs
>  our $git_temp = "/tmp/gitweb";
> -if (! -d $git_temp) {
> -	mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
> -}
>  
>  # target of the home link on top of all pages
>  our $home_link = $my_uri;
> @@ -56,7 +50,7 @@ # URI of GIT logo
>  our $logo = "@@GITWEB_LOGO@@";
>  
>  # source of projects list
> -our $projects_list = "@@GITWEB_LIST@@" || "$projectroot";
> +our $projects_list = "@@GITWEB_LIST@@";
>  
>  # default blob_plain mimetype and default charset for text/plain blob
>  our $default_blob_plain_mimetype = 'text/plain';
> @@ -66,6 +60,17 @@ # file to use for guessing MIME types be
>  # (relative to the current git repository)
>  our $mimetypes_file = undef;
>  
> +our $GITWEB_CONFIG = "@@GITWEB_CONFIG@@";
> +require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
> +
> +# version of the core git binary
> +our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
> +
> +$projects_list ||= $projectroot;
> +if (! -d $git_temp) {
> +	mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
> +}
> +
>  # input validation and dispatch
>  our $action = $cgi->param('a');
>  if (defined $action) {
> -- 
> 1.4.2.rc2.g59706-dirty
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
