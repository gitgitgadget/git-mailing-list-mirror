From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 16/16] send-email: use Perl idioms in while loop
Date: Thu, 30 Sep 2010 13:43:09 +0000
Message-ID: <1285854189-10240-17-git-send-email-avarab@gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:45:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JRZ-0001Uu-An
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab0I3Noy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:44:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42011 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab0I3Nox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:44:53 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so1858034wyb.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cxDBoYmYlP54wBdLnUq2HZRMcwvcHYVZsIU27ITrvBc=;
        b=gyai/xSdjoJTE7Zm6wlVhPniuNKWyzggAp+Pw7wRsloChXCo413kMrI9GMwy/K1jjD
         jXmiWlREcVl3XQZHLZhLsHTnYvl48PsrD6cu+ZDJxZU0BsWjA+bfyyxstQTGiG5/v7sz
         XaWzrz1AmdeJmJ/p0X2gpYCQXxpgS/tpHxR7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=akYuz+UlXC7gpHGt8bicverkhyjQRyKPEJa1lQHSufb4LcHQhFrX8v3amvK2ylvJcF
         kEJ3M8vcUR7S2mac0iID3rYlNelTvndzc5ogvdNblKTunbn/NjWZqlkgwsMNuUrJEkS/
         wFraDVUJOoRdOgU/BTgu3/gOZ17hwe7cderkk=
Received: by 10.216.210.206 with SMTP id u56mr3013638weo.50.1285854289584;
        Thu, 30 Sep 2010 06:44:49 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157664>

Change `while(<$fh>) { my $c =3D $_' to `while(my $c =3D <$fh>) {', and
use `chomp $c' instead of `$c =3D~ s/\n$//g;', the two are equivalent i=
n
this case.

I've also changed the --cccmd test so that we test for the stripping
of whitespace at the beginning of the lines returned from the
--cccmd. I think we probably shouldn't do this, but it was there
already so I haven't changed the behavior.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl   |    5 ++---
 t/t9001-send-email.sh |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5a19d3d..445d2ec 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1252,10 +1252,9 @@ foreach my $t (@files) {
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
 		open my $fh, "$cc_cmd \Q$t\E |"
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
-		while(<$fh>) {
-			my $c =3D $_;
+		while(my $c =3D <$fh>) {
+			chomp $c;
 			$c =3D~ s/^\s*//g;
-			$c =3D~ s/\n$//g;
 			next if ($c eq $sender and $suppress_from);
 			push @cc, $c;
 			printf("(cc-cmd) Adding cc: %s from: '%s'\n",
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 6f67da4..99a16d5 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -204,7 +204,7 @@ test_expect_success $PREREQ 'Prompting works' '
 test_expect_success $PREREQ 'cccmd works' '
 	clean_fake_sendmail &&
 	cp $patches cccmd.patch &&
-	echo cccmd--cccmd@example.com >>cccmd.patch &&
+	echo "cccmd--  cccmd@example.com" >>cccmd.patch &&
 	{
 	  echo "#!$SHELL_PATH"
 	  echo sed -n -e s/^cccmd--//p \"\$1\"
--=20
1.7.3.159.g610493
