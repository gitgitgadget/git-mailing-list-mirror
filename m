From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 17 Feb 2008 14:57:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171449230.30505@racer.site>
References: <200802102007.38838.lenb@kernel.org> <7vd4r4clnb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802162239090.5496@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Len Brown <lenb@kernel.org>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 15:58:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQkxt-0007Me-6j
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 15:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbYBQO51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 09:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755984AbYBQO50
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 09:57:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:40091 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755573AbYBQO50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 09:57:26 -0500
Received: (qmail invoked by alias); 17 Feb 2008 14:57:23 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 17 Feb 2008 15:57:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pI9FZjl0p+/V5uKdBRCyotX4TuApvMVcZ3UVtvo
	tF8L7jn1TxQcI8
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802162239090.5496@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74135>

Hi,

On Sat, 16 Feb 2008, Daniel Barkalow wrote:

> I wonder if the problem is that something isn't getting reinitialized 
> for the second connection. It's not a separate invocation of fetch-pack, 
> and I can't say for sure that it's sending the right info to the server 
> when the statics in builtin-fetch-pack.c are left over from the earlier 
> call. This would particularly explain the information that hitting 
> ctrl-c and trying again fixes it.

Oh, that should be it!  After all, the code in get_rev() in 
builtin-fetch-pack.c marks commits as SEEN and COMMON and POPPED.

So I guess you'd need to set something like

	struct commit_list *rev_list_orig;
	...
	rev_list_orig = rev_list;

before

        while ((sha1 = get_rev())) {

in the function find_common(), and then, after the while() loop, do 
something like

	while (rev_list_orig) {
		clear_commit_marks(rev_list->item,
			COMPLETE | COMMON | COMMON_REF | SEEN | POPPED);
		rev_list_orig = rev_list_orig->next;
	}

possibly free()ing the rev_lists in the process.

Ciao,
Dscho
