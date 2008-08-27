From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "failed to read delta base object at..."
Date: Wed, 27 Aug 2008 10:05:54 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808270937340.3363@nehalem.linux-foundation.org>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org> <20080825213104.GI2213@fieldses.org> <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org> <20080825221321.GL2213@fieldses.org>
 <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org> <48B46B04.70102@gmail.com> <48B46F46.9090302@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, bfields@fieldses.org
To: Jason McMullan <jason.mcmullan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:08:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYOUW-0003l0-QV
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYH0RGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYH0RGJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:06:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39843 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751285AbYH0RGI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 13:06:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7RH5sAJ024910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Aug 2008 10:05:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7RH5ssX012553;
	Wed, 27 Aug 2008 10:05:54 -0700
In-Reply-To: <48B46F46.9090302@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93900>



On Tue, 26 Aug 2008, Jason McMullan wrote:
> 
> All bets are off when data=writeback.

Not the way git writes pack-files. It does a fsync() before moving them 
into place (at least newer git versions do), so the data is stable.

I do worry about wild pointers. I can't recognize the data, and it 
definitely doesn't look like any git internal data structures, but 16-bit 
data _is_ what zlib internally uses for things like the decoding tables. 

So if there is some use-after-free issue, I could imagine things like this 
happening inside of git. People do occasionally run valgrind on git, 
though, and it's been clean in the past, but I don't know if that has ever 
been done on the threaded packing, for example.

For example, the corrupting data had patterns like this:

	00 f8 bf fe 6b 57 fe ff 55 57 fe ff 97 57 fe ff

where the pattern _could_ be something like

	{ 00 f8 febf },
	{ 6b 57 fffe },
	{ 55 57 fffe },
	{ 97 57 fffe },

assuming that the "fe ff" pattern really is meaningful and is a 16-bit 
little-endian word.

And the thign is, zlib "code" tables look exactly like that:

	typedef struct {
	    unsigned char op;           /* operation, extra bits, table bits */
	    unsigned char bits;         /* bits in this part of the code */
	    unsigned short val;         /* offset in table or code value */
	} code;

	/* op values as set by inflate_table():
	    00000000 - literal
	    0000tttt - table link, tttt != 0 is the number of table index bits
	    0001eeee - length or distance, eeee is the number of extra bits
	    01100000 - end of block
	    01000000 - invalid code
	 */

but those particular op/val things don't make sense in that context 
either. But I don't know zlib that well, maybe the deflate routines use 
some other model.

			Linus
