X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git pull and merging.
Date: Thu, 7 Dec 2006 12:27:45 +0100
Message-ID: <200612071227.46194.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <200612061744.31213.Josef.Weidendorfer@gmx.de> <4577B8C0.3060200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 11:27:58 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <4577B8C0.3060200@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33568>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsHPu-0007K4-Vm for gcvg-git@gmane.org; Thu, 07 Dec
 2006 12:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032053AbWLGL1u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 06:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032055AbWLGL1u
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 06:27:50 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:48177 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1032053AbWLGL1t (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 06:27:49 -0500
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de
 [131.159.35.49]) by mail.in.tum.de (Postfix) with ESMTP id B24D526FA; Thu,  7
 Dec 2006 12:27:47 +0100 (MET)
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

On Thursday 07 December 2006 07:46, Aneesh Kumar K.V wrote:
> Josef Weidendorfer wrote:

> > Now, instead of "git pull", git should default to
> > 
> > 	git pull origin refs/heads/devel:refs/remotes/origin/devel
> 
> 
> 
> this means the remote reference is refs/heads/devel and local tracking
> branch for that is refs/remotes/origin/devel. 

Yes.

> > ie. it should update the local tracking branch "refs/remotes/origin/devel"
> > with the remote branch "refs/heads/devel".
> > The tracking branch "refs/remotes/origin/devel" will be merged with current
> > branch afterwards.
> > 
> 
> 
> That will be merged is the tricky part.

No. The merging part actually is the easiest, because everything about
what to merge with what is already decided in "git pull" 's fetch phase:

* git fetch leaves the branches fetched _and_ what to merge of them
in .git/FETCH_HEAD. Example for "git pull" it git.git's master(shorted):

de51fa... branch 'master' of git://.../git/git
49ed2b... not-for-merge   branch 'maint' of git://.../git/git
b772ef... not-for-merge   branch 'next' of git://.../git/git

Which means: Already in the fetch phase, we look up branch.*.merge to
decide what to write into this file.

* the merge phase just looks up .git/FETCH_HEAD and merges all branches into
the current branch which are _not_ marked as "not-for-merge". There
is nothing tricky here: We did the 1st phase of pull in the same
"current" branch, so there really is no need to check any branch.*.merge
value again.

> > Now looking at the documentation for branch.<name>.merge, it talks
> > about the remote branch, which is "refs/heads/devel" in your case, ie.
> > the first part of the refspec of the full "git pull" command above.
> > 
> 
> This is most confusing part. What merge indicate is not about refs/heads/devel
> should track refs/remotes/origin/devel. That is specfied in the remote config option.

Yes. But the value of branch.*.merge, which is the _remote_ side of such a refspec
tracking specification given in remote.*.fetch's, will be checked against all
remote parts of refspecs fetched in the 1st phase of "git pull". And it is already
decided in the fetch phase what to merge.

Now looking at it, I think this semantic really is screwed and utterly confusing.
Why decides branch.*.merge about actions done in fetch (I think even if you did
"git fetch" alone)? OK, actually, that is an implementation detail and not
really important.

More important: Because "branch.*.merge" specifies a _remote_ branch,
the user has to understand that this info is already used in the fetch.
The intuitive mental model of a user about how it works IMHO is that
"branch.*.merge" is checked in the merge phase (as the name of the option suggests).
But this way, how could the merge phase know about any remote branch at all,
which does not need to be touched at all in the merge phase?

IMHO we should somehow change the semantic of branch.*.merge to specify the _local_
refspec part, as this is the branch which actually gets merged.
This is the only way that a user could grasp the meaning of it.
Perhaps introduce "branch.*.defaultmerge", and obsoleting "branch.*.merge"?

> I guess we need to have a standard way of saying the branches. 
> 
> May be we want to document it in repo-config.
> 
> local branch on which changes can be made <branch-name>
> local tracking branch refs/remotes/<remote-name>/<branch-name>

This is not forced, but can be changed by configuration.

> remote branch refs/heads/<branch-name>

?

