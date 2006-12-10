X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Show target of symbolic link in "tree" view
Date: Sun, 10 Dec 2006 13:25:46 +0100
Message-ID: <11657535944050-git-send-email-jnareb@gmail.com>
References: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Sun, 10 Dec 2006 12:24:42 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eCqn1uo+QuYzIr13Y412TJSjG/mxK54ZU936XF14JEkMmYloe5yk8cBecaHCv6box7D7ln5tV45BBZycW4Vel6mfwsSS6v3ykxF+YlOS76HkxU0Xhp0gEb03PMJXRuw4WyMJRIzq0CpJNeLRm3dlHl5iEUPMxKQRDrKwPsTnhQ0=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33881>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtNjV-0001o5-5a for gcvg-git@gmane.org; Sun, 10 Dec
 2006 13:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758430AbWLJMYi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 07:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758792AbWLJMYi
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 07:24:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:22549 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758430AbWLJMYh (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 07:24:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1088384uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 04:24:36 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr1935720ugm.1165753476500; Sun, 10
 Dec 2006 04:24:36 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 20sm4384353uga.2006.12.10.04.24.36; Sun, 10 Dec 2006 04:24:36 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBACQfq4025881; Sun, 10 Dec 2006 13:26:42 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBACQY6v025880; Sun, 10 Dec 2006 13:26:34 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

In "tree" view (git_print_tree_entry subroutine), for entries which are
symbolic links, add " -> link_target" after file name (a la "ls -l").

Link target is _not_ hyperlinked.

While at it, correct whitespaces (tabs are for aling, spaces are for indent)
in modified git_print_tree_entry subroutine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski wrote:
> I'll split the patch into two: first to read link target and show it in 
> "tree" view _without_ hyperlink, and later perhaps either your or mine 
> solution (most probably yours), depending on feedback.

That implements the first part.

 gitweb/gitweb.perl |   42 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5ea3fda..0c2cfc7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1989,12 +1989,31 @@ sub git_print_log ($;%) {
 	}
 }
 
+# return link target (what link points to)
+sub git_get_link_target {
+	my $hash = shift;
+	my $link_target;
+
+	# read link
+	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
+		or return;
+	{
+		local $/;
+		$link_target = <$fd>;
+	}
+	close $fd
+		or return;
+
+	return $link_target;
+}
+
+
 # print tree entry (row of git_tree), but without encompassing <tr> element
 sub git_print_tree_entry {
 	my ($t, $basedir, $hash_base, $have_blame) = @_;
 
 	my %base_key = ();
-	$base_key{hash_base} = $hash_base if defined $hash_base;
+	$base_key{'hash_base'} = $hash_base if defined $hash_base;
 
 	# The format of a table row is: mode list link.  Where mode is
 	# the mode of the entry, list is the name of the entry, an href,
@@ -2005,16 +2024,23 @@ sub git_print_tree_entry {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
 			                       file_name=>"$basedir$t->{'name'}", %base_key),
-			        -class => "list"}, esc_path($t->{'name'})) . "</td>\n";
+			        -class => "list"}, esc_path($t->{'name'}));
+		if (S_ISLNK(oct $t->{'mode'})) {
+			my $link_target = git_get_link_target($t->{'hash'});
+			if ($link_target) {
+				print " -> " . esc_path($link_target);
+			}
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
@@ -2036,8 +2062,8 @@ sub git_print_tree_entry {
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
