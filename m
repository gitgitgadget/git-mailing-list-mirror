From: "Ronald Landheer-Cieslak" <ronald@landheer-cieslak.com>
Subject: [PATCH] New script: git-changelog.perl - revised
Date: Fri, 2 Nov 2007 16:03:27 -0400
Message-ID: <67837cd60711021303q488e0873lea363b93fc90d591@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 21:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io2k7-0002oZ-Qb
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbXKBUDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbXKBUDc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:03:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:23111 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbXKBUDb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 16:03:31 -0400
Received: by nf-out-0910.google.com with SMTP id g13so916493nfb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=hra+9X9W0VBwM+P+I1XulEy2jermvrbJ1m9Ls37PKhE=;
        b=c4RdZ6TDMBYVg+JQo8c5L8+VyoUAW3oWrD+FuLX3nw/G2xFKs4RQk7XUgJbuWxOGqpYmmAvzQKRnHIRgWGqUd4DfessU2wDZoO8t4DayYXMsiqeUbOGBtvhmp74uW7MfrDrVqmU5MC0sjC6dez87hpNyELtb9sBbrgJd5C9pOJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=KWky3RMrUWFmmH65JT56ZRZalR2Y5CAI+KGU0sECgFLF8URLjeETfpoeaeSIMmb1x0LZR7JnYirv/svI9s8m3SJAR5ZWECQ/LxgW7A/zXsqfVe/pc/gflFuwQ1IawniQH3o45LMCZh1WZax4lBBNPHfraB9+lhQ7RXMGv8e89oo=
Received: by 10.78.184.2 with SMTP id h2mr1664545huf.1194033807674;
        Fri, 02 Nov 2007 13:03:27 -0700 (PDT)
Received: by 10.78.39.14 with HTTP; Fri, 2 Nov 2007 13:03:27 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 6e6093ff6195bbd4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63164>

I just noticed that I'd been sending personal replies to each and
every one of the replies I got - sorry about that.

Anyway, after Nicolas' suggestion, I moved the script into the contrib
directory and removed it from the Makefile, having the following patch
as net effect.
This is also available through git at
git://vlinder.landheer-cieslak.com/git/git.git#topic/git-log-changelog

As for difference wrt git2cl:
* less complicated
* less dependencies
* short hash for the commits are output in the change log
* git-changelog calls git-log with the proper parameters itself (no
need for the user to call it with a given set of parameters).

rlc

diff --git a/contrib/git-changelog/git-changelog.perl
b/contrib/git-changelog/git-changelog.perl
new file mode 100755
index 0000000..bffa1ab
--- /dev/null
+++ b/contrib/git-changelog/git-changelog.perl
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
