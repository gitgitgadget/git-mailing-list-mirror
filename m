From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Fri, 6 Feb 2009 16:31:06 +0100
Message-ID: <20090206153106.GA28897@diana.vm.bytemark.co.uk>
References: <20090128231305.16133.29214.stgit@localhost.localdomain> <20090129034512.GD24344@diana.vm.bytemark.co.uk> <b0943d9e0901300601j27ab6ebdq4b38a9f7c0cbe261@mail.gmail.com> <20090130152649.GA22044@diana.vm.bytemark.co.uk> <b0943d9e0901300936t4a6e0a37x1968a6949fb7bdda@mail.gmail.com> <b0943d9e0902060646hd779681x821e74d9a155d97b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:33:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVShO-0006X5-5l
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824AbZBFPbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 10:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZBFPbP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:31:15 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1038 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbZBFPbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:31:14 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LVSfa-0008Jm-00; Fri, 06 Feb 2009 15:31:06 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0902060646hd779681x821e74d9a155d97b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108733>

On 2009-02-06 14:46:19 +0000, Catalin Marinas wrote:

> 2009/1/30 Catalin Marinas <catalin.marinas@gmail.com>:
>
> > Now, should we add the check_clean argument to
> > Transaction.__init__() rather than run() as we do for the
> > allow_bad_head case?
>
> It looks like this may be a better option.

Sorry for taking so long to respond, but ... I strongly advise against
using default_iw in transaction.py. It's library code, and it should
take stuff like index and worktree as input parameters from layers
that are higher up in the abstraction stack. Compare the kernel policy
of having policy in userspace and not in the kernel.

And if you accept that reasoning, the check has to go in run() rather
than __init__(), because we don't have an iw in __init__(). (Though we
could add such a parameter, I guess.)

> The previous patch fails if "goto" pushes a patch with standard
> git-apply followed by another patch with a three-way merge. When
> Transaction.run() is called, even if the patch pushing succeeded,
> the function complains about local changes because of the
> "iw.index.is_clean(self.stack.head)" check.

Hmm, so that would have to be worked around somehow ... I guess doing
the check in __init__() might make sense after all, since that's
before we start changing things. How about adding a
check_clean_relative_to paramter to __init__() that's not a boolean,
but an iw to check against? It would default to None, meaning no
check.

> It is also a bit weird to push/pop patches and only complain at the
> end of local changes.

You mean the behavior the new infrastructure currently gives you? It's
actually convenient in a number of cases. Assume for example that you
have patch A that changes file foo, patch B that changes file bar, and
then local changes to file bar. At this point you can pop A without
problem, even though a middle stage is to pop and push B which touches
the same file as your local changes -- the existing checks will only
compare the diff between the original and final tree with your local
changes, and that diff doesn't contain bar.

> Below is an updated patch which does the checking in
> Transaction.__init__ (only the relevant parts of the patch):

Looks good, except for the hard-coded default_iw as I mentioned above.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
