From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hmm.. Try harder to find the common commits in git protocol?
Date: Mon, 28 Apr 2008 16:20:08 -0700
Message-ID: <7vabjdbm8n.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0804280936080.3119@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804281310320.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:21:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqcei-0002pY-AS
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 01:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965443AbYD1XUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 19:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965378AbYD1XUU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 19:20:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965291AbYD1XUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 19:20:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 279C83808;
	Mon, 28 Apr 2008 19:20:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 601B73806; Mon, 28 Apr 2008 19:20:10 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0804281310320.3119@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 28 Apr 2008 13:15:51 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80633>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Hmm. Trying to debug this, I find the behavior hard to reproduce. But I 
> *also* find that there seems to be something wrong in builtin-fetch-pack.
>
> Look at commit f3ec549481827b10609a43bf504517a0e8063a12 ("fetch-pack: 
> check parse_commit/object results"), and tell me that the "parents" 
> handling isn't totally broken. In particular, get_rev() does:
>
> 	struct commit_list *parents = NULL;
> 	..
> 	commit = rev_list->item;
> 	if (!(commit->object.parsed))
> 		if (!parse_commit(commit))
> 			parents = commit->parents;
> 	..
>
> which means that "parents" will never even get set if the commit was 
> already parsed!
>
> And whether it got parsed or not depends on how we got there etc, so this 
> may explain the occasionally odd behaviour I saw.
>
> Basically, I don't think that code can be right,...


> This patch should fix that problem, but I wonder why it got rewritten that 
> way in the first place?

Sorry, my fault while reviewing the series.  The intent of the update was
too focused on not touching possibly bad data (i.e. when parse_commit()
does not return zero to indicate success) and failed to make sure that it
acts identically on good data --- very bad.
