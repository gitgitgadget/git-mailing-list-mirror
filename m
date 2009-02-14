From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] send-email: allow send-email to run outside a repo
Date: Sat, 14 Feb 2009 00:38:33 -0500
Message-ID: <1234589913-67684-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 06:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYDG1-0002rH-NY
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 06:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbZBNFij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 00:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbZBNFij
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 00:38:39 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:53951 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZBNFii (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 00:38:38 -0500
Received: by gxk22 with SMTP id 22so1501217gxk.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 21:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=yqEY4rOOsWaVMTrw9qUODSMV6O3ugZox8OluGKe4W1s=;
        b=hEh7cQoFlqUIXPIc7HdyfT9EMHrG46O3RN3DHEDr7QojwSKbmzYpxzp7wq9FF1gwa6
         bBrvNe4SQS9BeVyjLlFMZYl6EJjsUMYohuVQu0uKB8+DdnCY8/UZdkgUEcFtszSN9DPD
         L+IpD39Q+yrYzDDDw8/SX9+esqvy0ShHeqCb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=gib5hvOJaueseOZqJVT65hR5AxhF9CG+lMOaADb66T3LkbUOD1UOTMbX2buK0HU+JE
         JAv070m+NRiKROxsmYRKGZlEdW843PnonImAZN6Kf4UJR4ViUByHjj7sR2t/Ihhewl0G
         KCHJWdufVVVhwed6GDIJsdoeu86Gd30rrtXqA=
Received: by 10.150.144.17 with SMTP id r17mr381793ybd.215.1234589916034;
        Fri, 13 Feb 2009 21:38:36 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id u25sm5215236ele.16.2009.02.13.21.38.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 21:38:35 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.239.gfa9f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109822>

From: Jay Soffian <jaysoffian@gmail.com>

send-email is supposed to be able to run from outside a repo. This
ability was broken by commits caf0c3d6 (make the message file name more
specific) and 5df9fcf6 (interpret unknown files as revision lists).

This commit provides a fix for both.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Junio,

This is on top of my previous send-email commits from tonight. I'm not
sure whether it applies cleanly otherwise.

j.

 git-send-email.perl |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 23a55e2..49ed8c2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -23,7 +23,7 @@ use Getopt::Long;
 use Text::ParseWords;
 use Data::Dumper;
 use Term::ANSIColor;
-use File::Temp qw/ tempdir /;
+use File::Temp qw/ tempdir tempfile /;
 use Error qw(:try);
 use Git;
 
@@ -157,7 +157,10 @@ if ($@) {
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
-my $compose_filename = $repo->repo_path() . "/.gitsendemail.msg.$$";
+my $compose_filename = ($repo ?
+	tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
+	tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
+
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -268,6 +271,9 @@ unless ($rc) {
     usage();
 }
 
+die "Cannot run git format-patch from outside a repository\n"
+	if $format_patch and not $repo;
+
 # Now, let's fill any that aren't set in with defaults:
 
 sub read_config {
@@ -420,6 +426,7 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 
 # returns 1 if the conflict must be solved using it as a format-patch argument
 sub check_file_rev_conflict($) {
+	return unless $repo;
 	my $f = shift;
 	try {
 		$repo->command('rev-parse', '--verify', '--quiet', $f);
@@ -461,6 +468,8 @@ while (defined(my $f = shift @ARGV)) {
 }
 
 if (@rev_list_opts) {
+	die "Cannot run git format-patch from outside a repository\n"
+		unless $repo;
 	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
 }
 
-- 
1.6.2.rc0.238.g0c1fe
