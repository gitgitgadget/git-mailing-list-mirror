From: Marcus Griep <marcus@griep.us>
Subject: [PATCH 1/2] Fix multi-glob assertion in git-svn
Date: Wed, 06 Aug 2008 15:55:42 -0400
Message-ID: <489A01BE.7080201@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 21:57:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQp7y-00080J-PL
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 21:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbYHFTzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 15:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYHFTzv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 15:55:51 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:46470 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbYHFTzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 15:55:50 -0400
Received: by an-out-0708.google.com with SMTP id d40so13275and.103
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 12:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:x-enigmail-version
         :content-type:content-transfer-encoding:sender;
        bh=IjH7QFDRu0r8txeKj0dlRIZVvnOzUVA2dGCW0swB2c4=;
        b=LM8gkn1oKLoLrC3wDwEDYn8gybBkvLaX/WL1MYpLKAQiinBDh0s3xPHUm/GPndq0Dv
         N36YegOuMLkxk+Y/cvaqqnWu5Ae19iW6Cz1El83NIj1kq0ozvqENWe6yhZKhAkz4FArI
         M8a1MRHZ0QrSa4MtMHJKVpGnb1eusUrgXXDoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=pGp/cOa1S0GA1BKtqm4mMKrCjlY6ToCJyqsSKuIi/JGRrKmKiTHettWxecWwGWQnzc
         DaknioWTOwSoh3dtamQPWcQv7aH3/L1jpiE8NPrKhMakg5U9+oW3UEEdzfUYP9GPNAkD
         HCgXjcnyXS1b1+6cNGRnS5yndVQM5rQqbXNM0=
Received: by 10.100.8.4 with SMTP id 4mr976132anh.38.1218052549185;
        Wed, 06 Aug 2008 12:55:49 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 11sm1442829wrl.7.2008.08.06.12.55.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 12:55:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91534>

=46rom 81b736f4a815ebded8978e63f2cba393528a57e0 Mon Sep 17 00:00:00 200=
1
=46rom: Marcus Griep <marcus@griep.us>
Date: Tue, 5 Aug 2008 15:45:05 -0400
Subject: [PATCH 1/2] Fix multi-glob assertion in git-svn

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 git-svn.perl            |    5 +++--
 t/t9108-git-svn-glob.sh |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cf6dbbc..95d11c2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4904,14 +4904,15 @@ sub new {
        my ($class, $glob) =3D @_;
        my $re =3D $glob;
        $re =3D~ s!/+$!!g; # no need for trailing slashes
-       my $nr =3D ($re =3D~ s!^(.*)\*(.*)$!\(\[^/\]+\)!g);
-       my ($left, $right) =3D ($1, $2);
+       my $nr =3D $re =3D~ tr/*/*/;
        if ($nr > 1) {
                die "Only one '*' wildcard expansion ",
                    "is supported (got $nr): '$glob'\n";
        } elsif ($nr =3D=3D 0) {
                die "One '*' is needed for glob: '$glob'\n";
        }
+       $re =3D~ s!^(.*)\*(.*)$!\(\[^/\]+\)!g;
+       my ($left, $right) =3D ($1, $2);
        $re =3D quotemeta($left) . $re . quotemeta($right);
        if (length $left && !($left =3D~ s!/+$!!g)) {
                die "Missing trailing '/' on left side of: '$glob' ($le=
ft)\n";
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index f6f71d0..ef6d88e 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -83,4 +83,23 @@ test_expect_success 'test left-hand-side only globbi=
ng' '
        cmp expect.two output.two
        '

+echo "Only one '*' wildcard expansion is supported (got 2): 'branches/=
*/*'" > expect.three
+echo "" >> expect.three
+
+test_expect_success 'test disallow multi-globs' '
+       git config --add svn-remote.three.url "$svnrepo" &&
+       git config --add svn-remote.three.fetch trunk:refs/remotes/thre=
e/trunk &&
+       git config --add svn-remote.three.branches \
+                        "branches/*/*:refs/remotes/three/branches/*" &=
&
+       git config --add svn-remote.three.tags \
+                        "tags/*/*:refs/remotes/three/tags/*" &&
+       cd tmp &&
+               echo "try try" >> tags/end/src/b/readme &&
+               poke tags/end/src/b/readme &&
+               svn commit -m "try to try"
+               cd .. &&
+       test_must_fail git-svn fetch three &> stderr.three &&
+       cmp expect.three stderr.three
+       '
+
 test_done
--
1.5.4.3

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
