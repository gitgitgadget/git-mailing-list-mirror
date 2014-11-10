From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore
 submodules
Date: Mon, 10 Nov 2014 14:01:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 14:01:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnob2-0005U7-UQ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 14:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbaKJNBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 08:01:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:64065 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbaKJNBY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 08:01:24 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MKbZD-1XpjTK20Gt-0020ix;
 Mon, 10 Nov 2014 14:01:21 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:O4yDThfeV3wJtm0tStV1V+Vq3KRQ6kv50z376Gqa/udM0NzO8Ry
 Hb3WrEG9JgHesiqdsEFG/eUxFXBSPsBMSlxkcfxRBBLpRK+qnrrYH7CKOTn1il7T1T/cTpG
 ySj5iGWKCGzhMq9y1omZRLdqimRs9C045tPYb0m2mbkratOVW+x/W/1HL+3Sv1UjT8c94UA
 YoUKUMzGkT0JqkxrjNckA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 7 Nov 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/receive-pack.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index be4172f..4ba51df 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -740,7 +740,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
> >  static void merge_worktree(unsigned char *sha1)
> >  {
> >  	const char *update_refresh[] = {
> > -		"update-index", "--refresh", NULL
> > +		"update-index", "--ignore-submodules", "--refresh", NULL
> >  	};
> >  	const char *read_tree[] = {
> >  		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
> 
> I suspect that you did not squash this into 1/2 on purpose, and I am
> guessing the reason is because you were unsure what should happen
> when there were differences in submodules' working trees (otherwise,
> you would have simply squashed without "oops it was a thinko to
> forget passing this option" as a separate patch).  I am not sure
> either.

This change is squashed into the first patch in the next iteration.

> By the way, if the expected use case of updateInstead is what I
> outlined in the previous message, would it make more sense not to
> fail with "update-index --refresh" failure (i.e. the working tree
> files have no changes since the index)?
> 
> Thinking about it a bit more, checking with "update-index --refresh"
> feels doubly wrong.  You not just want the working tree files to be
> pristine with respect to the index, but also you do not want to see
> any change between the index and the original HEAD, i.e.
> 
> 	$ git reset --hard && echo >>Makefile ; git add Makefile
>         $ git update-index --refresh ; echo $?
>         0
> 
> this is not a good state from which you would want to update the
> working tree.
> 
> Wouldn't the two-tree form "read-tree -u -m" that is the equivalent
> to branch switching do a sufficient check?

That is indeed what the patched code calls.

> Also, regarding the new calls to die() in the main patch, shouldn't
> they just be returning the error reason in string form, just like
> DENY_REFUSE returns "branch is currently checked out" to signal a
> push failure to the caller?

Changed in the next iteration.

Ciao,
Johannes
