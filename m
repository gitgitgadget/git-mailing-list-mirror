From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: reset invalidates the memoized mergeinfo caches
Date: Wed, 8 Aug 2012 22:52:58 +0000
Message-ID: <20120808225258.GA24956@dcvr.yhbt.net>
References: <20120807200207.GA10899@m62s10.vlinux.de>
 <20120807204510.GA10453@dcvr.yhbt.net>
 <20120808054129.GB10899@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Myrick <amyrick@apple.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:53:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzF7g-0003C6-PW
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 00:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680Ab2HHWxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 18:53:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36878 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab2HHWw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 18:52:59 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638871F5BE;
	Wed,  8 Aug 2012 22:52:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120808054129.GB10899@m62s10.vlinux.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203142>

Peter Baumann <waste.manager@gmx.de> wrote:
> On Tue, Aug 07, 2012 at 08:45:10PM +0000, Eric Wong wrote:
> > Peter Baumann <waste.manager@gmx.de> wrote:
> > > +			for my $suffix (qw(yaml db)) {
> > > +				unlink("$cache_file.$suffix");
> > 
> > Need to check for unlink() errors (and ignore ENOENT).
> 
> I'm not sure what you mean here: Aren't we screwed either way if unlinking
> the file failed? There is nothhing we can do about it if e.g. the user doesn't
> have the permissions to delete the file, besides terminating, e.g.
> 
> 	for my $cache_file (("$cache_path/lookup_svn_merge",
> 			     "$cache_path/check_cherry_pick",
> 			     "$cache_path/has_no_changes")) {
> 		for my $suffix (qw(yaml db)) {
> 			next unless (-e "$cache_file.$suffix");
> 			unlink("$cache_file.$suffix") or 
> 				die "Failed to delete $cache_file.$suffix";
> 		}

Yes we're screwed, but silent failure is the worst way to fail,
especially if it can lead us back to the problems your patch is meant to
address.

Perhaps something like this (with $! to show the error):

			my $file = "$cache_file.$suffix";
			next unless -e $file;
			unlink($file) or die "unlink($file) failed: $!\n";
