From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5] gitweb: Streamify patch output in git_commitdiff
Date: Thu, 24 Aug 2006 19:34:36 +0200
Message-ID: <200608241934.36684.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 24 19:46:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGJHE-00011m-MX
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 19:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWHXRp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 Aug 2006 13:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWHXRp5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 13:45:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29778 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030201AbWHXRp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 13:45:57 -0400
Received: by nf-out-0910.google.com with SMTP id o25so638006nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 10:45:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gjXt8Y6GOK9+Zy/EgYdYzy2DF+ZKuP8MRsXBF3QBA4RQVx8YmcgXH3F9HuTtt9IbRSSH2DNz2Hp9rC1e4XjIYY+FrHyOkIKjbTcxxk/4NnYzq3+OXpu1MmmdWFmDVMJZq98+wDkB4yur2lmlPvRI8UvukhzEsHxUVFW9+xiUzN4=
Received: by 10.49.43.2 with SMTP id v2mr4008447nfj;
        Thu, 24 Aug 2006 10:45:55 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p20sm4867170nfc.2006.08.24.10.45.54;
        Thu, 24 Aug 2006 10:45:54 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25964>

Change output of patch(set) in git_commitdiff from slurping whole diff
in @patchset array before processing, to passing file descriptor to
git_patchset_body.

Advantages: faster, incremental output, smaller memory footprint.
Disadvantages: cannot react when there is error during closing file
descriptor.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:
> I do not know we would want to slurp the entier diff in an
> array before processing. =A0Is this easy to streamify by passing
> an pipe fd to the formatting sub?

This patch adresses that.

 gitweb/gitweb.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1d3d9df..d72b19a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1539,7 +1539,7 @@ sub git_difftree_body {
 }
=20
 sub git_patchset_body {
-	my ($patchset, $difftree, $hash, $hash_parent) =3D @_;
+	my ($fd, $difftree, $hash, $hash_parent) =3D @_;
=20
 	my $patch_idx =3D 0;
 	my $in_header =3D 0;
@@ -1548,7 +1548,9 @@ sub git_patchset_body {
=20
 	print "<div class=3D\"patchset\">\n";
=20
-	LINE: foreach my $patch_line (@$patchset) {
+	LINE:
+	while (my $patch_line =3D <$fd>) {
+		chomp $patch_line;
=20
 		if ($patch_line =3D~ m/^diff /) { # "git diff" header
 			# beginning of patch (in patchset)
@@ -2727,7 +2729,6 @@ sub git_commitdiff {
 	# read commitdiff
 	my $fd;
 	my @difftree;
-	my @patchset;
 	if ($format eq 'html') {
 		open $fd, "-|", $GIT, "diff-tree", '-r', '-M', '-C',
 			"--patch-with-raw", "--full-index", $hash_parent, $hash
@@ -2738,13 +2739,11 @@ sub git_commitdiff {
 			last unless $line;
 			push @difftree, $line;
 		}
-		@patchset =3D map { chomp; $_ } <$fd>;
=20
-		close $fd
-			or die_error(undef, "Reading git-diff-tree failed");
 	} elsif ($format eq 'plain') {
 		open $fd, "-|", $GIT, "diff-tree", '-r', '-p', '-B', $hash_parent, $=
hash
 			or die_error(undef, "Open git-diff-tree failed");
+
 	} else {
 		die_error(undef, "Unknown commitdiff format");
 	}
@@ -2806,7 +2805,8 @@ TEXT
 		#git_difftree_body(\@difftree, $hash, $hash_parent);
 		#print "<br/>\n";
=20
-		git_patchset_body(\@patchset, \@difftree, $hash, $hash_parent);
+		git_patchset_body($fd, \@difftree, $hash, $hash_parent);
+		close $fd;
=20
 		print "</div>\n"; # class=3D"page_body"
 		git_footer_html();
--=20
1.4.1.1
