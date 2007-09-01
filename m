From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Clearly distinguish regexp / exact match searches
Date: Sat, 01 Sep 2007 02:13:02 +0200
Organization: At home
Message-ID: <fbaaqb$ked$1@sea.gmane.org>
References: <20070825221852.11739.6955.stgit@rover> <20070826013831.17924.75365.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 02:13:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRGcS-00019G-S3
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 02:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXIAANQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 20:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbXIAANP
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 20:13:15 -0400
Received: from main.gmane.org ([80.91.229.2]:46569 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbXIAANO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 20:13:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRGbv-0007cS-Ju
	for git@vger.kernel.org; Sat, 01 Sep 2007 02:13:11 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 02:13:11 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 02:13:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57234>

[Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org]

Nice idea, although most probably post 1.5.3.
Ack, FWIW.

Petr Baudis wrote:

> This patch does a couple of things:
> 
> * Makes commit/author/committer search case insensitive
> 
>       To be consistent with the grep search; I see no convincing
>       reason for the search to be case sensitive, and you might
>       get in trouble especially with contributors e.g. from Japan
>       or France where they sometimes like to uppercase their last
>       name.
> 
> * Makes grep search by default grep for fixed strings
> 
>       Since we will have a checkbox.
> 
> * Introduces 're' checkbox that enables POSIX extended regexp searches
> 
>       This works for all the search types. The idea comes from Jakub.
> 
> It does not make much sense (and is not easy at all) to untangle most of
> these changes from each other, thus they all go in a single patch.

The last two changes certainly _have_ to go together, as they have
no much sense individually. I'm not so sure about making commit search
case insensitive; I agree that it would be not easy to untangle those
changes from the regexp changes.

Nevertheless I'd separate one patch: changing usage of parse_commits
(see comments below).

> Cc: Jakub Narebski <jnareb@gmail.com>

I didn't get a copy by email...

> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
> Sorry, previous version kept git_feed() the user of parse_commits() with
> unchanged usage.
> ---
> 
>  gitweb/gitweb.perl |   52 ++++++++++++++++++++++++++++++++++------------------
>  1 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1ac4523..bdb0b1f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -473,13 +473,15 @@ if (defined $searchtype) {
>       }
>  }
>  
> +our $search_use_regexp = $cgi->param('sr');
> +
>  our $searchtext = $cgi->param('s');
>  our $search_regexp;
>  if (defined $searchtext) {
>       if (length($searchtext) < 2) {
>               die_error(undef, "At least two characters are required for search parameter");
>       }
> -     $search_regexp = quotemeta $searchtext;
> +     $search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
>  }

Nice idea, good solution... although: yet another CGI parameter?

> @@ -609,6 +611,7 @@ sub href(%) {
>               searchtype => "st",
>               snapshot_format => "sf",
>               extra_options => "opt",
> +             search_use_regexp => "sr",
>       );
>       my %mapping = @mapping;
>  

I would put 'search_use_regexp' after searchtype, not at the end of
the @mapping list.

> @@ -1937,7 +1940,7 @@ sub parse_commit {
>  }
>  
>  sub parse_commits {
> -     my ($commit_id, $maxcount, $skip, $arg, $filename) = @_;
> +     my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
>       my @cos;
>  
>       $maxcount ||= 1;
> @@ -1947,7 +1950,7 @@ sub parse_commits {
>  
>       open my $fd, "-|", git_cmd(), "rev-list",
>               "--header",
> -             ($arg ? ($arg) : ()),
> +             @args,
>               ("--max-count=" . $maxcount),
>               ("--skip=" . $skip),
>               @extra_options,

This is a good idea. It not only allows passing more than single
parameter to rev-list, but also make it easier to use "no extra
options" parse_commits invocation. Although it makes order of
types of options different than in git-rev-list invocation.

But I'd rather have this, and changes in calling parse_commits,
as a separate commit.

We could always use anonymous array reference if we want to pass
more than one option:

  parse_commits(commit, maxcount, skip, [arg1, arg2], filename)

> @@ -2422,6 +2425,9 @@ EOF
>                     $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
>                     " search:\n",
>                     $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
> +                   "<span title=\"Extended regular expression\">" .
> +                   $cgi->checkbox(-name => 'sr', -value => 1, -checked => $search_use_regexp, -label => 're') .
> +                   "</span>" .
>                     "</div>" .
>                     $cgi->end_form() . "\n";
>       }

Perhaps this checkbox should be _below_ search form text field,
rather than after it.

> @@ -5095,7 +5101,7 @@ sub git_history {
>               $ftype = git_get_type($hash);
>       }
>  
> -     my @commitlist = parse_commits($hash_base, 101, (100 * $page), "--full-history", $file_name);
> +     my @commitlist = parse_commits($hash_base, 101, (100 * $page), $file_name, "--full-history");
>  
>       my $paging_nav = '';
>       if ($page > 0) {
> @@ -5185,7 +5191,9 @@ sub git_search {
>                       $greptype = "--committer=";
>               }
>               $greptype .= $search_regexp;
> -             my @commitlist = parse_commits($hash, 101, (100 * $page), $greptype);
> +             my @commitlist = parse_commits($hash, 101, (100 * $page), undef,
> +                                            $greptype, $search_use_regexp ? ('--extended-regexp') : (),
> +                                            '--regexp-ignore-case');
>  
>               my $paging_nav = '';
>               if ($page > 0) {

The change makes it harder to write getting log of commits with
some extra option but without the path limiter.

> @@ -5235,8 +5243,9 @@ sub git_search {
>               my $git_command = git_cmd_str();
>               my $searchqtext = $searchtext;
>               $searchqtext =~ s/'/'\\''/;
> +             my $pickaxe_flags = $search_use_regexp ? '--pickaxe-regex' : '';
>               open my $fd, "-|", "$git_command rev-list $hash | " .
> -                     "$git_command diff-tree -r --stdin -S\'$searchqtext\'";
> +                     "$git_command diff-tree -r --stdin -S\'$searchqtext\' $pickaxe_flags";
>               undef %co;
>               my @files;
>               while (my $line = <$fd>) {

Nice.

[...]
> @@ -5364,27 +5375,31 @@ sub git_search_help {
>       git_header_html();
>       git_print_page_nav('','', $hash,$hash,$hash);
>       print <<EOT;
> +<p><strong>Pattern</strong> is by default a normal string that is matched precisely (but without
> +regard to case, except in the case of pickaxe). However, when you check the <em>re</em> checkbox,
> +the pattern entered is recognized as the POSIX extended
> +<a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a> (also case
> +insensitive).</p>
>  <dl>
>  <dt><b>commit</b></dt>
> -<dd>The commit messages and authorship information will be scanned for the given string.</dd>
> +<dd>The commit messages and authorship information will be scanned for the given pattern.</dd>
>  EOT
>       my ($have_grep) = gitweb_check_feature('grep');
>       if ($have_grep) {
>               print <<EOT;
>  <dt><b>grep</b></dt>
>  <dd>All files in the currently selected tree (HEAD unless you are explicitly browsing
> -    a different one) are searched for the given
> -<a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a>
> -(POSIX extended) and the matches are listed. On large
> -trees, this search can take a while and put some strain on the server, so please use it with
> -some consideration.</dd>
> +    a different one) are searched for the given pattern. On large trees, this search can take
> +a while and put some strain on the server, so please use it with some consideration. Note that
> +due to git-grep peculiarity, currently if regexp mode is turned off, the matches are
> +case-sensitive.</dd>
>  EOT
[...]

> @@ -5392,7 +5407,8 @@ EOT
>  <dt><b>pickaxe</b></dt>
>  <dd>All commits that caused the string to appear or disappear from any file (changes that
>  added, removed or "modified" the string) will be listed. This search can take a while and
> -takes a lot of strain on the server, so please use it wisely.</dd>
> +takes a lot of strain on the server, so please use it wisely. Note that since you may be
> +interested even in changes just changing the case as well, this search is case sensitive.</dd>
>  EOT
>       }
>       print "</dl>\n";


I'd rather have case-insensitive search _only_ for commit search
(commit message, author, committer), and case-sensitive for the
rest: pickaxe and grep search.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
