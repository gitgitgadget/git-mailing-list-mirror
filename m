From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] send-email: use catfile() to concatenate files
Date: Tue, 14 Sep 2010 19:02:24 +0000
Message-ID: <1284490944-16964-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 21:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovam7-0006UG-5L
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 21:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab0INTCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 15:02:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62823 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0INTCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 15:02:33 -0400
Received: by wwd20 with SMTP id 20so70747wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=zN3bi738YRN957i4BH6bhVdzjjESTFM1LEDgV+eFE5Q=;
        b=lscawRONSPH5c1virx9DY9i8qrK+e+/s1Gi1vLSuLdrwNHMBNT2MoUCe698O2/sCV9
         TRFWKEeQQfSjCJ3UIWowNfn86dCyRUbR2RRuWUvKl9uf4IeK+k4+3eGFZDZE4t3dEeLx
         O4/Jsn0nDk0Oehi4QSp+eukdRLWXJiMzp+9LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=flsGWSn7IMak2CG37MNMT8SkXh6l6Bw1ZJR9YRP4q7yKBedYRL20EdsEK7FxWhcmsn
         QZfJHIAIKofS9pcEvJtLI2QH9cO1w/Tj0/DZzCUaC52jrd3YZtbVKtUTJGAVZ2Vz+WC1
         w4wqTw+4XN0gb5qJH2095ypyyzObSuJ0Cs0hs=
Received: by 10.216.236.42 with SMTP id v42mr4290034weq.10.1284490951783;
        Tue, 14 Sep 2010 12:02:31 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id n40sm381906weq.5.2010.09.14.12.02.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 12:02:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.5.g9c993
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156203>

Change send-email to use Perl's catfile() function instead of
"$dir/$file". If send-email is given a $dir that ends with a / we'll
end up printing a double slashed path like "dir//mtfnpy.patch".

This doesn't cause any problems since Perl's IO layer will handle it,
but it looks ugly.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6dab3bf..7f702e3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -24,6 +24,7 @@ use Text::ParseWords;
 use Data::Dumper;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
+use File::Spec::Functions qw(catfile);
 use Error qw(:try);
 use Git;
=20
@@ -511,7 +512,7 @@ while (defined(my $f =3D shift @ARGV)) {
 		opendir(DH,$f)
 			or die "Failed to opendir $f: $!";
=20
-		push @files, grep { -f $_ } map { +$f . "/" . $_ }
+		push @files, grep { -f $_ } map { catfile($f, $_) }
 				sort readdir(DH);
 		closedir(DH);
 	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
--=20
1.7.3.rc1.234.g8dc15
