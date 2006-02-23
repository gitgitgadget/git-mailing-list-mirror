From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: PATCH: simplify calls to git programs in git-fmt-merge-msg
Date: Thu, 23 Feb 2006 11:26:46 +0100
Message-ID: <81b0412b0602230226j12e88682h303d466a273bec09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_23711_11338765.1140690406121"
Cc: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 23 11:27:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCDgb-0007Bd-UP
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 11:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWBWK0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 05:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWBWK0s
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 05:26:48 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:28795 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbWBWK0r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 05:26:47 -0500
Received: by nproxy.gmail.com with SMTP id d4so9795nfe
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 02:26:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=KcdC1mRghD3f5yawJOoe3cOlw6B4I1nHKTE0DcXX8Vg0vFEr8k1MpQVQKNxH/m872JddylJY1dBKgBWbxP4HS8U1GEZA3b3uJcuKSjeNdsSjxAhL8JA1Cc0os2T5LMq438GerTrFrh5VUAdey9zrVlVWzCuGvwkzIztoCwOg1nQ=
Received: by 10.48.47.3 with SMTP id u3mr2288005nfu;
        Thu, 23 Feb 2006 02:26:46 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 02:26:46 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16639>

------=_Part_23711_11338765.1140690406121
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It also makes it work on ActiveState Perl.

------=_Part_23711_11338765.1140690406121
Content-Type: text/plain; 
	name=0001-fix-git-fmt-merge-msg.perl-for-activestate-perl.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek0xia37
Content-Disposition: attachment; filename="0001-fix-git-fmt-merge-msg.perl-for-activestate-perl.txt"

---

 git-fmt-merge-msg.perl |   31 +++++--------------------------
 1 files changed, 5 insertions(+), 26 deletions(-)

1c0dd861fa32017cf7bc4226bfa54d390a3fb91e
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index c13af48..dae383f 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -28,28 +28,13 @@ sub andjoin {
 }
 
 sub repoconfig {
-	my $val;
-	eval {
-		my $pid = open(my $fh, '-|');
-		if (!$pid) {
-			exec('git-repo-config', '--get', 'merge.summary');
-		}
-		($val) = <$fh>;
-		close $fh;
-	};
+	my ($val) = qx{git-repo-config --get merge.summary};
 	return $val;
 }
 
 sub current_branch {
-	my $fh;
-	my $pid = open($fh, '-|');
-	die "$!" unless defined $pid;
-	if (!$pid) {
-	    exec('git-symbolic-ref', 'HEAD') or die "$!";
-	}
-	my ($bra) = <$fh>;
+	my ($bra) = qx{git-symbolic-ref HEAD};
 	chomp($bra);
-	close $fh or die "$!";
 	$bra =~ s|^refs/heads/||;
 	if ($bra ne 'master') {
 		$bra = " into $bra";
@@ -61,18 +46,12 @@ sub current_branch {
 
 sub shortlog {
 	my ($tip) = @_;
-	my ($fh, @result);
-	my $pid = open($fh, '-|');
-	die "$!" unless defined $pid;
-	if (!$pid) {
-	    exec('git-log', '--topo-order',
-		 '--pretty=oneline', $tip, '^HEAD') or die "$!";
-	}
-	while (<$fh>) {
+	my @result;
+	foreach ( qx{git-log --topo-order --pretty=oneline $tip ^HEAD} ) {
 		s/^[0-9a-f]{40}\s+//;
 		push @result, $_;
 	}
-	close $fh or die "$!";
+	die "git-log failed\n" if $?;
 	return @result;
 }
 
-- 
1.2.3.g6ae0e


------=_Part_23711_11338765.1140690406121--
