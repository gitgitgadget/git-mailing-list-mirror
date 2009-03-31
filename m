From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: add a double quiet option to hide git commits
Date: Mon, 30 Mar 2009 23:52:31 -0700
Message-ID: <20090331065231.GA32142@dcvr.yhbt.net>
References: <49CFCD5A.1080801@simon.arlott.org.uk> <20090329224324.GB20675@dcvr.yhbt.net> <7vvdprjyrc.fsf@gitster.siamese.dyndns.org> <49D1100D.8010206@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mdpoole@troilus.org
To: Simon Arlott <simon@fire.lp0.eu>
X-From: git-owner@vger.kernel.org Tue Mar 31 08:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoXrI-0005sf-K2
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 08:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbZCaGwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 02:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbZCaGwd
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 02:52:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38559 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbZCaGwd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 02:52:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849D91F5FC;
	Tue, 31 Mar 2009 06:52:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49D1100D.8010206@simon.arlott.org.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115227>

Simon Arlott <simon@fire.lp0.eu> wrote:
> People may expect/prefer -q to still show git commits,
> so this change allows a second -q to hide them.
> 
> Signed-off-by: Michael Poole <mdpoole@troilus.org>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Thanks,
  Acked-by: Eric Wong <normalperson@yhbt.net>
and pushed out to git://git.bogomips.org/git-svn

> ---
> On 30/03/09 07:44, Junio C Hamano wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> >> Simon Arlott <simon@fire.lp0.eu> wrote:
> >>> Ideally only errors should be output in this mode so fetch
> >>> can be run from cron and normally produce no output. Without
> >>> this change it would output a single line on each git commit,
> >>> e.g.
> >>> r1909 = 32ef87860662526d4a62f903949ed21e0341079e (u2_10_12_branch)
> 
>  Documentation/git-svn.txt |    3 ++-
>  git-svn.perl              |    9 +++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index cda3389..8163a19 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -385,7 +385,8 @@ config key: svn.authorsfile
>  
>  -q::
>  --quiet::
> -	Make 'git-svn' less verbose.
> +	Make 'git-svn' less verbose. Specify a second time to make it
> +	even less verbose.
>  
>  --repack[=<n>]::
>  --repack-flags=<flags>::
> diff --git a/git-svn.perl b/git-svn.perl
> index e5c3dfe..d919798 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -68,6 +68,7 @@ my ($_stdin, $_help, $_edit,
>  	$_prefix, $_no_checkout, $_url, $_verbose,
>  	$_git_format, $_commit_url, $_tag);
>  $Git::SVN::_follow_parent = 1;
> +$_q ||= 0;
>  my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
>                      'config-dir=s' => \$Git::SVN::Ra::config_dir,
>                      'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
> @@ -80,7 +81,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>  		'useSvnsyncProps' => \$Git::SVN::_use_svnsync_props,
>  		'log-window-size=i' => \$Git::SVN::Ra::_log_window_size,
>  		'no-checkout' => \$_no_checkout,
> -		'quiet|q' => \$_q,
> +		'quiet|q+' => \$_q,
>  		'repack-flags|repack-args|repack-opts=s' =>
>  		   \$Git::SVN::_repack_flags,
>  		'use-log-author' => \$Git::SVN::_use_log_author,
> @@ -2331,13 +2332,13 @@ sub do_git_commit {
>  
>  	$self->{last_rev} = $log_entry->{revision};
>  	$self->{last_commit} = $commit;
> -	print "r$log_entry->{revision}" unless $::_q;
> +	print "r$log_entry->{revision}" unless $::_q > 1;
>  	if (defined $log_entry->{svm_revision}) {
> -		 print " (\@$log_entry->{svm_revision})" unless $::_q;
> +		 print " (\@$log_entry->{svm_revision})" unless $::_q > 1;
>  		 $self->rev_map_set($log_entry->{svm_revision}, $commit,
>  		                   0, $self->svm_uuid);
>  	}
> -	print " = $commit ($self->{ref_id})\n" unless $::_q;
> +	print " = $commit ($self->{ref_id})\n" unless $::_q > 1;
>  	if (--$_gc_nr == 0) {
>  		$_gc_nr = $_gc_period;
>  		gc();
> -- 
> 1.6.2
> -- 
> Simon Arlott
