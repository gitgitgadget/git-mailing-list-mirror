From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 13:55:36 -0500
Message-ID: <2S4y4AAYvrk5mQlxSrErW9bgimc0ab_fh8jlpjxj84k@cipher.nrlssc.navy.mil>
References: <U-ySqQANiPRpld4kgzdXbovGgsj6LfOEdRmtTDU2yyvITSG3LnZAsQ@cipher.nrlssc.navy.mil> <willow-jeske-01l5PFjPFEDjCfzf-01l5uqS9FEDjCcuF> <willow-jeske-01l5xqJDFEDjCftd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDh0-0007OA-Dx
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYFXSzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbYFXSzm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:55:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37408 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbYFXSzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:55:41 -0400
Received: by mail.nrlssc.navy.mil id m5OItb5d004074; Tue, 24 Jun 2008 13:55:37 -0500
In-Reply-To: <willow-jeske-01l5xqJDFEDjCftd>
X-OriginalArrivalTime: 24 Jun 2008 18:55:37.0221 (UTC) FILETIME=[E3B3D350:01C8D62B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86104>

David Jeske wrote:
> My takeaways from this thread:
> 
> - THANKS! to all of you for the detailed discussion, and for making git. Even
> though it's still unfamiliar to me, I really enjoy (g)it!
> 
> - I don't think anyone here thinks git is beyond improvement. This discussion
> did change my mind on a few things since my original post. I started this
> discussion to share my "unacclimated usability suggestions", because after I
> acclimate to git, I'll be telling new users that these idiosyncrasies are all
> no big deal too.  :) I still think there is value in this list of suggestions.
> I'll work on submitting patches...
> 
> - improve the man page description of "reset --hard" (see below)
> - standardize all the potentially destructive operations (after gc) on "-f /
> --force" to override

The thing is 'force' is not always the most descriptive word for the behavior
that you propose enabling with --force.

For the reset command in particular there is a --soft counterpart to --hard. They
are both modifiers on the term 'reset' i.e. a 'soft reset' or a 'hard reset'. The
default is wbat is called a 'mixed reset'.

'gc' is another command that has been mentioned along with its '--aggressive' option.
--force does not seem to make sense here either, since we are not necessarily forcing
anything to happen in the sense of overriding some safe guard. What is happening is
that possibly more cpu-intensive options are being selected when repacking (compressing)
the repository.

> Consider branch which has
> both "branch -[MD]" and "branch -f" in the same subcommand. What's wrong with
> "branch -[md] -f"?

I am inclined to agree here. I'm not sure why the options for 'git branch' were
created this way. I too have thought that a -f modifier on -m and -d would be
more intuitive.

> Of course --hard encourages one to read the manpage. However, git is using a
> bunch of new terms for things, and uses at least those three different methods
> to indicate command danger. Lets look at the working on the manpage:
> 
> "Matches the working tree and index to that of the tree being
> switched
> to. Any changes to tracked files in the working tree since <commit>
> are lost."
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I interpreted this as "any [non committed changes] to tracked files in the
> working tree since <commit> are lost."  I don't this this was a naive
> interpretation. I still think that's the way it reads after this whole
> conversation.

I think the reason it only says that uncommitted changes are lost is because
the committed changes are not lost even though they may become unreachable
from the head of the current branch. They are still reachable at least from
the reflog, so they are not lost. The uncommitted changes _are_ lost and are
unrecoverable.

> I'll work on my first patch for git:
> 
> -> "References to any working tree changes, and pulled changes, AND COMMITTED
> CHANGES to tracked files in the branch after <commit> will be dropped, causing
> them to be removed at the next garbage collect.".

Uncommited working tree changes are gone immediately. Anything that has already
been committed will be garbage collected only after it is not referenced by
anything else in the repository. A reference will be maintained in the reflog
for at least 30 days (by default).

> 
> -- Brandon Casey wrote:
>> After saying all of that, here is how I think you _should_ have done things.
>> Notice I _did_not_ use 'reset --hard'.
> 
> I was told that I can safely do "git checkout origin/master" instead of "reset
> --hard" to get back to the pull point, in case I didn't branch ahead of time.

I think 'git checkout origin/master' would be a little odd since this is usually
a remote tracking branch. 'git checkout -b mymaster origin/master' or similar
would be more common. This creates a new branch named 'mymaster'.

-brandon
