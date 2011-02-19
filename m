From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/3] gitweb/gitweb.perl: don't call S_ISREG() with undef
Date: Sat, 19 Feb 2011 15:27:42 +0000
Message-ID: <1298129262-10468-4-git-send-email-avarab@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 16:28:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqojE-0006EQ-Nj
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 16:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607Ab1BSP2H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 10:28:07 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34998 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577Ab1BSP2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 10:28:02 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1925810ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xcmu/5L/93YiIBmkQXxGB5b9UtQR08nhpD30YirPNG8=;
        b=hJC2OcwwIk7DoYlIXOV/gNlFE3RMgwzTcUq6rV+OAHnd6se+ChQgh8uDktRL+ZFuTw
         7Y1lxE6Jycl4QMlgFtV7uOB49ck7Bo/WSCi1ACLE4684N/hIz+4r8zPhu9lyNVLFEg2J
         fCCs2eBdB2QCbGO10uUESHxuFxd0jyBac4Sqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RUuA+XM0QUHhi6uE42e4hY6YZxXy3Wy6GWZ19/vSv//r5zcdyuFsHjSfA+5pDNCzJx
         U2owHX6d+QynKpw1dg1S8rTwNy0DNZzli8YsRopXNKtV2loSJZybA5huFYt5hcTkz5xT
         eGMcis7sQDZUlmAbJ+6GobsOlFLieH8tdIdcc=
Received: by 10.14.22.80 with SMTP id s56mr2234642ees.6.1298129282227;
        Sat, 19 Feb 2011 07:28:02 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id q52sm3006362eei.15.2011.02.19.07.28.01
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 07:28:01 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298124654-12051-1-git-send-email-avarab@gmail.com>
In-Reply-To: <1298124654-12051-1-git-send-email-avarab@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167288>

Change S_ISREG($to_mode_oct) to S_ISREG($from_mode_oct) in the branch
that handles from modes, not to modes. This logic appears to have been
caused by copy/paste programming by Jakub Narebski in e8e41a93. It
would be better to rewrite this code not to be duplicated, but I
haven't done so.

This issue caused a failing test on perl 5.13.9, which has a warning
that turned this up:

     gitweb.perl: Use of uninitialized value in subroutine entry at /ho=
me/avar/g/git/t/../gitweb/gitweb.perl line 4415.

Which caused the Git test suite to fail on this test:

    ./t9500-gitweb-standalone-no-errors.sh             (Wstat: 256 Test=
s: 90 Failed: 84)
      Failed tests:  1-8, 10-36, 38-45, 47-48, 50-88
      Non-zero exit status: 1

Reported-by: perl 5.13.9
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b02372c..1b9369d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4412,7 +4412,7 @@ sub git_difftree_body {
 		}
 		if ($diff->{'from_mode'} ne ('0' x 6)) {
 			$from_mode_oct =3D oct $diff->{'from_mode'};
-			if (S_ISREG($to_mode_oct)) { # only for regular file
+			if (S_ISREG($from_mode_oct)) { # only for regular file
 				$from_mode_str =3D sprintf("%04o", $from_mode_oct & 0777); # permi=
ssion bits
 			}
 			$from_file_type =3D file_type($diff->{'from_mode'});
--=20
1.7.2.3
