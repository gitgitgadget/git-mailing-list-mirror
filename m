From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 5/5] pull: add warning on non-ff merges
Date: Sun, 8 Sep 2013 20:49:23 -0500
Message-ID: <CAMP44s0z2=-SEJD8=K31MBcuPx=Xx__6BKaqd-MmXjAVTOr7mQ@mail.gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
	<1378689796-19305-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 03:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqbZ-0003ia-01
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 03:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab3IIBtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 21:49:25 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:53303 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab3IIBtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 21:49:24 -0400
Received: by mail-lb0-f179.google.com with SMTP id x18so4556371lbi.10
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=45VEMPszL0BuBi+ipEhNTcAO5mjUxI/gp3qsZoeKnao=;
        b=Un+dvyV6wPgoPD1njxdO5AHlseKPFNGHcEycgOAzCv+CVg02wuzT9HTqczP31ASPJA
         UGAR+L3Uw/XgkMVY/5C8g9qaWbZgCfs7TH2JPafB6Mgd8qkVoX3LiwwQMcRPOzsLgeq/
         7F9euDXs8mDaHS+SW6OiB4y+E5xV7kcFFiWMopLpBu4UDiO398t/sUFemsC6OTkwtldM
         Z7bx/CoSY1Mz248Gd+CmsUbfSW5eJ9wAXpBn36oVVCHKwKX9ARlWEUHcQQgHfqDkU9RN
         CRZyH8Ncjm74JVy5CoGuXzrnEmPLR1Hv4u9i/EPL0AdmHPKK/+44aAxDP/UhWdPxzVCH
         kL+w==
X-Received: by 10.112.168.170 with SMTP id zx10mr14112686lbb.0.1378691363141;
 Sun, 08 Sep 2013 18:49:23 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 18:49:23 -0700 (PDT)
In-Reply-To: <1378689796-19305-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234301>

On Sun, Sep 8, 2013 at 8:23 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> To prepare our uses for the upcoming changes we should warn them and let
> them know that they will need to specify a merge or a rebase in the
> future (when a non-fast-forward situation arises). Also, let them know
> we fallback to 'git pull --merge', so when the obsoletion of this mode
> comes, they know what to type without interrupting or changing their
> workflow.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

On top of this, we probably would want to update the documentation, so
the user can already read about what's going on when they type 'git
pull --help' as the warning suggests.

commit 60a2f5de7da2e119b858c7ab57b5f02cce9bdb9f
Author: Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun Sep 8 20:40:21 2013 -0500

    pull: add documentation about non-ff merges

    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 6d55737..d503924 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -23,6 +23,7 @@ More precisely, 'git pull' runs 'git fetch' with the given
 parameters and calls 'git merge' to merge the retrieved branch
 heads into the current branch.
 With `--rebase`, it runs 'git rebase' instead of 'git merge'.
+With `--merge`, it forces the merge, even if it's non-fast forward.

 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
@@ -41,9 +42,26 @@ Assume the following history exists and the current branch is
 ------------
          A---B---C origin/master
         /
+    D---E master
+------------
+
+Then `git pull` will merge in a fast-foward way up to the new master.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-foward case looks very different.
+
+------------
+         A---B---C origin/master
+        /
     D---E---F---G master
 ------------

+In the future, `git pull` will fail on these situations, however, most likely
+you would want to force a merge, which you can do with `git pull --merge`.
+
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the

-- 
Felipe Contreras
