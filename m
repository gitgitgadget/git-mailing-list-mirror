From: Greg KH <gregkh@linuxfoundation.org>
Subject: Bug in 'git am' when applying a broken patch
Date: Mon, 1 Jun 2015 09:17:59 +0900
Message-ID: <20150601001759.GA3934@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Cc: Gaston Gonzalez <gascoar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 02:18:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzDQl-00039T-3n
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 02:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbbFAASJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 20:18:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46829 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbFAASH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 20:18:07 -0400
Received: from localhost (p2208095-ipngn17401marunouchi.tokyo.ocn.ne.jp [153.224.29.95])
	by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4269A04;
	Mon,  1 Jun 2015 00:18:05 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270370>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I received the patch attached below as part of a submission against the
Linux kernel tree.  The patch seems to have been hand-edited, and is not
correct, and patch verifies this as being a problem:

$ patch -p1 --dry-run < bad_patch.mbox 
checking file drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
patch: **** malformed patch at line 133:                skb_put(skb, sizeof(struct ieee80211_authentication));

But git will actually apply it:
$ git am -s bad_patch.mbox
Applying: staging: rtl8192u: ieee80211: Fix sparse endianness warnings

But, there's nothing in the patch at all except the commit message:

$ git show HEAD
commit f6643dfef5b701db86f23be9ce6fb5b3bafe76b6
Author: Gaston Gonzalez <gascoar@gmail.com>
Date:   Sun May 31 12:17:48 2015 -0300

    staging: rtl8192u: ieee80211: Fix sparse endianness warnings
    
    Fix the following sparse warnings:
    
    drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32: warning: incorrect type in assignment (different base types)
    drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32:    expected restricted __le16 [usertype] frame_ctl
    drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32:    got int
    drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50: warning: invalid assignment: |=
    drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50:    left side has type restricted __le16
    drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:664:50:    right side has type int
    
    Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

$ git diff HEAD^
$ 

Any ideas what is going on here?  Shouldn't 'git am' have failed?

Oh, I'm using git version 2.4.2 right now.

I've asked Gaston for the original patch to verify before he hand-edited
it, to verify that git wasn't creating something wrong here, as well.

thanks,

greg k-h

--C7zPtVaVf+AK4Oqc
Content-Type: application/mbox
Content-Disposition: attachment; filename="bad_patch.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom driverdev-devel-bounces@linuxdriverproject.org Mon Jun  1 00:30:02 2=
015=0AReturn-Path: <driverdev-devel-bounces@linuxdriverproject.org>=0ADeliv=
ered-To: unknown=0AReceived: from compute3.internal (compute3.nyi.internal =
[10.202.2.43])=0A	 by sloti33d1t02 (Cyrus 3.0-git-fastmail-11446) with LMTP=
A;=0A	 Sun, 31 May 2015 11:30:02 -0400=0AX-Sieve: CMU Sieve 2.4=0AX-Spam-sc=
ore: 0.0=0AX-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_M=
ED -2.3, LANGUAGES en,=0A  BAYES_USED global, SA_VERSION 3.3.2=0AX-Spam-sou=
rce: IP=3D'140.211.166.137', Host=3D'fraxinus.osuosl.org', Country=3D'US',=
=0A  FromHeader=3D'com', MailFrom=3D'org'=0AX-Spam-charsets: plain=3D'us-as=
cii'=0AX-Resolved-to: greg@kroah.com=0AX-Delivered-to: greg@kroah.com=0AX-M=
ail-from: driverdev-devel-bounces@linuxdriverproject.org=0AReceived: from m=
x6 ([10.202.2.205])=0A  by compute3.internal (LMTPProxy); Sun, 31 May 2015 =
11:30:02 -0400=0AReceived: from mx6.messagingengine.com (localhost [127.0.0=
=2E1])=0A	by mx6.nyi.internal (Postfix) with ESMTP id 58719B20D6A=0A	for <g=
reg@kroah.com>; Sun, 31 May 2015 11:30:02 -0400 (EDT)=0AReceived: from mx6.=
nyi.internal (localhost [127.0.0.1])=0A    by mx6.messagingengine.com (Auth=
entication Milter) with ESMTP=0A    id AA3DB0F7DF1.0F1E7B20D36;=0A    Sun, =
31 May 2015 11:30:02 -0400=0AAuthentication-Results: mx6.messagingengine.co=
m;=0A    dkim=3Dfail (message has been altered; 2048-bit rsa key) header.d=
=3Dgmail.com header.i=3D@gmail.com header.b=3Dwe0mShpD;=0A    dmarc=3Dfail =
(p=3Dnone;has-list-id=3Dyes) header.from=3Dgmail.com;=0A    spf=3Dnone smtp=
=2Emailfrom=3Ddriverdev-devel-bounces@linuxdriverproject.org smtp.helo=3Dfr=
axinus.osuosl.org=0AReceived-SPF: none (linuxdriverproject.org: No applicab=
le sender policy available) receiver=3Dmx6.messagingengine.com; identity=3D=
mailfrom; envelope-from=3D"driverdev-devel-bounces@linuxdriverproject.org";=
 helo=3Dfraxinus.osuosl.org; client-ip=3D140.211.166.137=0AReceived: from f=
raxinus.osuosl.org (fraxinus.osuosl.org [140.211.166.137])=0A	by mx6.messag=
ingengine.com (Postfix) with ESMTP id 0F1E7B20D36=0A	for <greg@kroah.com>; =
Sun, 31 May 2015 11:30:02 -0400 (EDT)=0AReceived: from localhost (localhost=
 [127.0.0.1])=0A	by fraxinus.osuosl.org (Postfix) with ESMTP id 4AC1CA303B;=
=0A	Sun, 31 May 2015 15:30:00 +0000 (UTC)=0AX-Virus-Scanned: amavisd-new at=
 osuosl.org=0AReceived: from fraxinus.osuosl.org ([127.0.0.1])=0A	by localh=
ost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)=0A	with ESMTP id aS=
ISdbAcYKGt; Sun, 31 May 2015 15:29:59 +0000 (UTC)=0AReceived: from ash.osuo=
sl.org (ash.osuosl.org [140.211.166.34])=0A	by fraxinus.osuosl.org (Postfix=
) with ESMTP id 1D8B5A2FDC;=0A	Sun, 31 May 2015 15:29:58 +0000 (UTC)=0AX-Or=
iginal-To: devel@linuxdriverproject.org=0AX-Remote-Delivered-To: driverdev-=
devel@osuosl.org=0AReceived: from whitealder.osuosl.org (whitealder.osuosl.=
org [140.211.166.138])=0A by ash.osuosl.org (Postfix) with ESMTP id 9F62E1C=
0538=0A for <devel@linuxdriverproject.org>; Sun, 31 May 2015 15:29:56 +0000=
 (UTC)=0AReceived: from localhost (localhost [127.0.0.1])=0A by whitealder.=
osuosl.org (Postfix) with ESMTP id 98EE69175C=0A for <devel@linuxdriverproj=
ect.org>; Sun, 31 May 2015 15:29:56 +0000 (UTC)=0AX-Virus-Scanned: amavisd-=
new at osuosl.org=0AReceived: from whitealder.osuosl.org ([127.0.0.1])=0A b=
y localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)=0A with ESM=
TP id sJNyjCklO3b7 for <devel@linuxdriverproject.org>;=0A Sun, 31 May 2015 =
15:29:56 +0000 (UTC)=0AX-Greylist: domain auto-whitelisted by SQLgrey-1.7.6=
=0AReceived: from mail-vn0-f54.google.com (mail-vn0-f54.google.com=0A [209.=
85.216.54])=0A by whitealder.osuosl.org (Postfix) with ESMTPS id C79BB9172D=
=0A for <devel@driverdev.osuosl.org>; Sun, 31 May 2015 15:29:55 +0000 (UTC)=
=0AReceived: by vnbg129 with SMTP id g129so13395812vnb.9=0A for <devel@driv=
erdev.osuosl.org>; Sun, 31 May 2015 08:29:55 -0700 (PDT)=0ADKIM-Signature: =
v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dgmail.com; s=3D20120113;=0A=
 h=3Dfrom:to:cc:subject:date:message-id;=0A bh=3D2RMZc9bnU2CTbMbj5bzGKmfXje=
fvCUcplVVUMzI5lNA=3D;=0A b=3Dwe0mShpDBvfGpeRzXwL3qFT0zdQ32Q0E30wYyK9Qqs6Hum=
bj0oqhaeFYpKz//yDrZJ=0A KlMfbQ6+EAAdUXzNe/nHTjkZd3Wu8r0QSZ0Nuu620g53r6mKdei=
MBbuzaQ8ksHfpi7HB=0A U+NKuKaAlaT8J+TzLsmw3kuUsHjkGvHcAa+BmErRIg0k1ncngJrtlW=
Fm8v+P9bsKFMXy=0A ZFdQEerEjzeCgDB523JijTHfVCQWfYIDY2TflCIgGBGRJjhZ6OrfdKeLi=
AaP0nBQq9Zm=0A K74LuBsq0Kv52Z9Lv8Tjh0G9j/EGVheqhrRLfxB1jf7r10B6Aebz2hdTRT3T=
qQrUjV8o=0A VY1g=3D=3D=0AX-Received: by 10.52.38.97 with SMTP id f1mr207995=
04vdk.25.1433086194953;=0A Sun, 31 May 2015 08:29:54 -0700 (PDT)=0AReceived=
: from debianG.lan ([190.188.245.61])=0A by mx.google.com with ESMTPSA id a=
j20sm15552447vdc.21.2015.05.31.08.29.52=0A (version=3DTLSv1.2 cipher=3DECDH=
E-RSA-AES128-SHA bits=3D128/128);=0A Sun, 31 May 2015 08:29:54 -0700 (PDT)=
=0AFrom: Gaston Gonzalez <gascoar@gmail.com>=0ATo: gregkh@linuxfoundation.o=
rg, cristina.opriceana@gmail.com,=0A hamohammed.sa@gmail.com, gdonald@gmail=
=2Ecom, mahfouz.saif.elyazal@gmail.com,=0A paul.gortmaker@windriver.com=0AS=
ubject: [PATCH RESEND] staging: rtl8192u: ieee80211: Fix sparse endianness=
=0A warnings=0ADate: Sun, 31 May 2015 12:17:48 -0300=0AMessage-Id: <1433085=
468-20879-1-git-send-email-gascoar@gmail.com>=0AX-Mailer: git-send-email 2.=
1.4=0ACc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org=0AX-Been=
There: driverdev-devel@linuxdriverproject.org=0AX-Mailman-Version: 2.1.18-1=
=0APrecedence: list=0AList-Id: Linux Driver Project Developer List=0A <driv=
erdev-devel.linuxdriverproject.org>=0AList-Unsubscribe: <http://driverdev.l=
inuxdriverproject.org/mailman/options/driverdev-devel>, =0A <mailto:driverd=
ev-devel-request@linuxdriverproject.org?subject=3Dunsubscribe>=0AList-Archi=
ve: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>=0A=
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>=0AList-Help: <ma=
ilto:driverdev-devel-request@linuxdriverproject.org?subject=3Dhelp>=0AList-=
Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driver=
dev-devel>, =0A <mailto:driverdev-devel-request@linuxdriverproject.org?subj=
ect=3Dsubscribe>=0AMIME-Version: 1.0=0AContent-Type: text/plain; charset=3D=
"us-ascii"=0AContent-Transfer-Encoding: 7bit=0AErrors-To: driverdev-devel-b=
ounces@linuxdriverproject.org=0ASender: "devel" <driverdev-devel-bounces@li=
nuxdriverproject.org>=0AX-getmail-retrieved-from-mailbox: INBOX=0AStatus: R=
O=0AX-Status: A=0AContent-Length: 1776=0ALines: 38=0A=0AFix the following s=
parse warnings:=0A=0Adrivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c=
:663:32: warning: incorrect type in assignment (different base types)=0Adri=
vers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:663:32:    expected res=
tricted __le16 [usertype] frame_ctl=0Adrivers/staging/rtl8192u/ieee80211/ie=
ee80211_softmac.c:663:32:    got int=0Adrivers/staging/rtl8192u/ieee80211/i=
eee80211_softmac.c:664:50: warning: invalid assignment: |=3D=0Adrivers/stag=
ing/rtl8192u/ieee80211/ieee80211_softmac.c:664:50:    left side has type re=
stricted __le16=0Adrivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:66=
4:50:    right side has type int=0A=0A=0ASigned-off-by: Gaston Gonzalez <ga=
scoar@gmail.com>=0A---=0A drivers/staging/rtl8192u/ieee80211/ieee80211_soft=
mac.c | 5 +++--=0A 1 file changed, 3 insertions(+), 2 deletions(-)=0A=0Adif=
f --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/=
staging/rtl8192u/ieee80211/ieee80211_softmac.c=0Aindex d2e8b12..0477ba1 100=
644=0A--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c=0A+++ b/=
drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c=0A@@ -660,2 +660,2 @=
@ inline struct sk_buff *ieee80211_authentication_req(struct ieee80211_netw=
ork *be=0A 	auth =3D (struct ieee80211_authentication *)=0A 		skb_put(skb, =
sizeof(struct ieee80211_authentication));=0A=0A-	auth->header.frame_ctl =3D=
 IEEE80211_STYPE_AUTH;=0A-	if (challengelen) auth->header.frame_ctl |=3D IE=
EE80211_FCTL_WEP;=0A+	auth->header.frame_ctl =3D cpu_to_le16(IEEE80211_STYP=
E_AUTH);=0A+	if (challengelen)=0A+		auth->header.frame_ctl |=3D cpu_to_le16=
(IEEE80211_FCTL_WEP);=0A=0A 	auth->header.duration_id =3D 0x013a; //FIXME=
=0A=0A--=0A2.1.4=0A=0A_______________________________________________=0Adev=
el mailing list=0Adevel@linuxdriverproject.org=0Ahttp://driverdev.linuxdriv=
erproject.org/mailman/listinfo/driverdev-devel=0A=0A
--C7zPtVaVf+AK4Oqc--
