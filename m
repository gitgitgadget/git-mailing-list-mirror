From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2ter 2/2] gitweb: clean up gitweb_check_feature() calls
Date: Sat, 29 Nov 2008 13:00:32 -0800
Message-ID: <7vzljiz1qn.fsf@gitster.siamese.dyndns.org>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vej0u1d2c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 22:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Wx8-0006t2-Le
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 22:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYK2VAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 16:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbYK2VAy
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 16:00:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYK2VAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 16:00:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 761C682B71;
	Sat, 29 Nov 2008 16:00:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A027082B6E; Sat,
 29 Nov 2008 16:00:34 -0500 (EST)
In-Reply-To: <7vej0u1d2c.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 29 Nov 2008 12:39:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CEAABE0E-BE58-11DD-8426-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101926>

Junio C Hamano <gitster@pobox.com> writes:

> ...  The change is not
> about fixing (your proposed commit log message read "gitweb:fixes to
> gitweb feature check code") as nothing is broken.  It is purely about
> futureproofing and I think we should mark it as such.

Actually, there is a handful clueless/careless callers.  Before applying
any of the check => get patch, let's do this as a fix.

-- >8 --
Subject: [PATCH] gitweb: fix 'ctags' feature check and others

gitweb_check_feature() function is to retrieve the configuration parameter
list and calling it in a scalar context does not give its first element
that tells if the feature is enabled.  This fixes all the existing callers
to call the function correctly in list context.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 933e137..400f5c8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3914,7 +3914,7 @@ sub fill_project_list_info {
 	my ($projlist, $check_forks) = @_;
 	my @projects;
 
-	my $show_ctags = gitweb_check_feature('ctags');
+	my ($show_ctags) = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
 		my (@activity) = git_get_last_activity($pr->{'path'});
@@ -3988,7 +3988,7 @@ sub git_project_list_body {
 		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
 	}
 
-	my $show_ctags = gitweb_check_feature('ctags');
+	my ($show_ctags) = gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my %ctags;
 		foreach my $p (@projects) {
@@ -4457,7 +4457,7 @@ sub git_summary {
 	}
 
 	# Tag cloud
-	my $show_ctags = (gitweb_check_feature('ctags'))[0];
+	my ($show_ctags) = gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my $ctags = git_get_project_ctags($project);
 		my $cloud = git_populate_project_tagcloud($ctags);
@@ -4559,7 +4559,7 @@ sub git_blame {
 	my $fd;
 	my $ftype;
 
-	gitweb_check_feature('blame')
+	gitweb_check_feature('blame')[0]
 	    or die_error(403, "Blame view not allowed");
 
 	die_error(400, "No file name given") unless $file_name;
@@ -5610,7 +5610,7 @@ sub git_history {
 }
 
 sub git_search {
-	gitweb_check_feature('search') or die_error(403, "Search is disabled");
+	gitweb_check_feature('search')[0] or die_error(403, "Search is disabled");
 	if (!defined $searchtext) {
 		die_error(400, "Text field is empty");
 	}
@@ -5629,11 +5629,11 @@ sub git_search {
 	if ($searchtype eq 'pickaxe') {
 		# pickaxe may take all resources of your box and run for several minutes
 		# with every query - so decide by yourself how public you make this feature
-		gitweb_check_feature('pickaxe')
+		gitweb_check_feature('pickaxe')[0]
 		    or die_error(403, "Pickaxe is disabled");
 	}
 	if ($searchtype eq 'grep') {
-		gitweb_check_feature('grep')
+		gitweb_check_feature('grep')[0]
 		    or die_error(403, "Grep is disabled");
 	}
 
-- 
1.6.0.4.850.g6bd829
