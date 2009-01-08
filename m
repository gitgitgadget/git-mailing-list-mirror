From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs-* microformat
Date: Thu, 08 Jan 2009 08:56:37 +0100
Message-ID: <gk4bk5$9dq$1@ger.gmane.org>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com> <20090107184515.GB31795@gnu.kitenet.net> <20090107190238.GA3909@gnu.kitenet.net> <20090107232427.GA18958@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 08:58:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKpml-0002ra-Fy
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 08:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbZAHH5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 02:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZAHH5M
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 02:57:12 -0500
Received: from main.gmane.org ([80.91.229.2]:55065 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328AbZAHH5K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 02:57:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKplM-0001KM-75
	for git@vger.kernel.org; Thu, 08 Jan 2009 07:57:08 +0000
Received: from 94.37.32.116 ([94.37.32.116])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 07:57:08 +0000
Received: from giuseppe.bilotta by 94.37.32.116 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 07:57:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 94.37.32.116
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104897>

Hello Joey,

On Thursday 08 January 2009 00:24, Joey Hess wrote:

> The rel=vcs-* microformat allows a web page to indicate the locations of
> repositories related to it in a machine-parseable manner.
> (See http://kitenet.net/~joey/rfc/rel-vcs/)

Have you considered submitting the microformat to microformats.org?
That would make the microformat more official and would be an good
first step to have wider coverage of it, and additional reviews.

> Make gitweb use the microformat if it has been configured with project url
> information in any of the usual ways. On the project summary page, the
> repository URL display is simply marked up using the microformat. On the
> project list page and forks list page, the microformat is embedded in the
> header, since the URLs do not appear on the page.
> 
> The microformat could be included on other pages too, but I've skipped
> doing so for now, since it would mean reading another file for every page
> displayed.
> 
> There is a small overhead in including the microformat on project list
> and forks list pages, but getting the project descriptions for those pages
> already incurs a similar overhead, and the ability to get every repo url
> in one place seems worthwhile.

I agree with this, although people with very large project lists may
differ ... do we have timings on these?
 
> This changes git_get_project_url_list() to not check wantarray, and only
> return in list context -- the only way it is used AFAICS. It memoizes
> both that function and git_get_project_description(), to avoid redundant
> file reads.

You may want to consider splitting the patch into three: memoizing
of git_get_project_description(), reworking of
git_get_project_url_list(), and the actual rel=vc-* insertions.

> Signed-off-by: Joey Hess <joey@gnu.kitenet.net>
> ---
>  gitweb/gitweb.perl |   78 +++++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 62 insertions(+), 16 deletions(-)
> 
> This incorporates Giuseppe Bilotta's feedback, and uses new features
> of the microformat. You can see this version running at
> http://git.ikiwiki.info/

Oh, and do consider cc'ing jnareb and paski when submitting patches
for gitweb, as they are the (unofficial?) maintainers. I usually cc
gitster (Junio C Hamano) too.

[ Also cc'ing me for this round would have been a nice idea too,
since we had the review going on ;-) ]

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 99f71b4..c238717 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2020,9 +2020,14 @@ sub git_get_path_by_hash {
>  ## ......................................................................
>  ## git utility functions, directly accessing git repository
>  
> +{
> +my %project_descriptions; # cache
> +

Out of curiosity, why the grouping? I would have had

our %project_descriptions;

up above with all the global variables.

>  sub git_get_project_description {
>       my $path = shift;
>  
> +     return $project_descriptions{$path} if exists $project_descriptions{$path};
> +

This line is bordering on the 80 characters, so you may want to
consider moving 'my $descr' here, with something such as

my $descr = $project_descriptions{$path};
return $descr if exists $descr;

Also, I'm no perl guru so I'm not sure about exists vs defined here.

>       $git_dir = "$projectroot/$path";
>       open my $fd, "$git_dir/description"
>               or return git_get_project_config('description');
> @@ -2031,7 +2036,9 @@ sub git_get_project_description {
>       if (defined $descr) {
>               chomp $descr;
>       }
> -     return $descr;
> +     return $project_descriptions{$path}=$descr;
> +}
> +
>  }

[This is where I would end the first patch]

>  
>  sub git_get_project_ctags {
> @@ -2099,18 +2106,30 @@ sub git_show_project_tagcloud {
>       }
>  }
>  
> +{
> +my %project_url_lists; # cache
> +

Ditto for this: why not our %project_url_lists; without scoping?

>  sub git_get_project_url_list {
> +     # use per project git URL list in $projectroot/$path/cloneurl
> +     # or make project git URL from git base URL and project name
>       my $path = shift;
>  
> +     return @{$project_url_lists{$path}} if exists $project_url_lists{$path};
> +
> +     my @ret;
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
> +     } else {
> +            @ret = @{ config_to_multi(git_get_project_config('url')) };
> +     }
> +     @ret=map { "$_/$project" } @git_base_url_list if ! @ret;
> +
> +     $project_url_lists{$path}=\@ret;
> +     return @ret;
> +}
>  
> -     return wantarray ? @git_project_url_list : \@git_project_url_list;
>  }

[This is where I would end the second patch]

>  
>  sub git_get_projects_list {
> @@ -2856,6 +2875,7 @@ sub blob_contenttype {
>  sub git_header_html {
>       my $status = shift || "200 OK";
>       my $expires = shift;
> +     my $extraheader = shift;
>  
>       my $title = "$site_name";
>       if (defined $project) {
> @@ -2953,6 +2973,8 @@ EOF
>               print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
>       }
>  
> +     print $extraheader if defined $extraheader;
> +
>       print "</head>\n" .
>             "<body>\n";
>  
> @@ -4365,6 +4387,26 @@ sub git_search_grep_body {
>       print "</table>\n";
>  }
>  
> +sub git_link_title {
> +     my $project=shift;
> +     
> +     my $description=git_get_project_description($project);
> +     return $project.(length $description ? " - $description" : "");
> +}

Nice.

> +
> +# generates header with links to the specified projects
> +sub git_links_header {
> +     my $ret='';
> +     foreach my $project (@_) {
> +             # rel=vcs-* microformat
> +             my $title=git_link_title($project);
> +             foreach my $url git_get_project_url_list($project) {
> +                     $ret.=qq{<link rel="vcs-git" href="$url" title="$title"/>\n}
> +             }
> +     }
> +     return $ret;
> +}
> +
>  ## ======================================================================
>  ## ======================================================================
>  ## actions
> @@ -4380,7 +4422,9 @@ sub git_project_list {
>               die_error(404, "No projects found");
>       }
>  
> -     git_header_html();
> +     my $extraheader=git_links_header(map { $_->{path} } @list);
> +
> +     git_header_html(undef, undef, $extraheader);
>       if (-f $home_text) {
>               print "<div class=\"index_include\">\n";
>               insert_file($home_text);
> @@ -4405,8 +4449,10 @@ sub git_forks {
>       if (!@list) {
>               die_error(404, "No forks found");
>       }
> +     
> +     my $extraheader=git_links_header(map { $_->{path} } @list);
>  
> -     git_header_html();
> +     git_header_html(undef, undef, $extraheader);

This makes me wonder if it would be worth it to turn git_header_html
into -param => value style, but I'm not really sure it's worth it.

>       git_print_page_nav('','');
>       git_print_header_div('summary', "$project forks");
>       git_project_list_body(\@list, $order);
> @@ -4468,14 +4514,14 @@ sub git_summary {
>               print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
>       }
>  
> -     # use per project git URL list in $projectroot/$project/cloneurl
> -     # or make project git URL from git base URL and project name
>       my $url_tag = "URL";
> -     my @url_list = git_get_project_url_list($project);
> -     @url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
> -     foreach my $git_url (@url_list) {
> +     my $title=git_link_title($project);
> +     foreach my $git_url (git_get_project_url_list($project)) {
>               next unless $git_url;
> -             print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
> +             print "<tr class=\"metadata_url\"><td>$url_tag</td><td>".
> +                   # rel=vcs-* microformat
> +                   "<a rel=\"vcs-git\" href=\"$git_url\" title=\"$title\">$git_url</a>".
> +                   "</td></tr>\n";
>               $url_tag = "";
>       }

Good. Of course the comment removal (which is actually a due move to
git_get_project_url_list) would go in the appropriate patch if you
split them 8-)

-- 
Giuseppe "Oblomov" Bilotta
