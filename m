From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Sun, 15 Nov 2009 13:24:03 +0100
Message-ID: <200911151324.05109.trast@student.ethz.ch>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 13:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9eA6-0003PS-VK
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 13:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZKOMYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 07:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbZKOMYq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 07:24:46 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:11881 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbZKOMYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 07:24:45 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 13:24:48 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 13:24:48 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132933>

Thomas Rast wrote:
> git-pull has historically accepted full fetchspecs, meaning that you
> could do
> 
>   git pull $repo A:B
> 
> which would simultaneously fetch the remote branch A into the local
> branch B and merge B into HEAD.  This got especially confusing if B
> was checked out.  New users variously mistook pull for fetch or read
> that command as "merge the remote A into my B", neither of which is
> correct.

It gets worse.  *Much* worse.

Yesterday on IRC I helped 'thrope' with the github pull requests
guide.  This is a wiki page, but placed at a sufficiently prominent
URL to make it look like an authoritative guide to a new user.

  http://github.com/guides/pull-requests

I have since replaced the part in question with one that is more in
line with what the tools actually do, but the bottom line of the old
version was basically

  # You got a request to pull git://github.com/defunkt/grit.git master

  # mojombo can add the defunkt repository as a remote source, create
  # a new branch, and pull the defunkt repository contents into it
  # like this:

  $ git remote add -f defunkt git://github.com/defunkt/grit.git
  $ git checkout -b defunkt/master      # (1)
  $ git pull defunkt master:4f0ea0c     # (2)
  # [...]
  $ git commit                          # (3)
  $ git checkout master
  $ git merge defunkt/master            # (4)
  $ git push

Note that all but the first line and the numbers is literally
cut&pasted from the old version, which is still available at

  http://github.com/guides/pull-requests/24

so you can see for yourself.  Note that the lines (1) and (2) were
there even in version 3.

And as you can see, there are just so many things wrong with it:

(1) will actually create a new branch defunkt/master based on whatever
you happened to be on, making (4) merge something entirely different
than what the pull request was for.

(2) will pull defunkt's master into a local *branch* called 4f0ea0c
(in the guide this is actually the sha1 of defunkt's master, but who
knows), and then merge that into the local defunkt/master branch from
(1).

(3) shouldn't do anything at that point, but hell if I know how he got
the idea to commit there.

So this suggests several safety measures:

* Perhaps branch/checkout -b can refuse to create branches that
  already exist with this exact name under remotes if that's the only
  argument.  I.e., in the above situation (1),

    # refuse: remotes/defunkt/master exists
    git checkout -b defunkt/master
    git branch defunkt/master

    # accept: obviously you're asking for trouble explicitly
    git checkout -b defunkt/master defunkt/master 
    git branch defunkt/master defunkt/master

* Perhaps all branch-creating code could refuse to create branches
  that have a name that is also a valid sha1 prefix of an existing
  object?  This would be fairly drastic if a user's language has many
  words consisting only of [a-f], but on the other hand, the user can
  hardly be helped by having something that looks like a sha1 resolve
  to some *other* sha1.

* I ask you to reconsider this patch.  For some reason, people read
  things into pull with fetchspecs that are far from correct.

I haven't thought much about backwards compatibility yet, though, so
some of it may not be possible.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
