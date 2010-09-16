From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 7/7] gitweb: group remote heads
Date: Thu, 16 Sep 2010 11:31:05 +0200
Message-ID: <1284629465-14798-8-git-send-email-giuseppe.bilotta@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:32:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwApF-0007gF-It
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab0IPJb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:31:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34856 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0IPJb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:31:58 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so130944wwe.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=n5BBa2Ft38ymc5N1xLjOiGwmBMhKkefwtT2Gm+u2AcE=;
        b=NlAeXIV0nSqUpQYfo5UXsJv4nZ29lgm8qk79j83kA88VXycAi36b9qpZA58Traz7Ei
         8BhopN/AubLUUa2gQ6JayxYXVb0SNQyjGmt2prZrrmCjK7x86d2H1A1AhIRKgQHzt4GR
         dOM3ZIJjzFlYwbBBnIy5S/N2lDFwe6KYVRHz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wyuxv5cK5ZEd2pSyEck9SJcc/BD07yZxRV/LQCj6Yku7fNK9n2TGW3mDf6Dhb1ghcs
         k5qPJ4XttxFBO/K79a/kPqY31i7qR8hkl00yX8zPmDyLhFYRhUUc8YFJrcYsg2Np60Rv
         ZRetGcGlTahu/DFHdQPA9aqBRx8gxsus9UWcU=
Received: by 10.216.175.83 with SMTP id y61mr2509772wel.30.1284629518192;
        Thu, 16 Sep 2010 02:31:58 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id p42sm1666223weq.36.2010.09.16.02.31.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 02:31:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.230.g8b572
In-Reply-To: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156309>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   35 ++++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 92551e4..66b5400 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2758,6 +2758,16 @@ sub git_get_last_activity {
 	return (undef, undef);
 }
 
+sub git_get_remotes {
+	my ($limit) = @_;
+	open my $fd, '-|' , git_cmd(), 'remote';
+	return () unless $fd;
+	my @remotes = map { chomp ; $_ } <$fd>;
+	close $fd or return ();
+	my @remoteheads = git_get_heads_list($limit, 'remotes');
+	return (\@remotes, \@remoteheads);
+}
+
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
@@ -4979,7 +4989,7 @@ sub git_heads_body {
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "shortlog") . " | " .
 		      $cgi->a({-href => href(action=>"log", hash=>$ref{'fullname'})}, "log") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
+		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'fullname'})}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
 	}
@@ -4991,6 +5001,19 @@ sub git_heads_body {
 	print "</table>\n";
 }
 
+sub git_remotes_body {
+	my ($remotedata, $head) = @_;
+	my @remotenames = @{$remotedata->[0]};
+	my @allheads = @{$remotedata->[1]};
+	foreach my $remote (@remotenames) {
+		my @remoteheads = grep { $_->{'name'} =~ s!^\Q$remote\E/!! } @allheads;
+		git_begin_group("remotes", $remote, "remotes/$remote",$remote);
+		git_heads_body(\@remoteheads, $head);
+		git_end_group();
+	}
+
+}
+
 sub git_search_grep_body {
 	my ($commitlist, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
@@ -5137,7 +5160,7 @@ sub git_summary {
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16, 'heads');
-	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
+	my @remotelist = $remote_heads ? git_get_remotes(16) : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5217,9 +5240,7 @@ sub git_summary {
 
 	if (@remotelist) {
 		git_print_header_div('remotes');
-		git_heads_body(\@remotelist, $head, 0, 15,
-		               $#remotelist <= 15 ? undef :
-		               $cgi->a({-href => href(action=>"remotes")}, "..."));
+		git_remotes_body(\@remotelist, $head);
 	}
 
 	if (@forklist) {
@@ -5551,9 +5572,9 @@ sub git_remotes {
 	git_print_page_nav('','', $head,undef,$head, $heads_nav);
 	git_print_header_div('summary', $project);
 
-	my @remotelist = git_get_heads_list(undef, 'remotes');
+	my @remotelist = git_get_remotes();
 	if (@remotelist) {
-		git_heads_body(\@remotelist, $head);
+		git_remotes_body(\@remotelist, $head);
 	}
 	git_footer_html();
 }
-- 
1.7.3.rc1.230.g8b572
