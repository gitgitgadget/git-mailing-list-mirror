From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: extend blame to show links to diff and previous
Date: Tue, 26 Sep 2006 16:45:31 -0700 (PDT)
Message-ID: <20060926234531.26684.qmail@web31803.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-764622995-1159314331=:26157"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Sep 27 01:45:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSMcR-0004lp-VY
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 01:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWIZXpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 19:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWIZXpd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 19:45:33 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:44626 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932508AbWIZXpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 19:45:32 -0400
Received: (qmail 26686 invoked by uid 60001); 26 Sep 2006 23:45:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KvXZQbNYTY3LHfE0cLXlD2SaRNqlvEdkyPYBikUE3vtsKIrc7ziMwfrwD4hb4kZJ8vTixdVmIPUpEDeT2phGqx56zc5f++CxGv2MebWMbqXYF0tTQtytIvg1eY58GT/Ke77eb7Zmqj507GFThpY2taTP/FJuI0ZxwpcsbsT3tl4=  ;
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 16:45:31 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27839>

--0-764622995-1159314331=:26157
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

git_blame2() now has two more columns, "Prev" and "Diff",
before the "Commit" column, as follows:

Prev	Diff	Commit	Line	Data
SHA     Diff    SHA        N    ...
...

The "Prev" column shows the SHA of the parent commit,
between which this line changed.  Clicking on it shows the
blame of the file as of the parent commit, for that line.

So clicking repeatedly on "Prev" would show you the blame
of that file, from the point of view of the changes
of that particular line whose "Prev" you're clicking on.

The "Diff" column shows "Diff" which is a link to blobdiff
between "Prev" and "Commit" commits _for that line_.

So clicking on "Diff" would show you the blobdiff (HTML)
between the parent commit and this commit which changed
that particular line.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

--0-764622995-1159314331=:26157
Content-Type: text/plain; name="blame.txt"
Content-Description: 1027985432-blame.txt
Content-Disposition: inline; filename="blame.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 56638f2..d2519f0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2439,7 +2439,7 @@ sub git_blame2 {
 	print <<HTML;
 <div class="page_body">
 <table class="blame">
-<tr><th>Commit</th><th>Line</th><th>Data</th></tr>
+<tr><th>Prev</th><th>Diff</th><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
 	while (<$fd>) {
 		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
@@ -2447,6 +2447,8 @@ HTML
 		my $rev = substr($full_rev, 0, 8);
 		my $lineno = $2;
 		my $data = $3;
+		my %pco = parse_commit($full_rev);
+		my $parent = $pco{'parent'};
 
 		if (!defined $last_rev) {
 			$last_rev = $full_rev;
@@ -2455,11 +2457,25 @@ HTML
 			$current_color = ++$current_color % $num_colors;
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
+		# Print the Prev link
+		print "<td class=\"sha1\">";
+		print $cgi->a({-href => href(action=>"blame", hash_base=>$parent, file_name=>$file_name)},
+			      esc_html(substr($parent, 0, 8)));
+		print "</td>\n";
+		# Print the Diff (blobdiff) link
+		print "<td>";
+		print $cgi->a({-href => href(action=>"blobdiff", file_name=>$file_name, hash_parent_base=>$parent,
+					     hash_base=>$full_rev)},
+			      esc_html("Diff"));
+		print "</td>\n";
+		# Print the Commit link
 		print "<td class=\"sha1\">" .
 			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
 			        esc_html($rev)) . "</td>\n";
+		# Print the Line number
 		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
 		      esc_html($lineno) . "</a></td>\n";
+		# Print the Data
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
 		print "</tr>\n";
 	}
-- 
1.4.2.1.g03d06

--0-764622995-1159314331=:26157--
