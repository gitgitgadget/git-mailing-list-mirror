From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 22:38:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903302231370.4093@localhost.localdomain>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain> <7vk5668g55.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:42:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWkT-0007eE-9J
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbZCaFl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbZCaFl1
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:41:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46450 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866AbZCaFl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:41:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V5cP07003754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2009 22:39:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V5cOFk020567;
	Mon, 30 Mar 2009 22:38:24 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.441 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115217>



On Mon, 30 Mar 2009, Linus Torvalds wrote:
> 
> This if anything makes things just go slower.
> 
> Not much, but some. It went from 36.566s to 38.070s. That may be in the 
> noise, I've not done any sensitivity analysis.
> 
> I thought you perhaps had a missing "parse_commit()" making the 
> reachability thing not work (look_up_gently parses the object, but if it's 
> a tag deref_tag() will dereference it until it hits a commit, but never 
> parse the commit). But that wasn't it.

Ahhah.

I know why it makes things slower.

The slow case is already inside that whole:

	if (timestamp < cb->cmd->expire_unreachable) {

if-statement, so the thing that slows down is if we hit a commit that is 
_older_ than the expire limit.

But your whole "mark_reachable()" thing only marks things _younger_ than 
that reachable. So you mark exactly the wrong things reachable - you mark 
the ones that we don't even care about.

If I do

	mark_reachable(cb.ref_commit, 0);

instead (to traverse the _whole_ tree, with no regards to date), the time 
shrinks to 1.7s. But of course, that's also wrong.

Qutie frankly, I don't really understand why the logic isn't just

	if (timestamp < cb->cmd->expire_unreachable)
		goto prune; 

why is that reachability so important?

			Linus
