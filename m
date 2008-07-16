From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 11:43:03 -0400
Message-ID: <32541b130807160843k25f1d7d3u8bfecd6c1c6eab91@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nigel Magnay" <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 17:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ9Al-00084m-TJ
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 17:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbYGPPnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbYGPPnH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 11:43:07 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:23568 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbYGPPnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 11:43:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so68948and.103
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JHd+Rn0IZCQdjuD1aKiRgV5p/MTmuvJEmF+LMKcBzuc=;
        b=KjP5UC5oujJRQDpDxuHpc/0VOgOld0m+cnfvL5t+av7Uj2p5BmvWiwgNL6RJ1NVHvO
         BxN5t6BPwxME8XsdsxdxkcBxAVMeZmEKfHBBjb0eYOg0c6KmyKOGugS7TXiVf5Gg666D
         rl7z/7pCXkoNOQz2jNIGVNXCe80vh1Vs+YLfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JJbLrbsYU1xEb7PCzCiWSQr8bq3MtXqZLf+3MqmzSvQgNFNUNIWWTPnfYT+CkJ2H2v
         qE2HAPVzLtuh4435wNcSpyOHLIKbgiZcOuququc7faL9/JA176fm4kP5GYN0nvY7Ou02
         WStfVeUtm4n0tDOOuv3r13IIgxQVi6ZnEGhdk=
Received: by 10.100.93.19 with SMTP id q19mr2210027anb.139.1216222983465;
        Wed, 16 Jul 2008 08:43:03 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 08:43:03 -0700 (PDT)
In-Reply-To: <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88691>

On 7/16/08, Nigel Magnay <nigel.magnay@gmail.com> wrote:
> I wonder if this is a fairly common pattern. We tend to have modules
>  as git repositories, and projects that tie together those git
>  repositories as submodules. [and submodules are necessary because they're
>  shared between multiple supermodules].

I have exactly the same problem as you, and have been working on
improving my own workflow so that someday I can offer patches that
might be generally applicable.

In the meantime, my solution is... some shell scripts checked in at
the top level of my project. :)

In one of my applications, I have a /wv submodule, which provides a
cross-platform build environment.  That environment respectively
contains a /wv/wvstreams submodule, which is a library that we use.

When I make a change to wvstreams that's needed for my application, I
need to check into wvstreams, then check that link into wv, then check
that link into the application.  Then, when I push, I have to make
sure to always push wvstreams first, then wv, then application, or
else other users can end up with "commit id xxxxxx not found" type
errors.

So basically, committing is always harmless, since I can do anything I
want in my own repo (and I want to be able to update wvstreams
*without* always updating wv, and so on).  The tricky part is pushing.
 Here's the script I wrote to make sure I don't screw up when pushing:


~/src/vx-lin $ cat push-git-modules
#!/bin/sh -x
set -e
test -e wv/wvstreams/Makefile
(cd wv/wvstreams && git push origin HEAD:master) &&
(cd wv && git push origin HEAD:master) &&
git push origin HEAD:master ||
echo "Failed!"


Now, this script is pretty flawed.  Notably, it always pushes to the
'master' branch, which is stupid.  However, it works in our particular
workflow, because wvstreams isn't being modified by too many
developers and it's okay if we all commit to master.  This is also
aided by the fact that people are trained to push only after they've
made all the unit tests pass, etc.  And further, individual apps don't
have to update their wvstreams to the latest anyway unless they really
need the latest changes, which is a wonderful feature of git
submodules.

Now, sometimes the above push script will fail.  In my experience,
this is only when someone else has pushed in something before you,
which means a fast-forward is not possible on at least one of the
repos.  When that happens, you have to pull first, using this script:

~/src/vx-lin $ cat newest-git-modules
#!/bin/sh -x
set -e
test -e wv/wvstreams/Makefile
git pull origin master &&
(cd wv && git pull origin master) &&
(cd wv/wvstreams && git pull origin master) ||
echo "Failed!"

This pulls in the latest version of application, wv, and wvstreams, in
that order, and stops in case of any merge conflicts so that you can
resolve them by hand.  It's safe to run the above script more than
once in case you're not sure if it's done or not.

After pulling the new modules, you may need to make new commits to
update to the latest submodule commits - if that's indeed what you
want.  And then you can run push-git-modules, and be reasonably
assured that it will work (unless someone made another push while you
were fixing conflicts).

Finally, I have another script that retrieves the *currently linked*
version of the git modules.  I wish git-checkout would do this
automatically, but it doesn't, for apparently-difficult-to-resolve
safety reasons.  Anyway, note that this script uses the existence of
submodule/Makefile as "proof" that the submodule was checked out
correctly.


~/src/vx-lin $ cat get-git-modules
#!/bin/sh -x
set -e
git submodule init
git submodule update
test -e wv/Makefile
(cd wv && git submodule init && git submodule update)
test -e wv/wvstreams/Makefile


>  I guess it probably gets sticky when there are merge conflicts. Is
>  anyone working on this kind of thing; I might be able to give some
>  time to help work on it?

So as you can see, my scripts are crappy.  However, they have already
drastically reduced the number of mistakes made by developers in my
group (especially commits lost due to 'git submodule update' at the
wrong time, and pushes of the supermodule before the submodule).

If you want to work with me on my new submodule workflow (and I'd
certainly appreciate it!) then I'd suggest one or more of the
following starting points:

- Take the recursive push, pull, and update operations described
above, make them general (ie. not referring to my submodules by name
:)), and add them as commands in the real git-submodule script.  The
trickiest part here will be figuring out which remote branch to
push/pull.

- Perhaps add a "recursive commit" operation that recursively
auto-commits submodule refs, for use after running the
newest-git-modules script.  The commit message could be auto-generated
using something like "git-whatchanged" on the submodule.

- See what can be done about making git-checkout automatically
git-submodule-update *if and only if* the currently checked-out commit
of the submodule exactly matches the one that was checked out last
time, *and* the desired commit is already available in the submodule
repo (which is not necessarily the case, if you haven't fetched it
yet).  That is, as with any file in git, if it hasn't changed from the
one in the repo, you know you won't lose any information if you just
auto-replace it with the new version.

- Fix git-submodule-update to not just switch submodule branches if
you've made checkins in that submodule.  Right now, commits to a
submodule by default don't go to any branch, so if you subsequently
run git-submodule-update, your commits are lost (except for the
reflog).  This is very un-git-like in general, and
git-submodule-update should be much more polite.

Note that git-submodule is only about 800 lines of shell.  It's
remarkably straightforward to make it do whatever you want.  The hard
part is figuring out what you want, and making sure you don't stomp on
*other* people's workflows while you're there.

Also note that even if you don't contribute any of the above, I'm
planning to someday make time to do it myself :)  But don't hold your
breath.  I've been busy.

Have fun,

Avery
