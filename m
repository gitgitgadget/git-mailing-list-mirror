From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v5 0/6] {checkout,reset,stash} --patch
Date: Wed, 19 Aug 2009 11:40:20 +0200
Message-ID: <200908191140.22235.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <200908151204.36709.trast@student.ethz.ch> <20090818164826.GA27377@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 19 11:41:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdhfU-0000cE-3C
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 11:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbZHSJlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 05:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZHSJlE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 05:41:04 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:15654 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbZHSJlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 05:41:03 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 19 Aug
 2009 11:41:02 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 19 Aug
 2009 11:40:41 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090818164826.GA27377@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126525>

Jeff King wrote:
> 
> I took a look at this today.

Heh, now *my* procrastination is paying off :-)

> Hmm. I was about to write "so we need some clever way of integrating the
> interactive hunk selection with a 3-way merge". But I just had a
> thought: we should do it in the reverse order. We do the three-way merge
> into a temporary index, and then ask the user to apply the result of
> _that_ tree into the working tree. Or maybe I am missing something else
> obvious and you can enlighten me.

I think that is the correct way to go about it from the user's POV.
He would be confused if the patch applied to WT/index were different
(because of a later merge) from the hunks he chose in the -p loop.

However, there's the issue of merge conflicts.  Some options I can
think of are

1) refuse to work in the face of merge problems

2) stash requires a clean WT, so we can move the user's index out of
   the way and use temporary index + WT to let the user resolve the
   conflicts

3) require both clean WT and index so we can simply use the repo to
   resolve

(The first one isn't quite as restrictive as it sounds; the user can
always apply on top of a clean HEAD, fix conflicts and re-stash, thus
doing a "stash rebase".)


>   1. For --index mode, it actually invokes add--interactive twice. It
>      would be nice to do both passes at the same time, but I don't think
>      it is possible with the current add--interactive infrastructure.

Note that the 'git stash -p' in next always stashes the index whole,
so the "easy" way might simply be to also unstash the index whole (if
requested).

The changes will usually still be available in the worktree
application, because the 3-way merge is between base and HEAD on one
side and base and worktree-stash on the other side.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
