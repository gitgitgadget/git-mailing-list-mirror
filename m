From: Bruno Haible <bruno@clisp.org>
Subject: request for documentation about branch surgery
Date: Tue, 7 Jul 2009 01:05:12 +0200
Message-ID: <200907070105.12821.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 01:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNxFu-0003mO-Cc
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 01:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbZGFXFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 19:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbZGFXFg
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 19:05:36 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:47428 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbZGFXFf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 19:05:35 -0400
X-RZG-AUTH: :Ln4Re0+Ic/6oZXR1YgKryK8brksyK8dozXDwHXjf9hj/zDNRbfU4489asA==
X-RZG-CLASS-ID: mo00
Received: from linuix.haible.de
	(dslb-088-068-043-109.pools.arcor-ip.net [88.68.43.109])
	by post.strato.de (klopstock mo18) (RZmta 18.49)
	with ESMTP id 50742cl66MTJ6q ; Tue, 7 Jul 2009 01:05:33 +0200 (MEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122808>

Hi,

Here are a few things that I would have expected to find in the Git user's
manual, chapter "Rewriting history and maintaining patch series"
  <http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#cleaning-up-history>

It is meant for a user who does not yet know about "git rebase", "git merge",
"git reset" and the like. Organized by the goal that a user has ("how do I?").


1) After the section "Rewriting a single commit", it may be useful to
have a section "Inserting one or more new commits". This is something that
cannot be done with the "detached head" technique. I found this sequence
of commands useful:

  If you want to add a commit in the middle of a branch:

            A---C---...---Z    master

  =>

            A---B---C---...---Z    master

  it is achieved by

    $ git checkout A
    $ git branch temp
    $ git checkout temp
    [make changes for B]
    $ git commit -a

  now:

            A---C---...---Z    master
             \
              --B              temp

    $ git checkout master
    $ git rebase temp
    $ git branch -d temp


2) About the section "Reordering or selecting from a patch series".
   The "git rebase" documentation contains a good example:

   Reordering, possibly merging, the last 5 commits:
   $ git rebase -i HEAD~5
   See "man git-rebase" under "INTERACTIVE MODE".

   I find this technique very useful, because it guarantees that no
   commit gets lost (unlike "git cherry-pick"). Maybe the section could
   be split into two sections
      "Reordering a patch series"
   and
      "Selecting from a patch series"?


3) When do I need "git merge", and when do I need "git rebase", in the
   context of branch surgery?

   The simple answer, that I would find worth mentioning, is:
     - "git merge" copies commits from one branch to another.
     - "git rebase" only moves commits around to make history more linear.


4) It would be good to have a section "Cutting branches"

   How do I remove the N most recent commits from a branch?

               D---E---F---G---H---.........---Y---Z master

  =>
               D---E master

   It goes like this:

     $ git checkout master
     $ git reset --hard E


5) Then, it would be good to have a section "Replacing branches"

   How do I copy the contents of a branch over to another branch, replacing
   the recent development on that branch?

  If you want to copy a branch into another, while throwing away commits:

                     F1---F2---F3                         released
                    /
               D---E---F---G---H---.........---Y---Z master

  =>
                     F1---F2---F3   released
                    /
               D---E---F1---F2---F3 master

  This is achieved by

    $ git checkout master
    $ git reset --hard E      # Cut the branch "master"
    $ git merge released      # Copy commits from branch "released" to "master"


6) Also, it would be good to have a section "Reconnecting branches after rebase".
   If you want to reconnect a branch to a rebased master, here's how to do it:

                   /--C'--...---P'--Q'--...---Z'  new rebased master
              A---B---C---...---P---Q---...---Z   old master
                                 \
                                  --BA---...---BZ  release-branch

  =>
              A---B---C'--...---P'--Q'--...---Z'  new rebased master
                                 \
                                  --BA---...---BZ  release-branch

  This is achieved by

    $ git checkout release-branch
    $ git rebase --onto P' P


This might seem exotic, but these use cases all came up while rewriting the
history after a "git cvsimport".

Bruno
