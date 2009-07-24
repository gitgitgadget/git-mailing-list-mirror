From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 03/10] gitweb: Use "previous" header of git-blame -p in 'blame' view
Date: Sat, 25 Jul 2009 00:44:03 +0200
Message-ID: <1248475450-5668-4-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTTP-00070k-91
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbZGXWmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754885AbZGXWmg
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:42:36 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:39081 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbZGXWmf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:42:35 -0400
Received: by bwz28 with SMTP id 28so1676695bwz.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SSELi1VS3WzVPxdDCKFzbd9Q+Jvo21NWindVL1gM0Qs=;
        b=O9Z7t6Y31kpBPQthLjKbtpdjt47JmL0lIi4pz4q3MD57O99F5b7+H9lamlCLgPJTI6
         MBjGUuUnLJVHIaIbN0IkheRDVrhYyluqnocAiJTDEX4f0sPBnM22k9QZ8flSjbL2HH2x
         M6XcpEEb4lmvq7UsoG/vYWttVQAbbNGVm5EHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C3B2rBWKHLdKOiqL+LO55+jBnaJs68VASfxC7Qu15HUaFN/V9huFJztfcjLPxAto5g
         +OcqxuVkW5VNFrXJaJ52F92S0ppLABJFlhzGK4qxEn3uhzBfzWIZzXIPuRw+VjQ7W/yI
         DNPQiZm7OJ6A73jwr/4rBJ+yG1HcNaM+/eF+0=
Received: by 10.204.118.69 with SMTP id u5mr240546bkq.77.1248475354242;
        Fri, 24 Jul 2009 15:42:34 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id k29sm5978048fkk.26.2009.07.24.15.42.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:42:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMm45w005753;
	Sat, 25 Jul 2009 00:48:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMlXw3005747;
	Sat, 25 Jul 2009 00:47:33 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123961>

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

This solution had a bug that it didn't work for boundary commits.
Boundary commits don't have parents, so "git rev-parse <commit>^"
returned literal "<commit>^" (which didn't exists).  Gitweb didn't
detect this situation and passed this result literally as 'hb'
parameter in 'linenr' link.  Following such link currently gives
  400 - Invalid hash base parameter
error; 'hb' parameter is restricted via validate_refname to correct
refnames and doesn't allow for extended SHA-1 syntax.  This bug could
have been fixed alternatively by checking if commit is boundary commit,
or check if rev-parse result is unchanged (still ends in '^' prefix).

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

If there is no previous commit 'linenr' link points to blamed commit
and blamed filename, making it work correctly for boundary commits.

Acked-by: Luben Tuikov <ltuikov@yahoo.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Note that it does not change "sha1" link from 'commit' to 'commitdiff'
view, as requested by Junio C Hamano.  This is left for later,
separate commit.

New in v2:
 * we don't use totally unnecessary newly introduced unquote_maybe(),
   as unquote == unquote_maybe (unquotes only when necessary).
 * Added ACK from Luben Tuikov (author of 'data mining' behaviour)
   http://article.gmane.org/gmane.comp.version-control.git/123154

BTW. I think as a side effect this patch makes code a bit cleaner.

 gitweb/gitweb.perl |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3078b92..b8a121b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4827,7 +4827,7 @@ HTML
 			chomp $data;
 			last if ($data =~ s/^\t//); # contents of line
 			if ($data =~ /^(\S+)(?: (.*))?$/) {
-				$meta->{$1} = $2;
+				$meta->{$1} = $2 unless exists $meta->{$1};
 			}
 		}
 		my $short_rev = substr($full_rev, 0, 8);
@@ -4852,20 +4852,21 @@ HTML
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
+			$meta->{'file_parent'} = unquote($2);
+		}
+		my $linenr_commit =
+			exists($meta->{'parent'}) ?
+			$meta->{'parent'} : $full_rev;
+		my $linenr_filename =
+			exists($meta->{'file_parent'}) ?
+			$meta->{'file_parent'} : unquote($meta->{'filename'});
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
