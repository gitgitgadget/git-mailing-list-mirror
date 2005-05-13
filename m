From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: Adapting scripts to work in current (not top) directory
Date: Fri, 13 May 2005 14:59:08 +0400
Message-ID: <200505131459.08891.snake@penza-gsm.ru>
References: <200505121758.10971.snake@penza-gsm.ru> <20050512201215.GI324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 13 12:52:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWXle-0000Hn-My
	for gcvg-git@gmane.org; Fri, 13 May 2005 12:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVEMK72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 06:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVEMK72
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 06:59:28 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:2460 "HELO
	penza-gsm.ru") by vger.kernel.org with SMTP id S262338AbVEMK7P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 06:59:15 -0400
Received: (qmail 12019 invoked from network); 13 May 2005 10:59:12 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 13 May 2005 10:59:10 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <20050512201215.GI324@pasky.ji.cz>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	TW_MK,USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Friday, 13 May 2005 00:12 Petr Baudis wrote:
> Dear diary, on Thu, May 12, 2005 at 03:58:10PM CEST, I got a letter
> where Alexey Nezhdanov <snake@penza-gsm.ru> told me that...
>
> > All git and cogito scripts wants .git subdirectory. If I'm in a
> > subdirectory that have no .git direcory in it I'm out of luck.
>
> This is fine for Cogito, but Git itself shouldn't care - unless you mean
> the bundled mini-plumbing scripts. I don't know if anyone (and who) uses
> them except Linus, but I'm not likely to make much effort to maintain
> them, or even to actually accept any non-trivial changes to them.
>
> > I have wrote an example script that determines the lowest possible .git
> > directory position and changes to it to satisfy user request.
> >
> > Problems with script:
> > 1) May be I misunderstood the git ideology and it needs not this at all.
>
> Cogito really needs it.
Ok, so sticking with cogito.

> > if point (1) is false then there are couple of other problems:
> > 2) Script is extremelly ugly. I'm a week bash programmer so please
> > criticize.
> > 3) This logic shold be somehow embedded to all git- and cg- 
> > scripts. I can not figure how to do it non-intruisively.
>
> Add it to cg-Xlib. You can just update $_git appropriately. (Except when
> you were explicitly passed GIT_DIR.)
ok, that's easy.
>
> > gitpath=
> > subpath=
> > curpath=`pwd`
> > for ((i=2;i<9999;i=i+1)) ; do {
> >         path1=`echo $curpath | cut -d / -f 0-$i`
> >         path2=`echo $curpath | cut -d / -f $((i+1))-`
> >         [ -d "$path1"/.git ] && gitpath=$path1 && subpath=$path2
> >         [ "$path1" == "$curpath" ] && break
> > }; done
>
> I would gradually trim the $curpath by $(dirname) until I hit
> $curpath/.git or the root directory.
I have opted for current directory and not root. Explanation is later this 
mail. New variant:
=========================
--- /home/snake/scm/cogito/cg-Xlib      2005-05-12 08:47:29.000000000 +0400
+++ cg-Xlib     2005-05-13 13:40:58.000000000 +0400
@@ -8,7 +8,17 @@
 
 _cg_cmd=${0##*/}
 
-_git=${GIT_DIR:-.git}
+repopath=`pwd`
+while ((1)) ; do {
+  [ -d "$repopath/.git" ] && break
+  [ "$repopath" == "/" ] && {
+    repopath=`pwd`;
+    break;
+  };
+  repopath=`dirname $repopath`
+}; done
+
+_git=${GIT_DIR:-$repopath/.git}
 _git_objects=${GIT_OBJECT_DIRECTORY:-$_git/objects}
=========================
Here is a problem:
Because of git backend only some of the commands should be enabled to work 
from current directory. F.e. cg-init should not scan upper directories for 
".git" but should instead stick to current directory. In the script above 
this workarounded as choosing current directory instead of root but this will 
broke if we trying to initialise repo in a subdirectory of another repo.
So I have analysed list of cogito commands to find out which ones should be 
adopted to use "find repo" behaivoir:

"+" means "definitely yes"
"-" means "definitely no"
"?" means "not sure"
"." means "not matter"

+ cg-add
? cg-admin-lsobj
- cg-admin-uncommit
? cg-branch-add
? cg-branch-ls
- cg-cancel
- cg-clone
- cg-commit
+ cg-diff
- cg-export
. cg-help
- cg-init
+ cg-log
+ cg-ls
- cg-merge
+ cg-mkpatch
? cg-patch
- cg-pull
- cg-restore
+ cg-rm
- cg-seek
+ cg-status
- cg-tag
? cg-tag-ls
- cg-update
. cg-version

Any opinions?

-- 
Respectfully
Alexey Nezhdanov

