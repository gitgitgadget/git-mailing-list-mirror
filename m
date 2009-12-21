From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC PATCH] Record a single transaction for conflicting push 
	operations
Date: Mon, 21 Dec 2009 11:48:32 +0000
Message-ID: <b0943d9e0912210348o37b71935x5fad4f1a4be4b70@mail.gmail.com>
References: <20091217232212.4869.43002.stgit@toshiba-laptop>
	 <b8197bcb0912180123l4657839ctc121636af3724bee@mail.gmail.com>
	 <b0943d9e0912180749ga8857d9j975e119937db9674@mail.gmail.com>
	 <b8197bcb0912191550u300a9c20o351eba66c85292bb@mail.gmail.com>
	 <b0943d9e0912201521k73bdcb5fl333e845028954050@mail.gmail.com>
	 <b8197bcb0912202308p296207av416cd5590a11251b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@virtutech.com>
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 12:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMgkj-0002es-Ja
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 12:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624AbZLULsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 06:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756619AbZLULsg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 06:48:36 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:34378 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616AbZLULsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 06:48:35 -0500
Received: by fxm7 with SMTP id 7so4753730fxm.29
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 03:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wMvK0vy4Nxp3iFYyviQqDeJZgZD4HsiVQ/JZXPFMIaE=;
        b=XCnJMMW/VK5L1VWhl+4lhYpol+/2gWpTRxN6DKneR15/yQM0leJJu95orWJj3xpau1
         +kVH/xzE5WWb4aVlvHFfreoTvYpBNZpLO3NXIhGsudlUNXe29HKLJ/mPVa2kyVOdFnpI
         q34DjgqrLP49pVFBO7PDHKeu+Es0mRy25WLqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NpCN1DlVvDn947PRj1lwogJfQYG3Vm6xh3Z8RSPPce8STEpOtpiRyRuxfEE5F75s4Z
         EfDGDPNkUfpFasaVB/mbjahiAyEVVIKZo2FZ++GJAE/gDKVrn/i6ogsz6sz8I/kVvAzw
         Z3rpmVgQqfva6l/Yqx722vkARZPNAoGGOsIvU=
Received: by 10.223.164.96 with SMTP id d32mr9137353fay.106.1261396112870; 
	Mon, 21 Dec 2009 03:48:32 -0800 (PST)
In-Reply-To: <b8197bcb0912202308p296207av416cd5590a11251b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135555>

2009/12/21 Karl Wiberg <kha@treskal.com>:
> By the way, you do realize there's another command that requires two
> steps to undo completely: refresh? And that one is harder to get out
> of---undoing it all in one step would mean throwing away the updates
> to the patch.

But it looks to me like refresh does this by running separate
transactions. The push command does this in a single transaction, so
the quickest fix for the HEAD != top undo problem was to only record
one log per transaction.

If we keep the current behaviour with two logs per transaction, we
need to preserve the HEAD prior to the conflict so that logging
doesn't get the wrong HEAD (which is the new conflicting HEAD
currently). The patch below appears to fix this problem and still
generate two logs per transaction. While I'm more in favour of a
single log per transaction, if people find it useful I'm happy to keep
the current behaviour.

diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 30a153b..ba97c4f 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -197,18 +197,14 @@ class StackTransaction(object):
         exception) and do nothing."""
         self.__check_consistency()
         log.log_external_mods(self.__stack)
-        new_head = self.head
-
-        # Set branch head.
-        if set_head:
-            if iw:
-                try:
-                    self.__checkout(new_head.data.tree, iw, allow_bad_head)
-                except git.CheckoutException:
-                    # We have to abort the transaction.
-                    self.abort(iw)
-                    self.__abort()
-            self.__stack.set_head(new_head, self.__msg)
+
+        if set_head and iw:
+            try:
+                self.__checkout(self.head.data.tree, iw, allow_bad_head)
+            except git.CheckoutException:
+                # We have to abort the transaction.
+                self.abort(iw)
+                self.__abort()

         if self.__error:
             if self.__conflicts:
@@ -216,8 +212,11 @@ class StackTransaction(object):
             else:
                 out.error(self.__error)

-        # Write patches.
-        def write(msg):
+        # Write patches and update the branch head.
+        def write(msg, new_head):
+            # Set branch head.
+            if new_head:
+                self.__stack.set_head(new_head, self.__msg)
             for pn, commit in self.__patches.iteritems():
                 if self.__stack.patches.exists(pn):
                     p = self.__stack.patches.get(pn)
@@ -231,12 +230,16 @@ class StackTransaction(object):
             self.__stack.patchorder.unapplied = self.__unapplied
             self.__stack.patchorder.hidden = self.__hidden
             log.log_entry(self.__stack, msg)
+
         old_applied = self.__stack.patchorder.applied
-        write(self.__msg)
         if self.__conflicting_push != None:
+            write(self.__msg, set_head and self.head)
             self.__patches = _TransPatchMap(self.__stack)
             self.__conflicting_push()
-            write(self.__msg + ' (CONFLICT)')
+            write(self.__msg + ' (CONFLICT)', set_head and self.head)
+        else:
+            write(self.__msg, set_head and self.head)
+
         if print_current_patch:
             _print_current_patch(old_applied, self.__applied)

@@ -346,10 +349,10 @@ class StackTransaction(object):
             if merge_conflict:
                 # When we produce a conflict, we'll run the update()
                 # function defined below _after_ having done the
-                # checkout in run(). To make sure that we check out
-                # the real stack top (as it will look after update()
-                # has been run), set it hard here.
-                self.head = comm
+                # checkout in run(). Make sure that we have a consistent
+                # HEAD before the update function is called below (which
+                # sets the real HEAD).
+                self.head = self.top
         else:
             comm = None
             s = 'unmodified'
@@ -367,6 +370,8 @@ class StackTransaction(object):
                 x = self.unapplied
             del x[x.index(pn)]
             self.applied.append(pn)
+            # Set the real conflicting HEAD.
+            self.head = comm
         if merge_conflict:
             # We've just caused conflicts, so we must allow them in
             # the final checkout.
diff --git a/t/t3103-undo-hard.sh b/t/t3103-undo-hard.sh
index 2d0f382..a71cd32 100755
--- a/t/t3103-undo-hard.sh
+++ b/t/t3103-undo-hard.sh
@@ -46,7 +46,7 @@ test_expect_success 'Try to undo without --hard' '

 cat > expected.txt <<EOF
 EOF
-test_expect_failure 'Try to undo with --hard' '
+test_expect_success 'Try to undo with --hard' '
     stg undo --hard &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&


-- 
Catalin
