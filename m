From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] [gitweb] Blame "linenr" link jumps to previous state at "orig_lineno"
Date: Thu, 4 Jan 2007 18:37:45 -0800 (PST)
Message-ID: <605150.6351.qm@web31807.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jan 05 03:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2exr-00008i-TK
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 03:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbXAEChr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 21:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbXAEChr
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 21:37:47 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:32438 "HELO
	web31807.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030282AbXAEChq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jan 2007 21:37:46 -0500
Received: (qmail 6384 invoked by uid 60001); 5 Jan 2007 02:37:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=DjCNruuvZ2NLOSN+wLfftalWtJlQhpKAv/PKKuGxzQbwwAfbvaJaRpCvykXk6YWU8UUxPESTkdraiku2PcawNIWOn4dYnPYQg89rvj7aWV6EV8RgFZ7+L8RGlLbEmQpT1ZxjVzls4HfFhh9cWR9h+6yGSmitb136W1owk2JjlKY=;
X-YMail-OSG: eT0OLAAVM1mH391uh1DXGFIvmNf9owaM5GkXTkcQmEkt_oLIwHeGyPLENjGexg.tltMC1xz7142iY2GF3_wWcbXnjT_eRy_a8.KLF8jFo5KTCYFdqGvRiVHE.lV_i8vXGyIY06dtNksWfDBHBDl6QhjTy87qxoZV8Q--
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Thu, 04 Jan 2007 18:37:45 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35970>

Blame currently displays the commit id which introduced a
block of one or more lines, the line numbers wrt the current
listing of the file and the file's line contents.

The commit id displayed is hyperlinked to the commit.

Currently the linenr links are hyperlinked to the same
commit id displayed to the left, which is _no_ different
than the block of lines displayed, since it is the _same
commit_ that is hyperlinked.  And thus clicking on it leads
to the same state of the file for that chunk of
lines. I.e. data mining is not currently possible with
gitweb given a chunk of lines introduced by a commit.

This patch makes such data mining possible.

The line numbers are now hyperlinked to the parent of the
commit id of the block of lines.  Furthermore they are
linked to the line where that block was introduced.

Thus clicking on a linenr link will show you the file's
line(s) state prior to the commit id you were viewing.

So clicking continually on a linenr link shows you how this
line and its line number changed over time, leading to the
initial commit where it was first introduced.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

A quick show-and-tell of this patch is after applying it, open
"blame" on a file, click on a linenr link of a block which
has only a single line changed -- the diff between what
you're seeing now and before is at least that line.  This you can
data-mine with gitweb back to where the line was introduced.  Similar
argument applies to blocks of more than one line.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ac602ae..c87c61d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3208,9 +3208,14 @@ HTML
 				      esc_html($rev));
 			print "</td>\n";
 		}
+		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
+			or die_error("could not open git-rev-parse");
+		my $parent_commit = <$dd>;
+		close $dd;
+		chomp($parent_commit);
 		my $blamed = href(action => 'blame',
 				  file_name => $meta->{'filename'},
-				  hash_base => $full_rev);
+				  hash_base => $parent_commit);
 		print "<td class=\"linenr\">";
 		print $cgi->a({ -href => "$blamed#l$orig_lineno",
 				-id => "l$lineno",
-- 
1.5.0.rc0.g90e5
