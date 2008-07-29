From: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
Subject: [PATCH 1/2 v2] gitweb: sort projects by path.
Date: Tue, 29 Jul 2008 00:59:02 -0300
Message-ID: <1217303942-18526-1-git-send-email-barbieri@profusion.mobi>
References: <1217298868-16513-2-git-send-email-barbieri@profusion.mobi>
Cc: gitster@pobox.com,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 06:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNgNp-0005Eh-GR
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 06:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbYG2D7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 23:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbYG2D7U
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 23:59:20 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:10163 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbYG2D7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 23:59:19 -0400
Received: by qw-out-2122.google.com with SMTP id 3so409439qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 20:59:18 -0700 (PDT)
Received: by 10.214.184.3 with SMTP id h3mr1192084qaf.50.1217303953795;
        Mon, 28 Jul 2008 20:59:13 -0700 (PDT)
Received: from solid.profusion.mobi ( [201.82.39.16])
        by mx.google.com with ESMTPS id 5sm9944926ywl.4.2008.07.28.20.59.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 20:59:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.2
In-Reply-To: <1217298868-16513-2-git-send-email-barbieri@profusion.mobi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90560>

Projects are paths, so they should be sorted in pieces, not as a
whole, so a/x will be come before a-b/x.

Signed-off-by: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
---

New version that fix cmp_paths. Unlike I though initially, $#list
reports the last element index, not the list length. Nonetheless the
last component must be compared only if the list lengths are the same,
otherwise we'll get $root/a/a.git before $root/b.git and sections will
look ugly (group elements of the same level together).


 gitweb/gitweb.perl |   42 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..06c9901 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3574,17 +3574,45 @@ sub fill_project_list_info {
 	return @projects;
 }
 
+sub cmp_paths {
+	my ($a, $b) = @_;
+	my @la = split('/', $a);
+	my @lb = split('/', $b);
+	my $last;
+
+	if ($#la < $#lb) {
+		$last = $#la;
+	} else {
+		$last = $#lb;
+	}
+
+	for (my $i = 0; $i < $last; $i++) {
+		my $r = $la[$i] cmp $lb[$i];
+		if ($r != 0) {
+			return $r;
+		}
+	}
+
+	if ($#la == $#lb) {
+		return $la[$last] cmp $lb[$last];
+	} else {
+		return $#la <=> $#lb;
+	}
+}
+
 # print 'sort by' <th> element, either sorting by $key if $name eq $order
 # (changing $list), or generating 'sort by $name' replay link otherwise
 sub print_sort_th {
-	my ($str_sort, $name, $order, $key, $header, $list) = @_;
+	my ($sort_mode, $name, $order, $key, $header, $list) = @_;
 	$key    ||= $name;
 	$header ||= ucfirst($name);
 
 	if ($order eq $name) {
-		if ($str_sort) {
+		if ($sort_mode == 2) {
+			@$list = sort {cmp_paths($a->{$key}, $b->{$key})} @$list;
+		} elsif ($sort_mode == 1) {
 			@$list = sort {$a->{$key} cmp $b->{$key}} @$list;
-		} else {
+		} elsif ($sort_mode == 0) {
 			@$list = sort {$a->{$key} <=> $b->{$key}} @$list;
 		}
 		print "<th>$header</th>\n";
@@ -3596,6 +3624,10 @@ sub print_sort_th {
 	}
 }
 
+sub print_sort_th_path {
+	print_sort_th(2, @_);
+}
+
 sub print_sort_th_str {
 	print_sort_th(1, @_);
 }
@@ -3620,8 +3652,8 @@ sub git_project_list_body {
 		if ($check_forks) {
 			print "<th></th>\n";
 		}
-		print_sort_th_str('project', $order, 'path',
-		                  'Project', \@projects);
+		print_sort_th_path('project', $order, 'path',
+		                   'Project', \@projects);
 		print_sort_th_str('descr', $order, 'descr_long',
 		                  'Description', \@projects);
 		print_sort_th_str('owner', $order, 'owner',
-- 
1.5.5.2
