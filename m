From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in git remote prune?
Date: Thu, 05 Nov 2009 17:36:15 -0800
Message-ID: <7vvdho5t9s.fsf@alter.siamese.dyndns.org>
References: <76718490911051634w2d364b73m567e73039508c857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 02:36:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Dkc-0001yn-PT
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 02:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbZKFBgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 20:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbZKFBgT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 20:36:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbZKFBgS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 20:36:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B71D5940D1;
	Thu,  5 Nov 2009 20:36:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wjHVPjn1sNXBcTZW7J5QFsRkJM0=; b=MtYdEY
	iP5R2HId2RwQsyhytXSQCjyvkpgg4Sk8vLKSrjG95z3D34LAsUpAErUOXu51nR5f
	2Bm1Bh3D5emUjKY/t/iZeBPmwsYcWDuJsjHiNV2yi8D+G50mWWHdMUVehR0WslYN
	rt+1sRGLEaG3DXXNIto2wH89nzJiux7Fv0GSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g4vDMvjYuutMzWGBGoyGtQaCnEE/BEoH
	mD/E6yxjoOE0or+NNlzxY5gi/FIOfjDW/X19Ns9x/6FPN3InaVuURdD3+5VeRjBo
	7z03PDDxzwZb3XTF8ySeyxwfPebpB2bX+IN3GZBkK26CERUy7DQgjYc7uHloOdtb
	xx0otI/Hx50=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A989940D0;
	Thu,  5 Nov 2009 20:36:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 66E93940CF; Thu,  5 Nov 2009
 20:36:17 -0500 (EST)
In-Reply-To: <76718490911051634w2d364b73m567e73039508c857@mail.gmail.com>
 (Jay Soffian's message of "Thu\, 5 Nov 2009 19\:34\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C90ED5E2-CA74-11DE-8244-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132265>

Jay Soffian <jaysoffian@gmail.com> writes:

> Let's say you've got the following tracking branches:
>
> refs/remotes/origin/master
> refs/remotes/origin/next
> refs/remotes/origin/ghost
>
> And origin has only "master" and "next" (ghost has been removed upstream).
>
> Further, let's say you've got a refspec of:
>
> [remote "origin"]
>   fetch = +refs/heads/master:refs/remotes/origin/master
>
> What should "git remote prune origin" do?
>
> In my opinion, it should prune "next" and "ghost".  "ghost" is gone
> from upstream, so that's obvious. I think "next" should also be pruned
> because the refspec indicates the user is no longer interested in it.
>
> Currently it doesn't do anything (it only considers "master" per the
> refspec, which is still on origin, so it doesn't think there is
> anything to prune).

In your scenario, tracking branches for next and ghost couldn't have come
from the refspec you have in the configuration, but they do exist.  The
user has added them on purpose, perhaps by temporarily using wildcard
refspec, or perhaps by giving a refspec from the command line.

It does not matter how they got there, but the important thing to keep in
mind is that, even if the remote had refs/heads/{next,ghost}, we wouldn't
update it if we ran "git fetch" now.

In this situation, "git remote prune" should never prune 'next' nor
'ghost'.  If we were to implement auto-pruning in 'git fetch', it should
behave the same way.

I would define the logic to decide if refs/remotes/REMOTE/BRANCH is stale
to be:

 * See if there exists a refspec (either wildcard or concrete) that may
   cause "git fetch" to update the tracking branch in question, if the
   remote side had an appropriate ref.

   If there is no such refspec, stop here.  It is not stale.

   In your example, when considering refs/remotes/origin/master, there is
   such a refspec, and the "appropriate ref" is "refs/heads/master" on
   their side.  When considering refs/remotes/origin/{next,ghost}, there
   is none.  You stop here.

 * Then see if that ref exists at the remote side.  If it exists, stop
   here.  It means "git fetch" would update the tracking branch in
   question, so it is not stale.

   In your example, when considering refs/remotes/origin/master, the
   matching remote ref 'refs/heads/master' exists, so our tracking ref is
   not stale.

 * Otherwise, it is stale, and we can prune it.

Imagine a hypothetical "git fetch" that understands a ref with a magic
value 0{40} to signal "this ref is gone", and imagine what happens if the
origin had 'ghost' that has such a magic SHA-1 in it.  It would become
easier to understand how the above logic works.

 - When you issue "git fetch" under the condition of your example, think
   what would happen to 'next' (which has an ordinary value, not the magic
   "delete this" request).  Nothing happens.  We do not update it.

 - Nothing happens to 'ghost' either when you issue "git fetch".  It does
   not matter if that ref has this magic 'delete this' value.

Nothing happens because we were told by the refspec not to even look at
these refs/heads/{next,ghost} refs on the other side.
