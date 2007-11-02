From: "Ronald Landheer-Cieslak" <ronald@landheer-cieslak.com>
Subject: [PATCH] New script: git-changelog.perl
Date: Fri, 2 Nov 2007 11:55:24 -0400
Message-ID: <67837cd60711020855v5badf7a6o9b777f339df070f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 16:55:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InysH-0001EW-E9
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbXKBPza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756012AbXKBPza
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:55:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:25015 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbXKBPz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:55:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so858907nfb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=aaxIn0f7uYBM8/pSxw6sncHWUwK8JzQHWt51YQG1F88=;
        b=e24H3Vb7R/Op4CQYR8fpU68KseFwGQgPkHNcIXNkoN9rzJd4fO1C+fAp7wvJQJ16vGmTA7540QUIEWCQKab5fzlLaM7PL3QiKfgSJ/8JInYzUL6AfNeBaK4ex/0d7IK1QLqbD5sUoFZt0OYlbrZCBXNwyawd1Lgz4twrXo4BLKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=MD8EaoUzYKPy7sxHeiujqYvckRj8YDMWad8flckLbhL2TBH0KDpkS214SJnRYE7i3gYDtMc+nakhq+/uTNVfaCuUuO7GUvHOoNLsl2C9a71Cm/1n3TPb3L4sFMd2OhsItO6etCqOVk3+z9M8xiBLs0RA2pcb7TRSNkTB7v3kWCA=
Received: by 10.78.186.9 with SMTP id j9mr1427714huf.1194018924126;
        Fri, 02 Nov 2007 08:55:24 -0700 (PDT)
Received: by 10.78.39.14 with HTTP; Fri, 2 Nov 2007 08:55:24 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 7473da28824e79cb
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63138>

Hello all,

I've written a little script that will format the changes as reported
by git-log in a ChangeLog-like format. Entries look like this:
<date>\t<author>\n\t<sha1>: <subject>

An example taken from Gits own recent history:

2007-10-30      Junio C Hamano
        9c51414: Merge branch 'maint' into HEAD
        7eedc1c: Merge branch 'nd/worktree' into HEAD
        9725bb8: Merge branch 'cc/skip' into HEAD
        7ae4dd0: Merge branch 'jk/send-pack' into HEAD
        7e9a464: Merge branch 'lt/rename' into HEAD
        6beb669: Merge branch 'jn/web' into HEAD
        791e421: Merge branch 'ds/gitweb' into HEAD
        5153399: Merge branch 'js/rebase' into HEAD
        0bdb5af: Update GIT 1.5.3.5 Release Notes

2007-10-30      Gerrit Pape
        fee9832: No longer install git-svnimport, move to contrib/examples

I intend to use it for releases of my software, and I though others
might like it as well.

I haven't implemented any help yet, but if any-one would like some
documentation, I'll be glad to provide it.

rlc

diff --git a/Makefile b/Makefile
index 71479a2..cf2cb32 100644
--- a/Makefile
+++ b/Makefile
@@ -226,7 +226,7 @@ SCRIPT_PERL = \
        git-add--interactive.perl \
        git-archimport.perl git-cvsimport.perl git-relink.perl \
        git-cvsserver.perl git-remote.perl git-cvsexportcommit.perl \
-       git-send-email.perl git-svn.perl
+       git-send-email.perl git-svn.perl git-changelog.perl

 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
          $(patsubst %.perl,%,$(SCRIPT_PERL)) \
diff --git a/git-changelog.perl b/git-changelog.perl
new file mode 100755
index 0000000..bffa1ab
--- /dev/null
+++ b/git-changelog.perl
@@ -0,0 +1,68 @@
+#!/usr/bin/perl -w
+
+use strict;
+
+sub fetch_log {
+       my $command='git log --pretty=format:"%ai|%an|%h|%s" ';
+       foreach (@_) {
+               $command .= ' ' . $_;
+       }
+       $command .= " |";
+       my $fh;
+       open $fh, $command
+               or die "Failed to fetch logs";
+       # logs are presented as lines in which fields are separated by pipes.
+       # the fields are the date in ISO format (so the date as we
want it extends to the
+       # first space), the name of the author, the abbreviated SHA1
hash and the subject line
+       my $date_time;
+       my $date;
+       my $cruft;
+       my $author;
+       my $hash;
+       my $subject;
+       my $prev_date="";
+       my @cache; # a cache of the changes for the current date (i.e.
while $prev_date eq $date)
+       my %entry; # a cache entry; $entry{'author'} is the entry and
@$entry{'changes'} are the changes for the author in question
+       while (<$fh>) {
+               ($date_time, $author, $hash, $subject) = split(/\|/);
+               ($date, $cruft) = split(/\s/, $date_time, 2);
+               chomp $author;
+
+               if ($date ne $prev_date)
+               {
+                       foreach (@cache)
+                       {
+                               # print out the line with the date and
the author
+                               my $changes = $_->{'changes'};
+                               print "\n" . $prev_date . "\t" .
$_->{'author'} . "\n" if ($#{$changes} != -1);
+                               foreach (@{$changes})
+                               {
+                                       print "\t" . $_->{'hash'} . ':
' . $_->{'subject'};
+                               }
+                       }
+                       $prev_date = $date;
+                       @cache = ();
+               }
+               # try to find an entry with the same author in the cache
+               my $found = -1;
+               my $i;
+               for ($i = 0; $i <= $#cache && $found == -1; $i++)
+               {
+                       if ($cache[$i]->{'author'} eq $author)
+                       {
+                               $found = $i;
+                       }
+               }
+               if ($found == -1)
+               {
+                       my $changes = ();
+                       push @cache, { 'author', $author, 'changes', $changes };
+                       $found = $#cache;
+               }
+               push @{$cache[$found]->{'changes'}}, { 'hash', $hash,
'subject', $subject };
+       }
+}
+
+fetch_log @ARGV;
+
+



-- 
Ronald Landheer-Cieslak
Software Architect
http://www.landheer-cieslak.com/
New White Paper: "Three Good Reasons to Plan Ahead"
