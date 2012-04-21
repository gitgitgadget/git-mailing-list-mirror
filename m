From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: contrib/workdir/git-new-workdir broken in 1.7.10 after introducing
 gitfiles
Date: Sat, 21 Apr 2012 20:45:23 +0200
Message-ID: <4F930043.1080506@web.de>
References: <CAHsq6J6JOTYfEtK0Z=_qfMFf9N1DWQ4zx46YhBbNu-1gEMyfog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Antonin Hildebrand <antonin@hildebrand.cz>
X-From: git-owner@vger.kernel.org Sat Apr 21 20:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLfKF-000326-Sp
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 20:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab2DUSps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 14:45:48 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:37082 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab2DUSpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 14:45:47 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate07.web.de (Postfix) with ESMTP id C43C411FDA67
	for <git@vger.kernel.org>; Sat, 21 Apr 2012 20:45:28 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.156.147]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MTxxp-1SltPG2lVp-00QnFP; Sat, 21 Apr 2012 20:45:24
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAHsq6J6JOTYfEtK0Z=_qfMFf9N1DWQ4zx46YhBbNu-1gEMyfog@mail.gmail.com>
X-Provags-ID: V02:K0:DPR0MVpLCPR0GntpGP3R+n9nWhz4rQmlVRlOyW8PWCe
 hQ3Gi+/sPsw6gdPF5Sm7msGukjnwrZdnztTmtRQb5KrafIr/Zx
 Cqtc0ffKkfRjHmeUKUNwVP4x97YLJsT5jqUW/hnBNdHIQCEoem
 eSC2Q5rLavqhBz8Q6zMFeEc3IXCpUydXCPB6N+MdjgB7aJH2ti
 FbdidE6smVSBUICmJtu6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196056>

Am 20.04.2012 22:16, schrieb Antonin Hildebrand:
> Hi there,
> 
> I'm just solving same problem as described here in the question:
> http://stackoverflow.com/questions/4115817/duplicate-submodules-with-git
> 
> I wanted to try proposed solution, but git-new-workdir does not work
> in latest release 1.7.10.
> 
> The problem are plaintext .git files pointing to the root
> "superproject" .git directory. The script has not been updated to deal
> with this new situation.

The problem is not the gitfile, but the core.worktree setting. And
I don't see how that script can be updated to deal with the new
situation. Since 1.7.8 the core.worktree setting is used to point
from the submodules .git directory to its work tree. And as
git-new-worktree just links the config file, it inherits the
core.worktree setting too, so that will always point to the first
work tree even when in the new workdir. And if git-new-worktree
would change core.worktree, the first work tree will stop working.

I'm not sure why git-new-workdir is used here anyways, the only reason
I can think of is to save some disk space. So use a regular submodule
there and everything should work for you (at the expense of having the
same object store on disk twice).

But it seems like a check is missing in the git-new-workdir script if
the core.worktree setting is used, as it will never do what it is meant
to when that is set and doesn't point to the target directory. Maybe
something like the patch below?

What I worry about is that after this change it will give users who
follow the above mentioned recipe a misleading advice, as following it
will make the first submodule stop working. But from the perspective of
git-new-workdir this change makes sense, and maybe we have to fix the
stackoverflow recipe instead ... on the other hand, problems like this
could be the avoided if we'd use the "if we reached thru a gitfile,
then the working tree is where you found that gitfile" setup logic
outlined in
http://permalink.gmane.org/gmane.comp.version-control.git/188007

Opinions?

----8<-----
Subject: [PATCH] git-new-workdir: Suggest unsetting the core.worktree setting

Linking to a repository that has the core.worktree option set can only
work when that core.worktree setting already points to the new-workdir.
In all other cases strange things will happen, as new-workdir will be
overridden by that setting.

So just die when that setting is found and tell the user why and that he
should remove it.

Reported-by: Antonin Hildebrand <antonin@hildebrand.cz>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 contrib/workdir/git-new-workdir |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 75e8b25..90cc207 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -41,6 +41,14 @@ then
 		" remove from \"$git_dir/config\" to use $0"
 fi

+# don't link to a repository that has core.worktree defined
+coreworktree=$(git --git-dir="$git_dir" config --get core.worktree)
+if test -n "$coreworktree"
+then
+	die "\"$git_dir\" has core.worktree set to \"$coreworktree\"," \
+		" remove from \"$git_dir/config\" to use $0"
+fi
+
 # don't link to a workdir
 if test -h "$git_dir/config"
 then
-- 
1.7.10.208.gb5e6d
