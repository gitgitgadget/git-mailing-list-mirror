From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix project-specific feature override behavior
Date: Mon, 01 Mar 2010 22:51:34 +0100
Message-ID: <20100301215040.32574.8149.stgit@localhost.localdomain>
References: <m37hpwma9u.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eli Barzilay <eli@barzilay.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 22:52:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDXB-0003oo-1e
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198Ab0CAVwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:52:07 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:59378 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0CAVwE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:52:04 -0500
Received: by fxm19 with SMTP id 19so1247872fxm.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=cM3jDX4rpndCktHWkg+w+/1tSadTWCUcemPACYgbVTU=;
        b=KzVOToF7SccXfcGbvc1ZO2HGKpgPiaMqAqqh4d59X/2cEPTxC11bgZ7j0VT2BgjZsT
         /PJyUizyXrrzYSuOkCbnQIRupkP/J5YINBTyAU//swMH9J2JH7krVZ5E7tDgEwmJ6/k0
         FQV1NGGxMwOJju4g6hQ3VL7V+Da+t7RXLKqqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=ACJxAAih1jz6sRI/DGMIALRqWsyBcg1cma9fJ7X27e/u3rsuhCM3jimxDNAB2LT2jJ
         out4/QwXEt9waDOoKegAti380cBoJvahz559TaDPELh4E0ajjiREZWFwGtcsAUM+D0YL
         WO5fjE8o7xUV40XR1nnesBPZkGDdlKqjK6+oc=
Received: by 10.223.15.23 with SMTP id i23mr5694301faa.53.1267480322292;
        Mon, 01 Mar 2010 13:52:02 -0800 (PST)
Received: from localhost.localdomain (abwj97.neoplus.adsl.tpnet.pl [83.8.233.97])
        by mx.google.com with ESMTPS id 16sm2498008fxm.11.2010.03.01.13.52.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 13:52:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o21LpY5b032612;
	Mon, 1 Mar 2010 22:51:45 +0100
In-Reply-To: <m37hpwma9u.fsf@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141360>

This commit fixes a bug in processing project-specific override in
a situation when there is no project, e.g. for the projects list page.

When 'snapshot' feature had project specific config override enabled
by putting
  $feature{'snapshot'}{'override'} = 1;

(or equivalent) in $GITWEB_CONFIG, and when viewing toplevel gitweb
page, which means the projects list page (to be more exact this
happens for any project-less action), gitweb would put the following
Perl warnings in error log:

  gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at gitweb.cgi line 2065.
  fatal: error processing config file(s)
  gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at gitweb.cgi line 2221.
  gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at gitweb.cgi line 2218.


The problem is in the following fragment of code:

  # path to the current git repository
  our $git_dir;
  $git_dir = "$projectroot/$project" if $project;

  # list of supported snapshot formats
  our @snapshot_fmts = gitweb_get_feature('snapshot');
  @snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);

For the toplevel gitweb page, which is the list of projects, $project is not
defined, therefore neither is $git_dir.  gitweb_get_feature() subroutine
calls git_get_project_config() if project specific override is turned
on... but we don't have project here.


Those errors mentioned above occur in the following fragment of code in
git_get_project_config():

  	# get config
  	if (!defined $config_file ||
  	    $config_file ne "$git_dir/config") {
  		%config = git_parse_project_config('gitweb');
  		$config_file = "$git_dir/config";
  	}

git_parse_project_config() calls git_cmd() which has '--git-dir='.$git_dir


There are (at least) three possible solutions:
1. Harden gitweb_get_feature() so that it doesn't call
   git_get_project_config() if $project (and therefore $git_dir) is not
   defined; there is no project for project specific config.
2. Harden git_get_project_config() like you did in your fix, returning early
   if $git_dir is not defined.
3. Harden git_cmd() so that it doesn't add "--git-dir=$git_dir" if $git_dir
   is not defined, and change git_get_project_config() so that it doesn't
   even try to access $git_dir if it is not defined.

This commit implements both 1.) and 2.), i.e. gitweb_get_feature() doesn't
call project-specific override if $git_dir is not defined (if there is no
project), and git_get_project_config() returns early if $git_dir is not
defined.


Add a test for this bug to t/t9500-gitweb-standalone-no-errors.sh test.

Reported-by: Eli Barzilay <eli@barzilay.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is a fix, with much too long commit message ;-)

 gitweb/gitweb.perl                     |    9 ++++++++-
 t/t9500-gitweb-standalone-no-errors.sh |   16 ++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1ce4de1..d02734e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -467,7 +467,11 @@ sub gitweb_get_feature {
 		$feature{$name}{'sub'},
 		$feature{$name}{'override'},
 		@{$feature{$name}{'default'}});
-	if (!$override) { return @defaults; }
+	# project specific override is possible only if we have project
+	our $git_dir; # global variable, declared later
+	if (!$override || !defined $git_dir) {
+		return @defaults;
+	}
 	if (!defined $sub) {
 		warn "feature $name is not overridable";
 		return @defaults;
@@ -2225,6 +2229,9 @@ sub config_to_multi {
 sub git_get_project_config {
 	my ($key, $type) = @_;
 
+	# do we have project
+	return unless (defined $project && defined $git_dir);
+
 	# key sanity check
 	return unless ($key);
 	$key =~ s/^gitweb\.//;
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 0fe9beb..4f2b9b0 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -591,14 +591,22 @@ test_debug 'cat gitweb.log'
 # ----------------------------------------------------------------------
 # gitweb config and repo config
 
-cat >>gitweb_config.perl <<EOF
+cat >>gitweb_config.perl <<\EOF
 
-\$feature{'blame'}{'override'} = 1;
-\$feature{'snapshot'}{'override'} = 1;
-\$feature{'avatar'}{'override'} = 1;
+# turn on override for each overridable feature
+foreach my $key (keys %feature) {
+	if ($feature{$key}{'sub'}) {
+		$feature{$key}{'override'} = 1;
+	}
+}
 EOF
 
 test_expect_success \
+	'config override: projects list (implicit)' \
+	'gitweb_run'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
 	'config override: tree view, features not overridden in repo config' \
 	'gitweb_run "p=.git;a=tree"'
 test_debug 'cat gitweb.log'
