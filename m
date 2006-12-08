X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [RFC] Light-weight checkouts via ".gitlink"
Date: Fri, 8 Dec 2006 22:52:31 +0100
Message-ID: <200612082252.31245.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 21:52:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33755>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsne4-0002W4-9Q for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947407AbWLHVwh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 16:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947408AbWLHVwh
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:52:37 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:35583 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1947407AbWLHVwg (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 16:52:36 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 6322D282A for
 <git@vger.kernel.org>; Fri,  8 Dec 2006 22:52:35 +0100 (MET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

when I recently thought about submodule support, I had the
idea that it is easier to get it by going in small,
incremental steps, introducing usefull subfeatures on their
on while on it.

The following is one outcome of this, a proposal for
light-weight checkouts of git branches, without the need
to have to full repository in a .git subdirectory, but
the just have a file .gitlink is simple as possible, which
manages the link to the real repository.

Of course, this feature is tailored to support checkouts of
submodules as being such light-weight checkouts themself.
The current proposal just says that light-weight checkouts
should be ignored when existing inside of another checkout.
For real submodule support, we would want to be able the
do a "git add" on these light-weight checkouts (which of
course are bound to some commit), and on "git commit", this
would add a "submodule object" at this place into the tree
of the outer repository.

Comments?

Josef


============================================================

Support for multiple external light-weight checkouts
aka ".gitlink" proposal


Main ideas behind light-weight checkouts
----------------------------------------

Make submodules easier to implement by separating
part of the needed infrastructure into a independent,
yet useful feature

(1) Allow to separate a branch checkout from its repository location
on the local filesystem. This minimally needs to be only _one_ file,
called ".gitlink" here. One should be able to move the
checkout directory around (within some limits) without breaking
the link to its "base" repository.

We want this later for submodule checkouts inside of a supermodule
checkout: (a) to not loose the objects+index+HEAD if the user
removes the whole checkout to remove the submodule in next
supermodule commit; (b) to allow for moving submodules around
between supermodule commits.

This can be implemented with a small script reading .gitlink and setting
up $GITDIR and $GIT_INDEX_FILE accordingly. However, there should be
a further environment variable to use a file for HEAD ($GIT_HEAD_FILE?).
Interpretation of the link to the base directory has to be a little smart,
ie. by prefixing a relative path with as many ".." as needed to find a
git repository.

(2) Light-weight checkouts should work inside of another
checkout, be it a normal or a light-weight checkout itself.
The subdirectory of the light-weight checkout has to be ignored
in the outer checkout (at least by default).

This is needed to be able to use light-weight checkouts for submodels,
as these should be checked out inside of another checkout (even
inside of another submodule checkout for hierarchical submodules).

This can be implemented by enhancing git to ignore any subdirectory which
has a file .gitlink in it.


Example usage
-------------

Keep a checkout of the todo branch of git.git inside of the checkout of
any other branch (or fully outside). You should be able to use all the normal
git commands inside of this directory (commit etc).
Something like inside of e.g. a master checkout of git.git:

 make todo
 cd todo
 touch .gitlink
 git checkout todo

The .gitlink file can be empty in this case when we make the smart lookup of
the base repository do the right thing with a default of an emtpy relative path.

Another usage is to keep all your git repositories (looking like bare ones)
in one place, e.g. below $HOME/git-repositories/, and have the the checkouts
you are working in at another place, without the need for setting $GITDIR etc
for this.


Some thoughts about implementation
----------------------------------

As we need our own index and HEAD for any light-weight checkout, we
can choose a subdirectory of .git of the base repository to store a full,
independent working GITDIR on its own. It would default to linking the
objects and refs namespace to the base repository, but for submodules,
it *can* have its own object database and refs namespace; it just would
be locateable via the GITDIR of the base repository.

"Locateable" means that we need a name for different light-weight
checkouts. The name can be determined from the relative position of
the light-weight checkout to its base repository, or could be fixed
and specified in the .gitlink file.

Example for an light-weight checkout with name "mywork", linking to
the (bare) base repository "base":

 base.git/external/mywork/HEAD
 base.git/external/mywork/index
 base.git/external/mywork/refs -> ../../../refs
 base.git/external/mywork/objects -> ../../../objects

A light-weight checkout in a sibling directory to base.git needs
the relative path to its own .git directory:
"../base.git/external/mywork".

This can be split up in two things:
- relative path to base repository
- a name for this light-weight checkout
One has to be able to get this out of the content of the .gitlink file.


Proposal for .gitlink entries (one line per entry)
--------------------------------------------------

* Gitdir = "<Path to base git repository>"

Optional.
An absolute or relative path to the base git repository.
With relative path, a heuristic is used to find the
git directory: the path will be prefixed by as
many "../" as needed, and ".git" or .gitlink appended.
The value defaults to an empty relative path, which
will check all parent directories for a .git subdirectory.

* Name: <explicit name for this checkout>

Optional.
Git uses this name to find its own GITDIR in the GITDIR
of the base repository. If not specified, the name defaults
to the relative path of the light-weight checkout from
the base directory, stripping any ".." in front.



For the "mywork" example above, we could have a checkout
directory, sibling to "base.git" and called "mywork".
For the .gitlink file inside, it is enough to specify

 Gitdir = base

Because the search heuristic will find the base repository
at real relative path "../base.git". Further, relative
path of the checkout from the base repository is "../mywork",
giving the name "mywork".

When moving the checkout into another directory, it's name
would change if not explicitly specified in the .gitlink
file. For submodules, this could be the wanted semantic.
However, with changing name, we have possibly lost our
index and HEAD.
A solution for this could be to always store a copy of HEAD
into .gitlink, or even have a "Head:" .gitlink entry itself
as HEAD.

============================================================
