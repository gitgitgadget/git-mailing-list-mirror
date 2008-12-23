From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] strbuf_readlink semantics update.
Date: Tue, 23 Dec 2008 10:16:01 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812231009220.3535@localhost.localdomain>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <1230026749-25360-1-git-send-email-madcoder@debian.org> <20081223102127.GA21485@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:17:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBp5-0007Ut-Um
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 19:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbYLWSQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 13:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbYLWSQP
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 13:16:15 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51587 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750916AbYLWSQP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2008 13:16:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBNIG2x8031704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Dec 2008 10:16:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBNIG1fn017340;
	Tue, 23 Dec 2008 10:16:01 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20081223102127.GA21485@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.424 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103846>



On Tue, 23 Dec 2008, Pierre Habouzit wrote:
>
> when readlink fails, the strbuf shall not be destroyed. It's not how
> read_file_or_gitlink works for example.

I disagree.

This patch just makes things worse. Just leave the "strbuf_release()" in 
_one_ place.

Look:

   6 files changed, 15 insertions(+), 5 deletions(-)

you added ten unnecessary lines, and you made the interface harder to use. 
What was the gain here?

> Fix read_old_data possible leaks in case of errors, since even when no
> data has been read, the strbufs may have grown to prepare the reads.
> strbuf_release must be called on them.

That's a separate error, and quite frankly, the best approach to that is 
likely to instead of breaking strbuf_readlink(), just make the S_IFREG() 
case release it.

I'd suggest that strbuf_read_file() should probably also do a 
strbuf_release() if it returns a negative error value, but that's a 
separate issue (and still leaves "read_old_data()" having to release 
things, since read_old_data() wants to see exactly st_size bytes. Although 
I suspect we might want to change that, and just make it test for 
negative too).

		Linus
