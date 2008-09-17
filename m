From: Andreas Ericsson <ae@op5.se>
Subject: Re: Project organisation and structure
Date: Wed, 17 Sep 2008 19:01:47 +0200
Message-ID: <48D137FB.70502@op5.se>
References: <bcf9fe2c0809170649x3f377c7erecc9f69a4a664d52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: k wayne <pleexed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 19:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg0TS-00040O-Gq
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 19:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbYIQRBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 13:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758074AbYIQRBx
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 13:01:53 -0400
Received: from mail.op5.se ([193.201.96.20]:56427 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757158AbYIQRBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 13:01:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 998F81B80046;
	Wed, 17 Sep 2008 18:51:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cEvrbdoqZoSs; Wed, 17 Sep 2008 18:51:43 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 2BC3A24B0005;
	Wed, 17 Sep 2008 18:51:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <bcf9fe2c0809170649x3f377c7erecc9f69a4a664d52@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

k wayne wrote:
> Hello,
> I'm new to git, and I hope this is the right mailinglist for what I'm
> going to ask; it was the only one I found on http://git.or.cz. Sorry
> if it's not or my question is remarkably stupid. I've read the git
> documentation, of course, but it wasn't always easy to wrap my head
> around all the concepts, so I might have missed an obvious solution to
> my problem.
> 

This is the right place, and no you didn't miss anything obvious.


> I have a collection of libraries and programs, which aren't coupled
> too much, but aren't really independent either; for example, library X
> depends on Y, program Z on lib A and so forth. Since all of these libs
> and programs are logically connected to each other in some way, I
> would like to have them all in one central repository.
> So I heard that I could create kind of a "meta-repository" for the
> whole project, and have submodules for each library or program, which
> sounds exactly like what I want. However, I've been told that my
> current directory layout will not work this way with git.
> 
> This is how my project root directory (say it's ~) looks like:
> ~/build - Build files which apply for the whole project, like doxygen
> build files.
> ~/include/$submodule - Each library/program has an own directory here,
> in which all header files go.
> ~/projects/$submodule - Files related to an individual project, like
> makefiles etc.
> ~/src/$submodule - Like the above two, but for source files.
> ~/test/$submodule - Again, a directory for each library/program,
> containing files for (unit)tests.
> ~/doc - Documentation files for the project as a whole.
> ~/doc/$submodule - Documentation files for individual libraries/programs.
> 
> These are the directories I would like git to track for me. There are
> some other dirs not listed here (e.g. for object files,) but I can
> easily add them to .gitignore.
> 
> So, the git structure as I imagine it would look like this: ~/.git
> contains the "meta-repository," in which all the submodules reside.
> Each submodule would have its .git directory in ~/projects/$submodule.
> Alternatively, ~/.git for the meta-repo and ~/.git-$subproject or
> something like this would be okay too.
> 
> However, I have been told I cannot go to ~/projects/$submodule and do
> a "git add ../../{include,src,test,doc}/$submodule" there.

Right. That would break things rather horribly as you're trying to add
files below the root of your repository.

> I could add
> symlinks in ~/projects/$submodule to each of these dirs and add that
> link, but this would not work with windows, I guess (would it work
> with git, anyway?)
> 

It would work with git, and it will work on windows, sort of. Git knows
that the symlink is a symlink, but it will check out a proper copy of
the actual file in its place on windows. You just have to be careful
when updating it, as tests and stuff before you've committed to git
might break with one file being the old revision still.

> So, how can I manage my code without having to restructure my tree?
> 

Short answer; Lots of symlinks.

Longer answer:
Are you really sure that's the best structure for your code? I usually
find it absolutely simplest to bundle tests, buildrules and source
all in one directory (possibly with tests and documentation in a subdir),
but otherwise keep it all jumbled together. There's a very important
reason for this, and it's that your .cpp files shouldn't have to know
what some other buildsystem is doing with its header files, so you
should always be able to #include "header_for_this_api.hpp" and be
done with it.

If I were you, I'd do something like this:
/: top-level buildstuff
/doc: collection-wide documentation ("this suite of programs blahblah")
/t: integration tests
/lib/$library_subproject - holds library source/build/unit-tests/doc
/src/$program_subproject - holds program source/build/unit-tests/doc

After all, you're mostly updating one library or program at a time, right?
If you're not and all the API's are in wild flux, you should probably
just keep it jumbled in a single git repository for the moment and split
them later when things have calmed down a bit.

> I'd like to keep it that way, because it is convenient to have only
> one directory to pass to the compiler as an additional include dir,
> and can include my header files as "submodule/someheader.hpp" which
> is, in my opinion, helpful in organizing the code.
> 

With the layout above, you just pass -I./lib as include dir and use
	#include <$library/header.hpp>
in your cpp files, which is presumably what you'd use if you'd installed
the headers in the normal location too.

> If there should be no way I can keep my directory setup the way it is
> with the current git, would a feature request be a good idea (and
> possibly implemented),

A feature request to be able to track files outside the repository would
require some major surgery to the most basic of git objects, so I assume
such a feature wouldn't be too well received.

> or does my directory tree have a serious flaw I
> haven't stumbled across yet, which makes it unusable anyways?
> 

I'd call it unusable to have to hop to several different directories to
add a single public function to a library, but perhaps that's just me?

Perhaps your programs contain mini-libraries that are shared at link-time
between applications? My advice in that case is to turn them into libraries
and make proper API's from them. That way the above directory structure
will give you everything you want while maintaining each individual
component separated in its own repository.

http://people.redhat.com/drepper/goodpractice.pdf holds a very nice and
concise writeup on how to create API's. I follow to the letter in most
of my library-like projects.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
