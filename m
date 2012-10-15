From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: A design for subrepositories
Date: Mon, 15 Oct 2012 19:10:50 +0200
Message-ID: <507C439A.6060202@web.de>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi> <7vd30m2sbr.fsf@alter.siamese.dyndns.org> <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi> <7vzk3p1xh3.fsf@alter.siamese.dyndns.org> <20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi> <507ABDF3.4040106@web.de> <20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi> <507AE773.1010301@web.de> <20121015015934.1597359e76eaqvh2.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lauri Alanko <la@iki.fi>
X-From: git-owner@vger.kernel.org Mon Oct 15 19:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNoCH-0001SL-GX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 19:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab2JORLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 13:11:10 -0400
Received: from mout.web.de ([212.227.17.12]:54579 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953Ab2JORLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 13:11:09 -0400
Received: from [192.168.178.41] ([91.3.173.246]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MCqsR-1TFrhH1cVH-009arn; Mon, 15 Oct 2012 19:11:00
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121015015934.1597359e76eaqvh2.lealanko@webmail.helsinki.fi>
X-Provags-ID: V02:K0:JVOMiJOeUAxkvOYg4ErOeFKsXc0Z+Hh/gt2BvTNwPVu
 f9Up7borhUvfMyxfFyiCK18MwV39eq+0FW0i9ETRf6KDzdsbk+
 UYQIv7WYSauYkvpzzVVnjSCubsIG4evHrAz8zefT+tlwvRVZSo
 4Zs1XBn0HOfAYf32BC5OPrnavI5VPOwEqqYm1v6bbmOcdw/4dP
 BB06tfrP4eF9drh3MavoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207763>

Am 15.10.2012 00:59, schrieb Lauri Alanko:
>>> la@bq:~/tmp/super$ git mv sub movedsub
>>> fatal: source directory is empty, source=sub, destination=movedsub
>>
>> This error here indicates that we didn't teach git to properly move
>> a submodule yet. It is one of my next goals to make "git [submodule]
>> mv sub movedsub" do the right thing here.
> 
> I'll digress here a bit: I'm not really fond of the idea of adding
> special-purpose support into the core git commands. It just makes them
> messier, and there will always be other tools that won't be supported by
> git directly. I'd much rather see an mv-hook that arbitrary extensions
> could use to update metadata associated with a tree entry.

One third of the participants of the GitSurvey2010 stated that they are
using submodules (e.g. more than gitattributes), so adding some support
for them into the core doesn't look that unwarranted to me. And believe
me, without putting support in there the user experience will stay
suboptimal.

> Indeed, one of the reasons a separate tool seemed attractive to me was
> that that way I could be sure that the tool was a high-level utility
> that was completely implemented on top of basic low-level git
> operations. The fact that git's submodule support manifests as bits and
> pieces in various parts of the core seems a bit worrisome to me.

I see it the other way around: Due to the fact that submodules were
only accessible via the submodule script and not integrated into the
core made a lot of people (e.g. the Jenkins Git plugin we are using at
work) code around that. That wouldn't have been necessary if I would
have finished my submodule update work at that time.

And e.g. you can't forget to add changes inside the submodule anymore
since diff and status learned to show those changes. And we still have
mis-merges at my dayjob due to not updated submodules, which will go
away the moment merge learns to update all submodules without merge
conflicts. And so on.

> (Moreover, it's confusing to the user. I read the git-submodule man page
> and thought that that described all the available submodule operations.
> Only now did I find out that clone and fetch also have built-in
> submodule functionality.)

Then the man page might need some overhaul. Care to take a look?

>>> la@bq:~/tmp/super$ mv sub movedsub
>>
>> Currently it is better to remove the submodule here, as recreating it
>> with a "git submodule update" later will get the relative paths right.
> 
> This was a bit of a special case, as this was the original directory
> where we did "git init sub" and "git submodule add ./sub". So "sub"
> actually contains the real repository, not a gitlink to
> .git/modules/sub. Arguably "git submodule add" should move the local
> submodule's repository there.

That sounds like a good idea.

>>> la@bq:~/tmp/super$ git rm sub
>>> rm 'sub'
>>> la@bq:~/tmp/super$ git add movedsub
>>
>> And to git this adds a completely different submodule (as its name
>> is not "sub"), which breaks your expectation.
> 
> Submodule? This is just a normal git add, not git submodule add. I
> thought this just adds to the index a gitlink with the head revision in
> movedsub, which is the same as the head revision was in sub, so it's
> detected as a move of a gitlink.

You're free to use simple gitlinks, but then you can't expect existing
and coming goodies - like git being able to move them around in the
work tree - work all by itself, because they are only possible with
submodule support.

>> To do what you intended
>> use this line instead:
>>
>> $ git update-index --add --cacheinfo 160000 $HASH movedsub
> 
> Doesn't this do exactly the same thing as "git add" for a directory
> containing a repository?

In my test case "git add movesub" silently does nothing, as my
directory is empty. So I need the update-index here.

>>> la@bq:~/tmp/superc$ git submodule update --init
>>> Submodule 'sub' (/home/la/tmp/super/sub) registered for path 'sub'
>>> fatal: repository '/home/la/tmp/super/sub' does not exist
>>> Clone of '/home/la/tmp/super/sub' into submodule path 'sub' failed
>>
>> And that fails because to be able to clone a submodule it has to be
>> pushed into its own repo first, so it can be cloned from there somewhere
>> else. After doing that this will work.
> 
> Sorry, but I can't get this to work. To me it seems that when fetching
> submodules from the origin, submodule.sub.url has to point to the actual
> location of the repository, and if this is outdated or missing, the
> fetch won't work.
> 
> It would make sense that if the url is missing, the submodule repo
> inside origin's .git/modules would be used, but this doesn't seem to be
> the case currently.

No it isn't. Patches welcome ;-)

> Anyway, I am a bit surprised to hear of such active development for
> git-submodule. It's pretty old now (the shell script says 2007), and I
> thought that if it were to ever support the kind of basic functionality
> I require, it would do so already.

So much to do, so little time.

> How soon do you envision support for bare repositories with submodules?

I'm not sure what you mean by that and what your use case is, but I'll
be happy to discuss design issues with you. But as that is not my itch
I don't expect to be working on that soon, as my next main goal is to
get recursive checkout working (currently I'm removing the obstacles
I find in my way towards that, but there is still quite some work to
do until I get there).
