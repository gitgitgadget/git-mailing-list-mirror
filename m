From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: reset invalidates the memoized mergeinfo
 caches
Date: Tue, 7 Aug 2012 20:45:10 +0000
Message-ID: <20120807204510.GA10453@dcvr.yhbt.net>
References: <20120807200207.GA10899@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Myrick <amyrick@apple.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 22:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyqeV-0004Br-CY
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 22:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab2HGUpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 16:45:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53240 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667Ab2HGUpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 16:45:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88C81F42A;
	Tue,  7 Aug 2012 20:45:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120807200207.GA10899@m62s10.vlinux.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203045>

Peter Baumann <waste.manager@gmx.de> wrote:
> Therefore the easiest solution to clear the cache is to delete the files
> on disk in 'git svn reset'. Normally, deleting the files behind the back
> of the memoization module would be problematic, because the in-memory
> representation would still exist and contain wrong data. Fortunately, the
> memoization is active in memory only for a small portion of the code.
> Invalidating the cache by deleting the files on disk if it isn't active
> should be safe.

Thanks for the patch and explanation.  A few comments below:

> +	sub clear_memoized_mergeinfo_caches {
> +		die "Only call this method in non-memoized context" if ($memoized);
> +
> +		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
> +		return unless -d $cache_path;
> +
> +		for my $cache_file (("$cache_path/lookup_svn_merge",
> +				     "$cache_path/check_cherry_pick",
> +				     "$cache_path/has_no_changes")) {
> +			for my $suffix (qw(yaml db)) {
> +				unlink("$cache_file.$suffix");

Need to check for unlink() errors (and ignore ENOENT).

> @@ -2126,8 +2142,13 @@ sub rev_map_set {
>  
>  	sysopen(my $fh, $db_lock, O_RDWR | O_CREAT)
>  	     or croak "Couldn't open $db_lock: $!\n";
> -	$update_ref eq 'reset' ? _rev_map_reset($fh, $rev, $commit) :
> -				 _rev_map_set($fh, $rev, $commit);
> +	if ($update_ref eq 'reset') {
> +		_rev_map_reset($fh, $rev, $commit);
> +		clear_memoized_mergeinfo_caches();

Better to clear_memoized_mergeinfo_caches() before _rev_map_reset()
in case unlink() (or anything else) fails when clearing the cache.

> +test_expect_success 'initialize source svn repo' '
> +	svn_cmd mkdir -m "create trunk" "$svnrepo"/trunk &&
> +	svn_cmd mkdir -m "create branches" "$svnrepo/branches" &&
> +	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
> +	(
> +		cd "$SVN_TREE" &&
> +		touch foo &&
> +		svn add foo &&

svn_cmd here, too.

> +		svn commit -m "a" &&
> +		svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
> +		svn switch "$svnrepo"/branches/branch1 &&
> +		touch bar &&
> +		svn add bar &&
> +		svn commit -m b &&
> +		svn switch "$svnrepo"/trunk &&
> +		touch baz &&
> +		svn add baz &&
> +		svn commit -m c &&
> +		svn up &&
> +		svn merge "$svnrepo"/branches/branch1 &&
> +		svn commit -m "m"
> +	) &&
