X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Hyperlink target of symbolic link in "tree" view (if possible)
Date: Sun, 10 Dec 2006 13:25:48 +0100
Message-ID: <11657536303381-git-send-email-jnareb@gmail.com>
References: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Sun, 10 Dec 2006 12:25:18 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=c3TX8edS6YVmwYueIUUDp+MSumIW4Uyk66fKMWV3sMC5NSR8qXglAhAJ9TD61qug1jzol65SnXBQ6yzc3BJ0KYUgXDZJD8Nr8K4gAqcC5u7LuuUiHpH75x3OKWARyh1EmQkDLdkZ8uZ+K5HxbZjYJISOinVZoGb7myYNEnuZzZk=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33883>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtNk4-0001tZ-Gs for gcvg-git@gmane.org; Sun, 10 Dec
 2006 13:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758847AbWLJMZN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 07:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758849AbWLJMZN
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 07:25:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:22549 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758847AbWLJMZL (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 07:25:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1088384uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 04:25:10 -0800 (PST)
Received: by 10.67.106.3 with SMTP id i3mr8209550ugm.1165753510710; Sun, 10
 Dec 2006 04:25:10 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 z40sm4422473ugc.2006.12.10.04.25.10; Sun, 10 Dec 2006 04:25:10 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBACRHFQ025893; Sun, 10 Dec 2006 13:27:18 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBACRArV025891; Sun, 10 Dec 2006 13:27:10 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Make symbolic link target in "tree" view into hyperlink to generic
"object" view (as we don't know if the link target is file (blob) or
directory (tree), and if it exist at all).

Target of link is made into hyperlink when:
 * hash_base is provided (otherwise we cannot find hash
   of link target)
 * link is relative
 * in no place link goes out of root tree (top dir)

Full path of symlink target from the root dir is provided in the title
attribute of hyperlink.

Currently symbolic link name uses ordinary file style (hidden
hyperlink), while the hyperlink to symlink target uses default
hyperlink style, so it is underlined while link target which is not
made into hyperlink is not underlined.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:
> In other words, I think trying to be lazy is extremely important
> while drawing a big list.

This implements "lazy" hyperlinking of symbolic link target in "tree"
view.

 gitweb/gitweb.perl |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a988f85..6493311 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2008,6 +2008,48 @@ sub git_get_link_target {
 	return $link_target;
 }
 
+# given link target, and the directory (basedir) the link is in,
+# return target of link relative to top directory (top tree);
+# return undef if it is not possible (including absolute links).
+sub normalize_link_target {
+	my ($link_target, $basedir, $hash_base) = @_;
+
+	# we can normalize symlink target only if $hash_base is provided
+	return unless $hash_base;
+
+	# absolute symlinks (beginning with '/') cannot be normalized
+	return if (substr($link_target, 0, 1) eq '/');
+
+	# normalize link target to path from top (root) tree (dir)
+	my $path;
+	if ($basedir) {
+		$path = $basedir . '/' . $link_target;
+	} else {
+		# we are in top (root) tree (dir)
+		$path = $link_target;
+	}
+
+	# remove //, /./, and /../
+	my @path_parts;
+	foreach my $part (split('/', $path)) {
+		# discard '.' and ''
+		next if (!$part || $part eq '.');
+		# handle '..'
+		if ($part eq '..') {
+			if (@path_parts) {
+				pop @path_parts;
+			} else {
+				# link leads outside repository (outside top dir)
+				return;
+			}
+		} else {
+			push @path_parts, $part;
+		}
+	}
+	$path = join('/', @path_parts);
+
+	return $path;
+}
 
 # print tree entry (row of git_tree), but without encompassing <tr> element
 sub git_print_tree_entry {
@@ -2029,7 +2071,15 @@ sub git_print_tree_entry {
 		if (S_ISLNK(oct $t->{'mode'})) {
 			my $link_target = git_get_link_target($t->{'hash'});
 			if ($link_target) {
-				print " -> " . esc_path($link_target);
+				my $norm_target = normalize_link_target($link_target, $basedir, $hash_base);
+				if (defined $norm_target) {
+					print " -> " .
+					      $cgi->a({-href => href(action=>"object", hash_base=>$hash_base,
+					                             file_name=>$norm_target),
+					               -title => $norm_target}, esc_path($link_target));
+				} else {
+					print " -> " . esc_path($link_target);
+				}
 			}
 		}
 		print "</td>\n";
-- 
1.4.4.1
