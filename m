From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (6/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:16:03 -0700
Message-ID: <5005F233.1070905@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrH01-0006dx-Kz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993Ab2GQXQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:16:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216Ab2GQXQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:16:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1768565;
	Tue, 17 Jul 2012 19:16:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=pj4UF241+e8d
	ItE/g2q6ecD/FGU=; b=wj4VC1m4xYRqHskxJ6oVLsVnGUxIFLYoTmcQH03NE+j6
	udXQC5WSAfibf9qcFYm//XJhCSm+RlHfZrfXNpM4DZGdtfw7+5mi/hSMXkrbuJ15
	ASX52BxO5GAopXQIaB/sE15DEoilCVk7WIH9TH5hFwT1gdcokyckHIrHSSRVQNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=krGwXC
	fQPUWOO+0I8+/KIF3adIOC9kDRd/K/Tk2wC6MFapXRm7w9pQDXEZo/c/9mchNCzC
	c70KX3d33Tlp6byRfvb5520sP4HqYpCzY7DgJdEYxAHsoD8Ga+rsqr3HGNYNYKWN
	BidEsehfqgTB1xveOI67VsQ7ChnQljsH8W38A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F22558564;
	Tue, 17 Jul 2012 19:16:04 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF5B18562; Tue, 17 Jul
 2012 19:16:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120717174446.GA14244@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 6176DC6E-D065-11E1-9DDB-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201631>

>From cb1a73929da15e87fa3dcc41c4cfa9ca592081fa Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Thu, 12 Jul 2012 17:14:24 -0700
Subject: [PATCH 07/11] Fix Git::SVN::Migration after its move.

Also...
* eliminate the big "import all the Git command functions" loop, nothing needs it
  any more
* only load Git::SVN::Migration if we need it
---
 git-svn.perl              | 28 +++++++++++++++-------------
 perl/Git/SVN/Migration.pm | 16 +++++++++++++++-
 perl/Makefile             |  1 +
 t/Git-SVN/00compile.t     |  3 ++-
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index f2bf759..8b8607d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -11,7 +11,6 @@ $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';

 use Git::SVN;
-use Git::SVN::Log;

 use Git::SVN::Utils qw(fatal can_compress);

@@ -77,24 +76,26 @@ use File::Spec;
 use File::Find;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
-use Git;
+
+use Git qw(
+    git_cmd_try
+    command
+    command_oneline
+    command_noisy
+    command_output_pipe
+    command_close_pipe
+    command_bidi_pipe
+    command_close_bidi_pipe
+);
+
 use Git::SVN::Editor qw//;
 use Git::SVN::Fetcher qw//;
-use Git::SVN::Ra qw//;
+use Git::SVN::Log;
 use Git::SVN::Prompt qw//;
+use Git::SVN::Ra qw//;
 use Memoize;  # core since 5.8.0, Jul 2002

 BEGIN {
-	# import functions from Git into our packages, en masse
-	no strict 'refs';
-	foreach (qw/command command_oneline command_noisy command_output_pipe
-	            command_input_pipe command_close_pipe
-	            command_bidi_pipe command_close_bidi_pipe/) {
-		for my $package ( qw(Git::SVN::Migration),
-			__PACKAGE__) {
-			*{"${package}::$_"} = \&{"Git::$_"};
-		}
-	}
 	Memoize::memoize 'Git::config';
 	Memoize::memoize 'Git::config_bool';
 }
@@ -365,6 +366,7 @@ if (defined $_authors_prog) {
 }

 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
+	require Git::SVN::Migration;
 	Git::SVN::Migration::migration_check();
 }
 Git::SVN::init_vars();
diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
index 082a788..b17fe00 100644
--- a/perl/Git/SVN/Migration.pm
+++ b/perl/Git/SVN/Migration.pm
@@ -32,12 +32,22 @@ package Git::SVN::Migration;
 #              rebuilding the .rev_db.  Rebuilding the rev_db is not
 #              possible if noMetadata or useSvmProps are set; but should
 #              be no problem for users that use the (sensible) defaults.
+
 use strict;
 use warnings;
+
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Basename qw/dirname basename/;
-use vars qw/$_minimize/;
+
+our $_minimize;
+
+use Git qw(
+	command
+	command_noisy
+	command_output_pipe
+	command_close_pipe
+);

 sub migrate_from_v0 {
 	my $git_dir = $ENV{GIT_DIR};
@@ -146,6 +156,7 @@ sub migrate_from_v2 {
 	read_old_urls(\%l_map, '', "$ENV{GIT_DIR}/svn");
 	my $migrated = 0;

+	require Git::SVN;
 	foreach my $ref_id (sort keys %l_map) {
 		eval { Git::SVN->init($l_map{$ref_id}, '', undef, $ref_id) };
 		if ($@) {
@@ -157,6 +168,9 @@ sub migrate_from_v2 {
 }

 sub minimize_connections {
+	require Git::SVN;
+	require Git::SVN::Ra;
+
 	my $r = Git::SVN::read_all_remotes();
 	my $new_urls = {};
 	my $root_repos = {};
diff --git a/perl/Makefile b/perl/Makefile
index 2a4ca57..d6a0e84 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -31,6 +31,7 @@ modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
 modules += Git/SVN/Editor
 modules += Git/SVN/Log
+modules += Git/SVN/Migration
 modules += Git/SVN/Prompt
 modules += Git/SVN/Ra
 modules += Git/SVN/Utils
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
index 37626f4..1307b65 100644
--- a/t/Git-SVN/00compile.t
+++ b/t/Git-SVN/00compile.t
@@ -3,9 +3,10 @@
 use strict;
 use warnings;

-use Test::More tests => 4;
+use Test::More tests => 5;

 require_ok 'Git::SVN';
 require_ok 'Git::SVN::Utils';
 require_ok 'Git::SVN::Ra';
 require_ok 'Git::SVN::Log';
+require_ok 'Git::SVN::Migration';
-- 
1.7.11.1
