From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Mon, 23 May 2005 17:49:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505231724270.16151@localhost.localdomain>
References: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
 <7vsm0hpbub.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505202025480.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 23:49:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaKmm-0000cD-Cm
	for gcvg-git@gmane.org; Mon, 23 May 2005 23:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVEWVt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 17:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEWVt7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 17:49:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58028 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261976AbVEWVtx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 17:49:53 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGY00LMCPYFRA@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 May 2005 17:49:28 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0505202025480.2206@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[catching up after a weekind away -- you guys have not been standing still]

On Fri, 20 May 2005, Linus Torvalds wrote:

> On Fri, 20 May 2005, Junio C Hamano wrote:
> >
> > Although I do not have immediate objections to what it tries to
> > do, I have to think about the intent of the patch and its
> > ramifications.
> 
> I really think it should be a totally separate flag to enable showing the
> sub-trees if the tree-blobification wants this.
> 
> In fact, I can pretty much _guarantee_ that the patch as posted is the
> wrong thing to do: it will do horribly wrong things for things like
> 
> 	git-whatchanged arch/i386/kernel/head.S
> 
> (but I haven't tried it - try it yourself. The correct output for the 
> kernel archive is just a single commit, and a single blob change in that 
> commit).

OK.  What about the following patch?  It outputs changed tree objects 
only if -p nor -v nor -s is specified, i.e. whenever what is really 
wanted is output of what changed at the object level.  This makes it 
more coherent with the non-recursive output as well.  Checked that 
git-diff-helper doesn't get confused.

If a separate flag is really needed, then consistency dictates that the 
non recursive output should provide output for tree objects only when 
that flag is given as well, which makes the non recursive output rather 
useless in most cases.  And IMHO this is just too much burden for little 
benefit (the extra flag not the recursive tree object output).

=====

This patch includes output of modified tree objects to recursive output, 
just like non recursive output already does.  When -v, -s or -p  is 
specified then the recursive output supresses modified tree objects 
since they don't make much sense in that case.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -127,6 +127,8 @@ static int compare_tree_entry(void *tree
 	if (recursive && S_ISDIR(mode1)) {
 		int retval;
 		char *newbase = malloc_base(base, path1, pathlen1);
+		if (!silent && !verbose_header && !show_root_diff)
+			diff_change(mode1, mode2, sha1, sha2, base, path1);
 		retval = diff_tree_sha1(sha1, sha2, newbase);
 		free(newbase);
 		return retval;
