From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <luksan@gmail.com>
Subject: [PATCH] Add a credential-helper for KDE
Date: Sat, 27 Aug 2011 21:54:02 +0200
Message-ID: <4E594B5A.6070902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 21:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxOxQ-00015a-N0
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 21:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711Ab1H0TyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Aug 2011 15:54:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38029 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab1H0TyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 15:54:07 -0400
Received: by bke11 with SMTP id 11so3278814bke.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=AihdcxK/O6Nbd6NHwKXhNMuozxgWEj/2j6SstjGvbF4=;
        b=dvaZ63TpwrI1PVd1b8B/ltzjUI5juhtIBYZU59zoB/bgOKqP01uui/eSvcnryzhZGO
         nJvIqxu27BrOAx2Ra3/xSwK/ey4mgDIyBUBw/hF+tAdOF8JYksIVfy/AiDozXtpMo5YW
         l+KKLeb6wswBfxsAT1hrEwLEC+Pq75+Je/WSw=
Received: by 10.204.9.218 with SMTP id m26mr1272856bkm.92.1314474844858;
        Sat, 27 Aug 2011 12:54:04 -0700 (PDT)
Received: from [192.168.1.73] (c-d33fe155.47-1-64736c12.cust.bredbandsbolaget.se [85.225.63.211])
        by mx.google.com with ESMTPS id m18sm779329bkt.18.2011.08.27.12.54.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 12:54:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110824 Thunderbird/6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180245>

This Python script plugs into the credentials API
of Git to ask the user for passwords with a nice
KDE password dialog.

The password is saved in the KWallet.

Signed-off-by: Lukas Sandstr=C3=B6m <luksan@gmail.com>
---

Here is a credentials-helper for KDE. You need to have PyKDE installed =
to use it.

See Documentation/gitcredentials.txt for more info.

 .../git-kde-credentials-helper.py                  |  122 ++++++++++++=
++++++++
 1 files changed, 122 insertions(+), 0 deletions(-)
 create mode 100755 contrib/kde-credetials-helper/git-kde-credentials-h=
elper.py

diff --git a/contrib/kde-credetials-helper/git-kde-credentials-helper.p=
y b/contrib/kde-credetials-helper/git-kde-credentials-helper.py
new file mode 100755
index 0000000..8d3be4d
--- /dev/null
+++ b/contrib/kde-credetials-helper/git-kde-credentials-helper.py
@@ -0,0 +1,122 @@
+#!/usr/bin/env python
+# encoding=3Dutf-8
+#
+# Copyright 2011, Lukas Sandstr=C3=B6m
+#
+# Licensed under the GPL version 2.
+
+import sys, commands
+from PyQt4.QtCore import QString
+from PyKDE4.kdecore import i18n, ki18n, KAboutData, KCmdLineArgs, KCmd=
LineOptions
+from PyKDE4.kdeui import KApplication, KWallet, KPasswordDialog
+
+appName     =3D "git-kde-credentials-helper"
+catalog     =3D ""
+programName =3D ki18n ("Git KDE credentials helper")
+version     =3D "0.1"
+description =3D ki18n ("Credentials storage helper for Git")
+license     =3D KAboutData.License_GPL_V2
+copyright   =3D ki18n ("(c) 2011 Lukas Sandstr=C3=B6m")
+text        =3D ki18n ("none")
+homePage    =3D "http://www.git-scm.com"
+bugEmail    =3D "luksan@gmail.com"
+
+aboutData   =3D KAboutData (appName, catalog, programName, version, de=
scription,
+                          license, copyright, text, homePage, bugEmail=
)
+
+class CredentialHelper(KApplication):
+    def __init__(self, token, username =3D None, desc =3D None, reject=
 =3D False):
+        super(CredentialHelper, self).__init__()
+        self.password =3D None
+        self.username =3D username
+        self.save_password =3D False
+        self.token =3D token
+        self.desc =3D desc
+
+        if not self.token:
+            return
+
+        self.open_wallet()
+
+        if reject:
+            self.wallet.removeEntry(QString(token))
+            return
+
+        if not self.check_wallet():
+            self.ask_password_dialog()
+       =20
+        if self.save_password:
+            self.store_password()
+
+        self.output_credentials()
+
+    def output_credentials(self):
+        if self.username:
+            print "username=3D" + self.username
+        if self.password:
+            print "password=3D" + self.password
+
+    def store_password(self):
+        self.wallet.writeMap(QString(self.token),
+            {QString("username") : QString(self.username),
+             QString("password") : QString(self.password)})
+
+    def open_wallet(self):
+        self.wallet =3D KWallet.Wallet.openWallet(
+            KWallet.Wallet.LocalWallet(), 0, KWallet.Wallet.Synchronou=
s)
+        if not self.wallet.isOpen():
+            return None
+        if not self.wallet.hasFolder("GitCredentials"):
+            self.wallet.createFolder("GitCredentials")
+        self.wallet.setFolder("GitCredentials")
+
+    def check_wallet(self):
+        (res, data) =3D self.wallet.readMap(self.token)
+        if res !=3D 0:
+            return None
+        try:
+            self.username =3D data[QString("username")]
+            self.password =3D data[QString("password")]
+        except KeyError:
+            return None
+        return self.username and self.password
+
+    def ask_password_dialog(self):
+        dlg =3D KPasswordDialog(None,
+            KPasswordDialog.KPasswordDialogFlag(
+                KPasswordDialog.ShowKeepPassword |
+                KPasswordDialog.ShowUsernameLine))
+        if self.desc:
+            desc =3D self.desc
+        else:
+            desc =3D self.token
+        dlg.setPrompt(i18n("Please enter username and password for %s"=
 % (desc)))
+        dlg.setUsername(self.username)
+        dlg.setKeepPassword(True)
+        if not dlg.exec_():
+            return
+        self.username =3D dlg.username()
+        self.password =3D dlg.password()
+        self.save_password =3D dlg.keepPassword()
+
+def main():   =20
+    KCmdLineArgs.init(sys.argv, aboutData)
+   =20
+    options =3D KCmdLineOptions()
+    options.add("unique <token>", ki18n("Unique token identifying the =
credential"))
+    options.add("description <desc>", ki18n("Human readable descriptio=
n of the credential"))
+    options.add("username <username>", ki18n("Requested username"))
+    options.add("reject", ki18n("Purge credential"))   =20
+   =20
+    KCmdLineArgs.addCmdLineOptions(options)
+    args =3D KCmdLineArgs.parsedArgs();
+
+    username =3D args.getOption("username")
+    token =3D args.getOption("unique")
+    desc =3D args.getOption("description")
+    reject =3D args.isSet("reject")
+
+    app =3D CredentialHelper(token, username, desc, reject)
+
+if __name__ =3D=3D "__main__":
+    main()
--=20
1.7.6.1
