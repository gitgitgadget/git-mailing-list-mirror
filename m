From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Convert shortlog to handle cogito (cg-log) output
Date: Tue, 26 Apr 2005 04:39:50 -0400
Message-ID: <20050426083950.GA30167@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@transmeta.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 10:36:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQLXa-0000LK-Nb
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 10:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVDZIkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 04:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVDZIkM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 04:40:12 -0400
Received: from mail.autoweb.net ([198.172.237.26]:22747 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261400AbVDZIjy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 04:39:54 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DQLbi-0006l8-JG; Tue, 26 Apr 2005 04:39:50 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DQLcV-0001eJ-00; Tue, 26 Apr 2005 04:40:39 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DQLbi-0001Q4-2F; Tue, 26 Apr 2005 04:39:50 -0400
To: Matthias Andree <matthias.andree@gmx.de>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Convert "shortlog" to understand cogito's cg-log output format instead
of "bk changes" format.

Cogito (and by inference, "git" in general) have a different log output
format than BitKeeper.  This log format seems somewhat simpler to parse.

The following patch is a *bare minimum* conversion to make "shortlog"
provide corrected output the Cogito script "cg-log".

(This is clearly not sufficient, and not intended for application to any
rea tree, as a lot of BitKeeper domain knowledge remains, but this
should be enough for Linus to provide changelogs in the "shortlog"
format again, and hopefully to serve as a template for further
modifications by others.)

Signed-Off-By: Ryan Anderson <ryan@michonline.com>

--- cogito-tools/shortlog	2005-04-26 04:22:01.000000000 -0400
+++ cogito-tools/git-shortlog	2005-04-26 04:36:52.000000000 -0400
@@ -3052,7 +3052,7 @@
       }
 
     if (defined $address and $opt{multi}
-	and m{^[^<[:space:]]} and not m{^ChangeSet@}) {
+	and m{^[^<[:space:]]} and not m{^commit }) {
       # if we are in multi mode, if we encounter a non-address
       # left-justified line, flush all data and print the header. The
       # 'defined $address' trick lets this only trigger to switch back
@@ -3063,13 +3063,14 @@
       @prolog = ($_);
       undef %$log;
       undef $address;
-    } elsif (m{^<([^>]+)>} or m{^ChangeSet@[0-9.]+,\s*[-0-9:+ ]+,\s*(\S+)}) {
+    } elsif (m{^<([^>]+)>} or m{^author (.*) <(.*)>}) {
       # go figure if a line starts with an address, if so, take it
       # resolve the address to a name if possible
       append_item(%$log, @cur); @cur = ();
-      $address = lc($1);
+      $address = lc($2);
       $address =~ s/\[[^]]+\]$//;
       $name = rmap_address($address, 1);
+      $name = $1 if ($name eq $address);
       $author = treat_addr_name($address, $name);
       $first = 1;
       $firstpar = 1;
@@ -3093,25 +3094,28 @@
       } else {
 	  print STDERR " SKIPPED SIGNED-OFF-BY  $author\n" if $debug;
       }
-    } elsif ($first) {
+    } elsif ($first && m/^(?:[[:space:]]{4}|\t)(.*)$/) {
       # we have a "first" line after an address, take it,
       # strip common redundant tags
+      
+      my $comment = $1;
 
       # kill "PATCH" tag
-      s/^\s*\[PATCH\]//;
-      s/^\s*PATCH//;
-      s/^\s*[-:]+\s*//;
+      $comment =~ s/^\s*\[PATCH\]//;
+      $comment =~ s/^\s*PATCH//;
+      $comment =~ s/^\s*[-:]+\s*//;
 
       # strip trailing colon or period, and if we strip one,
       # we don't parse further lines as part of the first paragraph
-      if (s/[:.]+\s*$//) { $firstpar = 0; }
+      if ($comment =~ s/[:.]+\s*$//) { $firstpar = 0; }
 
       # kill leading and trailing whitespace for consistent indentation
-      s/^\s+//; s/\s+$//;
+      $comment =~ s/^\s+//; s/\s+$//;
 
-      push @cur, $_;
+      push @cur, $comment;
       $first = 0;
-    } elsif (defined $address) {
+
+    } elsif (defined $address && m/^(?:[[:space:]]{4}|\t)(.*)$/ ) {
       # second or subsequent lines -- if in first paragraph,
       # append this line to the first log line.
       if (m/^\s*$/) { $firstpar = 0; }
@@ -3124,6 +3128,10 @@
       }
       # we don't parse further lines as part of the first paragraph
       if (s/[:.]+\s*$//) { $firstpar = 0; }
+
+    } elsif (m/^(commit|tree|parent|committer) / || m/^\s*$/) {
+      # Skip unused header lines
+
     } else {
       # store header before a changelog
       push @prolog, $_;


-- 

Ryan Anderson
  sometimes Pug Majere
