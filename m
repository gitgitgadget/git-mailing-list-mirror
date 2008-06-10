From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Separate filling list of projects info
Date: Tue, 10 Jun 2008 19:21:01 +0200
Message-ID: <200806101921.02156.jnareb@gmail.com>
References: <200806101919.24242.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 19:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K67fc-0006CQ-O6
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYFJR3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 13:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYFJR3P
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:29:15 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:8703 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbYFJR3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 13:29:14 -0400
Received: by gv-out-0910.google.com with SMTP id e6so646678gvc.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RSt+0WHXPeCtevIBWiajLDAE1S+6jt64dEg2eFYwN58=;
        b=WauBpX1i6iNCULf31QTALV0/JMI2qLHPknY3Ut0bqqwRNpxReeoZ4hMkC0pzcRStNn
         9SICnOinMOL/zti4cP8waFyh6Kj+CnzyqFTFuMBWCuHbxbNuHaATXzFWsLZcTEhPMw0+
         4Am4JxaBKRY7EJGt61brBoxf7sT63knTPOmik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VgO/3heknl4XAB/XPnPSyk59mOq5r0w3d114Uxngvhia/4SIQqjaFeYtWX2qQLMFOP
         R5ZcCxL9Q7soh3w0BeumJgoiyMdmd8XW1oWPKMK4xP0EqphRqr2qBwcbI6BoqnO+dsg4
         8q4+fIXE9t9gM1Xlmb9k297GuQT6fMjNTBYN0=
Received: by 10.103.176.2 with SMTP id d2mr3513482mup.112.1213118521733;
        Tue, 10 Jun 2008 10:22:01 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.165])
        by mx.google.com with ESMTPS id y2sm8498768mug.1.2008.06.10.10.21.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 10:22:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200806101919.24242.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84529>

Extract filling project list info, i.e. adding age, description, owner
and forks information, into fill_project_list_info() subroutine.  This
is preparation for smart pagination and smart searching (to make it
possible to calculate/generate info only for those projects which will
be shown).

Small changes compared to original version to improve readability
(comments, names of variables, named loops).

Additionally, store both full ('descr_long') and shortened ('descr')
project description in Perl's internal form (using to_utf8).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It is meant to be minimally intrusive patch, although it corrects
some code (variable naming, ensuring storing data in Perl internal
form, comments, etc.).

 gitweb/gitweb.perl |   35 +++++++++++++++++++++++------------
 1 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 198772c..d7a9809 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3559,21 +3559,24 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
-sub git_project_list_body {
-	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
-
-	my ($check_forks) = gitweb_check_feature('forks');
-
+# fills project list info (age, description, owner, forks) for each
+# project in the list, removing invalid projects from returned list
+# NOTE: modifies $projlist, but does not remove entries from it
+sub fill_project_list_info {
+	my ($projlist, $check_forks) = @_;
 	my @projects;
+
+ PROJECT:
 	foreach my $pr (@$projlist) {
-		my (@aa) = git_get_last_activity($pr->{'path'});
-		unless (@aa) {
-			next;
+		my (@activity) = git_get_last_activity($pr->{'path'});
+		unless (@activity) {
+			next PROJECT;
 		}
-		($pr->{'age'}, $pr->{'age_string'}) = @aa;
+		($pr->{'age'}, $pr->{'age_string'}) = @activity;
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
-			$pr->{'descr_long'} = to_utf8($descr);
+			$descr = to_utf8($descr);
+			$pr->{'descr_long'} = $descr;
 			$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
 		}
 		if (!defined $pr->{'owner'}) {
@@ -3585,14 +3588,22 @@ sub git_project_list_body {
 			    ($pname !~ /\/$/) &&
 			    (-d "$projectroot/$pname")) {
 				$pr->{'forks'} = "-d $projectroot/$pname";
-			}
-			else {
+			}	else {
 				$pr->{'forks'} = 0;
 			}
 		}
 		push @projects, $pr;
 	}
 
+	return @projects;
+}
+
+sub git_project_list_body {
+	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
+
+	my ($check_forks) = gitweb_check_feature('forks');
+	my @projects = fill_project_list_info($projlist, $check_forks);
+
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
-- 
1.5.5.3
