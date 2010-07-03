From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 4/4] git-cvsserver: break from loop after a successful hit
Date: Sat, 3 Jul 2010 23:24:26 +0200
Message-ID: <AANLkTimPJPv0RieGQcXyJULFDcapVM74JCXcM9LU8CEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 23:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVACi-0008TJ-JG
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 23:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab0GCVYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 17:24:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42521 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab0GCVYr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 17:24:47 -0400
Received: by fxm14 with SMTP id 14so2997420fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=TRIu46iB1OTujtc1npCElD3R+6xEl45cB1z8Ui4BiYA=;
        b=iiapjGNRHKyhzS2vBBhd1AwWDRZ5+qyhd4f+Ydk9n59Zc1aAOkKno6G6Y7QEtPLdoZ
         6MERYoyryeVjz0vaxiGyzDcRcmHMtGZfo31CuMkxL0nXVqhdlpVpS3FbNbBkhD/29P1o
         CZ0+4j4C6k5aCeTJy8dltxjVa5kkAcpkDgC7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=rRxaSAV3Z/8BdyqmNvcq4kbP+GSqQFdv69A6oQBOra/uJGiaieGXhpMSOFAKv7bAzo
         XFvWmS1++BcwwzEDngWBD0jtlGdIYniibUZmlnURX+JAbHeXNjuQz8sx8AWJaaeGKgUx
         DUuGTw7JP4C+jkgWzkAQLPSYPP5YXvxKwZQKE=
Received: by 10.103.218.4 with SMTP id v4mr61805muq.95.1278192286115; Sat, 03 
	Jul 2010 14:24:46 -0700 (PDT)
Received: by 10.103.225.9 with HTTP; Sat, 3 Jul 2010 14:24:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150206>

No need to check for more lines of the authentication database after fo=
und a
matching line.
---
=A0git-cvsserver.perl | =A0 =A09 ++++-----
=A01 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 01c5b21..fa2a11e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -242,11 +242,10 @@ if ($state->{method} eq 'pserver') {
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
1.7.2.rc1.dirty
