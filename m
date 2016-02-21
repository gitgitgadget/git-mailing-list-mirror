From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: interactive rebase results across shared histories
Date: Sun, 21 Feb 2016 03:12:49 +0100
Message-ID: <56C91D21.90306@moritzneeb.de>
References: <87io1j6laz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Seb <spluque@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 03:12:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXJW5-0004DA-4T
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 03:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcBUCMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 21:12:53 -0500
Received: from moritzneeb.de ([78.47.1.106]:54792 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbcBUCMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 21:12:52 -0500
Received: from [192.168.1.4] (f051245187.adsl.alicedsl.de [78.51.245.187])
	by moritzneeb.de (Postfix) with ESMTPSA id CEADB1C058;
	Sun, 21 Feb 2016 03:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456020770;
	bh=EbpLwCBQBmUwT2UwTVA/dYgfHF3itwrAGyc9iSq2tLU=;
	h=Subject:To:References:From:Date:In-Reply-To:From;
	b=URkL9uK0rTxCC3/pDCitO1QNtMrUFO8YGSLANg6JqXkjJZCyGz6Gk7dBR2IbA6cOj
	 kQaDcjI6ufMJH1v+z4TGTJOHJFNBbkPbZoa5UvndzAUm1bNJMgvd/iSBLtIfDOccva
	 meMMb2jh7ckxrOKQZFjW68RrZT+CQTm3Eoxv/C/g=
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <87io1j6laz.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286794>

Hi Seb,

On 02/20/2016 11:58 PM, Seb wrote:
> Hello,
> 
> I've recently learnt how to consolidate and clean up the master branch's
> commit history.  I've squashed/fixuped many commits thinking these would
> propagate to the children branches with whom it shares the earlier parts
> of the its history.  However, this is not the case; switching to the
> child branch still shows the non-rebased (dirty) commit history from
> master.  Am I misunderstanding something with this?

I am not sure what you meand by "child branch". If I understand
corretly, you have something like:

            A---B---C topic
           /
      D---E---F---G master

then you merge the topic:

            A---B---C topic
           /         \
      D---E---F---G---H master

and then you do something like "git rebase -i E" to linearize history
and maybe squash some commits, to result in something like:

      D---E---F---G---AB'---C' master

Where AB' is a squashed commit containing the changes from A and B.

Now, your misunderstanding may be in the fact of "what happened to the
topic branch?". Because looking at the whole graph, you have something
like this:

          A---B---C topic
         /
    D---E---F---G---AB'---C' master

where it is important to note, that the topic still points to C. Which
is totally correct, because you did not say anything about topic after
the merge. If you wanted to continue working on the topic branch, then
maybe a non-interactive rebasing, like described in the rebase manpage
would be something you might want to do before rebasing. E.g., from the
start doing "git rebase master topic" leads to:

                     A'--B'--C' topic
                    /
       D---E---F---G master

and then you could squash your commits as you like with "git rebase -i G":

	      AB'--C' topic
             /
D---E---F---G master

and maybe fast-forward merging master with "git merge master", then you
have both branches pointing to C':

    D---E---F---G---AB'--C' topic,master

The same could've been reached in one step via "git rebase -i master topic".

Maybe, to get a better understanding, you could use visualization tool
like "tig" or "gitk" to observe what happens to your commits (hashes)
and branches (labels) and just play around with some of these operations.
