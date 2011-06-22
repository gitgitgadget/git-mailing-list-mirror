From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Make git_search_* subroutines render whole pages
Date: Wed, 22 Jun 2011 17:28:55 +0200
Message-ID: <1308756535-29701-6-git-send-email-jnareb@gmail.com>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 17:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZPNz-0002tj-NK
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 17:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412Ab1FVPa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 11:30:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357Ab1FVPaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 11:30:25 -0400
Received: by fxm17 with SMTP id 17so714628fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=kUSUHselc1DDVH3pUZU+goTW+KIKsmDzJYMd7GlmO8Y=;
        b=DW6fnFzGhTx9fhtOQn6VVP74FwE4PPRxd7v+Z/5cSphCDGoi3yOT2tmEF/YgEOAlxv
         NMfacS94UQ4pxVy4n6SYK8OBL2I56LDCIp8hSmwqvzdO3v2SSzlUhevr5EULK1l3t9tG
         pi3DoIqtw/TOUIDAa6eeSaH6AQADfp68wfLOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D0JcksLXvt0XNCURVrFcoD0/cOetMf0j42v4F5EJjtI0LlMrrbhd2HWOla2UkuN1x4
         Lt1/kPBzFuLBQemH1edHVpBT+X0hDXbGQbn0WCdEVaLFn8x2Z5BJD9z+iMJR5TOLUozu
         RfpXXqeNLeZnQQwppC9jh3j0cUCr5epBw9f3k=
Received: by 10.223.98.5 with SMTP id o5mr1036673fan.33.1308756571391;
        Wed, 22 Jun 2011 08:29:31 -0700 (PDT)
Received: from localhost.localdomain (abuz77.neoplus.adsl.tpnet.pl [83.8.197.77])
        by mx.google.com with ESMTPS id l26sm400935fah.14.2011.06.22.08.29.29
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 08:29:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176246>

This means moving git_header_html() and git_footer_html() invocation
from git_search() to individual git_search_* subroutines.

While at it reorganize search-related code a bit, moving invoking of
git commands before any output is generated.


This has the following advantages:

* gitweb now shows an error page if there was unknown search type
  (evaluate_and_validate_params checks only that it looks sanely);
  remember that we shouldn't call die_error after any output.

* git_search_message is now safe agains die_error in parse_commits
  (though this is very unlikely).

* gitweb now can check errors while invoking git commands and show
  error page (again, quite unlikely).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1c06476..f8df027 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5577,6 +5577,8 @@ sub git_search_message {
 		$paging_nav .= " &sdot; next";
 	}
 
+	git_header_html();
+
 	git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash);
 	if ($page == 0 && !@commitlist) {
@@ -5584,20 +5586,26 @@ sub git_search_message {
 	} else {
 		git_search_grep_body(\@commitlist, 0, 99, $next_link);
 	}
+
+	git_footer_html();
 }
 
 sub git_search_changes {
 	my %co = @_;
 
+	local $/ = "\n";
+	open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
+		'--pretty=format:%H', '--no-abbrev', '--raw', "-S$searchtext",
+		($search_use_regexp ? '--pickaxe-regex' : ())
+			or die_error(500, "Open git-log failed");
+
+	git_header_html();
+
 	git_print_page_nav('','', $hash,$co{'tree'},$hash);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
 	print "<table class=\"pickaxe search\">\n";
 	my $alternate = 1;
-	local $/ = "\n";
-	open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
-		'--pretty=format:%H', '--no-abbrev', '--raw', "-S$searchtext",
-		($search_use_regexp ? '--pickaxe-regex' : ());
 	undef %co;
 	my @files;
 	while (my $line = <$fd>) {
@@ -5661,21 +5669,27 @@ sub git_search_changes {
 	}
 
 	print "</table>\n";
+
+	git_footer_html();
 }
 
 sub git_search_files {
 	my %co = @_;
 
+	local $/ = "\n";
+	open my $fd, "-|", git_cmd(), 'grep', '-n',
+		$search_use_regexp ? ('-E', '-i') : '-F',
+		$searchtext, $co{'tree'}
+			or die_error(500, "Open git-grep failed");
+
+	git_header_html();
+
 	git_print_page_nav('','', $hash,$co{'tree'},$hash);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
 	print "<table class=\"grep_search\">\n";
 	my $alternate = 1;
 	my $matches = 0;
-	local $/ = "\n";
-	open my $fd, "-|", git_cmd(), 'grep', '-n',
-		$search_use_regexp ? ('-E', '-i') : '-F',
-		$searchtext, $co{'tree'};
 	my $lastfile = '';
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -5732,6 +5746,8 @@ sub git_search_files {
 	close $fd;
 
 	print "</table>\n";
+
+	git_footer_html();
 }
 
 sub git_search_grep_body {
@@ -7319,8 +7335,6 @@ sub git_search {
 		$page = 0;
 	}
 
-	git_header_html();
-
 	if ($searchtype eq 'commit' ||
 	    $searchtype eq 'author' ||
 	    $searchtype eq 'committer') {
@@ -7329,9 +7343,9 @@ sub git_search {
 		git_search_changes(%co);
 	} elsif ($searchtype eq 'grep') {
 		git_search_files(%co);
+	} else {
+		die_error(400, "Unknown search type");
 	}
-
-	git_footer_html();
 }
 
 sub git_search_help {
-- 
1.7.5
