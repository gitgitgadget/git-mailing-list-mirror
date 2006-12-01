X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 23:57:27 -0500
Message-ID: <20061201045727.GA22622@thunk.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org> <Pine.LNX.4.64.0611301431420.3513@woody.osdl.org> <Pine.LNX.4.64.0611301749450.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 04:57:58 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611301749450.20138@iabervon.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32849>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq0TA-0002eg-Sz for gcvg-git@gmane.org; Fri, 01 Dec
 2006 05:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758957AbWLAE5r (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 23:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758967AbWLAE5q
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 23:57:46 -0500
Received: from thunk.org ([69.25.196.29]:12681 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S1758954AbWLAE5q (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 23:57:46 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1Gq0WV-0005LR-95; Fri, 01 Dec 2006 00:01:19 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1Gq0Sm-0000kS-27; Thu, 30 Nov 2006
 23:57:28 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

On Thu, Nov 30, 2006 at 07:12:31PM -0500, Daniel Barkalow wrote:
> This is where I think "git add" is really broken. For every other git 
> command, if the command causes the index to not match HEAD, the command 
> contains "index" either in the name of the command or in an option.
> 
> So, if you understand the index, and you understand git's model, but you 
> don't know this one weird corner case, you will come to the conclusion 
> that "git add <path>" leaves <path> such that the index matches HEAD.

But it's not just this one wierd corner case.  You yourself said that
"git pull/merge" leave the index where it's != HEAD.   

I have serious trouble believing that "if the command leaves index !=
HEAD, the command must contain 'index' in either the name of the
command or the option" is all that important of a consistent rule or
principle that must be maintained at all costs.


By the way, after thinking about this for a while, part of the problem
is that the name "index" really sucks.  Which is perhaps why Linus is
now trying to stop us from actually using the term "index" in these
discussions.  :-)    If we called it a "staging area", as our Great
Leader has suggested, I think it would be a lot easier for novice
users to understand.    Consider what is in the git man page:

	The index is a simple binary file, which contains an efficient
	representation of a virtual directory content at some random
	time.  It does so by a simple array that associates a set of
	names, dates, permissions and content (aka "blob") objects
	together. The cache is always kept ordered by name, and names
	are unique (with a few very specific rules) at any point in
	time, but the cache has no long-term meaning, and can be
	partially updated at any time.....

	In particular, the index file can have the representation of
	an intermediate tree that has not yet been instantiated. So
	the index can be thought of as a write-back cache, which can
	contain dirty information that has not yet been written back
	to the backing store.

For a kernel programmer, this might not be understandable --- but for
your typical application programmer, this is enough to cause him or
her to conclude that git is simply not meant for use by mere mortals.

So as Junio and Linus have both said, it's all about your mental
model, and if we think about it in terms of a staging area for a
commit, and we think about what commands are most natural given that
model, it's far more important than whether a command has "index" in
its name or specified in an option.

Put another way, the reason why I think people are liking the whole
"git add" and "git rm" suggestion is that it's a nice middle ground
between the "hide the index" and the "shove the index in the user's
face" approaches.  It's not that we are hiding the fact that there is
this thing with the horribly chosen name "index", but instead we talk
about this concept of a staging area and we don't dwell on things like
the fact that it is a binary file which stores an efficient
representation of a virtual directory.... blah blah blah.

Once this is done, the only command which is still problematic to
describe is "git diff".  Yes, it almost always does the right thing.
But if you read the man page, even we are now using "<tree-ish>"
instead of "<ent>" to describe it, it still forces the user who is
reading the man page to prove to him- or her-self that it really
always does the right thing.  The EXAMPLES section really helps, but
even so, the man page is need in terrible of help.

For example, exactly what "git diff" does is described in terms of
"git diff-files", "git diff-index". and "git diff-tree".  (And the
command name git-diff-index, git-diff-tree and git-diff-files in the
DESCRIPTION aren't even hotlinks, making it hard to get to the
plumbing man pages, which is the only place where you can get
documentation of the options accepted by git-diff.)    

OK, so once the novice user gets past this hurdle, he/she says, OK,
what does "git diff <tree-ish>" does?  Hmm, according to EXAMPLES,
this diffs the working tree with the named tree.  What options can I
give?  Well, with one one <tree-ish>, I have to go to read the man
page for "git-diff-index", whose synposis says, "Compares content and
mode of blobs between the index and repository".  But wait!  According
to git-diff's EXAMLES section, "git diff <tree-ish>" doesn't involve
the index at all!  Why does the synposis say anything about the index?
And this leaves the novice confused and bewildered.  And why not?  If
the user spends time puzzling through the man page, he/she will
discover that:

1) "git diff-index <tree>" compares the tree with the working
directory, and doesn't involve the index at all, even though it is in
the command name.  WTF?!?

2) If you want to really diff the index, you have to use the command
"git diff-index --cached <tree>"

If you look at this from the point of the novice user, it becomes very
clear why the index and commands that operate on the index are
hopelessly confusing.  Yes, if you the grasshopper read and medidate
very deeply the low-level meaning of the plumbing, and then someone
like Linus slaps you upside the head with one of his e-mail messages,
it will suddenly make sense to you.  The problem with this method is
that it doesn't scale terribly well.  :-)

But if you are just reading the "git-diff" man page for the first
time, and are then forced to read the "git-diff-index" man page to
puzzle out what a particular "git diff" option does, and then have to
confront the notion that something as "git diff HEAD" involves a
command "git diff-index", even though this confusing thing called the
index is never involved unless the --cache option is given --- can you
see how this might cause the beginning user of git to conclude that
git is hopelessly confusing and too hard to use?

The question then is how can we fix the "git diff" man page, and how
do we explain "git diff" in a tutorial so that users can understand
what in the world does it do?  For a starting point, I'd recommend
moving the EXAMPLES to the beginning of the man page, and moving the
any mention of git-diff-index, git-diff-files, and git-diff-tree to
the very end of the man page, and to put the most commonly used
options in the git-diff man page, so that most users don't have to
look at the low-level plumbing man pages to figure out how the
high-level git-diff works.  

