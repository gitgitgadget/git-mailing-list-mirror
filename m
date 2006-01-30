From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] shallow clone
Date: Mon, 30 Jan 2006 10:46:15 -0800
Message-ID: <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 19:47:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3e2g-00067D-LD
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 19:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWA3SqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 13:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWA3SqT
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 13:46:19 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60824 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964856AbWA3SqR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 13:46:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060130184403.WNLG17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 Jan 2006 13:44:03 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15286>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> . Download the full tree for v2.6.14 commit and store its
>>   objects locally.
>
> On first read, I mistook "tree" for "commit"...

It turns out that this 'single' request step is unneeded, as
long as we implement 'graft' requests.  We can then tell
"Cauterize at v2.6.14 and give me the master" to `upload-pack`.
`upload-pack` would run `rev-list --objects master`, tries to include
everything that is reachable from "master", but notices that the
v2.6.14 commit does not have any parent (thanks to the
customized graft) and stops there -- the result is the history
since v2.6.14.

>> . Set up `info/grafts` to lie to the local git that Linux kernel
>>   history began at v2.6.14 version.
>
> Maybe also record this in .git/config, so that you can
>
> - disallow fetching from this repo, and
> - easily extend the shallow copy to a larger shallow one, or a full one.

I thought about that before I wrote the message, but it boils
down to grepping lines from grafts that have only one object
name (i.e. cauterizing records), so it is redundant.

Also there is no strict reason to forbid cloning from such a
shallow repository.  No harm is done as long as you make it
clear to somebody who clones from you that what you have is a
shallow copy, so that the cloned repository can cauterize
history at appropriate places.

A second generation clone, when cloning from a shallow
repository, needs to mark itself that it has the same or
shallower history (otherwise a third generation clone from it
would not work), so the `upload-pack` protocol needs to be
updated to send grafts information the `upload-pack` side
usually uses to the downloader even when 'graft' request is not
used by the downloader.  But once it is done, you should be able
to clone safely from a shallow repository and end up with a
repository with the same (or shallower -- if you asked to make a
shallow clone from it) history.

> Why not just start another fetch? Then, "have <refs/tags/start_shallow>" 
> would be sent, and upload-pack does the right thing?

Yes, almost.  We need to realize that `upload-pack` that hears
"have A, want B" is allowed to omit objects that appear in
`ls-tree B` output but not in `ls-tree A`.  "have A" means not
just "I have A", but "I have A and all of its ancestors", so
just sending "have start_shallow" (or start_shallow^ for that
matter) is not quite enough [*1*].

> If you absolutely want to get only one pack, which then is stored as-is, 
> upload-pack could start two rev-list processes: one for the tree and one 
> for all the rest.

The message you are responding did two separate transfers (one
'single', and another 'fetch'); I do not particularly mind doing
two (it is just an initial clone anyway), but as I said it turns
out that we do not need the initial 'single'.

>> [NOTE]
>> Most likely this is not directly run by the user but is run as
>> the first command invoked by the shallow clone script.
>
> Better make it an option to git-clone

Probably -- I was just outlining the lowest-level mechanism and
haven't thought much about the UI.

[Footnote]

*1* This is true even without more aggressive optimization by
rev-list that does not exist there yet.  Here is a minimalistic
demonstration.  One file project with a handful straight-line
commits.  Each change to the file reverts the change made by the
previous commit.

 * The HEAD commit has "white", the HEAD~1 "black" and HEAD~2
   "white".

 * We say we are interested in things since HEAD~2 (i.e. we
   pretend that the history starts at HEAD~1 and it does not
   have a parent) and ask for HEAD.

 * Notice that only one copy of the file appears in the output.
   It is "black" blob.  We do not get "white" blob because we
   are telling it that we _have_ HEAD~2.  The resulting set of
   objects is not enough to check-out the HEAD commit.

This roughly corresponds to your "have shallow_start", but not
quite -- in that sequence you have objects for HEAD~2 commit.
But the point is that I want to leave the door open for
optimizing upload-pack, so that it can choose to omit objects
that do not appear in A when you say "have A", if the object
appears in one of A's ancestors.

-- >8 --
#!/bin/sh

rm -fr .git

git init-db
zebra=white
echo $zebra >file
git add file
git commit -m initial

for i in 0 1 2 3 4 5
do
	case $zebra in
	white) zebra=black ;;
	black) zebra=white ;;
	esac
	echo $zebra >file
	git commit -a -m "$i $zebra"
done
git rev-list --objects HEAD~2..HEAD |
git name-rev --stdin
