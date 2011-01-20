From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 11:53:16 -0800
Message-ID: <7v62tjs66r.fsf@alter.siamese.dyndns.org>
References: <ih1449$ul6$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Kelly <steveire@gmail.com>, KDE PIM <kde-pim@kde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 20 20:53:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg0ZZ-0004ih-BF
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 20:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab1ATTx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 14:53:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab1ATTx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 14:53:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D29B83152;
	Thu, 20 Jan 2011 14:54:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1H+9W1dZsu7n43lUH/pcG90oZXE=; b=WcFwV3
	/mOj59shm+wMcll4HLzkDZ0wL+uVbtmW3i2b5o9zBIzxmmVW3PopGdCGHZZZ44og
	7maE0ml0u6u+Dj9x7yul9CrijyEjLP6rWBZqRhD23CzZDT5wxYsXkAHP/1dET/HZ
	HogvPHtwNehx2PB9fu6385V7+YuovBLOpp1fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mnstjNuHP7P5cj+LKtMpZlYqvEVS+u4B
	6jnnurmYA/ie0Hgl9cDW31jg8jTiX9UewdK1R/z53XEr5PvYoF61JYdu6QBUjDG5
	DNchmWIbl2H0BFALGovFe9QdoquS1jwvipKJL1zCGKB0xm1nSy0x1N/4hXJaHgmw
	3GKPiKJiAU8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A31123151;
	Thu, 20 Jan 2011 14:54:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5500B314D; Thu, 20 Jan 2011
 14:54:03 -0500 (EST)
In-Reply-To: <ih1449$ul6$1@dough.gmane.org> (Stephen Kelly's message of
 "Mon\, 17 Jan 2011 11\:02\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0AA10D80-24CF-11E0-9B7F-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165326>

Stephen Kelly <steveire@gmail.com> writes:

> There were also messages like this:
>
> $ git pull
> remote: Counting objects: 5, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From /home/kde-devel/dev/src/playground/git/tmp/remote
>  + 1434cd2...dd30974 HEAD       -> origin/HEAD  (forced update)

Stephen, thanks, I think you have found a bug, not in this step but one
step before this 'git pull', where Bob pushes to the remote for the first
time after making a commit.

This issue is inherent in the way how the 'separate remotes' layout
introduced in 1.6.0 arranges the remote tracking mappings.

The refs/remotes/origin/HEAD in Bob's repository is supposed to be a
symbolic ref that points at the primary branch of the 'origin' remote
(typically its master), e.g. "ref: refs/remotes/origin/master".  But in
general, local 'refs/remotes/origin/X' for any value of X is to copy
'refs/heads/X' from the 'origin'.

Oops.  If the origin repository has 'refs/heads/HEAD', these rules
obviously conflict with each other.

In this particular case, Bob pushes the change to his refs/heads/master to
the remote to update its refs/heads/master.  The push at the same time
tries to pretend that it fetched from the remote to update Bob's tracking
branches, so refs/remotes/origin/master in Bob's repository is also
updated to point at this commit.

However, because Bob's refs/remotes/origin/HEAD is a symbolic ref that
points at his refs/remotes/origin/master, its value is also updated by
this push.

Bob's next fetch from remote will then notice that remotes/origin/HEAD he
has is different from refs/heads/HEAD the remote has, and tries to update
it, which would obviously a non-fast-forward.

I personally think it is reasonable to forbid HEAD or anything all caps
that ends with "_HEAD" as branch names.  Opinions?
