From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: Fix cloning and sharing bug
Date: Sun, 4 Aug 2013 08:31:10 -0500
Message-ID: <CAMP44s2DhS=B3fTD-FCrkUK=h4hWuBN6n6mqEws2qh=YiBegJw@mail.gmail.com>
References: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de>
	<1375612683-9104-1-git-send-email-apelisse@gmail.com>
	<478CA849-148C-4F73-A64F-9A5829523CC3@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Sun Aug 04 15:31:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5yPA-0007m3-3M
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 15:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab3HDNbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Aug 2013 09:31:13 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:61233 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab3HDNbM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Aug 2013 09:31:12 -0400
Received: by mail-la0-f44.google.com with SMTP id fo12so1464480lab.31
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dpp33eRISqoA6PgjT2Y5Gfc+CoGMr0cqD2cTkIe6Gfc=;
        b=Ex954eyAcFN7iUOl0Jnnm7NiLGf5+sJmHQJyUcKEcsuyvB9kZlwd7+daYkaTXNFz/r
         U1sTgHeqtZoZ1Lq6ZTZsI77LJye4PTOoh1iHZL2HrKVe7bXBymv/YdREpg1sS64r/UIs
         OQlyIpHVAX5wGhWp1VlGBaPXyf2HSJKCrPxSOw+EAJ6pbGi68hgXx8lUJOqacFvC/Ilf
         HOjVqF4Wrg73BVQ/hxvHYXBw9fLWpjOXJZtWJO4xClSRric3YlF1uhcp68Qk2XK4I64f
         l44co+8rImoVWjChIWq/ZtSCbawWZzvv2x17R8mbdQwnU7lOqcKzeffJPQ5ntIs+kuad
         aODw==
X-Received: by 10.112.162.131 with SMTP id ya3mr6862746lbb.85.1375623070731;
 Sun, 04 Aug 2013 06:31:10 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 4 Aug 2013 06:31:10 -0700 (PDT)
In-Reply-To: <478CA849-148C-4F73-A64F-9A5829523CC3@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231627>

On Sun, Aug 4, 2013 at 7:17 AM, J=C3=B6rn Hees <dev@joernhees.de> wrote=
:
> Hi,
>
> On 4 Aug 2013, at 12:38, Antoine Pelisse <apelisse@gmail.com> wrote:
>> [=E2=80=A6]
>> I also decided to always clone local repositories because what J=C3=B6=
rn Hees
>> said makes sense:
>> If you have a local clone of a big repository, and then want to add =
a slow
>> remote, you would have to reclone everything.
>> I think the trade-off is good, because clone from local should not b=
e that
>> time expensive (maybe it can be on disk-space though).
>
> I was working on a similar patch in the meantime, this point was the =
only thing that
> kept me from submitting=E2=80=A6 Can someone of you think of an easy =
way to do this lazily
> on the first non-local remote being added?
> In case we don't have a non-local clone (a mercurial dir with a clone=
 subdir) yet, we
> would try to go though the local mercurial remotes and then clone the=
m=E2=80=A6 Just would
> need a way to get their URLs. I thought about going through all "git =
remote -v"

git config --get-regexp '^remote.*.url' is probably more appropriate.

Either way, I don't see why such a change should be in the same patch.

> This way we wouldn't need to copy by default (bad for big repos), but=
 could still do this
> in a cheap way if a slow remote is added later on.
>
> Btw, is there any reason why we don't just use the local mercurial re=
motes as shared
> repo? Cause it's not under our git dir and might be deleted?

Yes. Or moved, or might be in an external drive, or many other reasons.

This is my solution:

--- a/contrib/remote-helpers/git-remote-hg.py
+++ b/contrib/remote-helpers/git-remote-hg.py
@@ -391,11 +391,22 @@ def get_repo(url, alias):
             os.makedirs(dirname)
     else:
         shared_path =3D os.path.join(gitdir, 'hg')
-        if not os.path.exists(shared_path):
-            try:
-                hg.clone(myui, {}, url, shared_path, update=3DFalse, p=
ull=3DTrue)
-            except:
-                die('Repository error')
+
+        # check and upgrade old organization
+        hg_path =3D os.path.join(shared_path, '.hg')
+        if os.path.exists(shared_path) and not os.path.exists(hg_path)=
:
+            repos =3D os.listdir(shared_path)
+            for x in repos:
+                local_hg =3D os.path.join(shared_path, x, 'clone', '.h=
g')
+                if not os.path.exists(local_hg):
+                    continue
+                shutil.copytree(local_hg, hg_path)
+
+        # setup shared repo (if not there)
+        try:
+            hg.peer(myui, {}, shared_path, create=3DTrue)
+        except error.RepoError:
+            pass

         if not os.path.exists(dirname):
             os.makedirs(dirname)

It should also work in all the cases, but there would not be an extra
unnecessary clone while upgrading, and it doesn't sneak in any other
changes.

You can see the changes on top of my previous patch that lead to this
diff in my repo:

https://github.com/felipec/git/commits/fc/master

Cheers.

--=20
=46elipe Contreras
