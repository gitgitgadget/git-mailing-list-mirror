From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 18:10:36 +0200
Message-ID: <507AE3FC.3040200@web.de>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi> <7vd30m2sbr.fsf@alter.siamese.dyndns.org> <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi> <7vzk3p1xh3.fsf@alter.siamese.dyndns.org> <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi> <507ABDF3.4040106@web.de> <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lauri Alanko <la@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:11:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNQmG-0002oN-LU
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 18:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab2JNQKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 12:10:45 -0400
Received: from mout.web.de ([212.227.15.4]:54182 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535Ab2JNQKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 12:10:44 -0400
Received: from [192.168.178.41] ([79.193.81.106]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Mcni1-1T62Vv2UzJ-00IS3A; Sun, 14 Oct 2012 18:10:43
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
X-Provags-ID: V02:K0:HRy6lEBz0z/r+NjjACStpj8DovRkDukXRGQmUeiKxaD
 xP4NQLCjXXk1dwVm9o21HuYNH0rg+vOIVUNNDp5/wZrFVRppU5
 UtD8v0nphnxjDEdU5HWWCmFJhKYHhTfeBKVLLptqPg7RcUkr8I
 YpAyuaQBlStS76EQOhnGHcZzLgf371q9o5Vw3Esnvp4wvxAq2B
 QTFIt7waD7uElWLJtto1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207672>

Am 14.10.2012 17:27, schrieb Lauri Alanko:
> Quoting "Jens Lehmann" <Jens.Lehmann@web.de>:
> 
>>>>> If the
>>>>> submodules ever get reorganized and foo is moved to ./bar, then it is
>>>>> impossible to check out older versions or alternate branches, since
>>>>> the submodule is no longer where it is expected to be at the origin.
> 
>> Your initial statement is not correct.
> 
> Please elaborate. My initial statement was about "git submodule add ./foo", and this is what I get:
> 
> la@bq:~/tmp$ git --version
> git version 1.8.0.rc2.2.gfc364c7
> la@bq:~/tmp$ git init super
> Initialized empty Git repository in /home/la/tmp/super/.git/
> la@bq:~/tmp$ cd super
> la@bq:~/tmp/super$ echo foo > foo
> la@bq:~/tmp/super$ git add foo
> la@bq:~/tmp/super$ git ci -m foo
> [master (root-commit) a0dd543] foo
>  1 file changed, 1 insertion(+)
>  create mode 100644 foo
> la@bq:~/tmp/super$ git init sub
> Initialized empty Git repository in /home/la/tmp/super/sub/.git/
> la@bq:~/tmp/super$ cd sub
> la@bq:~/tmp/super/sub$ echo bar > bar
> la@bq:~/tmp/super/sub$ git add bar
> la@bq:~/tmp/super/sub$ git ci -m bar
> [master (root-commit) a6ee6d6] bar
>  1 file changed, 1 insertion(+)
>  create mode 100644 bar
> la@bq:~/tmp/super/sub$ cd ..
> la@bq:~/tmp/super$ git submodule add ./sub
> Adding existing repo at 'sub' to the index
> la@bq:~/tmp/super$ git ci -m sub
> [master cb289e8] sub
>  2 files changed, 4 insertions(+)
>  create mode 100644 .gitmodules
>  create mode 160000 sub
> la@bq:~/tmp/super$ git branch old
> la@bq:~/tmp/super$ git mv sub movedsub
> fatal: source directory is empty, source=sub, destination=movedsub

This error here indicates that we didn't teach git to properly move
a submodule yet. It is one of my next goals to make "git [submodule]
mv sub movedsub" do the right thing here. To do these steps manually
you'll additionally have to do the following before moving the
submodule (because after moving it the relative paths will be broken):

$ HASH=$(cd sub; git rev-parse HEAD)

> la@bq:~/tmp/super$ mv sub movedsub

Currently it is better to remove the submodule here, as recreating it
with a "git submodule update" later will get the relative paths right.

> la@bq:~/tmp/super$ git rm sub
> rm 'sub'
> la@bq:~/tmp/super$ git add movedsub

And to git this adds a completely different submodule (as its name
is not "sub"), which breaks your expectation. To do what you intended
use this line instead:

$ git update-index --add --cacheinfo 160000 $HASH movedsub

(With the "--next" option currently in the "next" branch of Junio's
repo a "git submodule add --name sub movedsub" should do the job.
Until then a bit more magic is necessary).

> la@bq:~/tmp/super$ git config -f .gitmodules submodule.sub.path movedsub
> la@bq:~/tmp/super$ git config -f .gitmodules submodule.sub.url ./movedsub
> la@bq:~/tmp/super$ git ci -am movedsub
> [master 5598bc0] movedsub
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename sub => movedsub (100%)
> la@bq:~/tmp/super$ cd ..
> la@bq:~/tmp$ git clone super superc
> Cloning into 'superc'...
> done.
> la@bq:~/tmp$ cd superc
> la@bq:~/tmp/superc$ git co old
> Branch old set up to track remote branch old from origin.
> Switched to a new branch 'old'
> la@bq:~/tmp/superc$ git submodule update --init
> Submodule 'sub' (/home/la/tmp/super/sub) registered for path 'sub'
> fatal: repository '/home/la/tmp/super/sub' does not exist
> Clone of '/home/la/tmp/super/sub' into submodule path 'sub' failed

And that fails because to be able to clone a submodule it has to be
pushed into its own repo first, so it can be cloned from there somewhere
else. After doing that this will work.

> So a normal relative path in .gitmodules to inside the tree is fragile, since the location of the submodule can change.

As I said, the current user experience is suboptimal. The test case
'submodule update properly revives a moved submodule' in t7406 shows
what has to be done with current git to properly move a submodule,
which is way too much to remember for a regular git user.
