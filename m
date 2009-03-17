From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] disable post-checkout test on Cygwin
Date: Tue, 17 Mar 2009 17:26:43 +0100
Message-ID: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c3c5c5467be0465530818
Cc: layer <layer@known.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:36:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjcH9-0003W2-76
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbZCQQeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbZCQQeX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:34:23 -0400
Received: from mail-ew0-f168.google.com ([209.85.219.168]:53651 "EHLO
	mail-ew0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbZCQQeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:34:22 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2009 12:34:21 EDT
Received: by ewy12 with SMTP id 12so113355ewy.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=lSunWJfFn/W95DA4gcnc3GHm/+Ag7pRYzlfGxf5q3eM=;
        b=OipmR4a4Q1AFDWUXPe2/IRrVp1L0jeAgRdjoME5kUCa2n7Zc+nY7NEiaBvKhvgwkhi
         TDwmhTu8jHoeJLtLP2aq65a0uMfHzKYhbdGVP5UPs16Od48d8cpmOBgHOniH872qsSPp
         lv9KIUfp10gP9tmgbsD2RpyilQ8rzNOsjMaKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=PlpCJRpwo1zUzBfTwBy+s69pGdV2aBfPFWLYh5GYgmUqUqhN0xx2uPC9K9bNmPYwfJ
         eUKv+peJbVF/hKFlm4MlnofZEBWJh4YhY1BGRJKoX0AgI8BH2ea7RoShN4XJ4D/ea/Xv
         pbh0OG4tLeJUcrV7xdiTgazt1ND5cSXFBqAeU=
Received: by 10.210.36.8 with SMTP id j8mr118775ebj.83.1237307203282; Tue, 17 
	Mar 2009 09:26:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113496>

--0015174c3c5c5467be0465530818
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

It is broken because of the tricks we have to play with
lstat to get the bearable perfomance out of the call.
Sadly, it disables access to Cygwin's executable attribute,
which Windows filesystems do not have at all.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t5403-post-checkout-hook.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

2009/3/3 Jeff King <peff@peff.net>:
> +mkdir -p templates/hooks
> +cat >templates/hooks/post-checkout <<'EOF'
> +#!/bin/sh
> +echo $@ > $GIT_DIR/post-checkout.args
> +EOF
> +chmod +x templates/hooks/post-checkout
> +
> +test_expect_success 'post-checkout hook is triggered by clone' '
> + =C2=A0 =C2=A0 =C2=A0 git clone --template=3Dtemplates . clone3 &&
> + =C2=A0 =C2=A0 =C2=A0 test -f clone3/.git/post-checkout.args
> +'

This is broken on cygwin: the hook script won't be not marked executable
by copy_file, because the native Win32 stat(2) routines are used and
report the mode of source file as 0666.

--0015174c3c5c5467be0465530818
Content-Type: application/octet-stream; 
	name="0001-disable-post-checkout-test-on-Cygwin.diff"
Content-Disposition: attachment; 
	filename="0001-disable-post-checkout-test-on-Cygwin.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fsesorz30

RnJvbSBlNTM5NGVlNzEwNDYwZTI1MzY5YjQ3NTU3OTg5MzBhM2YxOTA4NWM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDE3IE1hciAyMDA5IDE3OjIyOjUzICswMTAwClN1YmplY3Q6IFtQQVRDSF0gZGlzYWJs
ZSBwb3N0LWNoZWNrb3V0IHRlc3Qgb24gQ3lnd2luCgpJdCBpcyBicm9rZW4gYmVjYXVzZSBvZiB0
aGUgdHJpY2tzIHdlIGhhdmUgdG8gcGxheSB3aXRoCmxzdGF0IHRvIGdldCB0aGUgYmVhcmFibGUg
cGVyZm9tYW5jZSBvdXQgb2YgdGhlIGNhbGwuClNhZGx5LCBpdCBkaXNhYmxlcyBhY2Nlc3MgdG8g
Q3lnd2luJ3MgZXhlY3V0YWJsZSBhdHRyaWJ1dGUsCndoaWNoIFdpbmRvd3MgZmlsZXN5c3RlbXMg
ZG8gbm90IGhhdmUgYXQgYWxsLgoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21s
QGdtYWlsLmNvbT4KLS0tCiB0L3Q1NDAzLXBvc3QtY2hlY2tvdXQtaG9vay5zaCB8ICAgIDIgKysK
IDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3QvdDU0MDMtcG9zdC1jaGVja291dC1ob29rLnNoIGIvdC90NTQwMy1wb3N0LWNoZWNr
b3V0LWhvb2suc2gKaW5kZXggNGZkYjQxOC4uNTg1OGI4NiAxMDA3NTUKLS0tIGEvdC90NTQwMy1w
b3N0LWNoZWNrb3V0LWhvb2suc2gKKysrIGIvdC90NTQwMy1wb3N0LWNoZWNrb3V0LWhvb2suc2gK
QEAgLTcxLDYgKzcxLDcgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAncG9zdC1jaGVja291dCByZWNl
aXZlcyB0aGUgcmlnaHQgYXJncyB3aGVuIG5vdCBzd2l0Y2hpbmcgYnIKICAgICAgICAgdGVzdCAk
b2xkID0gJG5ldyAtYSAkZmxhZyA9IDAKICcKIAoraWYgdGVzdCAiJChnaXQgY29uZmlnIC0tYm9v
bCBjb3JlLmZpbGVtb2RlKSIgPSB0cnVlOyB0aGVuCiBta2RpciAtcCB0ZW1wbGF0ZXMvaG9va3MK
IGNhdCA+dGVtcGxhdGVzL2hvb2tzL3Bvc3QtY2hlY2tvdXQgPDwnRU9GJwogIyEvYmluL3NoCkBA
IC04Miw1ICs4Myw2IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ3Bvc3QtY2hlY2tvdXQgaG9vayBp
cyB0cmlnZ2VyZWQgYnkgY2xvbmUnICcKIAlnaXQgY2xvbmUgLS10ZW1wbGF0ZT10ZW1wbGF0ZXMg
LiBjbG9uZTMgJiYKIAl0ZXN0IC1mIGNsb25lMy8uZ2l0L3Bvc3QtY2hlY2tvdXQuYXJncwogJwor
ZmkKIAogdGVzdF9kb25lCi0tIAoxLjYuMi4xNDIuZ2FmOGRiCgo=
--0015174c3c5c5467be0465530818--
