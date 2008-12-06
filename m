From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] builtin-commit.c: further refactor branch
 switching
Date: Fri, 5 Dec 2008 18:08:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812051802570.3425@nehalem.linux-foundation.org>
References: <1228528455-3089-1-git-send-email-gitster@pobox.com> <1228528455-3089-2-git-send-email-gitster@pobox.com> <1228528455-3089-3-git-send-email-gitster@pobox.com> <1228528455-3089-4-git-send-email-gitster@pobox.com> <1228528455-3089-5-git-send-email-gitster@pobox.com>
 <1228528455-3089-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 03:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8mcI-0000rK-R5
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 03:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbYLFCIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 21:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbYLFCIl
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 21:08:41 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58486 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752993AbYLFCIk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2008 21:08:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB628ZB0024833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Dec 2008 18:08:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB628Z9s029140;
	Fri, 5 Dec 2008 18:08:35 -0800
In-Reply-To: <1228528455-3089-6-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.931 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102440>



The whole series looks good, I think.

But one thing I reacted to is exemplified best by this one:

On Fri, 5 Dec 2008, Junio C Hamano wrote:
>
> +int reset_index_and_worktree(int force, int merge, int quiet, int *wt_error,
> +			     struct commit *old_commit, const char *old_label,
> +			     struct commit *new_commit, const char *new_label)

This takes three flags (force, merge, quiet) as three parameters.

And in the series, 3/6 and 4/6 had other cases where the same flags (just 
not _all_ of them) were passed around to other functions. In 4/6, you had 
"switch_trees()" taking "int merge, int quiet", and in 3/6 you had 
"reset_tree()" taking "int quiet" and also have a "int worktree" flag.

I think it would be really nice to have a unified namespace for these 
flags. There are lots of commonalities between "checkout" and "reset" (and 
certainly differences too), wouldn't it be nice to have something like

	#define CO_FORCE 0x001
	#define CO_MERGE 0x002
	#define CO_QUIET 0x004
	#define CO_WORKTREE 0x008

and just pass in a single "unsigned int checkout_flags" as an argument?

Having eight parameters is obscene.

		Linus
