From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (take 2)] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Fri, 15 Sep 2006 03:43:28 +0200
Message-ID: <200609150343.28334.jnareb@gmail.com>
References: <200609142327.23059.jnareb@gmail.com> <7v8xkm2gfs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 03:43:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO2jb-0002Sm-F9
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 03:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWIOBnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 21:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWIOBnI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 21:43:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:57822 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751440AbWIOBnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 21:43:06 -0400
Received: by ug-out-1314.google.com with SMTP id o38so116825ugd
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 18:43:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P/YDYZe+WIWiB5oNnIpWUfhojn/znj62nb7qEHL1ZLTYJqblKRo717TfTgkUMo3jc3nyyj/H6fFT1ots+IqYHkVecveDZhSP/4QtK+osuRKBEwDhVMYWo5CXsan5u7B+2yI2f8FUEI93d+grATEKKm2DMT8xNCL7aIkpQbVl8ek=
Received: by 10.67.100.17 with SMTP id c17mr5164584ugm;
        Thu, 14 Sep 2006 18:43:04 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id 55sm988848ugq.2006.09.14.18.43.03;
        Thu, 14 Sep 2006 18:43:03 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v8xkm2gfs.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27054>

This is in response to Linus work on packed refs. Additionally it
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
 gitweb/gitweb.perl |   41 +++++++++++++++++++----------------------
 1 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 25383bc..b4a890b 100755
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
 
@@ -1098,17 +1085,27 @@ sub git_get_refs_list {
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
+		} elsif ($line =~ m/^[0-9a-fA-F]{40}\t$ref_dir\/?(.*)\^\{\}$/ &&
+		         $1 eq $refs[-1]{'name'}) {
+			# most likely a tag is followed by its peeled
+			# (deref) one, and when that happens we know the
+			# previous one was of type 'tag'.
+			$refs[-1]{'type'} = "tag";
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
