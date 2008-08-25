From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "failed to read delta base object at..."
Date: Mon, 25 Aug 2008 12:01:42 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org>
References: <20080825164602.GA2213@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXhLO-0000FX-Cj
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 21:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949AbYHYTBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 15:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbYHYTBy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 15:01:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50896 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753562AbYHYTBx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 15:01:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7PJ1h7D007997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Aug 2008 12:01:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7PJ1gTu032482;
	Mon, 25 Aug 2008 12:01:43 -0700
In-Reply-To: <20080825164602.GA2213@fieldses.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.427 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93656>



On Mon, 25 Aug 2008, J. Bruce Fields wrote:
>
> Today I got this:
> 
> fatal: failed to read delta base object at 3025976 from
> /home/bfields/local/linux-2.6/.git/objects/pack/pack-f7261d96cf1161b1b0a1593f673a67d0f2469e9b.pack

This is almost certainly due to some corruption. Basically, the call to 
"cache_or_unpack_entry()" failed, which in turn is because 
'unpack_entry()' will have failed. 

And since you didn't see any other error, that failure is almost certainly 
due to unpack_compressed_entry() having failed. We don't print out _why_ 
(which is a bit sad), but the only thing that unpack_compressed_entry() 
does is to just "inflate()" the data at that offset.

So it probably got a zlib data error, or an adler32 crc failure.

> This has happened once before recently, I believe with a pack that had
> just been created on a recent fetch.  (If I remember correctly, this was
> soon after a failed suspend/resume cycle that might have interrupted an
> in-progress fetch; could that possible explain the error?)  In that case
> I reset origin/master, deleted a tag or two, and fetched, and the
> problem seemed to be fixed.

An interrupted fetch shouldn't have caused this, it really should only 
happen if you have some actual filesystem data error. Something didn't get 
written back correctly, or the page cache isn't coherent (or it got 
corrupted by something else like a wild kernel pointer, of course).

			Linus
