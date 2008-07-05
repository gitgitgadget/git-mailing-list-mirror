From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] Add git-basis.perl to contrib directory
Date: Sat,  5 Jul 2008 16:40:34 -0400
Message-ID: <1215290434-27694-4-git-send-email-adambrewster@gmail.com>
References: <7vod5crydx.fsf@gitster.siamese.dyndns.org>
 <1215290434-27694-1-git-send-email-adambrewster@gmail.com>
 <1215290434-27694-2-git-send-email-adambrewster@gmail.com>
 <1215290434-27694-3-git-send-email-adambrewster@gmail.com>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, adambrewster@gmail.com,
	Adam Brewster <asb@bu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 22:42:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFEZu-00068Q-67
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 22:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbYGEUkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYGEUkv
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 16:40:51 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:50559 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbYGEUkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 16:40:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so734750ywe.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ty02/LZEHRpJWHJBRDXD30OjEuFO6NLLMa4q9aTpnGo=;
        b=ArXLLQpKGWSrPcIf8BChRpFYU2OQmtedLz0xgER8C7Aa4D5eicartzOoEjTzdhBwP2
         c+swiy1FXxOGHiWMQbvqVa26PXA6OPEP21b6jscowqDvjSO1u3RNpczD6guPJrA+YQMW
         Z+IymUjcrJ5h0FvBeLZ/cNah5UMpHtrNAqnfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FqfcHopKXwDsqZGtx5y5ri39hsxQtvM+xm70xdSN4dP3N1+gFTQ4RbCmrQACq9wNjm
         PZZEEMIMkTFAQfjQGTa8zt0xqqKAJJQhLf8g0talKAsI8vupNbBAmEj2bUvTPv+B7gry
         2SI4XJLFuVbotVeSbd3QI0TrQM5HkEj9yF7fg=
Received: by 10.150.177.20 with SMTP id z20mr4713331ybe.72.1215290439295;
        Sat, 05 Jul 2008 13:40:39 -0700 (PDT)
Received: from MBE.internal ( [65.96.168.20])
        by mx.google.com with ESMTPS id 34sm2803897yxl.9.2008.07.05.13.40.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 13:40:36 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id DD59D104A22; Sat,  5 Jul 2008 16:40:34 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <1215290434-27694-3-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87464>

Git-basis is a perl script that remembers bases for use by git-bundle.

This script shouldn't be needed because git-push and git-remote should do this
kind of work.  Unfortunately they currently don't so some might find this
script useful.

Signed-off-by: Adam Brewster <asb@bu.edu>
---
 contrib/basis/git-basis.perl |   77 ++++++++++++++++++++++++++++++++++++
 contrib/basis/git-basis.txt  |   90 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100755 contrib/basis/git-basis.perl
 create mode 100644 contrib/basis/git-basis.txt

diff --git a/contrib/basis/git-basis.perl b/contrib/basis/git-basis.perl
new file mode 100755
index 0000000..b3e753f
--- /dev/null
+++ b/contrib/basis/git-basis.perl
@@ -0,0 +1,77 @@
+#!/usr/bin/perl
+
+use strict;
+
+use Git;
+
+require Time::Local;
+my $git_epoch = Time::Local::timegm(0, 0, 0, 1, 0, 70);
+
+my $r = Git->repository();
+my $d = $r->repo_path();
+
+if ( ! -d "$d/bases" ) {
+    mkdir("$d/bases") || die "Could not create $d/bases: $!";
+}
+
+if ( $#ARGV == -1 || ($#ARGV == 0 && $ARGV[0] eq '--update') ) {
+    print STDERR "usage: git-basis [--update] basis1...\n";
+    exit;
+} elsif ( $ARGV[0] eq '--update' ) {
+    shift @ARGV;
+
+    my %new = ();
+    while (<STDIN>) {
+	if (!/^^?([a-z0-9]{40})/) {next;}
+	$new{$1} = 1;
+    }
+
+    foreach my $f (@ARGV) {
+	my %these = ();
+	my $fh;
+
+	open $fh, "+<$d/bases/$f" || die "Can't open bases/$f: $!";
+	while (<$fh>) {
+	    if (!/^([a-z0-9]{40})/) {next;}
+	    $these{$1} = 1;
+	}
+
+	print $fh "# ", gmtime() - $git_epoch,
+		" +0000 // ", scalar(localtime()), "\n";
+
+	foreach my $b (keys %new) {
+	    if (exists($these{$b})) {next;}
+	    print $fh "$b\n";
+	}
+	close $fh;
+    }
+} else {
+    my $n = 0;
+    my %basis = ();
+
+    my $f = shift @ARGV;
+    open F, "<$d/bases/$f" || die "Can't open bases/$f: $!";
+    while (<F>) {
+	if (!/^([a-z0-9]{40})/) {next;}
+	$basis{$1} = $n;
+    }
+    close F;
+
+    foreach $f (@ARGV) {
+	open F, "<$d/bases/$f" || die "Can't open bases/$f: $!";
+	while (<F>) {
+	    if (!/^([a-z0-9]{40})/) {next;}
+	    if (!exists($basis{$1})) {next;}
+
+	    if ($basis{$1} == $n) {$basis{$1}++;}
+	    else {delete $basis{$1};}
+	}
+	close F;
+	$n++;
+    }
+
+    foreach my $b (keys %basis) {
+	if ( $basis{$b} != $n ) {next;}
+	print "^$b\n";
+    }
+}
diff --git a/contrib/basis/git-basis.txt b/contrib/basis/git-basis.txt
new file mode 100644
index 0000000..97cfc20
--- /dev/null
+++ b/contrib/basis/git-basis.txt
@@ -0,0 +1,90 @@
+git-basis(1)
+============
+
+NAME
+----
+git-basis - Track sets of references available on remote systems (bases)
+
+SYNOPSIS
+--------
+[verse]
+'git-basis' <basis> [<basis>...]
+'git-basis' --update <basis> [<basis>...] < <object list or bundle>
+
+DESCRIPTION
+-----------
+Maintains lists of objects that are known to be accessible on remote
+computer systems that are not accessible by network.
+
+OPTIONS
+-------
+
+basis::
+	List of bases to operate on.  Any valid filename can be
+	the name of a basis.  Bases that do not exist are taken
+	to be empty.
+
+--update::
+	Tells git-basis to read a list of objects from stdin and
+	add them to each of the given bases.  git-basis produces
+	no output when this option is given.  Bases will be created
+	if necessary.
+
+object list or bundle::
+	Git-basis --update reads object names, one per line from stdin.
+	Leading caret ("^") characters are ignored, as is anything
+	after the object name.  Lines that don't begin with an object
+	name are ignored.  The output of linkgit:git-ls-remote[1] or a
+	bundle created by linkgit:git-bundle[1] are both suitable input.
+
+DISCUSSION
+----------
+git-basis is probably only useful with linkgit:git-bundle[1].
+
+To create a bundle that excludes all objects that are part of my-basis,
+use
+
+git-basis my-basis | git-bundle create my-bundle --all --stdin
+
+To add the objects in my-bundle to my-basis, use
+
+git-basis --update my-basis < my-bundle
+
+DETAILS
+-------
+Bases are stored as plain text files under .git/bases/.  One object
+entry per line.
+
+git-basis without --update reads all of the basis names given on the
+command line, and outputs the intersection of them to stdout, with each
+object prefixed by "^".
+
+git-basis --update reads object names from stdin, and adds all of the
+references to each of the bases listed.  Duplicate references will not
+be listed twice, but otherwise redundant information will be included.
+Each update is prefixed by a line with the current date.
+
+BUGS
+----
+Git-baisis has no undo function.  Once an object is added to a basis,
+it will stay there forever.  If you need to remove objects from a basis,
+use a text editor to alter the file .git/bases/<basis name>.
+
+Git-basis --update does not remove redundant information from bases.
+(Having an object implies that it's parents are also available.)  This
+is done intentionally to make sure git-basis --update is
+non-destructive.
+
+Bug reports are welcome, and patches are encouraged.
+
+SEE ALSO
+--------
+linkgit:git-bundle[1]
+
+AUTHOR
+------
+Written by Adam Brewster <asb@bu.edu>
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.5.5.1.211.g65ea3.dirty
