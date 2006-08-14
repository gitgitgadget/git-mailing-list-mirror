From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/9] gitweb: Separate ref parsing in git_get_refs_list into parse_ref
Date: Mon, 14 Aug 2006 02:07:00 +0200
Message-ID: <200608140207.01108.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:17:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZVH-0001tP-8Q
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWHNKQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWHNKQj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:653 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751973AbWHNKQi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:38 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20995nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Todlwh81bsf02W4e17ZYlzgfJSVmyWyzvb7uKg7VWUiMQ7NfOHat+mbH06tH68Mj1W2wYtyZmPUUX/UbKNBIxC0UHxVefVaUnQoajpIlyq5LNv3UGxkJPPQBMQRmG6AbaQaYY5v0SRR9ul0Jt6D+0DjNpFl4HJLF5jgYsCgUaw0=
Received: by 10.49.8.4 with SMTP id l4mr1034436nfi;
        Mon, 14 Aug 2006 03:16:37 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.36;
        Mon, 14 Aug 2006 03:16:37 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140202.46160.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25339>

Note that for each ref there are usually two calls to git subroutines:
first to get the type of ref, second to parse ref if ref is of commit
or tag type.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   80 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 28df59e..0c4ec92 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -690,6 +690,49 @@ sub parse_commit {
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
 
@@ -709,44 +752,11 @@ sub git_get_refs_list {
 	foreach my $ref_file (@refs) {
 		my $ref_id = git_get_hash_by_ref("$project/$ref_dir/$ref_file");
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
