From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git svn: reset invalidates the memoized mergeinfo
 caches
Date: Wed, 8 Aug 2012 07:41:29 +0200
Message-ID: <20120808054129.GB10899@m62s10.vlinux.de>
References: <20120807200207.GA10899@m62s10.vlinux.de>
 <20120807204510.GA10453@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Myrick <amyrick@apple.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 08 07:41:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syz1Z-00024G-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 07:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260Ab2HHFlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 01:41:37 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:56428 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752324Ab2HHFlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 01:41:35 -0400
Received: (qmail invoked by alias); 08 Aug 2012 05:41:33 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp030) with SMTP; 08 Aug 2012 07:41:33 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX199miYFEOl91haf6qG/nza9bORvwyOWwTwKlm/66s
	lXmmAZ7HVKqKXC
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id E0D2FD6BCC; Wed,  8 Aug 2012 07:41:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120807204510.GA10453@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203064>

On Tue, Aug 07, 2012 at 08:45:10PM +0000, Eric Wong wrote:
> Peter Baumann <waste.manager@gmx.de> wrote:
> > Therefore the easiest solution to clear the cache is to delete the files
> > on disk in 'git svn reset'. Normally, deleting the files behind the back
> > of the memoization module would be problematic, because the in-memory
> > representation would still exist and contain wrong data. Fortunately, the
> > memoization is active in memory only for a small portion of the code.
> > Invalidating the cache by deleting the files on disk if it isn't active
> > should be safe.
> 
> Thanks for the patch and explanation.  A few comments below:
> 
> > +	sub clear_memoized_mergeinfo_caches {
> > +		die "Only call this method in non-memoized context" if ($memoized);
> > +
> > +		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
> > +		return unless -d $cache_path;
> > +
> > +		for my $cache_file (("$cache_path/lookup_svn_merge",
> > +				     "$cache_path/check_cherry_pick",
> > +				     "$cache_path/has_no_changes")) {
> > +			for my $suffix (qw(yaml db)) {
> > +				unlink("$cache_file.$suffix");
> 
> Need to check for unlink() errors (and ignore ENOENT).


I'm not sure what you mean here: Aren't we screwed either way if unlinking
the file failed? There is nothhing we can do about it if e.g. the user doesn't
have the permissions to delete the file, besides terminating, e.g.

	for my $cache_file (("$cache_path/lookup_svn_merge",
			     "$cache_path/check_cherry_pick",
			     "$cache_path/has_no_changes")) {
		for my $suffix (qw(yaml db)) {
			next unless (-e "$cache_file.$suffix");
			unlink("$cache_file.$suffix") or 
				die "Failed to delete $cache_file.$suffix";
		}
	}

> 
> > @@ -2126,8 +2142,13 @@ sub rev_map_set {
> >  
> >  	sysopen(my $fh, $db_lock, O_RDWR | O_CREAT)
> >  	     or croak "Couldn't open $db_lock: $!\n";
> > -	$update_ref eq 'reset' ? _rev_map_reset($fh, $rev, $commit) :
> > -				 _rev_map_set($fh, $rev, $commit);
> > +	if ($update_ref eq 'reset') {
> > +		_rev_map_reset($fh, $rev, $commit);
> > +		clear_memoized_mergeinfo_caches();
> 
> Better to clear_memoized_mergeinfo_caches() before _rev_map_reset()
> in case unlink() (or anything else) fails when clearing the cache.

Will do.

> 
> > +test_expect_success 'initialize source svn repo' '
> > +	svn_cmd mkdir -m "create trunk" "$svnrepo"/trunk &&
> > +	svn_cmd mkdir -m "create branches" "$svnrepo/branches" &&
> > +	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
> > +	(
> > +		cd "$SVN_TREE" &&
> > +		touch foo &&
> > +		svn add foo &&
> 
> svn_cmd here, too.

Will do.
> 
> > +		svn commit -m "a" &&
> > +		svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
> > +		svn switch "$svnrepo"/branches/branch1 &&
> > +		touch bar &&
> > +		svn add bar &&
> > +		svn commit -m b &&
> > +		svn switch "$svnrepo"/trunk &&
> > +		touch baz &&
> > +		svn add baz &&
> > +		svn commit -m c &&
> > +		svn up &&
> > +		svn merge "$svnrepo"/branches/branch1 &&
> > +		svn commit -m "m"
> > +	) &&
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
