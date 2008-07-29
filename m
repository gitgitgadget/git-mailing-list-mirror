From: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
Subject: [PATCH 1/2] gitweb: sort projects by path.
Date: Mon, 28 Jul 2008 23:34:27 -0300
Message-ID: <1217298868-16513-2-git-send-email-barbieri@profusion.mobi>
References: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
Cc: gitster@pobox.com,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 04:35:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNf3t-0004by-6f
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 04:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYG2Cen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 22:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbYG2Cen
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 22:34:43 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:52360 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbYG2Cem (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 22:34:42 -0400
Received: by qw-out-2122.google.com with SMTP id 3so394563qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 19:34:42 -0700 (PDT)
Received: by 10.214.79.7 with SMTP id c7mr1059076qab.89.1217298882419;
        Mon, 28 Jul 2008 19:34:42 -0700 (PDT)
Received: from solid.profusion.mobi ( [201.82.39.16])
        by mx.google.com with ESMTPS id 6sm12944261ywp.3.2008.07.28.19.34.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 19:34:41 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.2
In-Reply-To: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90552>

Projects are paths, so they should be sorted in pieces, not as a
whole, so a/x will be come before a-b/x.

Signed-off-by: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
---
 gitweb/gitweb.perl |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..c5675cf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3574,17 +3574,40 @@ sub fill_project_list_info {
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
+		if ($la[$i] gt $lb[$i]) {
+			return 1;
+		}
+	}
+
+	return $#la <=> $#lb;
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
@@ -3596,6 +3619,10 @@ sub print_sort_th {
 	}
 }
 
+sub print_sort_th_path {
+	print_sort_th(2, @_);
+}
+
 sub print_sort_th_str {
 	print_sort_th(1, @_);
 }
@@ -3620,8 +3647,8 @@ sub git_project_list_body {
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
