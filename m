From: Johan Herland <johan@herland.net>
Subject: [PATCH] Bring local clone's origin URL in line with that of a remote
 clone
Date: Mon, 01 Sep 2008 21:07:33 +0200
Message-ID: <200809012107.34020.johan@herland.net>
References: <200808271400.54302.johan@herland.net>
 <200808310123.48018.johan@herland.net>
 <7vabeuf4oj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:09:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaEmD-0002Tj-Hl
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbYIATIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbYIATIU
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:08:20 -0400
Received: from smtp.getmail.no ([84.208.20.33]:36128 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbYIATIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:08:19 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K6J0022H6HF2S00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 01 Sep 2008 21:08:03 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6J00DGH6GMJ930@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 01 Sep 2008 21:07:34 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6J00EZ96GMQT40@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 01 Sep 2008 21:07:34 +0200 (CEST)
In-reply-to: <7vabeuf4oj.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94600>

On a local clone, "git clone" would use the fully DWIMmed path as the origin
URL in the resulting repo. This was slightly inconsistent with the case of a
remote clone where the _given_ URL was used as the origin URL (because the
DWIMming was done remotely, and was therefore not available to "git clone").

This behaviour caused problems when cloning a local non-bare repo with
relative submodule URLs, because these submodule URLs would then be resolved
against the DWIMmed URL (e.g. "/repo/.git") instead of the given URL (e.g.
"/repo").

This patch teaches "git clone" to use the _given_ URL - instead of the
DWIMmed path - as the origin URL. This causes relative submodule URLs to be
resolved correctly, as long the _given_ URL indicates the correct directory
against which the submodule URLs should be resolved.

The patch also updates a testcase that contained the old-style origin URLs.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Sunday 31 August 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > $ git clone /repo/foo bar
> > $ grep -B1 url bar/.git/config
> > [remote "origin"]
> >         url = /repo/foo/.git
> >
> > vs.
> >
> > $ git clone file:///repo/foo bar
> > $ grep -B1 url bar/.git/config
> > [remote "origin"]
> >         file:///home/johan/git/foo
> >
> > Hmm?
>
> If you mean "the latter lacks 'url =' and is broken", and if that is what
> happens, then it needs to be fixed.  But otherwise, I do not personally
> find these differences interesting.

Sorry, my fault (cut-n-paste error)

> But that does not mean I'd veto if somebody else cares deeply enough and
> comes up with a clean solution.

Is this clean enough? It passes selftests on my box, and although it
doesn't resolve all the issues I raised in this thread, it _does_ resolve
the one issue that I first bumped into, and that triggered this thread in
the first place. I expect this one issue is also the first that most other
people would bump into when working locally with relative submodule URLs.


Have fun! :)

...Johan


 builtin-clone.c   |    2 +-
 t/t5505-remote.sh |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index c0e3086..f44ecea 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -387,7 +387,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	path = get_repo_path(repo_name, &is_bundle);
 	if (path)
-		repo = path;
+		repo = xstrdup(make_nonrelative_path(repo_name));
 	else if (!strchr(repo_name, ':'))
 		repo = xstrdup(make_absolute_path(repo_name));
 	else
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index be9ee93..c449663 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -109,7 +109,7 @@ test_expect_success 'remove remote' '
 
 cat > test/expect << EOF
 * remote origin
-  URL: $(pwd)/one/.git
+  URL: $(pwd)/one
   Remote branch merged with 'git pull' while on branch master
     master
   New remote branch (next fetch will store in remotes/origin)
@@ -140,7 +140,7 @@ test_expect_success 'show' '
 
 cat > test/expect << EOF
 * remote origin
-  URL: $(pwd)/one/.git
+  URL: $(pwd)/one
   Remote branch merged with 'git pull' while on branch master
     master
   Tracked remote branches
@@ -169,7 +169,7 @@ test_expect_success 'prune' '
 
 cat > test/expect << EOF
 Pruning origin
-URL: $(pwd)/one/.git
+URL: $(pwd)/one
  * [would prune] origin/side2
 EOF
 
-- 
1.6.0.96.g2fad1
