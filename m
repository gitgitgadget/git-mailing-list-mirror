From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] git-svn: Don't fail `--help' if git directory not found.
Date: Sat, 24 Jan 2009 12:44:37 -0500
Message-ID: <20090124174437.GA10125@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 18:46:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQma8-0002jz-GB
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 18:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZAXRop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 12:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbZAXRop
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 12:44:45 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:65327 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbZAXRoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 12:44:44 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2468982qwe.37
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 09:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=nZmTpRjOX1QRU8RCvSqIj2VMl2OkbSRKesZSG4SZNJQ=;
        b=YWpOnkvc8BCytbOs2wkSdAOtM7FekUEc0Aifvi87Ccx6pqc0xKmu/k2gEAoiIXU85/
         gIwoSNIxg1sUFmaIAIz1OEPlKNvzLpMEpH69nyQQDgtLL78vCSYWGdhayltI8Ja0zGYI
         J849q687TX4uC6JR/fcIzL595yCF5qPiL2Dzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=ADMzQK1ojnaVwtVcHkX7EiFlmKgXedXmFor5kgkR27g11mC0QAzCSV4LzBfgu04ekH
         0Y91XyHYW7bT2KaBjpQdgY5VoWnRNqEBb6I3cnurWz2M5B9DUWUcybMnCbrSq03gJTit
         GMkEeh6XE8Ab2nx+0vihQKy8ZMjwmZKnYI4+I=
Received: by 10.214.149.3 with SMTP id w3mr2036820qad.111.1232819082526;
        Sat, 24 Jan 2009 09:44:42 -0800 (PST)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 9sm14725356ywf.33.2009.01.24.09.44.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jan 2009 09:44:41 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106981>

When called with the `--help' or `--version' from outside of a working tree
git-svn would fail with

	fatal: Not a git repository
	rev-parse --show-cdup: command returned error: 128

This happens because git-svn would check that it was running from the top of a
working directory before parsing options.  Fix this by parsing options first.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 git-svn.perl |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d4cb538..875a05b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -216,6 +216,25 @@ for (my $i = 0; $i < @ARGV; $i++) {
 	}
 };
 
+my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
+
+read_repo_config(\%opts);
+if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
+	Getopt::Long::Configure('pass_through');
+}
+my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
+                    'minimize-connections' => \$Git::SVN::Migration::_minimize,
+                    'id|i=s' => \$Git::SVN::default_ref_id,
+                    'svn-remote|remote|R=s' => sub {
+                       $Git::SVN::no_reuse_existing = 1;
+                       $Git::SVN::default_repo_id = $_[1] });
+exit 1 if (!$rv && $cmd && $cmd ne 'log');
+
+usage(0) if $_help;
+version() if $_version;
+usage(1) unless defined $cmd;
+load_authors() if $_authors;
+
 # make sure we're always running at the top-level working directory
 unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 	unless (-d $ENV{GIT_DIR}) {
@@ -241,25 +260,6 @@ unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
-my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
-
-read_repo_config(\%opts);
-if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
-	Getopt::Long::Configure('pass_through');
-}
-my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
-                    'minimize-connections' => \$Git::SVN::Migration::_minimize,
-                    'id|i=s' => \$Git::SVN::default_ref_id,
-                    'svn-remote|remote|R=s' => sub {
-                       $Git::SVN::no_reuse_existing = 1;
-                       $Git::SVN::default_repo_id = $_[1] });
-exit 1 if (!$rv && $cmd && $cmd ne 'log');
-
-usage(0) if $_help;
-version() if $_version;
-usage(1) unless defined $cmd;
-load_authors() if $_authors;
-
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
 	Git::SVN::Migration::migration_check();
 }
-- 
1.5.4.3
