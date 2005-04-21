From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Possible strategy cleanup for git add/remove/diff etc.
Date: Wed, 20 Apr 2005 21:04:44 -0700
Message-ID: <7vsm1kg4gz.fsf@assigned-by-dhcp.cox.net>
References: <20050419035107.GB5554@pasky.ji.cz>
	<7vacnumgot.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org>
	<Pine.LNX.4.58.0504192102140.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 06:01:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOSsJ-0005Wd-So
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 06:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVDUEF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 00:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVDUEF1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 00:05:27 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60646 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261209AbVDUEEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 00:04:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421040444.QKSP9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Apr 2005 00:04:44 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.58.0504192102140.6467@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 19 Apr 2005 21:32:44 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> And as you can see, the output matches "diff-tree -r" output (we always do
LT> "-r", since the index is always fully populated). All the same rules: "+"  
LT> means added file, "-" means removed file, and "*" means changed file. You 
LT> can trivially see that the above is a rename.

I do not know if Pasky tools already have something like this
already, or not; but just FIY, here is what I use to extract a
"patch" out of a working tree.

Usage:

    $ diff-tree -z [-r] ... | jit-diff-tree-helper [ | less ]
    $ diff-cache -z ...     | jit-diff-tree-helper [ | less ]

This would be useful for the merge I described in my initial
message in this thread to take a snapshot of what the user has
done since the last commit, to be applied on the result of the
merge.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

--- jit-diff-tree-helper	2005-03-19 15:28:25.000000000 -0800
+++ jit-diff-tree-helper	2005-04-20 19:15:32.000000000 -0700
@@ -0,0 +1,63 @@
+#!/usr/bin/perl -w
+
+use strict;
+use File::Temp qw(mkstemp);
+
+sub cat_file {
+    my ($sha1, $file) = @_;
+    unless (defined $sha1) { return "/dev/null"; }
+    if ($sha1 =~ /^0{40}$/) {
+	open I, '<', $file;
+    } else {
+	local $/; # slurp mode
+	open I, "-|", "cat-file", "blob", $sha1
+	    or die "$0: cannot read $sha1";
+    }
+    my ($o, $filename) = mkstemp(",,jit-diff-tree-helperXXXXXX");
+    print $o join("",<I>);
+    close I
+	or die "$0: closing cat-file pipe from $sha1";
+    close $o
+	or die "$0: closing write fd to $filename";
+    return $filename;
+}
+$/ = "\0";
+my $rM = "[0-7]+";
+my $rI = "[0-9a-f]{40}";
+while (<STDIN>) {
+    my ($old, $new, $file);
+    chomp;
+    if (/^\+$rM\tblob\t($rI)\t(.*)$/os) {
+	($old, $new, $file) = (undef, $1, $2);
+    }
+    elsif (/^-$rM\tblob\t($rI)\t(.*)$/os) {
+	($old, $new, $file) = ($1, undef, $2);
+    }
+    elsif (/^\*$rM->$rM\tblob\t($rI)->($rI)\t(.*)$/os) {
+	($old, $new, $file) = ($1, $2, $3);
+    }
+    else {
+	chomp;
+	print STDERR "warning: $0: ignoring $_\n";
+	next;
+    }
+    if (@ARGV) {
+	my $matches = 0;
+	for (@ARGV) {
+	    my $l = length($_);
+	    if ($file eq $_ ||
+		(substr($file, 0, $l) eq $_ &&
+		 substr($file, $l, 1) eq "/")) {
+		$matches = 1;
+		last;
+	    }
+	}
+	next unless $matches;
+    }
+    $old = cat_file $old, $file;
+    $new = cat_file $new, $file;
+    system "diff", "-L", "l/$file", "-L", "k/$file", "-pu", $old, $new;
+    for ($old, $new) {
+	unlink $_ if $_ ne '/dev/null';
+    }
+}


