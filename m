X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebsmi <jnareb@gmail.com>
Subject: [PATCH] gitweb: Better symbolic link support in "tree" view
Date: Mon,  4 Dec 2006 19:26:20 +0100
Message-ID: <1165256780505-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Mon, 4 Dec 2006 18:25:21 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=ZplgN6fHlfwYVLJbbqJmzRQmniRL9aC1p7THER0TeNvJsa3gTDdT0j56zL9ZTPBcQ7trS7fj0oXtb6XKC6OFyDBJAmDweYbijy/kQi2U6fHYLf9QL5BRf5BpKlJNAxRgP2JjTEvE732IpA/B5FidXkL1TqDkzxNSNMh3B/RKyoU=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33214>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrIV7-0004A8-No for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937230AbWLDSZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 13:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937229AbWLDSZJ
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:25:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:32406 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937235AbWLDSZG (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 13:25:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3080987uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 10:25:04 -0800 (PST)
Received: by 10.67.22.7 with SMTP id z7mr12484198ugi.1165256704043; Mon, 04
 Dec 2006 10:25:04 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 j2sm4039294ugf.2006.12.04.10.25.03; Mon, 04 Dec 2006 10:25:03 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kB4IQgmM020373; Mon, 4 Dec 2006 19:26:44 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kB4IQKX3020352; Mon, 4 Dec 2006 19:26:20 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From: Jakub Narebski <jnareb@gmail.com>

In "tree" view (git_print_tree_entry subroutine), add for symbolic
links after file name " -> link_target", a la "ls -l".  Use
git_get_link_target_html to escape target name and make it into
hyperlink if possible.

Target of link is made into hyperlink when:
 * hash_base is provided (otherwise we cannot find hash of link
   target)
 * link is relative
 * in no place link goes out of root tree (top dir)
 * target of link exists for hash_base

Full path of symlink target from the root dir is provided in the title
attribute of hyperlink. If symlink target is a directory, '/' is added
to end of path in title attribute.

Currently symbolic link name uses ordinary file style (hidden
hyperlink), while the hyperlink to symlink target uses default
hyperlink style.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   91 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ffe8ce1..3c1b75d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1989,12 +1989,83 @@ sub git_print_log ($;%) {
 	}
 }
 
+# print link tree entry (name of what link points to, possibly hyperlink)
+sub git_get_link_target_html {
+	my ($t, $basedir, $hash_base) = @_;
+
+	my $fd;
+	my %target = ();
+
+	# read link
+	open $fd, "-|", git_cmd(), "cat-file", "blob", $t->{'hash'};
+	{
+		local $/;
+		$target{'orig'} = <$fd>;
+	}
+	close $fd;
+
+	# we can make hyperlink out of link target only if $hash_base is provided
+	return esc_path($target{'orig'})
+		unless $hash_base;
+
+	# absolute links are returned as is, no hyperlink
+	if (substr($target{'orig'}, 0, 1) eq '/') {
+		return esc_path($target{'orig'});
+	}
+
+	# normalize link target to path from top (root) tree (dir)
+	if ($basedir) {
+		$target{'path'} = $basedir . '/' . $target{'orig'};
+	} else {
+		# we are in top (root) tree (dir)
+		$target{'path'} = $target{'orig'};
+	}
+	$target{'parts'} = [ ];
+	foreach my $part (split('/', $target{'path'})) {
+		# discard '.' and ''
+		next if (!$part || $part eq '.');
+		# handle '..'
+		if ($part eq '..') {
+			if (@{$target{'parts'}}) {
+				pop @{$target{'parts'}};
+			} else {
+				# link leads outside repository
+				return esc_path($target{'orig'});
+			}
+		} else {
+			push @{$target{'parts'}}, $part;
+		}
+	}
+	$target{'path'} = join('/', @{$target{'parts'}});
+
+	# check if path exists
+	open $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $target{'path'}
+		or return esc_path($target{'orig'});
+	my $line = <$fd>;
+	close $fd
+		or return esc_path($target{'orig'});
+	return esc_path($target{'orig'}) unless $line;
+
+	# parse ls-tree line to get type and hash of target of link
+	(undef, $target{'type'}, $target{'hash'}) =
+		($line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/);
+
+	# make a link if path exists
+	return $cgi->a({-href => href(action    => $target{'type'},
+	                              hash      => $target{'hash'},
+	                              file_name => $target{'path'},
+	                              hash_base => $hash_base),
+	                -title => $target{'path'} .
+	                          ($target{'type'} eq "tree" ? '/' : '')},
+	               esc_path($target{'orig'}));
+}
+
 # print tree entry (row of git_tree), but without encompassing <tr> element
 sub git_print_tree_entry {
 	my ($t, $basedir, $hash_base, $have_blame) = @_;
 
 	my %base_key = ();
-	$base_key{hash_base} = $hash_base if defined $hash_base;
+	$base_key{'hash_base'} = $hash_base if defined $hash_base;
 
 	# The format of a table row is: mode list link.  Where mode is
 	# the mode of the entry, list is the name of the entry, an href,
@@ -2005,16 +2076,20 @@ sub git_print_tree_entry {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
 			                       file_name=>"$basedir$t->{'name'}", %base_key),
-			        -class => "list"}, esc_path($t->{'name'})) . "</td>\n";
+			        -class => "list"}, esc_path($t->{'name'}));
+		if (S_ISLNK(oct $t->{'mode'})) {
+			print " -> " . git_get_link_target_html($t, $basedir, $hash_base);
+		}
+		print "</td>\n";
 		print "<td class=\"link\">";
 		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
-					     file_name=>"$basedir$t->{'name'}", %base_key)},
-			      "blob");
+		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		              "blob");
 		if ($have_blame) {
 			print " | " .
 			      $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
-				                           file_name=>"$basedir$t->{'name'}", %base_key)},
-				            "blame");
+			                             file_name=>"$basedir$t->{'name'}", %base_key)},
+			              "blame");
 		}
 		if (defined $hash_base) {
 			print " | " .
@@ -2036,8 +2111,8 @@ sub git_print_tree_entry {
 		print "</td>\n";
 		print "<td class=\"link\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
-					     file_name=>"$basedir$t->{'name'}", %base_key)},
-			      "tree");
+		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		              "tree");
 		if (defined $hash_base) {
 			print " | " .
 			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
-- 
1.4.4.1
