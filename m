From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push 
	operations
Date: Tue, 22 Dec 2009 18:33:44 +0000
Message-ID: <b0943d9e0912221033p39375ae6n9593b7d2887cb1ba@mail.gmail.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>
	 <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
	 <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>
	 <b8197bcb0912191550u300a9c20o351eba66c85292bb@mail.gmail.com>
	 <b0943d9e0912201521k73bdcb5fl333e845028954050@mail.gmail.com>
	 <b8197bcb0912202308p296207av416cd5590a11251b@mail.gmail.com>
	 <b0943d9e0912210348o37b71935x5fad4f1a4be4b70@mail.gmail.com>
	 <b8197bcb0912210548q67c1da4bhe023bed2811394d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@virtutech.com>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN9YO-0003Lq-Va
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 19:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbZLVSdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2009 13:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbZLVSdr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 13:33:47 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:49362 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZLVSdq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 13:33:46 -0500
Received: by fxm5 with SMTP id 5so6219605fxm.28
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 10:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OTTA44ATYOjTg+/pulpiYlk177j2C/5PrBvMbnjivnw=;
        b=qmIlFaYaxzrhopba+d7S/oIXsWvTLXramoV48HB5LD57Ml0jwtm6dN5CGozLQH6ikh
         lelpJNpxU6kIDSl214zvZCU9l1+YO14POCJLKuNHNz7RlNlJCcAHTZCjRBcJx1jVbbTf
         STV8eGcHEl23EE1/AqGaM0lsXBSd344MoHTDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jI3aeFM1l3czjP0DzXLklHr09sUDI01d1Hh2qaE0kbcvZ8pOuvL4v3Nj53IcFgL/Sk
         QRQ1AZEwIzmRd3bgvmNtjaL+W7PDiFvbRgJOqcsHlL932ONiA9JmJwB0U7Y61rPEPz/L
         ghsvISTgpD8Ut0kosjdMKCfM5mAnW/buQbZ7Y=
Received: by 10.223.127.195 with SMTP id h3mr3166724fas.57.1261506824750; Tue, 
	22 Dec 2009 10:33:44 -0800 (PST)
In-Reply-To: <b8197bcb0912210548q67c1da4bhe023bed2811394d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135591>

Updated patch below:


Record a single transaction for conflicting push operations

=46rom: Catalin Marinas <catalin.marinas@gmail.com>

StGit commands resulting in a conflicting patch pushing record two
transactions in the log (with one of them being inconsistent with HEAD
!=3D top). Undoing such operations requires two "stg undo" (possibly wi=
th
--hard) commands which is unintuitive. This patch changes such
operations to only record one log entry and "stg undo" reverts the stac=
k
to the state prior to the operation.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Gustav H=E5llberg <gustav@virtutech.com>
Cc: Karl Wiberg <kha@treskal.com>
---
 stgit/lib/transaction.py |   35 ++++++++++++++++-------------------
 t/t3101-reset-hard.sh    |    2 +-
 t/t3103-undo-hard.sh     |    4 ++--
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 30a153b..d82e724 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -90,7 +90,6 @@ class StackTransaction(object):
         self.__applied =3D list(self.__stack.patchorder.applied)
         self.__unapplied =3D list(self.__stack.patchorder.unapplied)
         self.__hidden =3D list(self.__stack.patchorder.hidden)
-        self.__conflicting_push =3D None
         self.__error =3D None
         self.__current_tree =3D self.__stack.head.data.tree
         self.__base =3D self.__stack.base
@@ -232,10 +231,9 @@ class StackTransaction(object):
             self.__stack.patchorder.hidden =3D self.__hidden
             log.log_entry(self.__stack, msg)
         old_applied =3D self.__stack.patchorder.applied
-        write(self.__msg)
-        if self.__conflicting_push !=3D None:
-            self.__patches =3D _TransPatchMap(self.__stack)
-            self.__conflicting_push()
+        if not self.__conflicts:
+            write(self.__msg)
+        else:
             write(self.__msg + ' (CONFLICT)')
         if print_current_patch:
             _print_current_patch(old_applied, self.__applied)
@@ -358,26 +356,25 @@ class StackTransaction(object):
         elif not merge_conflict and cd.is_nochange():
             s =3D 'empty'
         out.done(s)
-        def update():
-            if comm:
-                self.patches[pn] =3D comm
-            if pn in self.hidden:
-                x =3D self.hidden
-            else:
-                x =3D self.unapplied
-            del x[x.index(pn)]
-            self.applied.append(pn)
+
         if merge_conflict:
             # We've just caused conflicts, so we must allow them in
             # the final checkout.
             self.__allow_conflicts =3D lambda trans: True
+            self.__patches =3D _TransPatchMap(self.__stack)

-            # Save this update so that we can run it a little later.
-            self.__conflicting_push =3D update
-            self.__halt("%d merge conflict(s)" % len(self.__conflicts)=
)
+        # Update the stack state
+        if comm:
+            self.patches[pn] =3D comm
+        if pn in self.hidden:
+            x =3D self.hidden
         else:
-            # Update immediately.
-            update()
+            x =3D self.unapplied
+        del x[x.index(pn)]
+        self.applied.append(pn)
+
+        if merge_conflict:
+            self.__halt("%d merge conflict(s)" % len(self.__conflicts)=
)

     def push_tree(self, pn):
         """Push the named patch without updating its tree."""
diff --git a/t/t3101-reset-hard.sh b/t/t3101-reset-hard.sh
index bd97b3a..45e86dc 100755
--- a/t/t3101-reset-hard.sh
+++ b/t/t3101-reset-hard.sh
@@ -47,7 +47,7 @@ test_expect_success 'Try to reset with --hard' '
     stg reset --hard master.stgit^~1 &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
-    test "$(echo $(stg series))" =3D "> p1 - p2 - p3"
+    test "$(echo $(stg series))" =3D "+ p1 + p2 > p3"
 '

 test_done
diff --git a/t/t3103-undo-hard.sh b/t/t3103-undo-hard.sh
index 2d0f382..df14b1f 100755
--- a/t/t3103-undo-hard.sh
+++ b/t/t3103-undo-hard.sh
@@ -46,11 +46,11 @@ test_expect_success 'Try to undo without --hard' '

 cat > expected.txt <<EOF
 EOF
-test_expect_failure 'Try to undo with --hard' '
+test_expect_success 'Try to undo with --hard' '
     stg undo --hard &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
-    test "$(echo $(stg series))" =3D "> p1 - p2 - p3" &&
+    test "$(echo $(stg series))" =3D "+ p1 + p2 > p3" &&
     test "$(stg id)" =3D "$(stg id $(stg top))"
 '
