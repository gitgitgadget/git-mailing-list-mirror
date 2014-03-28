From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] ls-files: do not trust stat info if lstat() fails
Date: Fri, 28 Mar 2014 20:18:09 +0700
Message-ID: <1396012689-22480-1-git-send-email-pclouds@gmail.com>
References: <CAPig+cRurqCHyFtpCFOisc=1u06JSpmE9rHQa0ioLxrQMuJ4Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 14:18:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTWfZ-0003Pb-8l
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 14:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaC1NRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2014 09:17:52 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64979 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaC1NRv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 09:17:51 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so5007168pab.32
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+t2+AaoK4Qlo0p8sh1isBtntHM1sZ8g2kHLjQjxKpBs=;
        b=GxMwBtmwZrAvpnpUJyvsz/NRJPcxYiWkSkVIe9+CeyVMUQ8xrwmyZTXupU0t2fu432
         hAIBbyWCri+293kmooLw6GJ/J7o2etpXXjipzQbr1RfZLVf3QDTyi47uI5alaKh436Te
         4tw3eeHCZON+kz3D6xPt+C6PwgbSMfxMJs5py62ygmSs8vMQnuu6hs+ovcsZWEOa8lDQ
         iCIGxCg9j1lPxSWnPVX9Ya+mr+NJXBTgtcQmb2uVa9/feQHQ8I4/NqAViKtNO3swSsPE
         sdVOkMHqdKmy39nQhya7Pno3l0EF2zM2rYlclGPczFS0eg3Hjqvx9aQp1lS7yXPtSLiq
         0EaQ==
X-Received: by 10.68.40.138 with SMTP id x10mr8732591pbk.8.1396012670661;
        Fri, 28 Mar 2014 06:17:50 -0700 (PDT)
Received: from lanh ([115.73.244.146])
        by mx.google.com with ESMTPSA id cz3sm23075582pbc.9.2014.03.28.06.17.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Mar 2014 06:17:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 28 Mar 2014 20:18:43 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <CAPig+cRurqCHyFtpCFOisc=1u06JSpmE9rHQa0ioLxrQMuJ4Dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245387>

If 'err' is non-zero, lstat() has failed. Consider the entry modified
without passing the (unreliable) stat info to ce_modified() in this
case.

Noticed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Mar 28, 2014 at 11:04 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
 > On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D lstat(ce=
->name, &st);
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (show_deleted=
 && err) {
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 show_ce_entry(tag_removed, ce);
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 shown =3D 1;
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (show_modifie=
d && ce_modified(ce, &st, 0)) {
 >
 > Is it possible for the lstat() to have failed for some reason when w=
e
 > get here? If so, relying upon 'st' is unsafe, isn't it?

 The chance of random stat making ce_modified() return false is pretty
 low, but you're right. This code is a copy from the old show_files().
 I'll fix it in the git-ls series. Meanwhile a patch for maint to fix
 the original function.

 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 47c3880..e6bd00e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -260,7 +260,7 @@ static void show_files(struct dir_struct *dir)
 			err =3D lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
+			if (show_modified && (err || ce_modified(ce, &st, 0)))
 				show_ce_entry(tag_modified, ce);
 		}
 	}
--=20
1.9.1.345.ga1a145c
