From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Thu, 14 Sep 2006 23:27:22 +0200
Message-ID: <200609142327.23059.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 14 23:27:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNyjj-0005kP-4p
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 23:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWINV1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWINV1D
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 17:27:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:5322 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751202AbWINV1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 17:27:01 -0400
Received: by ug-out-1314.google.com with SMTP id o38so101199ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 14:27:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kzEm4MSzgEUJ6CYw8jEzmoaaON07wjZhlcy6OOSIcxwReLTq8PI3Q2ICo4+tV30vT6w/0e33Nlwgy5vrIRtlY7qe1Ju5/bU4bES4AvAzbKhyF4M7ni9xxXIMa/fJXwNNd0bQVqMXPwPCRz+fORV6vkg1fTKFTbmbOFmQSPyJZj4=
Received: by 10.66.252.4 with SMTP id z4mr5064900ugh;
        Thu, 14 Sep 2006 14:26:59 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k30sm861306ugc.2006.09.14.14.26.58;
        Thu, 14 Sep 2006 14:26:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27042>

This is response to Linus work on packed refs. Additionally it
makes gitweb work with symrefs, too.

Do not parse refs by hand, using File::Find and reading individual
heads to get hash of reference, but use git-peek-remote output
instead. Assume that the hash for deref (with ^{}) always follows hash
for ref, and that we hav derefs only for tags objects; this removes
call to git_get_type (and git-cat-file -t invocation) for tags, which
speeds "summary" and "tags" views generation, but might slow
generation of "heads" view a bit. As of now we do not save and use the
deref hash.

Remove git_get_hash_by_ref while at it, as git_get_refs_list was the
only place it was used.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
By the way, the previous patch
  "gitweb: Use File::Find::find in git_get_projects_list"
was added during working on this feature.

 gitweb/gitweb.perl |   39 +++++++++++++++++----------------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 25383bc..4e58a6b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -676,19 +676,6 @@ sub git_get_hash_by_path {
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
-# assumes that PATH is not symref
-sub git_get_hash_by_ref {
-	my $path = shift;
-
-	open my $fd, "$projectroot/$path" or return undef;
-	my $head = <$fd>;
-	close $fd;
-	chomp $head;
-	if ($head =~ m/^[0-9a-fA-F]{40}$/) {
-		return $head;
-	}
-}
-
 sub git_get_project_description {
 	my $path = shift;
 
@@ -1098,17 +1085,25 @@ sub git_get_refs_list {
 	my @reflist;
 
 	my @refs;
-	my $pfxlen = length("$projectroot/$project/$ref_dir");
-	File::Find::find(sub {
-		return if (/^\./);
-		if (-f $_) {
-			push @refs, substr($File::Find::name, $pfxlen + 1);
+	open my $fd, "-|", $GIT, "peek-remote", "$projectroot/$project/"
+		or return;
+	while (my $line = <$fd>) {
+		chomp $line;
+		if ($line =~ m/^([0-9a-fA-F]{40})\t$ref_dir\/?([^\^]+)$/) {
+			push @refs, { hash => $1, name => $2 };
+		} elsif ($line =~ m/^[0-9a-fA-F]{40}\t$ref_dir\/?.*\^\{\}$/) {
+			# assume that "peeled" ref is always after ref,
+			# and that you "peel" (deref) tags only
+			$refs[$#refs]->{'type'} = "tag";
 		}
-	}, "$projectroot/$project/$ref_dir");
+	}
+	close $fd;
+
+	foreach my $ref (@refs) {
+		my $ref_file = $ref->{'name'};
+		my $ref_id   = $ref->{'hash'};
 
-	foreach my $ref_file (@refs) {
-		my $ref_id = git_get_hash_by_ref("$project/$ref_dir/$ref_file");
-		my $type = git_get_type($ref_id) || next;
+		my $type = $ref->{'type'} || git_get_type($ref_id) || next;
 		my %ref_item = parse_ref($ref_file, $ref_id, $type);
 
 		push @reflist, \%ref_item;
-- 
1.4.2
