From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push 
	operations
Date: Fri, 18 Dec 2009 15:49:46 +0000
Message-ID: <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>
	 <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@virtutech.com>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 16:49:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLf5Z-0003Yf-E8
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 16:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbZLRPtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2009 10:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbZLRPtt
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 10:49:49 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:38824 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbZLRPts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 10:49:48 -0500
Received: by fxm21 with SMTP id 21so2932977fxm.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Wiv6KV1GaA0jzHOyVStEdVL+3wIAycPUjmwquqmsYHc=;
        b=Ep8fb4fIC4e9/B41HppDMcfS2MC7LOfYe0X1LFjWSv82WihLPXUq0f2icpVFq3Ui4f
         qhCRSUzDPl6T9Z1XkyuABdWkjeeYsTL/CTgVPUH+gInyYReTfsGxzpKZwkfauYRrANUe
         lbHom0JsW3CjlBEIgI7LqSvZR4236/oNLICRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t2UZw546EciB+CuBqlfO12OVLFF1QGtqP9Rv98DPuN8wrAthZu3dnuo8+xl+Fu0tTN
         7OPyYk1CGm88ifnPDURZDNG5p2FxUapKzKZTsnU2IE3qPb9TTrua+gTktAonhgykIMJ9
         guEYagw/5R+H6DUEvHUx/yqNcjQSXCenqoJAw=
Received: by 10.223.95.76 with SMTP id c12mr5330213fan.41.1261151386288; Fri, 
	18 Dec 2009 07:49:46 -0800 (PST)
In-Reply-To: <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135416>

2009/12/18 Karl Wiberg <kha@treskal.com>:
> On Fri, Dec 18, 2009 at 12:22 AM, Catalin Marinas
> <catalin.marinas@gmail.com> wrote:
>
>> StGit commands resulting in a conflicting patch pushing record two
>> transactions in the log (with one of them being inconsistent with
>> HEAD !=3D top). Undoing such operations requires two "stg undo"
>> (possibly with --hard) commands which is unintuitive. This patch
>> changes such operations to only record one log entry and "stg undo"
>> reverts the stack to the state prior to the operation.
>
> Hmm, OK. It was convenient to be able to undo just the last
> conflicting step, but I guess the increase in UI complexity wasn't
> worth it.
>
> I think your patch doesn't go quite far enough, though.
> self.__conflicting_push is currently set to a function that will do
> the extra updates that take us from the first to the second state to
> save in the log; if we'll be saving at only one point, we might as
> well run those updates immediately instead of deferring them. In othe=
r
> words, the entire __conflicting_push variable could be removed.

See below for an updated patch:


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
 stgit/lib/transaction.py |   14 +++++---------
 t/t3101-reset-hard.sh    |    2 +-
 t/t3103-undo-hard.sh     |    4 ++--
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 30a153b..ea85d5d 100644
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
@@ -371,12 +369,10 @@ class StackTransaction(object):
             # We've just caused conflicts, so we must allow them in
             # the final checkout.
             self.__allow_conflicts =3D lambda trans: True
-
-            # Save this update so that we can run it a little later.
-            self.__conflicting_push =3D update
+            self.__patches =3D _TransPatchMap(self.__stack)
+            update()
             self.__halt("%d merge conflict(s)" % len(self.__conflicts)=
)
         else:
-            # Update immediately.
             update()

     def push_tree(self, pn):
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


--=20
Catalin
