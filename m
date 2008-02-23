From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 22 Feb 2008 16:51:24 -0800
Message-ID: <7voda85wc3.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802211024200.17164@racer.site>
 <47BF18DF.6050100@nrlssc.navy.mil>
 <7vhcg07hmd.fsf@gitster.siamese.dyndns.org>
 <47BF669F.4070803@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Feb 23 01:52:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSicy-00054A-LZ
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 01:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937600AbYBWAvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 19:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936705AbYBWAvp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 19:51:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937600AbYBWAvn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 19:51:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 340055602;
	Fri, 22 Feb 2008 19:51:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2750A55BD; Fri, 22 Feb 2008 19:51:33 -0500 (EST)
In-Reply-To: <47BF669F.4070803@nrlssc.navy.mil> (Brandon Casey's message of
 "Fri, 22 Feb 2008 18:19:43 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74772>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>
>>  Also we may want to introduce a stash per branch if we do this.
>
> This isn't necessary for how I use stash.

That's what I thought initially.  But after thinking about it a
bit, I do not think so anymore.

It feels limiting not to be able to stash here and unstash
there.  You cannot stash on one branch and apply on another as
easily (you should still be able to, by naming the stash
explicitly, if you really wanted to).

But why would one even want to?  "What I've been hacking on is
getting into a good shape but now I noticed I was on a wrong
branch", is probably the only reason.  But that is what branch
switching "git checkout" (and its -m variant) does.  If your
changes are something that would make "checkout -m" conflict,
stashing and unstashing will result in the same conflict anyway,
so nothing is lost.

And there are obvious advantages to per-branch stash.  "stash
list" would contain only changes related to the current branch
by default for one thing.  "stash apply" without parameter would
be context sensitive as well.

By the way, I also thought that "pop instead of delete" was too
limiting.  I tried to like "pop" and wanted to justify it, but I
suspect it would invite user grief in this sequence:

        hack hack, gets interrupted
        git stash
        switch to another branch, service interrupt, and come back
        git stash pop
        hack hack, oops, I made a mess.

And earlier stash point was in a much better shape, but it has already
been lost.

While the workflow with the current stash would be:
        
        hack hack, gets interrupted
        git stash
        switch to another branch, service interrupt, and come back
        git stash apply
        hack hack, oops, I made a mess.
        git reset --hard
        git stash apply
        git commit
        git stash clear
