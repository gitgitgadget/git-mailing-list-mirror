From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 3/5] git-cvsserver: take care of empty passwords
Date: Tue, 6 Jul 2010 19:37:16 +0200
Message-ID: <AANLkTinpjbOStczVo7NaPlxqyAh_32kLy0kWKc_AsLiI@mail.gmail.com>
References: <3594077658746039911@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?B?TOFzemzzIMFTSElO?= <laszlo.ashin@neti.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 19:37:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWC5h-0003ZR-LJ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab0GFRhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 13:37:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62195 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0GFRhr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 13:37:47 -0400
Received: by bwz1 with SMTP id 1so3686342bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6DXgYpFeFCH5+V4Vk4psqguTm/Jm5ya+2QQSUH0xjoc=;
        b=u6ziHNs+zzdYRYNUmyi8SKS6Ea8E/bYmrxAzhXaec1pr1LFTY+8DLFHFgsyZwTvcmy
         5ujyPsl4kCd1Gmv6b1djtxrn7RHrgVBBxFC0JNq1kNWXifFNlIIrMtiSlbcbLdcMI1dr
         9cKNq759C2ZVlrZ0kDBR3vY0u4iZfZ/INDubc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NjZjhOmTBMoW6iWS841V51aFtBxGw/wVk1ZynOthmjhkuKTrGUNbrN5gc2nGnuZevX
         TZUqel3xN7upWSwDonYhXHPxYkbhF7R3/DBrR+kcJLca/F9N6nR3333WDAqAax6bksBJ
         lJIlyT0xEGFDHLxHXeCDwL/ZRrytm9cbs9xSA=
Received: by 10.204.51.3 with SMTP id b3mr2213289bkg.101.1278437856598; Tue, 
	06 Jul 2010 10:37:36 -0700 (PDT)
Received: by 10.204.79.19 with HTTP; Tue, 6 Jul 2010 10:37:16 -0700 (PDT)
In-Reply-To: <3594077658746039911@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150376>

Do not try to descramble them.
---
=A0git-cvsserver.perl | =A0 =A06 +++++-
=A01 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 10dcc65..e842d77 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -241,11 +241,15 @@ if ($state->{method} eq 'pserver') {
=A0 =A0 =A0 =A0 =A0 =A0 exit 1;
=A0 =A0 =A0 =A0 }

+ =A0 =A0 =A0 =A0if (length($password) > 0) {
+ =A0 =A0 =A0 =A0 =A0 =A0$password =3D descramble($password);
+ =A0 =A0 =A0 =A0}
+
=A0 =A0 =A0 =A0 my $auth_ok;
=A0 =A0 =A0 =A0 open my $passwd, "<", $authdb or die $!;
=A0 =A0 =A0 =A0 while (<$passwd>) {
=A0 =A0 =A0 =A0 =A0 =A0 if (m{^\Q$user\E:(.*)}) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (crypt($user, descramble($password)=
) eq $1) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (crypt($user, $password) eq $1) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $auth_ok =3D 1;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
=A0 =A0 =A0 =A0 =A0 =A0 };
--
1.7.0.4
