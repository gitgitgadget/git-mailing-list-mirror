From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: Re: git fetch refs and tags
Date: Wed, 24 Apr 2013 09:45:08 +0200
Organization: PHYTEC Messtechnik GmbH
Message-ID: <1366789508.3672.0.camel@lws-weitzel>
References: <1366714421.2899.10.camel@lws-weitzel>
	 <7vsj2hl2c7.fsf@alter.siamese.dyndns.org>
	 <CALKQrgdTyD+jX+2WqxArC2HPtWSLrhqL3YQ6M9-oYDvYSqU_-g@mail.gmail.com>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sitaramc@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUuOI-0007YF-UD
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765Ab3DXHpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 03:45:15 -0400
Received: from mail.phytec.de ([217.6.246.34]:47142 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757721Ab3DXHpO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 03:45:14 -0400
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id C250BBF0EC;
	Wed, 24 Apr 2013 09:43:33 +0200 (CEST)
Received: from [172.16.10.7] ([127.0.0.1])
          by idefix.phytec.de (Lotus Domino Release 8.5.3FP3)
          with ESMTP id 2013042409444143-168421 ;
          Wed, 24 Apr 2013 09:44:41 +0200 
In-Reply-To: <CALKQrgdTyD+jX+2WqxArC2HPtWSLrhqL3YQ6M9-oYDvYSqU_-g@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 8.5.3FP3|November 15, 2012) at
 24.04.2013 09:44:41,
	Serialize by Router on Idefix/Phytec(Release 8.5.3FP3|November 15, 2012) at
 24.04.2013 09:44:42,
	Serialize complete at 24.04.2013 09:44:42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222233>

Am Dienstag, den 23.04.2013, 22:50 +0200 schrieb Johan Herland:
> On Tue, Apr 23, 2013 at 4:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jan Weitzel <J.Weitzel@phytec.de> writes:
> >
> >> Hello,
> >> I have the following problem: I have 2 bare git repositories one has
> >> several branches and tags.
> >> If I try this in the second repository:
> >> git fetch -f ../main.git refs/heads/master:refs/heads/master
> >> I'm getting also tags from other branches, if I have an old object from
> >> one of the other branches.
> >> I would expect to have only tags pointing to master ref.
> >
> > A tag that points at a commit that is reachable from 'master' will
> > be followed, not just pointing _at_ 'master'.  For example, when
> > your 'master' is a bit beyond v1.2 release, it is likely you will
> > also get v1.1 and v1.0 tags (if your release structure is such that
> > new release contains everything old releases had).
> 
> That is all true, and behaves as expected. However, what Jan is observing
> is (I believe) equivalent to the following:
> 
Thank you for the explanation, you show exactly what I mean :)
Jan
> Remote repo:
> 
>   o---o---o---o <---- master, tag: spam
>    \      ^---- tag: eggs
>     \
>      o---o---o <---- tag: sausage
> 
> Local repo:
> 
>   o---o
>    \  ^---- master
>     \
>      o---o---o (unreachable)
> 
> Now, when Jan fetches master, he gets the new master, plus tags spam and
> eggs (as expected), but he ALSO gets tag sausage, which he _shouldn't_
> get, since it is not reachable from master (hence not part of the fetched
> history). The following session demonstrates the problem using the above
> example:
> 
> # Prepare history in repo1
> $ git init repo1
> Initialized empty Git repository in /home/johan/git/repo1/.git/
> $ cd repo1/
> $ echo foo>foo
> $ git add foo
> $ git commit -m a
> [master (root-commit) 92f92ec] a
>  1 file changed, 1 insertion(+)
>  create mode 100644 foo
> $ echo bar >> foo
> $ git commit -am b
> [master e90d835] b
>  1 file changed, 1 insertion(+)
> $ echo baz >> foo
> $ git commit -am c
> [master 09e4bb2] c
>  1 file changed, 1 insertion(+)
> $ echo xyzzy >> foo
> $ git commit -am d
> [master 13ce4fb] d
>  1 file changed, 1 insertion(+)
> $ git checkout -b side HEAD~3
> Switched to a new branch 'side'
> $ echo side >> foo
> $ git commit -am side
> [side 7294fc9] side
>  1 file changed, 1 insertion(+)
> 
> # Copy history to repo2, and make most of it unreachable
> $ cd ..
> $ git clone repo1 repo2
> Cloning into 'repo2'...
> done.
> $ cd repo2/
> $ git checkout -b master origin/master~2
> Switched to a new branch 'master'
> $ git remote rm origin
> $ git branch -D side
> Deleted branch side (was 7294fc9).
> $ git show-ref
> e90d8356350e4f2fd5e7bfb3a0327e2fa6115c2a refs/heads/master
> 
> # Create tags in repo1
> $ cd ../repo1/
> $ git checkout master
> Switched to branch 'master'
> $ git tag spam master
> $ git tag eggs master^
> $ git tag sausage side
> $ git branch -D side
> Deleted branch side (was 7294fc9).
> $ git show-ref
> 13ce4fbc1761562a36f755b081b0d44b657c25a9 refs/heads/master
> 09e4bb21112b0f0acb82ed3b0fd6af9c685c3799 refs/tags/eggs
> 7294fc90fc1fbd1dd941c8999518d4a4b57048b4 refs/tags/sausage
> 13ce4fbc1761562a36f755b081b0d44b657c25a9 refs/tags/spam
> 
> # Fetch master into repo2
> $ cd ../repo2
> $ git checkout -b foo
> Switched to a new branch 'foo'
> $ git fetch -f ../repo1 refs/heads/master:refs/heads/master
> From ../repo1
>    e90d835..13ce4fb  master     -> master
>  * [new tag]         eggs       -> eggs
>  * [new tag]         sausage    -> sausage
>  * [new tag]         spam       -> spam
> 
> # See that tag sausage was fetched even though it's not reachable from master
> $ git show-ref
> e90d8356350e4f2fd5e7bfb3a0327e2fa6115c2a refs/heads/foo
> 13ce4fbc1761562a36f755b081b0d44b657c25a9 refs/heads/master
> 09e4bb21112b0f0acb82ed3b0fd6af9c685c3799 refs/tags/eggs
> 7294fc90fc1fbd1dd941c8999518d4a4b57048b4 refs/tags/sausage
> 13ce4fbc1761562a36f755b081b0d44b657c25a9 refs/tags/spam
> $ git log --graph --decorate --all --oneline
> * 7294fc9 (tag: sausage) side
> | * 13ce4fb (tag: spam, master) d
> | * 09e4bb2 (tag: eggs) c
> | * e90d835 (HEAD, foo) b
> |/
> * 92f92ec a
> 
> 
> Have fun! :)
> 
> ...Johan
> 
> --
> Johan Herland, <johan@herland.net>
> www.herland.net
