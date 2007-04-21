From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Fri, 20 Apr 2007 17:42:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704201605580.4634@qynat.qvtvafvgr.pbz>
References: <200704171041.46176.andyparkins@gmail.com>  <"200704171803.58940.an
 dyparkins"@gmail.com>  <200704172012.31280.andyparkins@gmail.com><alpine.LFD.0.98.0704171530220.45
 04@xanadu.home><Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz><alpin
 e.LFD.0.98.0704171624190.4504@xanadu.home><Pine.LNX.4.63.0704171302200.1696
 @qynat.qvtvafvgr.pbz><alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@cam.org>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 03:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf4Ch-000626-56
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 03:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbXDUBPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 21:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbXDUBPf
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 21:15:35 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36957 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753917AbXDUBPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 21:15:34 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 20 Apr 2007 18:15:34 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 20 Apr 2007 18:15:07 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45142>

On Tue, 17 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
>
>>> I would like to, however this doesn't currently integrate
>>> well with git. I've been told in the past that once
>>> .gitattributes is in place then the hooks for the crlf stuff
>>> can be generalized to allow for calls out to custom code to
>>> do this sort of thing.
>>
>> And I agree that this is a perfectly sensible thing to do.  The facility
>> should be there for you to apply any kind of transformation with
>> external tools on data going in or out from Git.  There are good and bad
>> things you can do with such a facility, but at least it becomes your
>> responsibility to screw^H^H^H^Hfilter your data and not something that
>> is enforced by Git itself.
>
> You have to be careful, though.  Depending on what kind of
> transformation you implement with the external tools, you would
> end up having to slow down everything we would do.

you can slow down everything that you do on your system if you defined too much 
work for external tools, that won't slow other people down who don't define any 
work for external tools.

> It boils down to this statement from Andy:
>
>    ..., keywords (in other VCSs, and so why not in git) are
>    only updated when a file is checked out.  There is no need
>    to touch every file.  It's actually beneficial, because the
>    keyword in the file is the state of the file at the time it
>    was checked in - which is actually more useful than updating
>    it to the latest commit every time.
>
>    That means you're only ever expanding in a file that your
>    changing anyway - so it's effectively free.  git-checkout
>    would still be immediate and instantaneous.
>
> Back up a bit and think what "when a file is checked out" means.
> His argument assumes the current behaviour of not checking out
> when the underlying blob objects before munging are the same.

correct.

> But with keyword expansion and fancier "external tools" whose
> semantics are not well defined (iow, defined to be "do whatever
> they please"), does it still make sense to consider two blobs
> that appear in totally different context "the same" and omit
> checking out (and causing the external tools hook not getting
> run)?  I already pointed out to Andy that the branch name the
> file was taken from, if it were to take part of the keyword
> expansion, would come out incorrectly in his printed svg
> drawing.

this is part of the rope you are handing out. the external tool could do a lot 
of things that don't make sense. you could have the tool include the serial 
number of the cpu you happen to be running on at the moment, it wouldn't make 
sense to do this, but it could be done. the fact that the rope could be used to 
hang someone doesn't mean that you should outlaw rope.

> If you want somebody's earlier example of "giving a file with
> embedded keyword to somebody, who modifies and sends the result
> back in full, now you would want to incorporate the change by
> identifying the origin" to work, you would want "$Source$" (I am
> looking at CVS documentation, "Keyword substitution/Keyword
> List") to identify where that file came from (after all, a
> source tree could have duplicated files) so that you can tell
> which file the update is about, and this keyword would expand
> differently depending on where in the project tree the blob
> appears.
>
> It is not just the checkout codepath.  We omit diffs when we
> know from SHA-1 that the blobs are the same before decoration.
> We even omit diffs when we know from SHA-1 that two trees are
> the same without taking possible decorations that can be applied
> differently to the blobs they contain into account.  Earlier,
> Andy said he wanted to grep for the expanded text if he is
> grepping in the working tree, and I think that makes sense, but
> that means git-grep cannot do the same "borrow from working tree
> when expanding from blob object is more expensive" optimization
> we have for diff.  We also need to disable that optimization
> from the diff, regardless of what the correct semantics for
> grepping in working trees should be.

git would not be able to borrow from the working tree just becouse the index 
thinks that the file is the same (and frankly, I'm not sure this is really a 
safe thing to do in any case, it's just something that works frequently enough 
that we get away with it)

the diff optimizations could (and should) stay.

> I suspect that you would have to play safe and say "when
> external tools are involved, we need to disable the existing
> content SHA-1 based optimization for all paths that ask for
> them" to keep your sanity.

Andy and I are both expecting that if the blobs are the same that none of the 
git tools would flag them as different. this maintains the huge speedups that 
git achieves by doing these checks.

if you want to make an option somewhere that disables this optimization, I guess 
it would be Ok, but I wouldn't do so until someone came up with a situation 
where they really needed it, nothing in what Andy or I have asked for needs 
this.

both of us are treating the keyword expansion as decorations to the file. it's 
useful, but the core meaning of 'what this file is' is the checked in version 
with the keywords unexpanded. all the optmizations that only look at what's 
checked in will remain as valid as they are today, it's only things that look at 
your working directory that would change.

David Lang
