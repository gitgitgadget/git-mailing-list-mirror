From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 7 Jul 2008 11:03:46 -0400
Message-ID: <F0AD23BC-FA9A-4593-8942-228C428B661E@silverinsanity.com>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <7v7iby9ucx.fsf@gitster.siamese.dyndns.org> <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com> <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org> <20080707111803.GF31490@mit.edu> <m34p71gbuk.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@MIT.EDU>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 17:04:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFsGk-0005tr-3i
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 17:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbYGGPDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 11:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbYGGPDt
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 11:03:49 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53665 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbYGGPDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 11:03:48 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id DF7C01FFC02C;
	Mon,  7 Jul 2008 15:03:43 +0000 (UTC)
In-Reply-To: <m34p71gbuk.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87622>


On Jul 7, 2008, at 7:42 AM, Jakub Narebski wrote:

> Theodore Tso <tytso@MIT.EDU> writes:
>
>> True, but (and please correct me if I'm wrong) ORIG_HEAD will always
>> be pointing out HEAD before the user typed pretty much any git
>> porcelein command (which saves HEAD into ORIG_HEAD), but with  
>> reflogs,
>> it you have to paw through multiple HEAD@{n} to find the 'n' which
>> corresponds to state before executing the git plumbing command, since
>> multiple git plumbing commands could have updated the HEAD's reflog,
>> right?
>
> You can always use _branch_ reflog, either in the <branch>@{1} form,
> or in @{1} shortcut form.  @{1} should be equovalent to ORIG_HEAD
> even for rebase.

I personally expected @{1} to be identical to HEAD@{1}.  Since  
omitting a ref usually refers to HEAD, why shouldn't omitting it when  
referring to the reflogs mean the HEAD log?  The definition of @{1} is  
useful since there's no other easy way to get "current branch's  
reflog", but I think it's non-obvious.  (Since HEAD@{1} is something  
completely different, I think the only other way to refer to @{1} is $ 
(git symbolic-ref)@{1}.)

Also, your statement is only true if ORIG_HEAD was on the branch you  
are currently working.  If we want ORIG_HEAD to mean "state of HEAD  
before last command", then "git rebase upstream topic" from master  
should leave ORIG_HEAD pointing to master, not topic@{1}.  It also is  
no longer true if you switch branches.  Having ORIG_HEAD set to the  
point before a pull is useful to compare multiple branches to both the  
old and new position of your updated branch.

If we're going to have ORIG_HEAD set by _any_ command, we should  
probably come up with some consistent definition of it and set it  
appropriately.  The first place most people encounter ORIG_HEAD is  
after a pull, where it acts something like a reverse of FETCH_HEAD  
(old state of local vs. new state of remote).  However, pull only sets  
ORIG_HEAD by way of merge and reset sets ORIG_HEAD as well.  So the  
current definition appears to be "the prior state of the last branch  
to be drastically changed."  By this definition, ORIG_HEAD should be  
set by am and rebase as per Junio's patch.

You could make an argument for removing ORIG_HEAD, it's functionality  
being replaced by the reflogs.  At this point, it's a rather  
established bit of git, and I think has usefulness of it's own.

~~ Brian
