From: Sam Vilain <sam@vilain.net>
Subject: Re: post-update script to update wc - suggestions welcome
Date: Thu, 21 Jun 2007 10:28:33 +1200
Message-ID: <4679AA11.5050407@vilain.net>
References: <E1I0tZY-0001Uz-00@www.watts.utsl.gen.nz>	<7vr6o7uhwz.fsf@assigned-by-dhcp.pobox.com>	<46798AB6.6060403@vilain.net> <7vtzt2s5jl.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 00:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I18fM-0007H5-B9
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 00:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbXFTW2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 18:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbXFTW2n
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 18:28:43 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36623 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbXFTW2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 18:28:42 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 31AEE13A4F8; Thu, 21 Jun 2007 10:28:40 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 68B8C13A4EA;
	Thu, 21 Jun 2007 10:28:36 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <7vtzt2s5jl.fsf@assigned-by-dhcp.pobox.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50576>

Junio C Hamano wrote:
> I am afraid I am not following your logic.
> 
> I missed that "if git-diff-files"; it is not checking (you would
> have to ask for --exit-code or something --- traditionally we
> never used git-diff-xxxx exit code to indicate if there is any
> changes).

Oh, I expected a diff command to return an error code if differences
were found, like diff does.

> Suppose we update that "if" to see if diff-files says "no change
> in the working tree wrt the index".  But then, I think what you
> have at the end, "git reset --hard HEAD", where the HEAD is an
> arbitrary commit that does not necessarily have to do anything
> with what the index is based on, would remove what is known to
> the index but not in HEAD.

Good point.  Yes a semi-staged commit would lose information.  So we
also need to check that the index matches the previous value of what the
current branch points to.

How about this.  We call write-tree and get a tree ID.  If we can find
that tree in any of the commits reachable by the reflog or the history
of the current branch then we can be happy that no local changes have
been staged.  That will imply that if you want a non-bare repository to
update automatically and use push -f, you need reflog.

>  Which was my point about the
> "diff-index piped to perl".  I do not think that one is
> necessary.

Sure, I only did that because I didn't think reset --hard would remove
files which were previously in the index but not in the version being
reset to.

> Actually, more importantly, why is it justified to remove a file
> that is unchanged since the index, if the updated HEAD does not
> have it?  That is losing information, isn't it?

Well, not if you can confirm that the index matches some previous
version of the branch.

> Or are you assuming that this is used only for a worktree where
> there is NO actual development happens, but just kept up to date
> to whatever commit comes at HEAD?

I was aiming for something safe that people can just chmod +x to get
symmetric push/pull semantics.

Sam.
