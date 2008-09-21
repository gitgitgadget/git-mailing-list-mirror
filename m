From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [funny] "git checkout -t origin/xyzzy" seems to misbehave
Date: Sun, 21 Sep 2008 19:44:38 +0200
Message-ID: <20080921174438.GB3877@blimp.localhost>
References: <7v1vzd29i3.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khpea-0002gY-4U
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 19:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYIVRzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 13:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbYIVRze
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 13:55:34 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:34461 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYIVRzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 13:55:32 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CU82oUGi
Received: from tigra.home (Fa8f0.f.strato-dslnet.de [195.4.168.240])
	by post.webmailer.de (fruni mo28) (RZmta 17.4)
	with ESMTP id 3029e4k8MHmUds ; Mon, 22 Sep 2008 19:55:29 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 43961277D1;
	Sun, 21 Sep 2008 19:44:38 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 293D136D1D; Sun, 21 Sep 2008 19:44:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1vzd29i3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96502>

Junio C Hamano, Sun, Sep 21, 2008 10:23:00 +0200:
> When you
> 
>  * are on a branch "foo" that is not "bar",
>  * have "origin/bar",
>  * and already have a local branch "bar",
> 
> "git checkout -t origin/bar" seems to misbehave.
> 
>     $ git clone -s git.junio victim-002
>     $ cd victim-002
>     $ git branch
>     * master
>     $ git checkout -t origin/next
>     Branch next set up to track remote branch refs/remotes/origin/next.
>     Switched to a new branch "next"
>     $ git checkout -t origin/master
>     fatal: A branch named 'master' already exists.
>     $ git branch
>       master
>     * next
>     $ git diff --cached --shortstat
>      60 files changed, 2378 insertions(+), 3412 deletions(-)
>     $ git diff --cached master
>     $ exit
> 
> The first "checkout -t" is fine.  The failed one seems to have already
> updated the index and the work tree when it notices that it cannot create
> a new branch.

Precisely this (branch already exists) case is easy to handle with a
resolve_ref in builtin-checkout.c:switch_branches.

The other errors will still leave index and working tree in this
state: branch.c:create_branch does not cleanup in case of errors,
it just dies.
