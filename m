From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Fri, 29 May 2009 11:13:14 +0100
Message-ID: <b0943d9e0905290313gc37d98cy769f57a4715cae14@mail.gmail.com>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
	 <20090528124817.GA22262@diana.vm.bytemark.co.uk>
	 <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com>
	 <b0943d9e0905280751k3b9f26c9gd907a7c11ca9d5e2@mail.gmail.com>
	 <20090529072050.GA9760@diana.vm.bytemark.co.uk>
	 <b0943d9e0905290140i57aeaa33r8de34302b63ffa5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 29 12:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9z6V-0002wS-PR
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 12:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbZE2KNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 06:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZE2KNO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 06:13:14 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:42801 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbZE2KNN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 06:13:13 -0400
Received: by ewy24 with SMTP id 24so6155438ewy.37
        for <git@vger.kernel.org>; Fri, 29 May 2009 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nj0fGM3QOGVa344cYaupE8AfotbZl/pHFOBvbtrhPoE=;
        b=xZSrLGx/3bgLqFHvF7/Cr7AHRfMOOM/K8txXn4rRQJ+Mq7WOmXC4Ve+UbcAJc7fyge
         uDi4RFVpkE2GWXueOOrpzI0KzmHMxVr8nZwxiNLYqhKcj7sXFu8Jxw9g2qLrQFkFPGvt
         bq482YLgBsOvswbVZQNN4Ge+T96Y93DaIQUBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=owUQ21TZzu1r4XaXnEsho69wxvMiGTjoRsFmGH3iofwTMFQ+lzrS+Z/3SMOe8B1qfm
         72EI4UkTFE7zCI/tt6mOXUWZ7tnny0RaO/qVMlG/VDhZjc1Hd/FeZnYku9fDuIlaaIVz
         2uqsvL462eq1Y5F/YzL5Y+/Avj+oEU4RPDqFI=
Received: by 10.216.53.207 with SMTP id g57mr857034wec.3.1243591994210; Fri, 
	29 May 2009 03:13:14 -0700 (PDT)
In-Reply-To: <b0943d9e0905290140i57aeaa33r8de34302b63ffa5e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120267>

2009/5/29 Catalin Marinas <catalin.marinas@gmail.com>:
> =A0 =A0merge_bases =3D repository.get_merge_bases(public_head, stack.=
base)
> =A0 =A0if not stack.base in merge_bases:
> =A0 =A0 =A0 =A0public_head =3D __create_commit(repository, stack.head=
=2Edata.tree,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0[public_head, stack.base], options)
> =A0 =A0 =A0 =A0repository.refs.set(public_ref, public_head, 'publish'=
)
> =A0 =A0 =A0 =A0out.info('Merged the stack base into "%s"' % public_re=
f)
> =A0 =A0 =A0 =A0return

One minor improvement here, trying to guess what was merged:

diff --git a/stgit/commands/publish.py b/stgit/commands/publish.py
index fe7f7c6..401fbdf 100644
--- a/stgit/commands/publish.py
+++ b/stgit/commands/publish.py
@@ -67,10 +67,10 @@ options =3D [

 directory =3D common.DirectoryHasRepositoryLib()

-def __create_commit(repository, tree, parents, options):
+def __create_commit(repository, tree, parents, options, message =3D ''=
):
     """Return a new Commit object."""
     cd =3D git.CommitData(
-        tree =3D tree, parents =3D parents, message =3D '',
+        tree =3D tree, parents =3D parents, message =3D message,
         author =3D git.Person.author(), committer =3D git.Person.commi=
tter())
     cd =3D common.update_commit_data(cd, options, allow_edit =3D True)

@@ -106,8 +106,10 @@ def func(parser, options, args):
     # base by setting two parents.
     merge_bases =3D repository.get_merge_bases(public_head, stack.base=
)
     if not stack.base in merge_bases:
+        message =3D 'Merge ' + repository.describe(stack.base)
         public_head =3D __create_commit(repository, stack.head.data.tr=
ee,
-                                      [public_head, stack.base], optio=
ns)
+                                      [public_head, stack.base], optio=
ns,
+                                      message)
         repository.refs.set(public_ref, public_head, 'publish')
         out.info('Merged the stack base into "%s"' % public_ref)
         return
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 3303eea..6e3bb4f 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -614,6 +614,10 @@ class Repository(RunWithEnv):
         sha1_list =3D self.run(['git', 'merge-base', '--all',
                               commit1.sha1, commit2.sha1]).output_line=
s()
         return set(self.get_commit(sha1) for sha1 in sha1_list)
+    def describe(self, commit):
+        """Use git describe --all on the given commit."""
+        return self.run(['git', 'describe', '--all', commit.sha1]
+                       ).discard_stderr().discard_exitcode().raw_outpu=
t()
     def simple_merge(self, base, ours, theirs):
         index =3D self.temp_index()
         try:

--=20
Catalin
