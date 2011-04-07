From: Jeff King <peff@peff.net>
Subject: [RFH] eol=lf on existing mixed line-ending files
Date: Thu, 7 Apr 2011 19:15:57 -0400
Message-ID: <20110407231556.GA10868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mislav Marohnic <mislav@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 01:16:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7yQr-0004cA-DU
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 01:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157Ab1DGXQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 19:16:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51036
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757135Ab1DGXQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 19:16:02 -0400
Received: (qmail 24992 invoked by uid 107); 7 Apr 2011 23:16:47 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Apr 2011 19:16:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Apr 2011 19:15:57 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171093>

I investigated some odd git behavior with the EOL gitattributes today,
and I'm curious to hear what others on the list think of what git does.
In particular, index raciness means git produces non-deterministic
results in this case.

The repo in question has a gitattributes file with "* crlf=input" (which
we would spell "eol=lf" these days, but the results are the same), but
still contains some files with mixed line endings. Which you can
reproduce with:

  git init repo &&
  cd repo &&
  {
    printf 'one\n' &&
    printf 'two\r\n'
  } >mixed &&
  git add mixed &&
  git commit -m one &&
  echo '* eol=lf' >.gitattributes

Now if we run "git status" or "git diff", it will let us know that
"mixed" is modified, insofar as adding and committing it would perform
the LF conversion.

Now we come to the first confusing behavior. Generally one would expect
the working directory to be clean after a "git reset --hard". But not
here:

  git reset --hard &&
  git status

will still show "mixed" as modified. Because of course we are checking
out the version from HEAD into the index and working tree, which has the
mixed line endings. So we rewrite the identical file.

So that kind of makes sense. But it isn't all that helpful, if I just
want to reset my working tree to something sane without making a new
commit (more on this later).

But here's an extra helping of confusion on top. Every once in a while,
doing the reset _won't_ keep "mixed" as modified. I can trigger it
reliably by inserting an extra sleep into git:

diff --git a/unpack-trees.c b/unpack-trees.c
index 500ebcf..735b13e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -223,6 +223,7 @@ static int check_updates(struct unpack_trees_options *o)
 		}
 	}
 	stop_progress(&progress);
+	sleep(1);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
 	return errs != 0;

That puts a delay between when reset writes the "mixed" file, and when
we write out the refreshed index. So next time we look at the index
(e.g., in "status"), we will see that the "mixed" entry has up-to-date
stat information and not look at its actual contents.

But in the original case (without the sleep), that doesn't happen.
There, we usually end up writing the file and the index in the same
second. So when status looks at the index, the "mixed" entry is racily
clean, and we actually check it again.

So we get two different outcomes, depending on the index raciness. Which
one is right, or is it right for it to be non-deterministic?

And one final question. Let's say I don't immediately convert this mixed
file to the correct line-endings. Instead, it persists over a large
number of commits, some of them even changing the "mixed" file but not
fixing the line endings[1]. We can simulate that with:

  mv .gitattributes tmp
  echo three >>mixed &&
  git commit -a -m three &&
  mv tmp .gitattributes

Now imagine I am somebody who has cloned this repo; the clone will tend
to end the race condition in the "clean" state, since it will often take
more than 1 second to write out all of the files (at least for a
normal-sized project). We can simulate using our sleep-patched reset:

  git reset --hard

to get a "clean" repo. Now let's say I want to explore old history, so I
go to a detached HEAD, but using normal git, not the sleep-patched one:

  git checkout HEAD^

And, of course, now we think "mixed" is modified. After I'm done
exploring, I want to go back to "master", but I can't:

  $ git checkout master
  error: Your local changes to the following files would be overwritten by checkout:
          mixed

What is the best way out of this situation? You can't use "reset --hard"
to fix the working tree. I guess "git checkout -f" is the best option.

Hopefully my example made sense and was reproducible. The real repo
which triggered this puzzle was jquery. You can try:

  git clone git://github.com/jquery/jquery.git &&
  cd jquery &&
  git checkout 1.4.2 &&
  git checkout master

which will fail (but may succeed racily on a slow enough machine).
Obviously they need to fix the mixed line-ending files in their repo.
But that fix would be on HEAD, and "git checkout 1.4.2" will be forever
broken. Is there a way to fix that?

-Peff

[1] The one thing still puzzling me about the jquery repo is how they
managed to make so many commits (including ones to mixed line ending
files) without seeing the dirty working tree state and committing it. Is
there some combination of config that makes this not happen?
