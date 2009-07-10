From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Use "previous" header of git-blame -p in 'blame' view
Date: Fri, 10 Jul 2009 23:57:42 +0200
Message-ID: <200907102357.43475.jnareb@gmail.com>
References: <200907102354.43232.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 00:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPOAC-0003QR-DO
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 00:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369AbZGJWBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 18:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbZGJWBs
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 18:01:48 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:53491 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757335AbZGJWBn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 18:01:43 -0400
Received: by ewy26 with SMTP id 26so1423007ewy.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Ch9piy+4VOp6lSIaRVoEh6KWdCCLRYVSlZ+XL2KHE9Q=;
        b=dciXAy4Dffdq01cq8a0QjTzYWr8moQ0AzOA3F1gj6qe6H9bTGWIHR1LnXiVU9bffzJ
         WiMh/3ZkrZZvGUziqoIrkNnib0NoMCyb/Xy2j6ICrWUxMplWUzior+snuZPtaGLUOV7e
         6QO6ZkhOci39iLB6JtbSTREFD1UEJbdR2+C9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Jtfh76Gau4VIDqmc6dpXJUvywvv7KuscaYUxg7oDgOEzSB1VDdcOw+7GY5lXiK4VQb
         8laTTGElqU2Qq6Oon+c7sB7NEABq1jc6Vfm1o8VXUcCkEkRxDmXzbyoPfw3+eJ+LiiU5
         jUcIG6kNZpCeRafMFWGMCtEu6jdPrfoKBPFRI=
Received: by 10.211.195.3 with SMTP id x3mr2954159ebp.17.1247263300639;
        Fri, 10 Jul 2009 15:01:40 -0700 (PDT)
Received: from ?192.168.1.13? (abwp104.neoplus.adsl.tpnet.pl [83.8.239.104])
        by mx.google.com with ESMTPS id 7sm1977058eyg.59.2009.07.10.15.01.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 15:01:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200907102354.43232.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123088>

Luben Tuikov changed 'lineno' link (line number link) from pointing to
'blame' view at given line at blamed commit, to the one at parent of
blamed commit in
  244a70e (Blame "linenr" link jumps to previous state at
           "orig_lineno", 2007-01-04).
This made it possible to do data mining using 'blame' view, by going
through history of a line using mentioned line number link.

Original implementation called "git rev-parse <commit>^" to find SHA-1
of a parent of a given commit once per each blamed line.  In
  39c19ce (gitweb: cache $parent_commit info in git_blame(),
           2008-12-11)
this was improved so rev-parse was called once per each unique commit
in git-blame output.  Alternate solution would be to relax validation
for 'hb' parameter by allowing extended SHA-1 syntax of the form
<rev>^ (perhaps redirecting to gitweb URL with <rev>^ resolved, in
practice moving call to rev-parse to 'the other side of link').

This solution had a bug that it didn't work for boundary commits,
which did not have parents, so "git rev-parse <commit>^" returned
literal "<commit>^" (which didn't exists), which gitweb passed
as 'hb' parameter in 'linenr' link... following which gave
  400 - Invalid hash base parameter
error.  This bug could have been fixed by checking if commit is
boundary commit, or check if rev-parse result is unchanged (still
ends in '^' prefix).

The solution employing rev-parse to find parent of commit had inherent
problem if blamed commit renamed file; then name of file would be
different in its parent.  Solving this outside git-blame would be
difficult and costly (at least cost of additional fork for extra git
command).


Currently gitweb uses information in "previous" header, which was
introduced by Junio C Hamano in
  96e1170 (blame: show "previous" information in
           --porcelain/--incremental format, 2008-06-04)
This (currently undocumented) header has the following format:
  "previous <sha1 of parent commit> <filename at parent>"
Using "previous" header solves both problem of performance and the
problem that blamed commit could have renaming blamed file.

Because "previous" header can be repeated for the same commit when
blamed commit is merge (has more than one parent), and we are
interested usually in _first_ parent, currently we store only first
value if blame header repeats.  Using first parent (first "previous"
line) was what gitweb did before; without this change gitweb would use
last parent instead.

While at it introduce helper subroutine unquote_maybe(), which
unquotes filename if it is needed, which is marked by filename being
surrounded in doublequotes (which are not part of name, and which are
stripped by unquote_maybe() - which makes this function idempotent).
Currently unquote_maybe() us used only in git_blame.

If there is no previous commit 'linenr' link points to blamed commit
and blamed filename, making it work correctly for boundary commits.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

IMHO more important is that result is MORE CORRECT, not the better
performance.

In the table below you can see simple benchmark comparing gitweb
performance before and after this patch.  Operating system used was
Linux 2.6.14, on 1 GHz AMD Athlon processor (2002.43 BogoMIPS).
As there is one "git rev-parse <rev>^" per each individual commit
in blame output, it would be much worse 'before' for operating
systems with costly fork.

File                  |  C[1] || Time0[2] | Before[3] | After[3]
=================================================================
revision.c            |   121 ||   2.820s |    5.548s |   5.172s
gitweb/gitweb.perl[4] |   428 ||  11.749s |   19.797s |  17.293s

Table footnotes:
~~~~~~~~~~~~~~~~
[1] Individual commits in blame output:
    $ git blame -p <file> | grep author-time | wc -l
[2] Time for running "git blame -p" (user time, single run):
    $ time git blame -p <file> >/dev/null
[3] Time to run gitweb as Perl script from command line:
    $ time gitweb-run.sh "p=.git;a=blame;f=<file>" >/dev/null 2>&1
[4] Starting at 'origin', which is v1.6.3.3-412-gf581de1
    > git blame -p origin -- gitweb/gitweb.perl
    > "p=.git;a=blame;hb=origin;f=gitweb/gitweb.perl"


For comparison there is similar table for my 39c19ce (gitweb: cache
$parent_commit info in git_blame(), 2008-12-11):

File               | L[1] | C[2] || Time0[3] | Before[4] | After[4]
====================================================================
blob.h             |   18 |    4 || 0m1.727s |  0m2.545s |  0m2.474s
GIT-VERSION-GEN    |   42 |   13 || 0m2.165s |  0m2.448s |  0m2.071s
README             |   46 |    6 || 0m1.593s |  0m2.727s |  0m2.242s
revision.c         | 1923 |  121 || 0m2.357s | 0m30.365s |  0m7.028s
gitweb/gitweb.perl | 6291 |  428 || 0m8.080s | 1m37.244s | 0m20.627s

File               | L/C  | Before/After
=========================================
blob.h             |  4.5 |         1.03
GIT-VERSION-GEN    |  3.2 |         1.18
README             |  7.7 |         1.22
revision.c         | 15.9 |         4.32
gitweb/gitweb.perl | 14.7 |         4.71

As you can see the greater ratio of lines in file to unique commits
in blame output, the greater gain from the new implementation.

  Legend:

  [1] Number of lines:
      $ wc -l <file>
  [2] Number of unique commits in the blame output:
      $ git blame -p <file> | grep author-time | wc -l
  [3] Time for running "git blame -p" (user time, single run):
      $ time git blame -p <file> >/dev/null
  [4] Time to run gitweb as Perl script from command line:
      $ gitweb-run.sh "p=.git;a=blame;f=<file>" > /dev/null 2>&1


 gitweb/gitweb.perl |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fe73c2c..36b1ce5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1187,6 +1187,16 @@ sub unquote {
 	return $str;
 }
 
+# if filename is surrounded in double quotes, it need to be unquoted
+sub unquote_maybe {
+	my $str = shift;
+
+	if ($str =~ /^"(.*)"$/) {
+		return unquote($1);
+	}
+	return $str;
+}
+
 # escape tabs (convert tabs to spaces)
 sub untabify {
 	my $line = shift;
@@ -4827,7 +4837,7 @@ HTML
 			chomp $data;
 			last if ($data =~ s/^\t//); # contents of line
 			if ($data =~ /^(\S+)(?: (.*))?$/) {
-				$meta->{$1} = $2;
+				$meta->{$1} = $2 unless exists $meta->{$1};
 			}
 		}
 		my $short_rev = substr($full_rev, 0, 8);
@@ -4852,20 +4862,21 @@ HTML
 			              esc_html($short_rev));
 			print "</td>\n";
 		}
-		my $parent_commit;
-		if (!exists $meta->{'parent'}) {
-			open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
-				or die_error(500, "Open git-rev-parse failed");
-			$parent_commit = <$dd>;
-			close $dd;
-			chomp($parent_commit);
-			$meta->{'parent'} = $parent_commit;
-		} else {
-			$parent_commit = $meta->{'parent'};
-		}
+		# 'previous' <sha1 of parent commit> <filename at commit>
+		if (exists $meta->{'previous'} &&
+		    $meta->{'previous'} =~ /^([a-fA-F0-9]{40}) (.*)$/) {
+			$meta->{'parent'} = $1;
+			$meta->{'file_parent'} = unquote_maybe($2);
+		}
+		my $linenr_commit =
+			exists($meta->{'parent'}) ?
+			$meta->{'parent'} : $full_rev;
+		my $linenr_filename =
+			exists($meta->{'file_parent'}) ?
+			$meta->{'file_parent'} : unquote_maybe($meta->{'filename'});
 		my $blamed = href(action => 'blame',
-		                  file_name => $meta->{'filename'},
-		                  hash_base => $parent_commit);
+		                  file_name => $linenr_filename,
+		                  hash_base => $linenr_commit);
 		print "<td class=\"linenr\">";
 		print $cgi->a({ -href => "$blamed#l$orig_lineno",
 		                -class => "linenr" },
-- 
1.6.3.3
