From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/5] git-svn: memoize conversion of SVN merge ticket
	info to git commit ranges
Date: Mon, 21 Dec 2009 02:44:44 -0800
Message-ID: <20091221104443.GA14539@dcvr.yhbt.net>
References: <1261240435-8948-1-git-send-email-sam@vilain.net> <1261240435-8948-2-git-send-email-sam@vilain.net> <1261240435-8948-3-git-send-email-sam@vilain.net> <1261344246.20752.24.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Myrick <amyrick@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 11:45:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMflh-0003Jz-Rt
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 11:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbZLUKop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 05:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbZLUKop
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 05:44:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35029 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbZLUKop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 05:44:45 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FDCE1F520;
	Mon, 21 Dec 2009 10:44:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1261344246.20752.24.camel@denix>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135554>

Sam Vilain <sam@vilain.net> wrote:
> On Sun, 2009-12-20 at 05:33 +1300, Sam Vilain wrote:
> > +sub lookup_svn_merge {
> > +	my $uuid = shift;
> > +	my $url = shift;
> > +	my $merge = shift;
> > +
> > +	my ($source, $revs) = split ":", $merge;
> > +	my $path = $source;
> > +	$path =~ s{^/}{};
> > +	my $gs = Git::SVN->find_by_url($url.$source, $url, $path);
> > +	if ( !$gs ) {
> > +		warn "Couldn't find revmap for $url$source\n";
> > +		next;
> > +	}
> 
> As mentioned in the other thread, that 'next' should now be 'return'.

Thanks Sam and Andrew.  I've acked this series and pushed them out along
with a release notes update as well as another small fix (inline below).

Eric Wong (2):
      git svn: fix --revision when fetching deleted paths
      update release notes for git svn in 1.6.6

Sam Vilain (5):
      git-svn: expand the svn mergeinfo test suite, highlighting some failures
      git-svn: memoize conversion of SVN merge ticket info to git commit ranges
      git-svn: fix some mistakes with interpreting SVN mergeinfo commit ranges
      git-svn: exclude already merged tips using one rev-list call
      git-svn: detect cherry-picks correctly.

>From 577e9fcad2c8968846b365226b89778050496a78 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Mon, 21 Dec 2009 02:06:04 -0800
Subject: [PATCH] git svn: fix --revision when fetching deleted paths

When using the -r/--revision argument to fetch deleted history,
calling SVN::Ra::get_log() from an SVN::Ra object initialized
to track the deleted URL will fail.

This regression was introduced in:
  commit 4aacaeb3dc82bb6479e70e120053dc27a399460e
  "fix shallow clone when upstream revision is too new"

We now ignore errors from SVN::Ra::get_log() here because using
--revision will always override the value of $head here if
(and only if) we're tracking deleted directories.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d362de7..a6f5061 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1741,7 +1741,11 @@ sub fetch_all {
 	my $ra = Git::SVN::Ra->new($url);
 	my $uuid = $ra->get_uuid;
 	my $head = $ra->get_latest_revnum;
-	$ra->get_log("", $head, 0, 1, 0, 1, sub { $head = $_[1] });
+
+	# ignore errors, $head revision may not even exist anymore
+	eval { $ra->get_log("", $head, 0, 1, 0, 1, sub { $head = $_[1] }) };
+	warn "W: $@\n" if $@;
+
 	my $base = defined $fetch ? $head : 0;
 
 	# read the max revs for wildcard expansion (branches/*, tags/*)
-- 
Eric Wong
