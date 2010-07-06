From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 4/5] git-cvsserver: break the loop after successful hit
Date: Tue, 6 Jul 2010 19:38:09 +0200
Message-ID: <AANLkTik0pMkYDHZD9jgzn3OaGUdyeiFwAv7o3OTUmEvO@mail.gmail.com>
References: <-1324832183078898154@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?B?TOFzemzzIMFTSElO?= <laszlo.ashin@neti.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 19:38:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWC6Q-0003uK-Kg
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab0GFRic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 13:38:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39097 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab0GFRib convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 13:38:31 -0400
Received: by bwz1 with SMTP id 1so3686897bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hSnNHoWKx4stzTmGDgy5Xv7Tlaxq+d770D8suVOJcfw=;
        b=E/xPheVKDOLa0pJHbc1tpUJiyAu6H8meruu7oz01P03Z9mnD5n5rChLGxPCt3IwtFR
         o8kn3HzM2kMtce2JoMkrg0Oo8/h6SKKij4IcQivaUGMai1WJXgcaAx1v+cd/vpK8ICPj
         NZRHOAYF/7iDOAFFLlJjjHUvyF7cXjjKZ4KCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bld0jphC8U4LzBe8weG5fIw04ttXo3v2ZMOcLFK+hVjEJIjjSbXxO2e++dS6EZVw7K
         IjSB1NrIF3UZbPc5OYWVakC5mvCruJoyFmUMLoxOQ41Mrg6QL4pirn+0uBwxJhRDkg2y
         Zr9SwQH38cRbmm/KOw0MvdocgWuXm5gKlEp4I=
Received: by 10.204.82.130 with SMTP id b2mr4057416bkl.12.1278437909280; Tue, 
	06 Jul 2010 10:38:29 -0700 (PDT)
Received: by 10.204.79.19 with HTTP; Tue, 6 Jul 2010 10:38:09 -0700 (PDT)
In-Reply-To: <-1324832183078898154@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150377>

No need to check for more lines of the authentication database after fo=
und a
matching one.
---
=A0git-cvsserver.perl | =A0 =A09 ++++-----
=A01 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index e842d77..cd461ac 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -248,11 +248,10 @@ if ($state->{method} eq 'pserver') {
=A0 =A0 =A0 =A0 my $auth_ok;
=A0 =A0 =A0 =A0 open my $passwd, "<", $authdb or die $!;
=A0 =A0 =A0 =A0 while (<$passwd>) {
- =A0 =A0 =A0 =A0 =A0 =A0if (m{^\Q$user\E:(.*)}) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (crypt($user, $password) eq $1) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$auth_ok =3D 1;
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
- =A0 =A0 =A0 =A0 =A0 =A0};
+ =A0 =A0 =A0 =A0 =A0 =A0if (m{^\Q$user\E:(.*)} && crypt($user, $passwo=
rd) eq $1) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$auth_ok =3D 1;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0last;
+ =A0 =A0 =A0 =A0 =A0 =A0}
=A0 =A0 =A0 =A0 }
=A0 =A0 =A0 =A0 close $passwd;

--
1.7.0.4
