From: "Lauri Alanko" <la@iki.fi>
Subject: Re: A design for subrepositories
Date: Mon, 15 Oct 2012 01:59:34 +0300
Message-ID: <20121015015934.1597359e76eaqvh2.lealanko@webmail.helsinki.fi>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
	<7vd30m2sbr.fsf@alter.siamese.dyndns.org>
	<20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi>
	<7vzk3p1xh3.fsf@alter.siamese.dyndns.org>
	<20121014131928.25943ezwa6fveyls.lealanko@webmail.helsinki.fi>
	<507ABDF3.4040106@web.de>
	<20121014182746.42895rwvalv4uoz6.lealanko@webmail.helsinki.fi>
	<507AE773.1010301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; DelSp="Yes"; format="flowed"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 00:59:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNXA3-0002ul-PE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 00:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab2JNW7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 18:59:44 -0400
Received: from smtp-rs1-vallila2.fe.helsinki.fi ([128.214.173.75]:46071 "EHLO
	smtp-rs1-vallila2.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751749Ab2JNW7o convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 18:59:44 -0400
Received: from webmail.helsinki.fi (webmail1-vallila2.fe.helsinki.fi [128.214.173.135])
	by smtp-rs1.it.helsinki.fi (8.14.4/8.14.4) with ESMTP id q9EMxYqH014894;
	Mon, 15 Oct 2012 01:59:35 +0300
Received: from scan-proxy1-1.it.helsinki.fi (scan-proxy1-1.it.helsinki.fi
	[128.214.2.137]) by webmail.helsinki.fi (Horde Framework) with HTTP; Mon,
	15 Oct 2012 01:59:34 +0300
In-Reply-To: <507AE773.1010301@web.de>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207685>

>> la@bq:~/tmp/super$ git mv sub movedsub
>> fatal: source directory is empty, source=sub, destination=movedsub
>
> This error here indicates that we didn't teach git to properly move
> a submodule yet. It is one of my next goals to make "git [submodule]
> mv sub movedsub" do the right thing here.

I'll digress here a bit: I'm not really fond of the idea of adding
special-purpose support into the core git commands. It just makes them
messier, and there will always be other tools that won't be supported by
git directly. I'd much rather see an mv-hook that arbitrary extensions
could use to update metadata associated with a tree entry.

Indeed, one of the reasons a separate tool seemed attractive to me was
that that way I could be sure that the tool was a high-level utility
that was completely implemented on top of basic low-level git
operations. The fact that git's submodule support manifests as bits and
pieces in various parts of the core seems a bit worrisome to me.

(Moreover, it's confusing to the user. I read the git-submodule man page
and thought that that described all the available submodule operations.
Only now did I find out that clone and fetch also have built-in
submodule functionality.)

>> la@bq:~/tmp/super$ mv sub movedsub
>
> Currently it is better to remove the submodule here, as recreating it
> with a "git submodule update" later will get the relative paths right.

This was a bit of a special case, as this was the original directory
where we did "git init sub" and "git submodule add ./sub". So "sub"
actually contains the real repository, not a gitlink to
.git/modules/sub. Arguably "git submodule add" should move the local
submodule's repository there.

>> la@bq:~/tmp/super$ git rm sub
>> rm 'sub'
>> la@bq:~/tmp/super$ git add movedsub
>
> And to git this adds a completely different submodule (as its name
> is not "sub"), which breaks your expectation.

Submodule? This is just a normal git add, not git submodule add. I
thought this just adds to the index a gitlink with the head revision in
movedsub, which is the same as the head revision was in sub, so it's
detected as a move of a gitlink.

> To do what you intended
> use this line instead:
>
> $ git update-index --add --cacheinfo 160000 $HASH movedsub

Doesn't this do exactly the same thing as "git add" for a directory
containing a repository?

>> la@bq:~/tmp/superc$ git submodule update --init
>> Submodule 'sub' (/home/la/tmp/super/sub) registered for path 'sub'
>> fatal: repository '/home/la/tmp/super/sub' does not exist
>> Clone of '/home/la/tmp/super/sub' into submodule path 'sub' failed
>
> And that fails because to be able to clone a submodule it has to be
> pushed into its own repo first, so it can be cloned from there somewhere
> else. After doing that this will work.

Sorry, but I can't get this to work. To me it seems that when fetching
submodules from the origin, submodule.sub.url has to point to the actual
location of the repository, and if this is outdated or missing, the
fetch won't work.

It would make sense that if the url is missing, the submodule repo
inside origin's .git/modules would be used, but this doesn't seem to be
the case currently.

> Currently "git fetch" checks all newly fetched commits for changes in
> gitlinks too, so that would just add another file to that.

I only now realized that it is indeed enough to check .gitmodules only
in the _updated_ refs. The older refs are interested in their submodules
only up to a certain commit, and even if those submodules have been
updated upstream, we won't be interested in them until we have trees
with gitlinks pointing to the newer revisions.

So it turns out that my main technical argument against git-submodule's
potential scalability was false, and it is indeed feasible to make it
support all the features I require.

However, "always tip" mode would break this, since then even non-updated
branches might be interested in upstream changes to a submodule.


Anyway, I am a bit surprised to hear of such active development for
git-submodule. It's pretty old now (the shell script says 2007), and I
thought that if it were to ever support the kind of basic functionality
I require, it would do so already.

How soon do you envision support for bare repositories with submodules?


Lauri
