From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Allow fancy globs in git-svn init branches
Date: Tue, 18 Sep 2012 20:46:54 +0000
Message-ID: <20120918204654.GA22856@dcvr.yhbt.net>
References: <1347925598-23907-1-git-send-email-ammon.riley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, marcin@owsiany.pl, schwern@pobox.com
To: Ammon Riley <ammon.riley@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:47:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4hE-0006m1-CG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab2IRUqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 16:46:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46990 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173Ab2IRUqy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 16:46:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739D41F42C;
	Tue, 18 Sep 2012 20:46:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1347925598-23907-1-git-send-email-ammon.riley@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205871>

Ammon Riley <ammon.riley@gmail.com> wrote:
> Branches passed to 'git-svn init' via the -b/--branches flag
> automatically had a /* appended to them.  When the branch contained
> a fancy glob with a {} pattern, this is incorrect behaviour, and
> leads to odd branches being created in the git repository.
> 
> Signed-off-by: Ammon Riley <ammon.riley@gmail.com>
> ---
>  git-svn.perl                         |  2 +-
>  t/t9141-git-svn-multiple-branches.sh | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 0d77ffb..f8e8558 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1678,7 +1678,7 @@ sub complete_url_ls_init {
>  	my $remote_path = join_paths( $gs->path, $repo_path );
>  	$remote_path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
>  	$remote_path =~ s#^/##g;
> -	$remote_path .= "/*" if $remote_path !~ /\*/;
> +	$remote_path .= "/*" if $remote_path !~ m#\*|\{[^/]+\}#;
>  	my ($n) = ($switch =~ /^--(\w+)/);
>  	if (length $pfx && $pfx !~ m#/$#) {
>  		die "--prefix='$pfx' must have a trailing slash '/'\n";
> diff --git a/t/t9141-git-svn-multiple-branches.sh b/t/t9141-git-svn-multiple-branches.sh
> index 3cd0671..1b872a9 100755
> --- a/t/t9141-git-svn-multiple-branches.sh
> +++ b/t/t9141-git-svn-multiple-branches.sh
> @@ -119,4 +119,16 @@ test_expect_success 'create new branches and tags' '
>  		svn_cmd up && test -e tags_B/Tag2/a.file )
>  '
>  
> +test_expect_success 'clone multiple branch paths using fancy glob' '
> +	git svn clone -T trunk \
> +		      -b b_one/{first} --branches b_two \

I'm concerned encouraging this can cause confusion on the command-line
for bash users.

In bash, "b_one/{first}" will be passed as-is (and hardly anybody
will have a repo with '{word}' in the path)

However, unless quoted on the command-line, a likely case of:
"b_one/{first,second}" will expand to: "b_one/first" "b_one/second"

...which causes "b_one/second" to be interpreted as the destination
directory.   A knowledgeable bash user can avoid this by using:
-b=b_one/{first,second} to avoid this situation.

But with the above invocation, no explicit support is needed
for command-line parsing in git-svn.
