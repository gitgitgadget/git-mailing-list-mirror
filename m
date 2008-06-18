From: "=?UTF-8?Q?Jo=C3=A3o_Abecasis?=" <joao@abecasis.name>
Subject: Re: [PATCH] git-svn: follow revisions of svm-mirrored repositories
Date: Tue, 17 Jun 2008 21:58:06 -0500
Message-ID: <7bf6f1d20806171958y4104a77cxf660d2853d391e2d@mail.gmail.com>
References: <7bf6f1d20806132102x71422617s26260fdc348a7c04@mail.gmail.com>
	 <485589F5.6020409@vilain.net>
	 <7bf6f1d20806171957k29dbdd4fh52c3b515e7b573d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 18 04:59:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8nt3-00065V-4u
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 04:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836AbYFRC6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 22:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756736AbYFRC6J
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 22:58:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:19356 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519AbYFRC6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 22:58:08 -0400
Received: by ug-out-1314.google.com with SMTP id h2so701888ugf.16
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 19:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=S3PbO0wXub7DKlJKAfpazatS10aN9DMDUgXkp/A9t8Y=;
        b=BZu31lH9LdOETQpTK5tLv9luB66ntV6528nLgDMw9+VbMfKkF31y+g0uTVgnoj2UfV
         1voHzgRtbAr8mbQNB3l2EJxAbW29ndDbZs/ViT7ojnQQGStojAZ9neskYgIOHGhQyy/h
         4Vix/dAutVjYajhduqyrxDuBuNjSYD6Jn+Ufg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ij+Pps2gcOI/YNpRwueJp81LhQJcnk4tbH27C3+1jM9+4MB05xm6wdBdeXAgrxdv3Q
         kFDwTSQMK96i3aNVpKY+QJDFI07z/9kUIBqIkzU+JuUmUPRYxWotDUkBoyTBbB+gFzMc
         OHDv7FvC7mmpjL0EykWolAIKeFLPcqmohgTJM=
Received: by 10.67.115.9 with SMTP id s9mr8824350ugm.81.1213757886530;
        Tue, 17 Jun 2008 19:58:06 -0700 (PDT)
Received: by 10.67.94.6 with HTTP; Tue, 17 Jun 2008 19:58:06 -0700 (PDT)
In-Reply-To: <7bf6f1d20806171957k29dbdd4fh52c3b515e7b573d@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e93d67da3fae708e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85353>

Although git-svn keeps track of source revisions in svm-mirrored
repositories, it doesn't use that information in all places.

This fixes working_head_info and Git::SVN::find_by_url to work with
mirrored repositories when useSvmProps is set. At least the commands
find-rev and rebase, which didn't work for me with svm-mirrored
repositories, are now working.
---
 git-svn.perl |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 47b0c37..51325b6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -537,13 +537,13 @@ sub cmd_find_rev {
 		my $head = shift;
 		$head ||= 'HEAD';
 		my @refs;
-		my (undef, undef, undef, $gs) = working_head_info($head, \@refs);
+		my (undef, undef, $uuid, $gs) = working_head_info($head, \@refs);
 		unless ($gs) {
 			die "Unable to determine upstream SVN information from ",
 			    "$head history\n";
 		}
 		my $desired_revision = substr($revision_or_hash, 1);
-		$result = $gs->rev_map_get($desired_revision);
+		$result = $gs->rev_map_get($desired_revision, $uuid);
 	} else {
 		my (undef, $rev, undef) = cmt_metadata($revision_or_hash);
 		$result = $rev;
@@ -1158,7 +1158,7 @@ sub working_head_info {
 		if (defined $url && defined $rev) {
 			next if $max{$url} and $max{$url} < $rev;
 			if (my $gs = Git::SVN->find_by_url($url)) {
-				my $c = $gs->rev_map_get($rev);
+				my $c = $gs->rev_map_get($rev, $uuid);
 				if ($c && $c eq $hash) {
 					close $fh; # break the pipe
 					return ($url, $rev, $uuid, $gs);
@@ -1417,6 +1417,16 @@ sub read_all_remotes {
 			my ($remote, $local_ref, $remote_ref) = ($1, $2, $3);
 			$local_ref =~ s{^/}{};
 			$r->{$remote}->{fetch}->{$local_ref} = $remote_ref;
+		} elsif (m!^(.+)\.usesvmprops=\s*(.*)\s*$!) {
+			my $svm;
+			eval {
+				my $section = "svn-remote.$1";
+				$svm = {
+					source => tmp_config('--get', "$section.svm-source"),
+					replace => tmp_config('--get', "$section.svm-replace"),
+				}
+			};
+			$r->{$1}->{svm} = $svm;
 		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
 			$r->{$1}->{url} = $2;
 		} elsif (m!^(.+)\.(branches|tags)=
@@ -1566,13 +1576,21 @@ sub find_by_url { # repos_root and, path are optional
 		}
 		my $p = $path;
 		my $rwr = rewrite_root({repo_id => $repo_id});
+		my $svm = $remotes->{$repo_id}->{svm}
+			if defined $remotes->{$repo_id}->{svm};
 		unless (defined $p) {
 			$p = $full_url;
 			my $z = $u;
+			my $prefix = '';
 			if ($rwr) {
 				$z = $rwr;
+			} elsif (defined $svm) {
+				$z = $svm->{source};
+				$prefix = $svm->{replace};
+				$prefix =~ s#^\Q$u\E(?:/|$)##;
+				$prefix =~ s#(.+?)/?$#$1/#;
 			}
-			$p =~ s#^\Q$z\E(?:/|$)## or next;
+			$p =~ s#^\Q$z\E(?:/|$)#$prefix# or next;
 		}
 		foreach my $f (keys %$fetch) {
 			next if $f ne $p;
-- 
1.5.5.1
