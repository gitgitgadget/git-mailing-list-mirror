From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] remotes-hg: bugfix for fetching non local remotes
Date: Thu, 25 Jul 2013 14:12:17 -0500
Message-ID: <CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com>
References: <1374712977-3215-1-git-send-email-dev@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org, apelisse@gmail.com
To: Joern Hees <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Thu Jul 25 21:12:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Qxc-0003gN-AE
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 21:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757460Ab3GYTMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 15:12:20 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:35358 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762Ab3GYTMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 15:12:19 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so57783lab.6
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ekYfxHHXMWtzrokF66E6CtVPI0cplmGzwi3wvYAZdyk=;
        b=ct0megm7vM2xF0rhn246yqA87Ba+bM35nHhOnHngd4B0DH4uYD9x9cM9bcMeLiuzCm
         SeWay5l8lbPDITeKvOHiII21Vqnc9u1raEehzASfWX8eNETo6Ed1lDBv7JPzT5EDC/dd
         ARHqhG08yKmAYQoUPfBHnMTslIevLs2ORXIEPrr1zomXIYV81tOYti3B4yqp3aW9I4wB
         +UdALLriLZRfOyRU5KeKiXY3G175uW+VCeJULc8in3Ro0wyte/2Bh61k1imrIgC5Egmm
         ZrPy7cPXS/Tu+PqrbXzqq1yStO4JOVSVEkE9a5XxzZz8mh/WyT1yffPoYuiLXvx2Bezu
         QzvA==
X-Received: by 10.152.178.229 with SMTP id db5mr4877913lac.33.1374779538016;
 Thu, 25 Jul 2013 12:12:18 -0700 (PDT)
Received: by 10.114.175.227 with HTTP; Thu, 25 Jul 2013 12:12:17 -0700 (PDT)
In-Reply-To: <1374712977-3215-1-git-send-email-dev@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231144>

On Wed, Jul 24, 2013 at 7:42 PM, Joern Hees <dev@joernhees.de> wrote:
> 6796d49 introduced a bug by making shared_path == ".git/hg' which
> will most likely exist already, causing a new remote never to be
> cloned and subsequently causing hg.share to fail with error msg:
> "mercurial.error.RepoError: repository .git/hg not found"
>
> Changing shared_path to ".git/hg/.shared" will solve this problem
> and create a shared local mercurial repository for non local remotes.
> The initial dot circumvents a name clash problem should a remote be
> called "shared".
>
> Signed-off-by: Joern Hees <dev@joernhees.de>
> Mentored-by: Antoine Pelisse <apelisse@gmail.com>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 0194c67..f4e9d1c 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -390,7 +390,7 @@ def get_repo(url, alias):
>          if not os.path.exists(dirname):
>              os.makedirs(dirname)
>      else:
> -        shared_path = os.path.join(gitdir, 'hg')
> +        shared_path = os.path.join(gitdir, 'hg', '.shared')
>          if not os.path.exists(shared_path):
>              try:
>                  hg.clone(myui, {}, url, shared_path, update=False, pull=True)
> --
> 1.8.3.4

I don't like this approach because if it's a huge repository the user
would have to clone again, not only if he was using v1.8.3, but also
if he was using the latest and greatest (because you are changing the
location again). It's relatively trivial to move from the old to the
shared organization, so that's what I vote for. Besides, I don't see
the point of having a '.shared/.hg' directory, and nothing else on
that '.shared' folder.

So, here's my patch. If only Junio read them.

Subject: [PATCH] remote-hg: add shared repo upgrade

6796d49 (remote-hg: use a shared repository store) introduced a bug by
making the shared repository '.git/hg', which is already used before
that patch, so clones that happened before that patch, fail after that
patch, because there's no shared Mercurial repo.

It's trivial to upgrade to the new organization by copying the Mercurial
repo from one of the remotes (e.g. 'origin'), so let's do so.

Reported-by: Joern Hees <dev@joernhees.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg.py
b/contrib/remote-helpers/git-remote-hg.py
index 0194c67..57a8ec4 100755
--- a/contrib/remote-helpers/git-remote-hg.py
+++ b/contrib/remote-helpers/git-remote-hg.py
@@ -396,6 +396,13 @@ def get_repo(url, alias):
                 hg.clone(myui, {}, url, shared_path, update=False, pull=True)
             except:
                 die('Repository error')
+        else:
+            # check and upgrade old organization
+            hg_path = os.path.join(shared_path, '.hg')
+            if not os.path.exists(hg_path):
+                repos = os.listdir(shared_path)
+                local_hg = os.path.join(shared_path, repos[0], 'clone', '.hg')
+                shutil.copytree(local_hg, hg_path)

         if not os.path.exists(dirname):
             os.makedirs(dirname)
-- 
1.8.3.3

-- 
Felipe Contreras
