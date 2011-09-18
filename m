From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <luksan@gmail.com>
Subject: [PATCH v2] Add a credential-helper for KDE
Date: Sun, 18 Sep 2011 16:52:58 +0200
Message-ID: <4E7605CA.7020204@gmail.com>
References: <4E594B5A.6070902@gmail.com> <20110831014237.GA2519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <luksan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 18 16:53:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Ik1-0005qn-GV
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 16:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab1IROxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 10:53:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63346 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab1IROxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 10:53:03 -0400
Received: by bkbzt4 with SMTP id zt4so4682532bkb.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bnPOmXGZZ+Y/vjLEB+1YV2dxNIp/6YsopzkMClmmsdA=;
        b=IboY5xVeArklJA4JBF8A6MTnOcjt90AXExI5edv1jRQrlh46T5BXREKjf9wbvZNLKo
         0NhyiCH6Ob4sfTfAw6/CCvjr0PYkcDaTI92BZvshO9KaiZNexH8F3QcykDGUzhU1Hdq8
         zuGX/dDfoLJCi9C3VpTLctimtfjDRkb6LCryc=
Received: by 10.204.156.144 with SMTP id x16mr921004bkw.85.1316357581258;
        Sun, 18 Sep 2011 07:53:01 -0700 (PDT)
Received: from [192.168.1.73] (c-d33fe155.47-1-64736c12.cust.bredbandsbolaget.se. [85.225.63.211])
        by mx.google.com with ESMTPS id y8sm11367513bkb.4.2011.09.18.07.52.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 07:52:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110824 Thunderbird/6.0
In-Reply-To: <20110831014237.GA2519@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181613>

This Python script plugs into the credentials API
of Git to ask the user for passwords with a nice
KDE password dialog.

The password is saved in the KWallet.

Signed-off-by: Lukas Sandstr=C3=B6m <luksan@gmail.com>
---

On 2011-08-31 03:42, Jeff King wrote:
> Can we call it git-credential-kdewallet or similar? Then users can ju=
st
> do:
>=20
>   git config credential.helper kdewallet
>=20
> (where "kdewallet" can be whatever you think is most appropriate; the
> key is naming it git-credential-*).

Done.

[...]

> If I am reading this correctly, you look up based purely on the conte=
xt
> token. Which means that if I do something like this:
>=20
>   $ git push https://host.com/repo.git
>   [enter username: user1, password: foo]
>   $ git push https://user2@host.com/other-repo.git
>=20
> We will invoke the helper as:
>=20
>   git credential-kdewallet --unique=3Dhttps:host.com --username=3Duse=
r2
>=20
> but the helper will ignore the "user2" bit, and return "user1 / foo".
>=20
> The "cache" helper I wrote handles this situation better, by indexing
> both on the token and the username. I wonder if the username should
> become part of the token. Or if the token should really just become a
> canonicalized URL, minus the actual path. So the first one would get:
>=20
>   --unique=3Dhttps://host.com
>=20
> and the second would get:
>=20
>   --unique=3Dhttps://user2@host.com
>=20
> Then helpers wouldn't need to worry about doing anything special.
>=20
> What do you think? Also, any comments in general on writing a helper?
> You are the first one besides me to do so. Did you find anything in t=
he
> interface or the documentation confusing? Suggestions are very welcom=
e,
> as nothing has been released yet and we're free to tweak as much as w=
e
> want.
>=20
> -Peff

Right. Multiple usernames per "unique" context is supported in this ver=
sion.
I looked at the git-credential-storage helper when I wrote the first pa=
tch,
which didn't have obvious support for multiple usernames per unique con=
text.

Keeping the username outside the token is probably a good thing, but pe=
rhaps it
should be clarified in the api-docs that multiple usernames has to be s=
upported.

Also; what about rejecting credentials. This code currently deletes jus=
t a=20
username/password pair if a username is specified, and all credentials =
associated
with the token if only --unique and --reject is specified. Is this corr=
ect/expected
behavior?

When I first wrote the helper I tried to immediately ask for a new pass=
word if a
credential was rejected, but this didn't work with the HTTP auth code, =
since it
doesn't retry the auth with the new credentials after a reject. I think=
 it would
be better if we asked for a new password instead of just saying "auth f=
ailed" and=20
having the user retry the fetch/pull when the stored credentials are in=
correct.

/Lkas

 .../git-credential-kdewallet.py                    |  137 ++++++++++++=
++++++++
 1 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-credential-kdewallet/git-credential-kde=
wallet.py

diff --git a/contrib/git-credential-kdewallet/git-credential-kdewallet.=
py b/contrib/git-credential-kdewallet/git-credential-kdewallet.py
new file mode 100755
index 0000000..29c4ae1
--- /dev/null
+++ b/contrib/git-credential-kdewallet/git-credential-kdewallet.py
@@ -0,0 +1,137 @@
+#!/usr/bin/env python
+# encoding=3Dutf-8
+#
+# Copyright 2011, Lukas Sandstr=C3=B6m
+#
+# Licensed under the GPL version 2.
+
+import sys
+from PyQt4.QtCore import QString
+from PyKDE4.kdecore import i18n, ki18n, KAboutData, KCmdLineArgs, KCmd=
LineOptions
+from PyKDE4.kdeui import KApplication, KWallet, KPasswordDialog
+
+appName     =3D "git-credential-kdewallet"
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
+            self.reject_credential()
+            return
+
+        if not self.check_wallet():
+            self.ask_password_dialog()
+
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
+    def reject_credential(self):
+        (res, data) =3D self.wallet.readMap(self.token)
+        if self.username:
+            try:
+                del data[QString(self.username)]
+            except KeyError:
+                pass
+            self.wallet.writeMap(self.token, data)
+        else:
+            self.wallet.removeEntry(self.token)
+
+    def store_password(self):
+        (res, data) =3D self.wallet.readMap(self.token)
+        data[QString(self.username)] =3D QString(self.password)
+        self.wallet.writeMap(QString(self.token), data)
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
+        for u, p in data.iteritems():
+            # Pick the first complete credential if no username is spe=
cified
+            if not self.username and u and p:
+                self.username =3D u
+                self.password =3D p
+                return True
+            if self.username =3D=3D u:
+                self.password =3D p
+                return True
+        return None
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
+def main():
+    KCmdLineArgs.init(sys.argv, aboutData)
+
+    options =3D KCmdLineOptions()
+    options.add("unique <token>", ki18n("Unique token identifying the =
credential"))
+    options.add("description <desc>", ki18n("Human readable descriptio=
n of the credential"))
+    options.add("username <username>", ki18n("Requested username"))
+    options.add("reject", ki18n("Purge credential"))
+
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
