From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Fri, 30 Jan 2009 17:36:57 +0000
Message-ID: <b0943d9e0901300936t4a6e0a37x1968a6949fb7bdda@mail.gmail.com>
References: <20090128231305.16133.29214.stgit@localhost.localdomain>
	 <20090129034512.GD24344@diana.vm.bytemark.co.uk>
	 <b0943d9e0901300601j27ab6ebdq4b38a9f7c0cbe261@mail.gmail.com>
	 <20090130152649.GA22044@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:39:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSxJz-0007gi-4m
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbZA3RhB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 12:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbZA3RhA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 12:37:00 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:46183 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZA3RhA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 12:37:00 -0500
Received: by fxm13 with SMTP id 13so332698fxm.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tsdnVOS47HY/9dkZpL8miSJ+gouzby7xdE1V2O1Hbfg=;
        b=trSXxTZ8ir58TD7/q/VBP6bXAA0l57ReRjO4yjVti8cDeLAyM5hWah6uAoU2wB43o5
         Ze7FGy5tQ46k3jx0UGX2AMN430TIFhHAoBUhag3i3aamLMWOGDPhDPVL+EtXj/7x8h6x
         C1OID5B5PFC3KUwRjONNNuXbI7YfcNtk6rwJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xSRGLYmCd2CIvC6aRTHEmB6sr0MqzXfuOp7knoVh2beau+9hkOy7Bj/a8U3mp82NLA
         fvvpxEgAlFDomoV/rEM3Mv9WyFDKtKP54kMi9Qa2/pbCjGEmfgzXA9lxMV3H/GBBAASg
         OSXSmOH0Jj9G/iSzVGj5N7EffCYAXTGcqqnb4=
Received: by 10.223.113.132 with SMTP id a4mr1289788faq.75.1233337017203; Fri, 
	30 Jan 2009 09:36:57 -0800 (PST)
In-Reply-To: <20090130152649.GA22044@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107858>

2009/1/30 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-01-30 14:01:20 +0000, Catalin Marinas wrote:
>
>> @@ -706,9 +706,15 @@ class Index(RunWithEnv):
>>                      ).output_one_line())
>>          except run.RunException:
>>              raise MergeException('Conflicting merge')
>> -    def is_clean(self):
>> +    def is_clean(self, tree =3D None):
>> +        """Check whether the index is clean relative to the given t=
ree."""
>> +        if tree:
>> +            sha1 =3D tree.sha1
>> +        else:
>> +            sha1 =3D 'HEAD'
>>          try:
>> -            self.run(['git', 'update-index', '--refresh']).discard_=
output()
>> +            self.run(['git', 'diff-index', '--quiet', '--cached', s=
ha1]
>> +                    ).discard_output()
>>          except run.RunException:
>>              return False
>>          else:
>
> OK (though I personally would have allowed only Tree objects, with no
> defaulting to the current HEAD).

Done.

See below for an update. I added an __assert_index_worktree_clean()
function in Transaction.

Now, should we add the check_clean argument to Transaction.__init__()
rather than run() as we do for the allow_bad_head case? The check
would need to be done in run() where we have an iw. Just a thought,
I'm not convinced it is better.


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index e2b4266..07079b8 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -706,9 +706,11 @@ class Index(RunWithEnv):
                     ).output_one_line())
         except run.RunException:
             raise MergeException('Conflicting merge')
-    def is_clean(self):
+    def is_clean(self, tree):
+        """Check whether the index is clean relative to the given tree=
ish."""
         try:
-            self.run(['git', 'update-index', '--refresh']).discard_out=
put()
+            self.run(['git', 'diff-index', '--quiet', '--cached', tree=
=2Esha1]
+                    ).discard_output()
         except run.RunException:
             return False
         else:
@@ -858,6 +860,14 @@ class IndexAndWorktree(RunWithEnvCwd):
         cmd =3D ['git', 'update-index', '--remove']
         self.run(cmd + ['-z', '--stdin']
                  ).input_nulterm(paths).discard_output()
+    def worktree_clean(self):
+        """Check whether the worktree is clean relative to index."""
+        try:
+            self.run(['git', 'update-index', '--refresh']).discard_out=
put()
+        except run.RunException:
+            return False
+        else:
+            return True

 class Branch(object):
     """Represents a Git branch."""
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 54de127..c961222 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -147,6 +147,11 @@ class StackTransaction(object):
                 'This can happen if you modify a branch with git.',
                 '"stg repair --help" explains more about what to do ne=
xt.')
             self.__abort()
+    def __assert_index_worktree_clean(self, iw):
+        if not iw.worktree_clean() or \
+           not iw.index.is_clean(self.stack.head.data.tree):
+            self.__halt('Repository not clean. Use "refresh" or '
+                        '"status --reset"')
     def __checkout(self, tree, iw, allow_bad_head):
         if not allow_bad_head:
             self.__assert_head_top_equal()
@@ -183,13 +188,17 @@ class StackTransaction(object):
             self.__checkout(self.__stack.head.data.tree, iw,
                             allow_bad_head =3D True)
     def run(self, iw =3D None, set_head =3D True, allow_bad_head =3D F=
alse,
-            print_current_patch =3D True):
+            print_current_patch =3D True, check_clean =3D False):
         """Execute the transaction. Will either succeed, or fail (with=
 an
         exception) and do nothing."""
         self.__check_consistency()
         log.log_external_mods(self.__stack)
         new_head =3D self.head

+        # Check for clean index and worktree
+        if check_clean and iw:
+            self.__assert_index_worktree_clean(iw)
+
         # Set branch head.
         if set_head:
             if iw:


--=20
Catalin
