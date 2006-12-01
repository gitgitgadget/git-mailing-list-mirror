X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 19:12:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301749450.20138@iabervon.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
 <Pine.LNX.4.64.0611301431420.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 00:12:46 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611301431420.3513@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32837>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpw16-0002eu-Qf for gcvg-git@gmane.org; Fri, 01 Dec
 2006 01:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030979AbWLAAMe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 19:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031629AbWLAAMe
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 19:12:34 -0500
Received: from iabervon.org ([66.92.72.58]:16140 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S1030979AbWLAAMd (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 19:12:33 -0500
Received: (qmail 13607 invoked by uid 1000); 30 Nov 2006 19:12:32 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 30
 Nov 2006 19:12:32 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Linus Torvalds wrote:

> A normal "read tree object" would populate index entries with that bit 
> cleared, and so it would be possible to have
> 
> 	git add file.c
> 	git diff
> 
> show something like
> 
> 	diff --git a/file.c b/file.c
> 	added file <mode> <sha1>
> 
> rather than show the whole big diff (which I _really_ don't think you want 
> to see, and which is actually against the whole point, which is that you 
> add _content_ to the index, and "git diff" will always show you the stuff 
> that is _not_ added to the index yet).

I'm not sure I want to see the whole added file more when diffing two 
trees, or when I do "git diff --cached" after "git update-index --add", 
than when I do "git diff" after "git add", but I'll concede that viewing 
the content of a new file as a diff is no fun. (Maybe diff-against-nothing 
for display needs work in general? It's solve the whole root commit thing, 
too.)

> (Of course, if you _also_ had changed it between the "git add" and the 
> "git diff", you'd get both the "added file <mode> <sha1>" _and_ the diff 
> that is the diff between the thing you added, and the status it has now).
> 
> So showing a real diff after "git add" would really be wrong. The index 
> really is important. But if it's _only_ an issue of worrying about seeing 
> added files at all, we can add a "people comfort" bit to do that.

This is where I think "git add" is really broken. For every other git 
command, if the command causes the index to not match HEAD, the command 
contains "index" either in the name of the command or in an option.

So, if you understand the index, and you understand git's model, but you 
don't know this one weird corner case, you will come to the conclusion 
that "git add <path>" leaves <path> such that the index matches HEAD.

Now *you* know that "git add" really is "git update-index --add", because 
you were typing the latter (well, "git update-cache --add", anyway) before 
"git add" existed at all. But for new users, and anyone who wasn't adding 
a lot of files back then, it's a surprising exception that has to be 
learned and internalized.

"git checkout" leaves the index matching HEAD or its original state.
"git commit" leaves the index matching HEAD (the new HEAD) or its original 
state.
"git reset" (all options) leaves the index matching HEAD or its original 
state.
"git pull/merge" does disrupt the index, but it also starts to prepare a 
commit based on multiple *HEAD files, and it leaves every stage of the 
index matching some *HEAD or its original state. And new users still seem 
to wonder where the merge happens, because it doesn't say "in the index".
"git apply" leaves the index alone.

"git update-index" says it works on the index.
"git apply --index" says it works on the index.

Am I missing any violations of the rule? I guess "git rm", but that's just 
for the CVS-damaged, unnecessary anyway, and it still doesn't care about 
the state of the working directory at any particular point in time. And I 
still prefer "git update-index --force-remove" as a command for that 
operation.

So it's obvious that the "add" functionality is properly called "git add 
--index", because whatever "git add" would, it would have to leave the 
index matching HEAD or its original state.

(Well, okay, '"git commit -i path" ^C', violates the rule. But I forgot 
until recently that -i stands for --include, not --index, which would make 
a reasonable expansion, too)

> (Quite frankly, I don't think it's worthwhile. I really think this is a 
> documentation issue. Make people understand that "git add" adds the 
> contents too, and that git never tracks filenames on their own at all).

I think people's model is likely to be closer to "touch" for the index, 
especially since it has no effect if the file is already in the index.

> So it is always going to be true that
> 
> 	git add file
> 	echo New line >> file
> 	git commit
> 
> must commit the old contents of the file. That really _does_ follow from 
> the whole "track contents" model. Anything that doesn't do this is 
> fundamnetally broken, and has broken the notion of what "git add" means.

"git add" doesn't *say* it changes the index, and nothing else there 
*says* it changes the index, so "git commit" there should say "nothing to 
commit", because you never did "git update-index file", either before or 
after the change, and you didn't do "git commit file" or "git commit -a". 

Just tossing the words in commands around, it's obvious that what 
"git add file" should do is mean that you can now do
"git update-index file" instead of
"git update-index --add file". Saying you shouldn't need "update-index" 
after adding a file is like saying you shouldn't need "update-index" after 
modifying a file.

But it shouldn't change my index any more than "git apply" should, because 
it doesn't say it updates the index. (Of course, it would be good to have 
"git add --index file", matching "git apply --index patch", which does 
what "git add" does now.)

Now, in order to interact correctly with reseting, checking out a 
different branch, etc, it wants to have the information in the index 
file, so there isn't a separate file with a list to lose stuff from. And 
it patterns naturally as an adjunct to the index for some things (like 
ls-files, which doesn't care at all what the content associated with 
filenames is). But that's fundamentally an implementation detail, not an 
aspect of the model.

	-Daniel
