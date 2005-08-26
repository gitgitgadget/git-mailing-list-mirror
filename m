From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: SVN import issue
Date: Fri, 26 Aug 2005 12:40:44 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.26.10.40.38.616149@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Aug 26 12:45:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8bfz-0003XF-5C
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 12:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVHZKnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 06:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVHZKnH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 06:43:07 -0400
Received: from main.gmane.org ([80.91.229.2]:32142 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751514AbVHZKnH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 06:43:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E8beY-0003LH-6d
	for git@vger.kernel.org; Fri, 26 Aug 2005 12:41:42 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Aug 2005 12:41:42 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Aug 2005 12:41:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7798>

Hi,

I'm off to the beach for the next two weeks, so if somebody wants to
munge cvs2git into svn2git, here's the basics on how to pull from a
remote SVN repo:


#!/usr/bin/perl

use strict;
use warnings;
use SVN::Core;
use SVN::Ra;

my(@new,@del,@mod);
sub show_log {
	my ($changed_paths, $revision, $author, $date, $message, $pool) = @_;
	$author = '<unknown>' unless defined $author;
	@new = (); @del = (); @mod = ();

	(my $pmessage = $message) =~ s/\n/\n    /g;
	print "*** $revision: $author \@ $date:\n<<< $pmessage>>>\n";
	print "Files:\n";
	while(my($path,$action) = each %$changed_paths) {
		my $act = $action->action;
		my $oldpath = $action->copyfrom_path;
		my $oldrev = $action->copyfrom_rev;
		$oldrev = undef if defined $oldrev and $oldrev <= 0;
		$oldpath = undef if defined $oldpath and ($oldpath eq "" or $oldpath eq $path);
		print "$act $path";
		print " <-" if $oldpath or $oldrev;
		print " $oldpath" if defined $oldpath;
		print " $oldrev" if defined $oldrev;
		print "\n";
		if($act eq "A") {
			push(@new,$path);
		} elsif($act eq "D") {
			push(@del,$path);
		} else {
			push(@mod,$path);
		}
	}
}


my $ra = SVN::Ra->new("svn://cvs.gnupg.org/gnupg");

my $latest = $ra->get_latest_revnum();
my $n = 1;
while($n <= $latest) {
	$ra->get_log("/",$n,$n,$n,1,1,\&show_log,"");

	foreach my $path(@new,@mod) {
		print "Reading $path, $n...\n";
		open(F,">/tmp/foo"); # ( OK, so use tempfile() here ;-)
		eval {
			$ra->get_file($path,$n,\*F);
		};
		close(F);
		if ($@) {
			print "... not a file\n";
			next;
		}
		my $sz = (stat("/tmp/foo"))[7];
		print "... done, $sz bytes\n.";
	}
} continue {
	$n++;
}

Paths in SVN are usually prefixed "/trunk/" (main branch) or
"/branches/foo/" (branch foo); tagging is done by creating "/tags/bar",
with the trunk (or branch) revision it is pointing to as its parent. 

So a branch point looks like this:

*** 350: <unknown> @ 1999-09-18T11:04:00.000000Z:
<<< This commit was manufactured by cvs2svn to create branch
    'STABLE-BRANCH-1-0'.>>>
Files:
A /branches/STABLE-BRANCH-1-0/cipher/rndw32.c <- /trunk/cipher/rndw32.c 349
A /branches/STABLE-BRANCH-1-0 <- /trunk 348

(and of *course* it may have changes from other revisions in it,
anything else would simply be too easy I guess...). Tags look like they
do, see tag 1-0-0 in the above repo; that seems to happen because their
CVS importer couldn't find a sane branchpoint. cvsps reports the same thing.

I haven't yet examined what a SVN merge looks like.

Nothing stops a SVN check-in from touching multiple branches at the same
time, though in practice that doesn't happen.

The mapping of SVN revision numbers to git SHA1s could get a bit
annoying because incremental imports need to work. Personally I'd use a
.svnmap file which has "svnid sha1" lines inside. The last line
obviously would not have a sha1 because we can't know that before
checking in the file...


So, if I find a working SVN importer when I come back I'll be happy  ;-)
(munging cvs2git shouldn't be particularly difficult), otherwise I'll do
it myself, in a month or so.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I had been driving my car for 40 years when I fell asleep at the wheel and
had an accident.
