From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] cvsimport: use show-ref to support packed refs
Date: Wed, 28 Nov 2007 14:44:23 -0500
Message-ID: <20071128194423.GB11396@coredump.intra.peff.net>
References: <20071128185504.GA11236@coredump.intra.peff.net> <20071128185611.GB11320@coredump.intra.peff.net> <Pine.LNX.4.64.0711281916140.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxSpx-00019W-HT
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 20:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbXK1To0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 14:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355AbXK1To0
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 14:44:26 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3792 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331AbXK1ToZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 14:44:25 -0500
Received: (qmail 13679 invoked by uid 111); 28 Nov 2007 19:44:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 14:44:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 14:44:23 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711281916140.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66416>

On Wed, Nov 28, 2007 at 07:16:36PM +0000, Johannes Schindelin wrote:

> > -sub get_headref ($$) {
> > -    my $name    = shift;
> > -    my $git_dir = shift;
> > -
> > -    my $f = "$git_dir/$remote/$name";
> > -    if (open(my $fh, $f)) {
> > -	    chomp(my $r = <$fh>);
> > -	    is_sha1($r) or die "Cannot get head id for $name ($r): $!";
> > -	    return $r;
> > -    }
> > -    die "unable to open $f: $!" unless $! == POSIX::ENOENT;
> > -    return undef;
> > +sub get_headref ($) {
> > +	my $name = shift;
> > +	my $r = `git show-ref -s '$name'`;
> > +	return undef unless $? == 0;
> > +	chomp $r;
> > +	return $r;
> >  }
> 
> Where has $remote gone?

Gah, thank you. Obviously I deleted it without looking when I removed
the now-unnecessary $git_dir. However, let me put a curse on whoever is
responsible for randomly using "$remote" as a global in this function,
when all of the other parameters (including the
obvious-candidate-for-a-global $git_dir) are passed in.

Since get_headref is useful in contexts where "$remote" is not always
prepended (see patch 3/3), I think the best solution is:

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1b5f187..bbf9799 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -692,7 +692,8 @@ my (@old,@new,@skipped,%ignorebranch);
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
 
 sub commit {
-	if ($branch eq $opt_o && !$index{branch} && !get_headref($branch)) {
+	if ($branch eq $opt_o && !$index{branch} &&
+		!get_headref("$remote/$branch")) {
 	    # looks like an initial commit
 	    # use the index primed by git-init
 	    $ENV{GIT_INDEX_FILE} = "$git_dir/index";
@@ -716,7 +717,7 @@ sub commit {
 	update_index(@old, @new);
 	@old = @new = ();
 	my $tree = write_tree();
-	my $parent = get_headref($last_branch);
+	my $parent = get_headref("$remote/$last_branch");
 	print "Parent ID " . ($parent ? $parent : "(empty)") . "\n" if $opt_v;
 
 	my @commit_args;
@@ -727,7 +728,7 @@ sub commit {
 	foreach my $rx (@mergerx) {
 		next unless $logmsg =~ $rx && $1;
 		my $mparent = $1 eq 'HEAD' ? $opt_o : $1;
-		if (my $sha1 = get_headref($mparent)) {
+		if (my $sha1 = get_headref("$remote/$mparent")) {
 			push @commit_args, '-p', $mparent;
 			print "Merge parent branch: $mparent\n" if $opt_v;
 		}
