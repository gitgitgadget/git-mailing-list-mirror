From: Paul Campbell <pcampbell@kemitix.net>
Subject: [BUG/PATCH] contrib/subtree: allow addition of remote branch with
 name not locally present
Date: Wed, 27 Feb 2013 23:51:13 +0000
Message-ID: <CALeLG_ndDWyPWRBQtKV4WswZUKRpNQzCAXmB0f0yoKGsAYMUig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adam Tkac <atkac@redhat.com>, David Greene <greened@obbligato.org>,
	Jesper Lyager Nielsen <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 00:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAqmh-0000lE-8E
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 00:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758725Ab3B0XvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 18:51:14 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:46618 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab3B0XvN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 18:51:13 -0500
Received: by mail-oa0-f51.google.com with SMTP id h2so2477572oag.24
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 15:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=ZnVdQxIc01UYcogQx2gv4XYleZbn6aVw0xaQWsOz4Fk=;
        b=WeEiWQJL0hYUI/eEbBqR3pPpTYE8VvKDeNN6U5hk4ZITf19MMeUm3d7e/ByAMmcrXN
         s4V8tPOztQstJ2Sw+g0HBdOPCrOqq+3mluj1vfceNv5gk779Xu6ZpMAZlw54Xafw6Lwk
         FGAH4qHYmYXT/YQspNVzkl7W7+T8nF30lkAAwogHTbF9GteAOeuTjO9L1hxK/yZSJcZV
         hTI/ahbVi3h9khPe9/sdYzntkzBMYLkswINWUjuuscp58aUE+O+bU992uqPyzCuK0jFs
         PBQHPBVCcnRqXe3PeQ+tfmO/It1IO7nCgN4w49a9Jcjmwsfn3/pp2u+zCWUbn0gV7QkX
         LP2g==
X-Received: by 10.60.171.144 with SMTP id au16mr4269968oec.56.1362009073324;
 Wed, 27 Feb 2013 15:51:13 -0800 (PST)
Received: by 10.76.132.234 with HTTP; Wed, 27 Feb 2013 15:51:13 -0800 (PST)
X-Originating-IP: [2.102.86.232]
X-Gm-Message-State: ALoCoQmmL9XAA5cATnVMHxWPW7qNYMix3Y+Hok34xA0XD6rAYn9MvCN562ekzYi/5BEpJogOqPK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217227>

cmd_add() attempts to check for the validity of refspec for the repository
it is about to add as a subtree. It tries to do so before contacting the
repository. If the refspec happens to exist locally (say 'master') then
the test passes and the repo is fetched. If the refspec doesn't exist
locally then the test fails and the remote repo is never contacted.

Removing the tests still works as the git fetch command fails with the
perfectly accurate error:

  fatal: Couldn't find remote ref <refspec>

Signed-off-by: Paul Campbell <pcampbell@carnegiecollege.ac.uk>
---

I must confess to not understanding the comment preceding the
rev-parse test. Given that it is against the rev-parse and not the
cmd_add_repository call I'm assuming it can be removed.

 contrib/subtree/git-subtree.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..9a38b18 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -503,14 +503,6 @@ cmd_add()

            "cmd_add_commit" "$@"
        elif [ $# -eq 2 ]; then
-           # Technically we could accept a refspec here but we're
-           # just going to turn around and add FETCH_HEAD under the
-           # specified directory.  Allowing a refspec might be
-           # misleading because we won't do anything with any other
-           # branches fetched via the refspec.
-           git rev-parse -q --verify "$2^{commit}" >/dev/null ||
-           die "'$2' does not refer to a commit"
-
            "cmd_add_repository" "$@"
        else
            say "error: parameters were '$@'"
--
1.8.2.rc1


-- 
Paul [W] Campbell
