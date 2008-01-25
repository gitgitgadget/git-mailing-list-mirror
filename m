From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 08:24:05 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801250811380.14161@hp.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org> <alpine.LFD.1.00.0801221913500.1741@woody.linux-foundation.org>
 <7vejc6761g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 17:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIRNO-0005gP-PB
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 17:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbYAYQZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 11:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYAYQZ0
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 11:25:26 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59652 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752740AbYAYQZZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 11:25:25 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0PGO6NY029577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jan 2008 08:24:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0PGO5lx023001;
	Fri, 25 Jan 2008 08:24:06 -0800
In-Reply-To: <7vejc6761g.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71717>



On Thu, 24 Jan 2008, Junio C Hamano wrote:
> 
> I wonder if the issue Dave Miller addressed with
> 69ae517541ed5ab7d4fdcd8f82a9b8bd949df347 (fast-import: fix
> unalinged allocation and access) applies here.

Good point, although we actually do things wrong for *another* reason.

We currently force cache_entry to be 8-byte aligned regardless of what the 
actual "sizeof(ptr)" is, so we should assume that alignment:

	#define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) + 8) & ~7)

and if that isn't correct, we'd need to change this #define.

So right now, the right thing to do is probably to make this alignment 
explicit:

	#define CE_ALIGN 8

and then use that both in the "cache_entry_size()" _and_ in the 
"estimate_cache_size()" calculations to make it obvious what the alignment 
is.

And then we could actually make the alignment less on architectures that 
don't need that much (there may be architectures that need more, but I 
doubt it: we don't have any large fields in that structure, so the 
structure alignment really probably does max out at 8 in practice even if 
the C language theory doesn't give you any such guarantees).

Side note: this is not likely to be a problem in _practice_. The on-disk 
representation is also aligned (also by 8), and while they can be 
*differently* aligned due to the relative alignment of the varying-length 
"name[]" field, and that can cause some padding to be needed, in practice 
it will never matter. The on-disk size also contains a header that we 
don't take into account, so it's already "over-estimated" to begin with 
for the in-memory representation.

So "estimate_cache_size()" really does over-estimate its needs by a 
biggish amount, which is why it all works regardless, but better safe than 
sorry. 

		Linus
