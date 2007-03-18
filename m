From: Sam Vilain <sam@vilain.net>
Subject: Re: [wishlist] git branch -d -r remotename
Date: Mon, 19 Mar 2007 09:46:10 +1200
Message-ID: <45FDB322.10904@vilain.net>
References: <45FD0804.6010401@vilain.net>	<20070318110507.5701413A382@magnus.utsl.gen.nz>	<20070318113210.5843E13A382@magnus.utsl.gen.nz> <7vvegyl4nt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:46:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3Cm-0002kV-1E
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbXCRVqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932853AbXCRVqT
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:46:19 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55411 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932835AbXCRVqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 17:46:17 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 24EA31570E2; Mon, 19 Mar 2007 09:46:16 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id BA1C813A302;
	Mon, 19 Mar 2007 09:46:12 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <7vvegyl4nt.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42526>

Junio C Hamano wrote:
>> Subject: [PATCH] git-remote: implement prune -c
>>
>> It would be nice to prune local refs which are irrelevant; add an
>> option to git-remote prune, with documentation.
>>     
>
> I do not understand what workflow you are assuming, so your use
> of the word "irrelevant" does not mean much to me.  I suspect
> other readers of the patch and documentation wouldn't find it
> clear in what situation this option is useful.
>   

Bad choice of words. What I mean is to delete all local refs which are
already reachable by a remote ref on the given remote.

> Perhaps you are thinking about this scenario?  I am only
> guessing because you are not clear enough:
>
> 	$ git clone
>         ... time passes ...
>         $ git checkout -b next origin/next
>         ... build, install, have fun ...
> 	$ git checkout master
>         ... time passes ...
>         $ git branch
>         ... notice that you do not hack on your copy of 'next'
>         ... and want to remove it
> 	$ git remote prune -c
>   

Yes, that's it. Or clean up the references you already pushed because
they are no longer of interest.

> In any case, are you checking irrelevancy?  What if your foo branch has
> more changes to be sent upstream?  Even when the remote has a
> bit older version doesn't your code remove yours?  For example,
> if you did this, instead of the above, what happens?
>
> 	$ git clone
>         ... time passes ...
>         $ git checkout -b next origin/next
>         ... build, install, have fun ...
> 	... find an opportunity to improve ...
>         $ edit
>         $ git commit ;# on your 'next'.
>         ... build, install, test ...
> 	$ git checkout master
>         ... time passes ...
>         $ git branch
>         ... notice that you do not hack on your copy of 'next' anymore,
>         ... and want to remove it
> 	$ git remote prune -c
>   

It doesn't do that because the head doesn't match any revision that was
given to us by `rev-list refs/remotes/foo/*`

> If the above is the usage scenario you are trying to help, then
> wouldn't it be helpful if you could also help removing 'my-next'
> in this slightly altered example?
>
> 	$ git clone
>         ... time passes ...
>         $ git checkout -b my-next origin/next
>         ... build, install, have fun ...
> 	$ git checkout master
>         ... time passes ...
>         $ git branch
>         ... notice that you do not hack on your copy of 'next'
>         ... which is 'my-next', and want to remove it
> 	$ git remote prune -c

Yes, the idea was to "sweep" all branches that were just local branches
of a remote and never worked on. This is most useful right now for
people switching from Cogito or old-style remotes, who have a lot of
branches that are remote tracking branches. Using this, they can just
set up a new remote, fetch and prune -c and be left in a tidy state.

Sam.
