X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Add generic git_object subroutine to display object of any type
Date: Sun, 10 Dec 2006 13:25:47 +0100
Message-ID: <11657536121090-git-send-email-jnareb@gmail.com>
References: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Sun, 10 Dec 2006 12:25:07 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DXlYzCM/bEPx6VLmhf9LVzZrJxGxPHdve4/ac9bEoJekTy4d8IrIwQUYZhNm6VolAchma/EYWIeiw9iUIXdHG3Ga6s/p/F27EdI7G9tlF1W3gcos/MnfAo2I9Nw+JBeMld3O+16CPDDY5f9CgC5zGFc1ld6/B/vFAm2CCyC9t3o=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33882>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtNjl-0001rf-Mi for gcvg-git@gmane.org; Sun, 10 Dec
 2006 13:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758807AbWLJMYz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 07:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758847AbWLJMYz
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 07:24:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:22549 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758807AbWLJMYy (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 07:24:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1088384uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 04:24:53 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr1937771ugj.1165753493211; Sun, 10
 Dec 2006 04:24:53 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 29sm4419210uga.2006.12.10.04.24.52; Sun, 10 Dec 2006 04:24:53 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBACR2Ur025888; Sun, 10 Dec 2006 13:27:08 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBACQqXZ025885; Sun, 10 Dec 2006 13:26:52 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add generic "object" view implemented in git_object subroutine, which is
used to display object of any type; to be more exact it redirects to the
view of correct type: "blob", "tree", "commit" or "tag".  To identify object
you have to provide either hash (identifier of an object), or (in the case of
tree and blob objects) hash of commit object (hash_base) and path (file_name).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
First version had checking if $hash and $hash_base are explicit SHA-1
if are defined.  This version doesn't have this check, which is
important for next patch.

 gitweb/gitweb.perl |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0c2cfc7..a988f85 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -434,6 +434,7 @@ my %actions = (
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
 	"snapshot" => \&git_snapshot,
+	"object" => \&git_object,
 	# those below don't need $project
 	"opml" => \&git_opml,
 	"project_list" => \&git_project_list,
@@ -3620,6 +3621,53 @@ sub git_commit {
 	git_footer_html();
 }
 
+sub git_object {
+	# object is defined by:
+	# - hash or hash_base alone
+	# - hash_base and file_name
+	my $type;
+
+	# - hash or hash_base alone
+	if ($hash || ($hash_base && !defined $file_name)) {
+		my $object_id = $hash || $hash_base;
+
+		my $git_command = git_cmd_str();
+		open my $fd, "-|", "$git_command cat-file -t $object_id 2>/dev/null"
+			or die_error('404 Not Found', "Object does not exist");
+		$type = <$fd>;
+		chomp $type;
+		close $fd
+			or die_error('404 Not Found', "Object does not exist");
+
+	# - hash_base and file_name
+	} elsif ($hash_base && defined $file_name) {
+		$file_name =~ s,/+$,,;
+
+		system(git_cmd(), "cat-file", '-e', $hash_base) == 0
+			or die_error('404 Not Found', "Base object does not exist");
+
+		# here errors should not hapen
+		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_name
+			or die_error(undef, "Open git-ls-tree failed");
+		my $line = <$fd>;
+		close $fd;
+
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+		unless ($line && $line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/) {
+			die_error('404 Not Found', "File or directory for given base does not exist");
+		}
+		$type = $2;
+		$hash = $3;
+	} else {
+		die_error('404 Not Found', "Not enough information to find object");
+	}
+
+	print $cgi->redirect(-uri => href(action=>$type, -full=>1,
+	                                  hash=>$hash, hash_base=>$hash_base,
+	                                  file_name=>$file_name),
+	                     -status => '302 Found');
+}
+
 sub git_blobdiff {
 	my $format = shift || 'html';
 
-- 
1.4.4.1
