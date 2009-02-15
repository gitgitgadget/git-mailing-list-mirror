From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 1/3] send-email: allow send-email to run outside a repo
Date: Sat, 14 Feb 2009 23:32:13 -0500
Message-ID: <1234672335-54321-2-git-send-email-jaysoffian@gmail.com>
References: <1234672335-54321-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 05:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYYj9-0007tT-4Q
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 05:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbZBOEcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 23:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbZBOEct
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 23:32:49 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:14333 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbZBOEcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 23:32:48 -0500
Received: by yw-out-2324.google.com with SMTP id 5so820192ywh.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 20:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OjD/vttHcfDYpqWv2Jko3AMh6Ip0dDz3pqZMOKS3Dxg=;
        b=wsdnP26VrPpoYCkK7jbF7NHnSVSg0LFL2VFXRWZw/zZYJompfAChRfibLwKikR9kLv
         EZYL/24u0n+0SpwmBYQ1TNL7FpqBe6uHXxPH4r8Xh1I5Kb/LKQ/3173O0R+ZtAZznC5d
         +ucxSF2tcpp7YAMdNWrm3dc0slL59nNhDh7NY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DjxYF619aD8Nc1vgxMrilAZK41xhgFyChgUdKnnGUY7c5ibVXdEEyXs9aH0XddBaMB
         kJS1oZJ2qYKOmFgNZRGS2AzIZgt5G4S0eNpxcAFLd+vuI1qPbU+ow9qbQxxC6SzmVZaP
         rG9oCrLdBCsDRm6qe3xtw9QnI05aE0OvDztEE=
Received: by 10.100.119.17 with SMTP id r17mr1640847anc.130.1234672366076;
        Sat, 14 Feb 2009 20:32:46 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c23sm4748621ana.32.2009.02.14.20.32.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 20:32:19 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.250.g3b7b7
In-Reply-To: <1234672335-54321-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109957>

send-email is supposed to be able to run from outside a repo. This
ability was broken by commits caf0c3d6 (make the message file name more
specific) and 5df9fcf6 (interpret unknown files as revision lists).

This commit provides a fix for both.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Junio,

I think you have this one applied already, but I don't currently in next
nor pu, so I rebased it on next. I also put it first in the series per
your request.

j.

 git-send-email.perl |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 77ca8fe..9dad100 100755
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
 
@@ -156,7 +156,10 @@ if ($@) {
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
@@ -267,6 +270,9 @@ unless ($rc) {
     usage();
 }
 
+die "Cannot run git format-patch from outside a repository\n"
+	if $format_patch and not $repo;
+
 # Now, let's fill any that aren't set in with defaults:
 
 sub read_config {
@@ -404,6 +410,7 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 
 # returns 1 if the conflict must be solved using it as a format-patch argument
 sub check_file_rev_conflict($) {
+	return unless $repo;
 	my $f = shift;
 	try {
 		$repo->command('rev-parse', '--verify', '--quiet', $f);
@@ -445,6 +452,8 @@ while (defined(my $f = shift @ARGV)) {
 }
 
 if (@rev_list_opts) {
+	die "Cannot run git format-patch from outside a repository\n"
+		unless $repo;
 	push @files, $repo->command('format-patch', '-o', tempdir(CLEANUP => 1), @rev_list_opts);
 }
 
-- 
1.6.2.rc0.251.g344d
