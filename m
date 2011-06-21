From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all
 untracked files
Date: Mon, 20 Jun 2011 20:38:52 -0400
Message-ID: <20110621003852.GB2050@sigill.intra.peff.net>
References: <1308612986-26593-1-git-send-email-david@porkrind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: David Caldwell <david@porkrind.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 02:39:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYozd-0007yF-3C
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 02:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab1FUAi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 20:38:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54035
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755974Ab1FUAiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 20:38:55 -0400
Received: (qmail 29785 invoked by uid 107); 21 Jun 2011 00:39:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 20:39:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 20:38:52 -0400
Content-Disposition: inline
In-Reply-To: <1308612986-26593-1-git-send-email-david@porkrind.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176116>

On Mon, Jun 20, 2011 at 04:36:26PM -0700, David Caldwell wrote:

> The --clean option acts like the normal "git stash save" but also adds all
> untracked files in the working directory to the stash and then calls "git
> clean --force --quiet" to restore the working directory to a pristine
> state.

Hmm. I think I would call this something like "--untracked", as to me
the main function is saving those files, not cleaning them afterwards
(the fact that they are cleaned is really just making the untracked-file
handling in line with what we do for tracked files; we put the changes
in the stash and remove them from the working tree).

But that might just be me.

> I find this useful for certain projects that need to run release
> scripts. With this option I can run the release scripts from my main working
> directory and not have to maintain a "clean" directory in parallel just for
> releasing. Basically the work-flow becomes:
> 
>    $ git tag release-1.0
>    $ git stash --clean
>    $ make release
>    $ git stash pop
> 
> "git stash" alone is not enough in this case--it leaves untracked files
> lying around (configure and automake droppings, for instance) that might
> mess up a release process that expects everything to be very clean.

For that workflow, do you actually want the files saved and restored
via "stash pop"? That is, aren't those untracked files just useless
cruft that could be regenerated, and you would be just as happy to do:

  $ git tag release-1.0
  $ git stash
  $ git clean
  $ make release
  $ git stash pop

and have a pristine state after your pop? You end up regenerating them
during the next build, which could be costly. But you don't have to pay
the price of stashing potentially large files that are just going to end
up regenerated anyway. For that matter, what should this do with
gitignored files, like generated object files?

Also, wouldn't you want to "git clean" after your "make release" but
before your "git stash pop" in case the build creates cruft that is not
overwritten by your stash pop?

> Signed-off-by: David Caldwell <david@porkrind.org>
> 
> Hi,
> 
>   This is my first patch to git so I have a couple questions:

Hi David. Welcome to the list. :)

Please put your comments on the patch (i.e., anything not destined to go
into the commit message) below the "---" marker; that helps "git am"
know which part is which.

>   * I used 'find . -name ".git" -prune -o -print' to get a list of all the
>     files in the working directory. That assumes ".git" is the name
>     of the repo--is that assumption valid?

Generally yes, but somebody could do something tricky with GIT_DIR. You
should be using "git ls-files -o" instead.

>   * Also, that find command does not respect .gitignore. Should it? If it
>     does then I think it would need another option to also clean up stuff
>     that is normally ignored (similar to the way "git clean" works with the
>     -x option). My thoughts were that if we were stashing everything, being
>     overzealous with the cleanup wouldn't hurt (and would generally be
>     exactly what you want).

I'm not sure of the answer to this. I think it would depend on your
workflow and your project (i.e., is your build system fragile enough
that you need to get rid of ignored build products between builds, or is
it OK to leave them, which is more efficient). I would think respecting
ignore would be a sane default, but I don't know if it should be
configurable, or have an extra command line option to stash everything.

If you do want to respect .gitignore, then you can add
"--exclude-standard" to the "ls-files" command I mentioned above.

> @@ -86,7 +87,7 @@ create_stash () {
>  			git read-tree --index-output="$TMPindex" -m $i_tree &&
>  			GIT_INDEX_FILE="$TMPindex" &&
>  			export GIT_INDEX_FILE &&
> -			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
> +			(git diff --name-only -z HEAD; test -n "$clean" && find . -name ".git" -prune -o -print0) | git update-index -z --add --remove --stdin &&
>  			git write-tree &&
>  			rm -f "$TMPindex"
>  		) ) ||

When you apply this stash, what does the resulting index look like? Do
the untracked files remain properly untracked? That might be a good
thing to double check in the test script.

-Peff
