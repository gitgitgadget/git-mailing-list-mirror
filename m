From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: Separate ref parsing in git_read_refs into parse_ref
Date: Sat, 5 Aug 2006 00:40:36 +0200
Message-ID: <200608050040.36877.jnareb@gmail.com>
References: <200608050036.06490.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 05 00:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G98Nr-0007PF-8O
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161547AbWHDWmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161551AbWHDWmz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:42:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7142 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161547AbWHDWmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 18:42:53 -0400
Received: by nf-out-0910.google.com with SMTP id k26so45284nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 15:42:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pYQt5wZZHNAm65EczLm4LhOEpScHtb7iJzLBXVNz72mRNjNF2k4zuIfLxXwP8UBAebCxu6tYghn72S5UxDuyULqgmOzXh5Zqdpa91EdZCTcxkV5ZKS4o6nyJxb9AtDe6bEwARTG8KYCeJYE9VUxT0bEHaLSa9sc9Yh1b4qVCRLU=
Received: by 10.49.8.1 with SMTP id l1mr6021818nfi;
        Fri, 04 Aug 2006 15:42:52 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id q28sm2928781nfc.2006.08.04.15.42.51;
        Fri, 04 Aug 2006 15:42:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608050036.06490.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24858>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Pure coding style patch.

 gitweb/gitweb.perl |   80 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d440546..5b30654 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -677,6 +677,49 @@ sub parse_commit {
 	return %co;
 }
 
+# parse ref from ref_file, given by ref_id, with given type
+sub parse_ref {
+	my $ref_file = shift;
+	my $ref_id = shift;
+	my $type = shift || git_get_type($ref_id);
+	my %ref_item;
+
+	$ref_item{'type'} = $type;
+	$ref_item{'id'} = $ref_id;
+	$ref_item{'epoch'} = 0;
+	$ref_item{'age'} = "unknown";
+	if ($type eq "tag") {
+		my %tag = parse_tag($ref_id);
+		$ref_item{'comment'} = $tag{'comment'};
+		if ($tag{'type'} eq "commit") {
+			my %co = parse_commit($tag{'object'});
+			$ref_item{'epoch'} = $co{'committer_epoch'};
+			$ref_item{'age'} = $co{'age_string'};
+		} elsif (defined($tag{'epoch'})) {
+			my $age = time - $tag{'epoch'};
+			$ref_item{'epoch'} = $tag{'epoch'};
+			$ref_item{'age'} = age_string($age);
+		}
+		$ref_item{'reftype'} = $tag{'type'};
+		$ref_item{'name'} = $tag{'name'};
+		$ref_item{'refid'} = $tag{'object'};
+	} elsif ($type eq "commit"){
+		my %co = parse_commit($ref_id);
+		$ref_item{'reftype'} = "commit";
+		$ref_item{'name'} = $ref_file;
+		$ref_item{'title'} = $co{'title'};
+		$ref_item{'refid'} = $ref_id;
+		$ref_item{'epoch'} = $co{'committer_epoch'};
+		$ref_item{'age'} = $co{'age_string'};
+	} else {
+		$ref_item{'reftype'} = $type;
+		$ref_item{'name'} = $ref_file;
+		$ref_item{'refid'} = $ref_id;
+	}
+
+	return %ref_item;
+}
+
 ## ......................................................................
 ## parse to array of hashes functions
 
@@ -696,44 +739,11 @@ sub git_read_refs {
 	foreach my $ref_file (@refs) {
 		my $ref_id = git_read_hash("$project/$ref_dir/$ref_file");
 		my $type = git_get_type($ref_id) || next;
-		my %ref_item;
-		my %co;
-		$ref_item{'type'} = $type;
-		$ref_item{'id'} = $ref_id;
-		$ref_item{'epoch'} = 0;
-		$ref_item{'age'} = "unknown";
-		if ($type eq "tag") {
-			my %tag = parse_tag($ref_id);
-			$ref_item{'comment'} = $tag{'comment'};
-			if ($tag{'type'} eq "commit") {
-				%co = parse_commit($tag{'object'});
-				$ref_item{'epoch'} = $co{'committer_epoch'};
-				$ref_item{'age'} = $co{'age_string'};
-			} elsif (defined($tag{'epoch'})) {
-				my $age = time - $tag{'epoch'};
-				$ref_item{'epoch'} = $tag{'epoch'};
-				$ref_item{'age'} = age_string($age);
-			}
-			$ref_item{'reftype'} = $tag{'type'};
-			$ref_item{'name'} = $tag{'name'};
-			$ref_item{'refid'} = $tag{'object'};
-		} elsif ($type eq "commit"){
-			%co = parse_commit($ref_id);
-			$ref_item{'reftype'} = "commit";
-			$ref_item{'name'} = $ref_file;
-			$ref_item{'title'} = $co{'title'};
-			$ref_item{'refid'} = $ref_id;
-			$ref_item{'epoch'} = $co{'committer_epoch'};
-			$ref_item{'age'} = $co{'age_string'};
-		} else {
-			$ref_item{'reftype'} = $type;
-			$ref_item{'name'} = $ref_file;
-			$ref_item{'refid'} = $ref_id;
-		}
+		my %ref_item = parse_ref($ref_file, $ref_id, $type);
 
 		push @reflist, \%ref_item;
 	}
-	# sort tags by age
+	# sort refs by age
 	@reflist = sort {$b->{'epoch'} <=> $a->{'epoch'}} @reflist;
 	return \@reflist;
 }
-- 
1.4.1.1
