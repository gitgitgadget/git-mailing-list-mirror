From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Wed, 07 Jan 2009 13:30:13 +0100
Message-ID: <gk2794$djn$1@ger.gmane.org>
References: <20090107042518.GB24735@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 13:32:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKXZx-0002Nz-1L
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 13:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbZAGMaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 07:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZAGMap
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 07:30:45 -0500
Received: from main.gmane.org ([80.91.229.2]:50543 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbZAGMao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 07:30:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKXYW-0007uA-CG
	for git@vger.kernel.org; Wed, 07 Jan 2009 12:30:40 +0000
Received: from 78.13.52.22 ([78.13.52.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 12:30:40 +0000
Received: from giuseppe.bilotta by 78.13.52.22 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 12:30:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 78.13.52.22
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104792>

On Wednesday 07 January 2009 05:25, Joey Hess wrote:

> The rel=vcs microformat allows a web page to indicate the locations of
> repositories related to it in a machine-parseable manner.
> (See http://kitenet.net/~joey/rfc/rel-vcs/)

Interesting idea, I like it. However, I see a problem in the proposed
implementation versus the spec. According to the spec:

"""
The "title" is optional, but recommended if there are multiple, different
repositories linked to on one page. It is a human-readable description of the
repository.
[...]
If there are multiple repositories listed, without titles, tools should assume
they are different repositories.
"""

In this patch you do NOT add titles to the rel=vcs links, which means that
everything works fine only if there is a single URL for each project. If a
project has different URLs, it's going to appear multiple times as _different_
projects to a spec-compliant reader.

A possible solution would be to make @git_url_list into a map keyed by the
project name and having the description and repo URL(s) as values.

Since there is the possibility of different projects having the same
description (e.g. the default one), the link title could be composed of
"$project - $description" rather than simply $description.

Note that both in summary and in project list view you already retrieve the
description, so there are no additional disk hits.

> Make gitweb use the microformat in the header of pages it generates,
> if it has been configured with project url information in any of the usual
> ways.
> 
> Since getting the urls can require hitting disk, I avoided putting the
> microformat on *every* page gitweb generates. Just put it on the project
> summary page, the project list page, and the forks list page.
> The first of these already looks up the urls, so adding the microformat was
> free. There is a small overhead in including the microformat on the
> latter two pages, but getting the project descriptions for those pages
> already incurs a similar overhead, and the ability to get every repo url
> in one place seems worthwhile.
> 
> This changes git_get_project_description() to not check wantarray, and only
> return in list context -- the only way it is used AFAICS.

I assume you mean git_get_project_url_list()?

> 
> Signed-off-by: Joey Hess <joey@gnu.kitenet.net>
> ---
>  gitweb/gitweb.perl |   38 ++++++++++++++++++++++++++------------
>  1 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 99f71b4..3f8a228 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -789,6 +789,9 @@ $git_dir = "$projectroot/$project" if $project;
>  our @snapshot_fmts = gitweb_get_feature('snapshot');
>  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  
> +# populated later with git urls for the project
> +our @git_url_list;
> +
>  # dispatch
>  if (!defined $action) {
>       if (defined $hash) {
> @@ -2100,17 +2103,22 @@ sub git_show_project_tagcloud {
>  }
>  
>  sub git_get_project_url_list {
> +     # use per project git URL list in $projectroot/$path/cloneurl
> +     # or make project git URL from git base URL and project name
>       my $path = shift;
>  
> +     my @ret;
> +
>       $git_dir = "$projectroot/$path";
> -     open my $fd, "$git_dir/cloneurl"
> -             or return wantarray ?
> -             @{ config_to_multi(git_get_project_config('url')) } :
> -                config_to_multi(git_get_project_config('url'));
> -     my @git_project_url_list = map { chomp; $_ } <$fd>;
> -     close $fd;
> +     if (open my $fd, "$git_dir/cloneurl") {
> +             @ret = map { chomp; $_ } <$fd>;
> +             close $fd;
> +     }
> +     else {

Coding style: } else {

> +            @ret = @{ config_to_multi(git_get_project_config('url')) };
> +     }
>  
> -     return wantarray ? @git_project_url_list : \@git_project_url_list;
> +     return @ret ? @ret : map { "$_/$project" } @git_base_url_list;
>  }
>  
>  sub git_get_projects_list {
> @@ -2953,6 +2961,10 @@ EOF
>               print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
>       }
>  
> +     foreach my $url (@git_url_list) {
> +             print qq{<link rel="vcs" type="git" href="$url" />\n};
> +     }
> +
>       print "</head>\n" .
>             "<body>\n";
>  
> @@ -4380,6 +4392,8 @@ sub git_project_list {
>               die_error(404, "No projects found");
>       }
>  
> +     @git_url_list = map { git_get_project_url_list($_->{path}) } @list;
> +
>       git_header_html();
>       if (-f $home_text) {
>               print "<div class=\"index_include\">\n";
> @@ -4400,6 +4414,8 @@ sub git_forks {
>       if (defined $order && $order !~ m/none|project|descr|owner|age/) {
>               die_error(400, "Unknown order parameter");
>       }
> +     
> +     @git_url_list = map { git_get_project_url_list($_->{path}) } @list;
>  
>       my @list = git_get_projects_list($project);
>       if (!@list) {
> @@ -4457,6 +4473,8 @@ sub git_summary {
>               @forklist = git_get_projects_list($project);
>       }
>  
> +     @git_url_list = git_get_project_url_list($project);
> +
>       git_header_html();
>       git_print_page_nav('summary','', $head);
>  
> @@ -4468,12 +4486,8 @@ sub git_summary {
>               print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
>       }
>  
> -     # use per project git URL list in $projectroot/$project/cloneurl
> -     # or make project git URL from git base URL and project name
>       my $url_tag = "URL";
> -     my @url_list = git_get_project_url_list($project);
> -     @url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
> -     foreach my $git_url (@url_list) {
> +     foreach my $git_url (@git_url_list) {
>               next unless $git_url;
>               print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
>               $url_tag = "";

-- 
Giuseppe "Oblomov" Bilotta
