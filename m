From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore
 submodules
Date: Wed, 12 Nov 2014 12:06:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411121205360.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
 <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 12:06:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoVlA-0006De-KN
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 12:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbaKLLGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 06:06:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:53120 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbaKLLGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 06:06:44 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LoVja-1YTrue14ZO-00gUmS;
 Wed, 12 Nov 2014 12:06:38 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:oaddSc2KHWcEeKPcV2GCVU50U0oUHkzysovQX09z0Fiw9D5nxoD
 OqAydVjbN3f4CObr+Wn2eVU5E3wUPqTEJJV2NAMwZ7jaHpe+nLTDCK4gVCRwdsN8DsOzkFU
 VwhR/DGTOUPpYZSLJtJAL4qmUdM5q1kgJ7Ux/ebKfW5EkreCoGJMkW016w1p1kBeA8NPhTn
 YibI4IGYclUznZwOLH8Bg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Nov 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> By the way, if the expected use case of updateInstead is what I
> >> outlined in the previous message, would it make more sense not to
> >> fail with "update-index --refresh" failure (i.e. the working tree
> >> files have no changes since the index)?
> >> 
> >> Thinking about it a bit more, checking with "update-index --refresh"
> >> feels doubly wrong.  You not just want the working tree files to be
> >> pristine with respect to the index, but also you do not want to see
> >> any change between the index and the original HEAD, i.e.
> >> 
> >> 	$ git reset --hard && echo >>Makefile ; git add Makefile
> >>         $ git update-index --refresh ; echo $?
> >>         0
> >> 
> >> this is not a good state from which you would want to update the
> >> working tree.
> >> 
> >> Wouldn't the two-tree form "read-tree -u -m" that is the equivalent
> >> to branch switching do a sufficient check?
> >
> > That is indeed what the patched code calls.
> 
> I know that ;-), but I think I wasn't clear enough.
> 
> I am not saying you are not using two-tree read-tree.  I am saying
> the check with update-index --refresh before read-tree seems
> dubious.
> 
> There are three "cleanliness" we require in various occasions:
> 
>  (1) rebase asks you to have your index and the working tree match
>      HEAD exactly, as if just after "reset --hard HEAD".
> 
>  (2) merge asks you to have your index match HEAD exactly (i.e. no
>      output from "diff --cached HEAD"), and have no changes in the
>      working tree at paths that are involved in the operation.  It
>      is OK to have local changes in the working tree (but not in the
>      index) at paths that are not involved in a mergy operation.
> 
>  (3) checkout asks you to have your index and the working tree match
>      either HEAD or the commit you are switching to exactly at paths
>      that are involved in the operation.  It is OK to have local
>      changes in the working tree and in the index at paths that are
>      not different between the commits you are moving between, and
>      it is also OK to have the contents from the "new" commit in the
>      working tree and the index at paths that are different between
>      the two.
> 
> Dying when "update-index --refresh" signals a difference is an
> attempt to mimic #1, but it is in line with the spirit of the reason
> why a user would want to use updateInstead, I think.  The situation
> is more like the person who pushed into your repository from
> sideline did a "checkout -B $current_branch $new_commit" to update
> the HEAD, the index and the working tree, to let you pretend as if
> you based your work on the commit he pushed to you.
> 
> While you still need to error out when your local work does not
> satisfy the cleanliness criteria #3 above, I do not think you would
> want to stop the operation when "checkout" would not fail, e.g. you
> have a local change that does not interfere with the update between
> the two commits, with this one:
> 
> +	if (run_command(&child))
> +		die ("Could not refresh the index");
> 
> When refreshed the index successfully, we signal that there were
> differences between the index and the working tree with a non-zero
> return value, so "Could not refresh" is not quite right, either.
> 
> But this one that checks the exit status from two-tree read-tree
> 
> +	if (run_command(&child))
> +		die ("Could not merge working tree with new HEAD.  Good luck.");
> 
> is checking the right condition, i.e. cleanliness #3.  The
> disposition should not be "die", but an error return to tell the
> caller to abort the push as we discussed earlier.

I have to say that I am quite puzzled now: I guess that you want me to
drop the update-index --refresh call?

Ciao,
Johannes
