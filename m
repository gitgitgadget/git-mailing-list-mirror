From: Lionel Elie Mamane <lionel@mamane.lu>
Subject: Symmetric of rebase / more intelligent cherry-pick
Date: Tue, 11 Oct 2011 17:54:44 +0200
Message-ID: <20111011155444.GB14417@capsaicin.mamane.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 18:14:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDey8-00060G-Qr
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 18:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab1JKQOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 12:14:10 -0400
Received: from 5.xs4all.nl ([82.95.233.223]:39445 "EHLO capsaicin.mamane.lu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755043Ab1JKQOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 12:14:09 -0400
Received: from master by capsaicin.mamane.lu with local (Exim 4.74)
	(envelope-from <master@capsaicin.mamane.lu>)
	id 1RDefE-0001cb-MA
	for git@vger.kernel.org; Tue, 11 Oct 2011 17:54:44 +0200
Content-Disposition: inline
X-Operating-System: GNU/Linux
X-Request-PGP: http://www.mamane.lu/openpgp/rsa_v4_4096.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183303>

Hi,

I was thinking about a sort of symmetric to rebase, a kind of
"intelligent" mass cherry-pick. For the sake of example let's call it
"basere", although a better name would have to be found.

While
 git rebase UPSTREAM
moves the *current* branch (and any commit in it, but not in UPSTREAM)
on top of UPSTREAM,
 git basere UPSTREAM
would "cherry-pick" all commits in UPSTREAM that are not in HEAD to
the current branch.

git cherry-pick ..UPSTREAM
*nearly* does what I want, except that it lacks rebase's intelligence
of skipping commits that do the same textual changes as a commit
already in the current branch. So maybe it should be an option to
cherry-pick rather than a new command? E.g. --skip-same? What about
making it cherry-picks *default* behaviour?

Why do I think it is useful? Take the case of a developer following
two different origins A and B, and B uses rebase (not merge) to
integrate changes from A, but not as often as one would like. A could
for example be the "official" tree (e.g. linux Linus tree), and B a
feature branch of a developer that is meant to eventually go into A
"cleanly" at some future time and A's policy is that one has to rebase
before sending a merge request. Then another developer wants to keep
up with changes from *both* A and B. So, the situation could look
like:

      A---A---A remotes/A/master
     /
X---X---B0---B1---L master
     \
      B0---B1---B2--B3 remotes/B/master

So one does "git rebase remotes/A/master master" and one gets

      A---A---A---B0---B1---L master
     /
X---X
     \
      B0---B1---B2--B3 remotes/B/master

I'd like to go to the situation:

      A---A---A---B0---B1---L---B2--B3 master
     /
X---X
     \
      B0---B1---B2--B3 remotes/B/master

Without having to manually find the cutoff point "B2"
(or worse, if the history is more messy than that, as in:

      A---A---A---B1---L master
     /
X---X
     \
      B0---B1---B2--B3 remotes/B/master
)


The best way I have found to do that is:

git fetch B
git checkout --no-track -b TMP remotes/B/master
git rebase master
git checkout master
git merge --ff-only TMP
git branch -d TMP

or less commands but more messy/fragile (and more work for git):

git fetch B
git tag TMP
git rebase remotes/B/master
git rebase TMP
git tag -d TMP

but that is rather onerous for something that should be just one
command.


So what are your thoughts on that?

 - Good idea? Would you take a patch that does something like that?

 - Should it be cherry-picks's default behaviour?

 - An option to cherry-pick?

 - A new command? What name? Maybe "multi-cherry-pick"?

 - An option to rebase, e.g. "--pull" or "--incoming" or "--here"?
   ("--pull" is probably too confusing wrt to "git pull"; people will
    have trouble remembering which is which between "git pull
    --rebase" and "git rebase --pull"...)

-- 
Lionel
