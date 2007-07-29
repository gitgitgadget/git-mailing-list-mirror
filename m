From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: localhost placeholder parser for cloneurl file
Date: Mon, 30 Jul 2007 01:57:01 +0200
Organization: At home
Message-ID: <f8j9gb$voj$1@sea.gmane.org>
References: <d68f80d90707282354l1593f2ctc0cf7a05eeb3b8e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 01:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFIdb-0008I5-SZ
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbXG2X5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764121AbXG2X5N
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:57:13 -0400
Received: from main.gmane.org ([80.91.229.2]:52223 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbXG2X5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:57:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFIdF-000510-Cm
	for git@vger.kernel.org; Mon, 30 Jul 2007 01:57:05 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 01:57:05 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 01:57:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54163>

[Cc: Leandro Dorileo <ldorileo@gmail.com>, git@vger.kernel.org]

Leandro Dorileo wrote:

> From 32da24e1e18a1c5f32bfa0afdbcb6d0f2b0432f3 Mon Sep 17 00:00:00 2001
> From: Leandro Dorileo <dorileo@ossystems.com.br>
> Date: Sat, 28 Jul 2007 15:34:20 -0400
> Subject: [PATCH] gitweb: localhost placeholder parser for cloneurl file
> 
> Implementation of a localhost placeholder parsing in git_get_project_url_list.
> It`s useful in cases of gitweb being hosted in a work-station (like a notebook)
> used in a local team development environment and, implementation of a git-url
> link in the git project list body like in git.kernel.org.

First, the commit message _has_ to be self explanatory, and be easily
understood _without_ email message which introduced it.

So you should clean-up the explanation about _why_ one would want to
replace #localhost#, or ++LOCALHOST++ in the cloneurls by the server
name (the same configuration, different machines; although I do not
understand why it is so hard to change configutation depending on
machine).

Second, please clean up the code. Comments below.

Third, sign-off your patches: see Documentation/SubmittingPatches

> ---
>  gitweb/gitweb.perl |   21 ++++++++++++++++++---
>  1 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b381692..281d823 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1471,7 +1471,16 @@ sub git_get_project_url_list {
>       my @git_project_url_list = map { chomp; $_ } <$fd>;
>       close $fd;
> 
> -     return wantarray ? @git_project_url_list : \@git_project_url_list;
> +        if(wantarray){

Style: "if (wantarray) {".

But I think you would want to do the substitution regardless of
whether git_get_project_url_list() subroutine is called in scalar
or list context. (By the way I think it might be a mistake to use
this trick: return array in the list context, return array reference
in the scalar context).

So you would put the code proposed below before

        return wantarray ? @git_project_url_list : \@git_project_url_list;

> +            for(my $i = 0; $i < @git_project_url_list; $i++){
> +                if(index(@git_project_url_list[$i], "#localhost#") != -1){
> +                    @git_project_url_list[$i] =~
> s/#localhost#/server_name()/eg;
> +                }
> +            }

Why not simply:

        @git_project_url_list = map { s/#localhost#/server_name()/eg; } 
                @git_project_url_list;

And didn't you meant $cgi->server_name() or just $ENV{'SERVER_NAME'}?

> +            return @git_project_url_list;
> +        }else{
> +            return \@git_project_url_list;
> +        }

Just end with what it was before:

        return wantarray ? @git_project_url_list : \@git_project_url_list;

>  }
 
>  sub git_get_projects_list {
> @@ -3384,8 +3393,14 @@ sub git_project_list_body {
>                     $cgi->a({-href => href(project=>$pr->{'path'},
> action=>"shortlog")}, "shortlog") . " | " .
>                     $cgi->a({-href => href(project=>$pr->{'path'},
> action=>"log")}, "log") . " | " .
>                     $cgi->a({-href => href(project=>$pr->{'path'},
> action=>"tree")}, "tree") .
> -                   ($pr->{'forks'} ? " | " . $cgi->a({-href =>
> href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
> -                   "</td>\n" .
> +                   ($pr->{'forks'} ? " | " . $cgi->a({-href =>
> href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '');
> +
> +                      my @url_list = git_get_project_url_list($pr->{'path'});
> +                      if(@url_list != 0){
> +                        print " | " . $cgi->a({-href => @url_list[0]}, "git");
> +                      }

Style: "if (@url_list) {" is enough.
Style: use tabs for indent, now spaces.

But this is totally independent thing, and it should be put in
separate patch. And it doesn't make much sense as first URL in
the list might not be using scheme recognized by web browser:
 - it can be git:// URL.
 - it can be scp style ssh:// URL: <user>@<host>:<path>
 - it can be local path, without file:// prefix

> +
> +                   print "</td>\n" .
>                     "</tr>\n";
>       }
>       if (defined $extra) {


-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
