From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git rebase behaviour changed?
Date: Tue, 17 Jan 2006 19:52:32 +1300
Message-ID: <46a038f90601162252y7e2d9227p4eb4091b653d5c6d@mail.gmail.com>
References: <43CC695E.2020506@codeweavers.com>
	 <7vslrnh080.fsf@assigned-by-dhcp.cox.net>
	 <43CC89DC.5060201@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 07:52:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eykhx-0007GI-9S
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 07:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWAQGwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 01:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWAQGwd
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 01:52:33 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:51937 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751171AbWAQGwc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 01:52:32 -0500
Received: by wproxy.gmail.com with SMTP id 70so1263689wra
        for <git@vger.kernel.org>; Mon, 16 Jan 2006 22:52:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t6rUKe1CVvUAiAi0bsjPnkGj8xXxo6vOjW6drJi9w5HNl+x86F5WaM6z4C0HXF2wVBI3lC/ntpx68UHwuqo6poJk39zst7W2Vu2zQSwrPiHEqZh6noPC5s8KBqY6shGlwh5HD9ExnJRE5q4PVw0igOUuAzN/Nan4CvwbIeuYxSU=
Received: by 10.54.70.19 with SMTP id s19mr5866231wra;
        Mon, 16 Jan 2006 22:52:32 -0800 (PST)
Received: by 10.54.127.13 with HTTP; Mon, 16 Jan 2006 22:52:32 -0800 (PST)
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <43CC89DC.5060201@codeweavers.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14783>

On 1/17/06, Mike McCormack <mike@codeweavers.com> wrote:
>  > summary was: "if you do a merge, do not rebase; if you are going
>  > to rebase, do not merge".  The thread is this one:
>
> I want to do rebases.  So is it that behaviour of "git pull" that has
> been changed to do merges, and I should be using "fetch" instead of
> "pull" or something similar?

Now, I have realised that a simple mistake (merging from origin in you
scenario) would lead git-rebase to discard earlier patches during the
rebase. If you had a single commit *after* the merge, git-rebase would
have rebased that single patch, and dropped earlier patches.

git-rebase should refuse to run in the above scenario. Is there a
straightforward way to ask if the merge base is "shared"?

<thinking>
If the commit following right after the merge base on "our" side is a
merge commit, there's a good chance we're about to fuck up. To make
double sure, we can walk up that commit to the other parent (the one
that is not the merge base for the current merge) and get what merge
base between that commit and the current merge base. If it returns
anything interesting, we bail out if we are conservative -- or walk up
the history again if we take a more adventurous approach.

If it returns empty, it's a splice merge and get outta here -- you are
not supposed to rebase a splice merge. And if the merge after our
original merge base was an octopus, die too. Those are not rebasable
either.
</thinking>

So, the conservative (and easy) approach would be to make rebase bail
out when it finds any merge commit.

cheers,


martin
