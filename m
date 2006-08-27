From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Remove git_to_hash function
Date: Sun, 27 Aug 2006 23:45:26 +0200
Message-ID: <200608272345.26722.jnareb@gmail.com>
References: <200608272343.14653.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 27 23:45:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSRp-0004Nu-T0
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 23:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWH0Vpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 17:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWH0Vpe
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 17:45:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:11789 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932276AbWH0Vp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 17:45:29 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1123460nfa
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 14:45:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t67HJhY+kZTmyYsZqzwsLMHi6E7Vvi1XTI4dRd8N5aUI7S9F3uoZ6JFzVZeny+4YYDTuyA8A/81v3tOzLMck3uqsfUG2oP2MbgD3Xl36SUIu94rxLzdbn6rcETJfq9ISENdDblrxZmdfkqNZCnkUXSjJJf41jl2aZ2hguE4KflE=
Received: by 10.49.75.2 with SMTP id c2mr8208482nfl;
        Sun, 27 Aug 2006 14:45:28 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id q28sm3913698nfc.2006.08.27.14.45.27;
        Sun, 27 Aug 2006 14:45:28 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608272343.14653.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26114>

Remove git_to_hash function, which was to translate symbolic reference
to hash, and it's use in git_blobdiff.  We don't try so hard to guess
filename if it was not provided.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   27 +++------------------------
 1 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 99c74f1..ae18c27 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -635,26 +635,6 @@ sub git_get_hash_by_path {
 	return $3;
 }
 
-# converts symbolic name to hash
-sub git_to_hash {
-	my @params = @_;
-	return undef unless @params;
-
-	open my $fd, "-|", $GIT, "rev-parse", @params
-		or return undef;
-	my @hashes = map { chomp; $_ } <$fd>;
-	close $fd;
-
-	if (wantarray) {
-		return @hashes;
-	} elsif (scalar(@hashes) == 1) {
-		# single hash
-		return $hashes[0];
-	} else {
-		return \@hashes;
-	}
-}
-
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
@@ -2739,10 +2719,9 @@ sub git_blobdiff {
 			@difftree
 				or die_error('404 Not Found', "Blob diff not found");
 
-		} elsif (defined $hash) { # try to find filename from $hash
-			if ($hash !~ /[0-9a-fA-F]{40}/) {
-				$hash = git_to_hash($hash);
-			}
+		} elsif (defined $hash &&
+		         $hash =~ /[0-9a-fA-F]{40}/) {
+			# try to find filename from $hash
 
 			# read filtered raw output
 			open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base
-- 
1.4.1.1
